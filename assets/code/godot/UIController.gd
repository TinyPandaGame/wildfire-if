extends Control

## UIController — wildfire-if narrative interactive-film UI driver.
## Listens to GameManager (autoload) signals and updates on-screen Labels.
## Pure UI glue; no game state lives here.

@onready var _subtitle: Label = $SubtitleLabel
@onready var _options: Label = $OptionsLabel
@onready var _mood: Label = $MoodLabel

func _ready() -> void:
	var gm: Node = get_node_or_null("/root/GameManager")
	if gm == null:
		_subtitle.text = "[ERROR] GameManager autoload not registered. Check project.godot [autoload] section."
		return
	if gm.has_signal("node_started"):
		gm.node_started.connect(_on_node_started)
	if gm.has_signal("episode_complete"):
		gm.episode_complete.connect(_on_episode_complete)

func _on_node_started(node_id: String) -> void:
	var gm: Node = get_node_or_null("/root/GameManager")
	if gm == null:
		return
	# Optional UI-introspection method GameManager may expose.
	var node_data: Dictionary = {}
	if gm.has_method("get_current_node_view"):
		node_data = gm.call("get_current_node_view")
	if node_data.is_empty():
		_subtitle.text = node_id
		_options.text = "(no options registered)"
		return
	_subtitle.text = String(node_data.get("trigger", node_id))
	var lines: Array[String] = []
	for b in node_data.get("branches", []):
		var gesture: String = String(b.get("gesture", "tap"))
		var label: String = String(b.get("label", ""))
		lines.append("[%s] %s" % [gesture, label])
	_options.text = "\n".join(lines)

func _on_episode_complete(mood: String, wildfire_v01: bool) -> void:
	_subtitle.text = "Episode 1 完结。"
	_options.text = ""
	_mood.text = "基调：%s    野火 v0.1：%s" % [mood, "✦点亮" if wildfire_v01 else "未点亮"]
