extends Node

## GameManager — wildfire-if Episode 1 中央控制器
## 加载 narrative-graph.json，驱动视频节点切换，路由 tap/长按/拖拽到分支选项，
## 实时维护 12 维「鹰眼」statDelta，结束时计算 ending.mood 并落盘。

# ── 配置（@export 暴露给 Inspector）────────────────────────────────────────────
@export var graph_path: String = "res://data/narrative-graph.json"
@export var tuning_path: String = "res://data/tuning.json"
@export var save_path: String = "user://wildfire-if/progress.json"
@export var bible_version: String = "v2"

# 手势窗口（默认值 — 会被 tuning.json 覆盖）
@export var tap_window_ms: int = 2000
@export var long_press_min_ms: int = 800
@export var swipe_min_px: int = 120
@export var default_path_timeout_ms: int = 2000
@export var radar_flash_ms: int = 1500

# 触发野火 v0.1 火苗的累计 aggressive 选择数（公式 4.2）
@export var wildfire_v01_threshold: int = 2

# Episode 收束基调权重（公式 4.4）
@export var mood_weight_yahuo: float = 1.2     # 野火
@export var mood_weight_yayi: float = 1.0      # 压抑
@export var mood_weight_laolian: float = 0.9   # 老练
@export var mood_weight_chunye: float = 1.1    # 纯野

# stat 等级阈值（F→D→C→B→A→S）
@export var stat_grade_thresholds: Array[int] = [10, 25, 40, 60, 80]

# ── 信号 ─────────────────────────────────────────────────────────────────────
signal node_started(node_id: String)
signal node_ended(node_id: String)
signal branch_resolved(branch_id: String, option_index: int)
signal stat_delta_applied(dim: String, delta: int)
signal episode_complete(mood: String, wildfire_v01: bool)

# ── 状态 ─────────────────────────────────────────────────────────────────────
var _graph: Dictionary = {}
var _current_node_id: String = ""
var _node_started_at_ms: int = 0
var _stats: Dictionary = {}                # 12 维 → int
var _choices: Array[Dictionary] = []       # 历史选择记录
var _unlocked_leaves: Array[String] = []   # 已解锁叶分支 id
var _aggressive_count: int = 0             # 累计 aggressive 选择
var _long_press_count: int = 0
var _fast_tap_count: int = 0               # tap < 0.4s 极速点击
var _supressed_count: int = 0              # 忍/避/沉默
var _default_path_hits: int = 0

# 当前节点等待选项窗
var _awaiting_input: bool = false
var _input_window_started_at: int = 0
var _press_started_at: int = 0
var _press_origin: Vector2 = Vector2.ZERO

# ── 生命周期 ─────────────────────────────────────────────────────────────────

func _ready() -> void:
	_load_tuning()
	_load_graph()
	_load_or_init_progress()
	if _graph.has("startNode"):
		_enter_node(_graph["startNode"])

func _process(delta: float) -> void:
	# 检查节点结束 + default path fallback（公式 4.3）
	if _awaiting_input and _input_window_started_at > 0:
		var elapsed: int = Time.get_ticks_msec() - _input_window_started_at
		if elapsed >= default_path_timeout_ms:
			_resolve_default_path()

# ── 输入事件路由 ─────────────────────────────────────────────────────────────

func _input(event: InputEvent) -> void:
	if not _awaiting_input:
		return
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		var pressed: bool = event.pressed if "pressed" in event else false
		if pressed:
			_press_started_at = Time.get_ticks_msec()
			_press_origin = event.position if "position" in event else Vector2.ZERO
		else:
			_handle_release(event)
	elif event is InputEventScreenDrag or event is InputEventMouseMotion:
		# 拖拽提前结算（达到阈值即触发 swipe）
		if _press_started_at > 0:
			var pos: Vector2 = event.position if "position" in event else Vector2.ZERO
			var displacement: Vector2 = pos - _press_origin
			if displacement.length() >= swipe_min_px:
				_resolve_swipe(displacement)

func _handle_release(_event: InputEvent) -> void:
	if _press_started_at <= 0:
		return
	var press_duration_ms: int = Time.get_ticks_msec() - _press_started_at
	_press_started_at = 0
	if press_duration_ms >= long_press_min_ms:
		_resolve_long_press()
	else:
		_resolve_tap(press_duration_ms)

# ── 节点切换 ─────────────────────────────────────────────────────────────────

func _enter_node(node_id: String) -> void:
	if node_id == "__END__":
		_finish_episode()
		return
	if not _graph.get("nodes", {}).has(node_id):
		push_error("GameManager: unknown node_id %s" % node_id)
		return
	_current_node_id = node_id
	_node_started_at_ms = Time.get_ticks_msec()
	_awaiting_input = false
	_input_window_started_at = 0
	emit_signal("node_started", node_id)
	# 占位阶段：3s 黑屏后开放选项窗
	var node: Dictionary = _graph["nodes"][node_id]
	var duration_sec: float = float(node.get("durationSec", 3.0))
	await get_tree().create_timer(duration_sec).timeout
	_open_input_window()

func _open_input_window() -> void:
	_awaiting_input = true
	_input_window_started_at = Time.get_ticks_msec()

## UI introspection — UIController.gd reads this to render subtitle + option list.
func get_current_node_view() -> Dictionary:
	if _current_node_id == "" or not _graph.get("nodes", {}).has(_current_node_id):
		return {}
	var node: Dictionary = _graph["nodes"][_current_node_id]
	return {
		"id":       _current_node_id,
		"trigger":  node.get("trigger", _current_node_id),
		"label":    node.get("label", ""),
		"branches": node.get("branches", []),
	}

func _resolve_default_path() -> void:
	_awaiting_input = false
	var node: Dictionary = _graph["nodes"].get(_current_node_id, {})
	_default_path_hits += 1
	emit_signal("node_ended", _current_node_id)
	var next_id: String = node.get("default", "")
	if next_id == "":
		_finish_episode()
	else:
		_enter_node(next_id)

# ── 手势 → 选项 ──────────────────────────────────────────────────────────────

func _resolve_tap(duration_ms: int) -> void:
	_select_option_by_gesture("tap", duration_ms, Vector2.ZERO)

func _resolve_long_press() -> void:
	_long_press_count += 1
	_select_option_by_gesture("long_press", 0, Vector2.ZERO)

func _resolve_swipe(displacement: Vector2) -> void:
	_select_option_by_gesture("swipe", 0, displacement)

func _select_option_by_gesture(gesture: String, duration_ms: int, displacement: Vector2) -> void:
	_awaiting_input = false
	var node: Dictionary = _graph["nodes"].get(_current_node_id, {})
	var branches: Array = node.get("branches", [])
	var chosen_index: int = -1
	for i in range(branches.size()):
		var b: Dictionary = branches[i]
		if b.get("gesture", "tap") != gesture:
			continue
		if gesture == "swipe":
			var want_dir: String = b.get("swipeDir", "up")
			if not _matches_swipe_direction(displacement, want_dir):
				continue
		chosen_index = i
		break
	if chosen_index < 0:
		# 未匹配到任何分支 — 兜底：第一个选项（避免死状态，符合 E9）
		chosen_index = 0
	_apply_branch(branches[chosen_index], chosen_index, gesture, duration_ms)

func _matches_swipe_direction(displacement: Vector2, want: String) -> bool:
	var dx: float = displacement.x
	var dy: float = displacement.y
	match want:
		"up":    return abs(dy) > abs(dx) and dy < 0
		"down":  return abs(dy) > abs(dx) and dy > 0
		"left":  return abs(dx) > abs(dy) and dx < 0
		"right": return abs(dx) > abs(dy) and dx > 0
		_: return true

func _apply_branch(branch: Dictionary, option_index: int, gesture: String, duration_ms: int) -> void:
	var branch_id: String = branch.get("id", "")
	# 应用 statDelta（公式 4.1）
	var stat_delta: Dictionary = branch.get("statDelta", {})
	for dim_key in stat_delta:
		var delta: int = int(stat_delta[dim_key])
		_stats[dim_key] = clamp(int(_stats.get(dim_key, 0)) + delta, 0, 100)
		emit_signal("stat_delta_applied", dim_key, delta)
	# 计数器
	if branch.get("isAggressive", false):
		_aggressive_count += 1
	if branch.get("isSuppressed", false):
		_supressed_count += 1
	if gesture == "tap" and duration_ms < 400:
		_fast_tap_count += 1
	# 叶分支
	for leaf_id in branch.get("unlockLeaves", []):
		if not _unlocked_leaves.has(leaf_id):
			_unlocked_leaves.append(leaf_id)
	# 记录选择
	_choices.append({
		"branchId": branch_id,
		"optionIndex": option_index,
		"gesture": gesture,
		"durationMs": duration_ms,
		"timestamp": Time.get_unix_time_from_system(),
	})
	emit_signal("branch_resolved", branch_id, option_index)
	emit_signal("node_ended", _current_node_id)
	# 切下个节点
	var next_id: String = branch.get("next", "")
	if next_id == "":
		_finish_episode()
	else:
		_enter_node(next_id)

# ── 终末：Episode 收束基调判定（公式 4.4）─────────────────────────────────────

func _finish_episode() -> void:
	_awaiting_input = false
	var wildfire_v01: bool = _aggressive_count >= wildfire_v01_threshold
	var scores: Dictionary = {
		"压抑":   _supressed_count * mood_weight_yayi,
		"野火":   _aggressive_count * mood_weight_yahuo + (2.0 if wildfire_v01 else 0.0),
		"老练":   _long_press_count * mood_weight_laolian,
		"纯野":   _fast_tap_count * mood_weight_chunye,
	}
	var mood: String = _argmax_with_fallback(scores)
	_save_progress(mood, wildfire_v01)
	emit_signal("episode_complete", mood, wildfire_v01)

func _argmax_with_fallback(scores: Dictionary) -> String:
	var best_key: String = "野火"
	var best_val: float = -INF
	var second_val: float = -INF
	for k in scores:
		var v: float = float(scores[k])
		if v > best_val:
			second_val = best_val
			best_val = v
			best_key = k
		elif v > second_val:
			second_val = v
	# 差距 ≤ 1 时强制回落到 wildfire bible 默认基调"野火"
	if best_val - second_val <= 1.0:
		return "野火"
	return best_key

# ── 持久化 ───────────────────────────────────────────────────────────────────

func _save_progress(mood: String, wildfire_v01: bool) -> void:
	var dir_path: String = save_path.get_base_dir()
	if not DirAccess.dir_exists_absolute(dir_path):
		DirAccess.make_dir_recursive_absolute(dir_path)
	var data: Dictionary = {
		"bibleVersion": bible_version,
		"endingMood": mood,
		"wildfireV01": wildfire_v01,
		"stats": _stats,
		"statDelta": _stats,  # 累计 = delta（初始全 0）
		"choices": _choices,
		"unlockedLeaves": _unlocked_leaves,
		"defaultPathHits": _default_path_hits,
	}
	var f: FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
	if f == null:
		push_error("GameManager: cannot open %s for write" % save_path)
		return
	f.store_string(JSON.stringify(data, "\t"))
	f.close()

func _load_or_init_progress() -> void:
	if not FileAccess.file_exists(save_path):
		return
	var f: FileAccess = FileAccess.open(save_path, FileAccess.READ)
	if f == null:
		return
	var raw: String = f.get_as_text()
	f.close()
	var parsed: Variant = JSON.parse_string(raw)
	if typeof(parsed) != TYPE_DICTIONARY:
		push_warning("GameManager: progress.json corrupt — starting fresh (E6)")
		return
	var data: Dictionary = parsed
	if data.get("bibleVersion", "") != bible_version:
		push_warning("GameManager: bibleVersion mismatch %s vs %s — migration required" % [data.get("bibleVersion", ""), bible_version])
	_stats = data.get("stats", {})
	_choices = data.get("choices", [])
	_unlocked_leaves = data.get("unlockedLeaves", [])

# ── 资源加载 ─────────────────────────────────────────────────────────────────

func _load_graph() -> void:
	var f: FileAccess = FileAccess.open(graph_path, FileAccess.READ)
	if f == null:
		push_error("GameManager: cannot open graph %s" % graph_path)
		return
	var parsed: Variant = JSON.parse_string(f.get_as_text())
	f.close()
	if typeof(parsed) == TYPE_DICTIONARY:
		_graph = parsed

func _load_tuning() -> void:
	if not FileAccess.file_exists(tuning_path):
		return
	var f: FileAccess = FileAccess.open(tuning_path, FileAccess.READ)
	if f == null:
		return
	var parsed: Variant = JSON.parse_string(f.get_as_text())
	f.close()
	if typeof(parsed) != TYPE_DICTIONARY:
		return
	var t: Dictionary = parsed
	tap_window_ms = int(t.get("tap_window_ms", tap_window_ms))
	long_press_min_ms = int(t.get("long_press_min_ms", long_press_min_ms))
	swipe_min_px = int(t.get("swipe_min_px", swipe_min_px))
	default_path_timeout_ms = int(t.get("default_path_timeout_ms", default_path_timeout_ms))
	radar_flash_ms = int(t.get("radar_flash_ms", radar_flash_ms))
	wildfire_v01_threshold = int(t.get("wildfire_v01_threshold", wildfire_v01_threshold))
