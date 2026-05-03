# wildfire-if · Episode 1 · 狗笼 — Game Design Document

## 1. Overview（overview）

**项目代号**：wildfire-if Episode 1
**类型**：互动影游（Interactive Film / narrative）
**时长**：单次完整体验 22–28 分钟
**平台**：移动端竖屏优先，兼容横屏；后续可发行 Steam 桌面端
**引擎**：Godot 4（Phase 6.1 GodotRunner 已具备 batch 构建）
**内容主体**：第一篇·铁港·第一章·狗笼（来源 wildfire/01-01-狗笼.md，约 11KB 散文）

**核心体验**：玩家通过对真人/3D 实拍风格短片（占位阶段为黑屏字幕）进行 tap / 长按 / 拖拽 三种手势触发分支，重走 15 岁沈夜在铁港码头到狗笼到回家这一晚的"野性觉醒"时刻。玩家不操控篮球比赛规则，而是操控**沈夜在每个关键瞬间的选择**——压抑还是释放、回避还是迎击、藏锋还是炫技。

**单 Episode 结构**：4 幕 ×（5–8 视频节点）= 20–30 视频节点，5–6 个**强分支点**，外加 8–12 个**叶分支**（同终幕但风味不同的微变体）。

**为什么是互动影游**：
1. wildfire 第一章是**情境密度极高的散文**（搬货被刁难→狗笼遇刺挑衅→暴扣终结对手→回家见母亲），传统数值化难以承载，但天然适合"镜头+选择"叙事
2. 狗笼=无规则地下球场，正规比赛玩法不成立；玩家更想体验的是"做不做这件事"，不是"打不打得过"
3. wildfire 已有完整 12 维"鹰眼"评估系统，可在每次选择后用 6 维条变化（SPD/PWR/JMP/MND/WLD 等）作为**选择反馈层**，避免互动影游常见的"选了等于没选"

**Episode 1 的叙事 KPI**：玩家走完后必须能回答三个问题——
1. 沈夜为什么去狗笼？（生计 / 父亲 / 自我证明）
2. 狗笼里的"野"和正规篮球的差别？（无规则、流血、赌注）
3. 沈夜为什么"压抑跳投"很重要？（藏锋 vs 炫技的人生选择起点）

## 2. Player Fantasy（playerFantasy）

**核心幻想**：你是 15 岁的沈夜——身高 173cm 全铁港跳得最高的少年，白天在码头扛 80kg 的集装箱货件，傍晚走进锈蚀铁丝网围出来的"狗笼"，没人知道你能跳两米，还没人。今晚你要不要让他们知道？

**情绪曲线（4 幕，每幕给玩家一种独立情绪）**：

| 幕 | 玩家情绪 | 主导手势 | 节点数 |
|---|---|---|---|
| 第一幕：码头搬货 | 压抑 / 屈辱 / 隐忍 | 长按蓄力 | 5–7 |
| 第二幕：狗笼对打 | 警觉 / 试探 / 心跳 | tap 反应 | 6–8 |
| 第三幕：扣篮终结 | 爆发 / 释放 / 高光 | 拖拽起跳 | 5–7 |
| 第四幕：回家见母 | 沉默 / 温度 / 内省 | 长按凝视 | 4–6 |

**玩家情感投资点**：
- 第一幕埋钩——工头扣 50 块工资时，玩家被迫做"动手 / 忍下 / 转身"三选一，每个选择改变第二幕开局的 PWR/MND 微调
- 第二幕设"刀叔"远观隐藏触发——玩家若在某次拖拽前长按 1.5s（凝视刀叔），解锁"刀叔点头"叶分支，激活第八篇 callback
- 第三幕的扣篮节点是**全 Episode 唯一一次拖拽手势**——刻意把"释放"的体感唯一化
- 第四幕妈妈递热汤的镜头，玩家选"喝 / 放回 / 把工钱留桌上"，结局回响埋伏笔到 Episode 5（刀叔病故）

**反幻想（玩家不能做的事）**：
- 不能在第一章就投三分（与 wildfire 设定一致：3PT 初始 F 级）
- 不能在狗笼让对手流血（这是第三章的伏笔）
- 不能动暴力反击工头（沈夜的克制是性格设定，越界会触发 BAD END "下次别在码头"）

## 3. Detailed Rules（detailedRules）

### 3.1 视频节点机制
- 每个节点 = **一段 15–60s 视频**（占位阶段为 3s 黑屏 + 字幕 `VIDEO-XXX [描述]`）
- 节点结束有 0.5s **过渡窗口**——若玩家未输入则播放"默认选项"对应下个节点
- 节点元数据：`{ id, durationSec, branches: BranchSpec[], default: nodeId, mood, statDelta }`

### 3.2 三类手势的语义分工

| 手势 | 时机 | 语义 | 反馈 |
|---|---|---|---|
| **tap**（单击）| 视频结尾 0.5–2s 选项窗 | 主路径 A/B 二选一 | 屏幕轻闪 + 短促音效 |
| **长按**（≥0.8s 蓄力）| 节点中段或结尾 | 隐忍 / 蓄力 / 凝视 | 屏幕周边收紧 + 心跳低频 |
| **拖拽**（向某方向 swipe ≥120px）| 关键爆发节点 | 释放 / 起跳 / 突破 | 屏幕拉伸 + 镜头加速 |

**强约束**：每个分支点**只允许一种手势**激活——不让玩家在同一界面同时面对 tap/swipe，避免误触。

### 3.3 分支点结构

5–6 个**强分支点**（结构性影响后续 3+ 节点）：
1. **B1 码头工头扣钱**：tap 动手 / tap 忍下 / 长按转身 → 影响 PWR ±2、MND ±1
2. **B2 狗笼入场**：tap 直接进 / 长按蹲守门口听对话 → 解锁"知道对手底细"叶分支
3. **B3 第一次身体对抗**：长按硬扛 / tap 闪避 → PWR vs SPD 路线分化
4. **B4 扣篮 OR 平凡上篮**：拖拽（向上）扣 / tap 上篮 → JMP ±3、WLD ±2、是否触发"野火"觉醒计数器
5. **B5 赌注桌的钱**：tap 拿全 / tap 拿一半留给输家 / 长按转身 → MND/WLD 走"狼"或"狗"分化
6. **B6 妈妈的热汤**：tap 喝 / tap 把钱放桌上 / 长按沉默 → Episode 收束情绪基调

8–12 个**叶分支**（不影响后续节点，仅当幕镜头变体）：刀叔点头、码头老周递烟、铁丝网割破手、对手收钱前比中指、母亲咳嗽等。

### 3.4 鹰眼数据反馈层
- 每个分支点结算后**右下角浮现 1.5s 微型雷达图变化**，仅显示**本次变化的维度**（不堆 12 维全图）
- 数据**不影响 Episode 1 任何分支可达性**——它只是给玩家"我刚做出的选择是哪种 archetype"的镜面反馈
- Episode 终末汇总六维偏向（"狼/狗/沉默/野火/老练/纯野"），保存到 `state.json` 供后续 Episode 读取

### 3.5 状态持久化
- 走过的所有 `nodeId` 记录到 `progress.choices[]`
- 鹰眼增量记录到 `progress.statDelta`
- 解锁的叶分支 ID 记入 `progress.unlockedLeaves[]`
- 重玩可从任意已通过分支点继续

## 4. Formulas（formulas）

### 4.1 鹰眼增量公式
每个分支点的 `statDelta` 由 BranchSpec 显式声明：
```
finalStat[dim] = clamp(initialStat[dim] + Σ statDelta[dim], F=0, S=100)
```
等级映射：`F:0–9, D:10–24, C:25–39, B:40–59, A:60–79, S:80–100`
等级转换 thresholds 见 §7 Tuning Knobs。

### 4.2 "野火"觉醒触发条件
Episode 1 内累计满足任意 2 项即点亮"野火 v0.1"火苗（不进入 zone，仅作为后续 Episode 的 prereq）：
- B4 选择拖拽扣篮
- B3 选择长按硬扛
- B5 选择拿全部赌金
- 任意 3 个叶分支选了"挑衅向"风味
公式：`wildfire.v01 = (countAggressiveChoices >= 2)`

### 4.3 默认路径 fallback
若玩家在分支点超时（节点结束 +2s 内无输入）：
- 主分支：选 `default` 标的节点
- 叶分支：不解锁，不计入累计计数
- 累计 2 次默认路径 → 提示一次"无声选择也是选择"以增加沉浸（不阻塞）

### 4.4 Episode 收束基调判定
```
ending.mood = argmax({
  压抑: count(所有"忍/避/沉默"选择) * 1.0,
  野火: countAggressiveChoices * 1.2 + (wildfire.v01 ? 2 : 0),
  老练: count(所有"长按"选择) * 0.9,
  纯野: count(所有"tap 第一选项极速点击"<0.4s) * 1.1
})
```
权重在 §7 可调，互动影游不允许出现"无显著倾向"——若四类得分差 ≤ 1，强制按 wildfire bible 设定回落到"野火"基调。

## 5. Edge Cases（edgeCases）

| 编号 | 边界 | 处理 |
|---|---|---|
| E1 | 玩家在视频中段反复 tap | 忽略中段 tap，仅选项窗内的 tap 计数 |
| E2 | 长按到一半松开（<0.8s）| 视为 tap 主路径选项 A |
| E3 | 拖拽方向错误（仅 B4 节点期待向上）| 触发"上篮"分支，不报错；记录方向异常以便分析数据 |
| E4 | 视频节点资源加载失败（占位阶段大概率不发生）| 跳过该节点直接进 default 下一节点，dogfood 阶段不要求兜底 UI |
| E5 | 应用切到后台 / 来电 | 暂停当前节点，回到前台从节点起点重播（不从 mid-frame）|
| E6 | 进度 JSON 损坏 | 提示"读档失败"，按 freshStart 启动；不静默吞错 |
| E7 | 玩家点了所有 BAD-END 叶分支 | 仍能完成 Episode；BAD-END 是叶分支变体，不阻断主线 |
| E8 | wildfire bible 后续 retcon Episode 1 | Episode 1 的 `progress.json` 增加 `bibleVersion: "v2"` 字段，未来用 migration 而非破坏性覆盖 |
| E9 | 玩家**全部**长按 / 全部 tap | 允许但收束基调被强制偏向（见公式 §4.4），不退化为 dead state |
| E10 | 重玩同一分支点选不同支 | 允许；每条分支 `playCount[branchId]++`，第 2 次起视频不变但字幕加 `(回望)` 提示 |

## 6. Dependencies（dependencies）

### 6.1 上游内容依赖
- **wildfire/00-世界观.md** — 铁港、狗笼、12 维鹰眼、熔炉计划等设定（4.8KB，已载入 specs/source/）
- **wildfire/wildfire_story_bible.md** — 主角设定、能力解锁树、12 维数值、篇章结构（14.7KB）
- **wildfire/01-01-狗笼.md** — 第一章散文 11KB，4 幕（搬货→对打→扣篮→回家）

### 6.2 下游 Agent 依赖
- **StoryAgent.analyzeProse**（B5）→ 从 01-01-狗笼.md 抽出 `branches[]` 与 `extractedTruth/*.json`
- **NumericsAgent**（B6）→ 12 维鹰眼 progression 报告，提供 §4.1 thresholds 和 §4.4 权重的初始值
- **PipelineOrchestrator**（B7）→ 产 narrative gameType 的 code/art/audio assets
  - code：Godot scripts 实现 §3 视频节点机 + §4 公式
  - art：占位字幕卡 + 鹰眼浮现 UI 元素
  - audio：心跳低频、扣篮起跳音效（占位 sine wave 即可）
- **BuildAgent**（B8）→ Godot batch export 出 macOS / Android APK
- **PublishAgent**（B9）→ Steam page metadata（zh）

### 6.3 引擎/平台依赖
- Godot 4.x 命令行 export 模板
- Episode 1 不依赖 ink runtime（Phase A 决定：scope A 只生成 .ink 文件，不在引擎内运行）
- 视频占位阶段仅依赖 Godot 内置 ColorRect + Label，无 codec 依赖
- 跨 Episode 的 `progress.json` 路径：`user://wildfire-if/progress.json`

### 6.4 Phase 7 编排依赖
- StoryAgent 的 ExternalStoryBackend = null（agent-neutral 主路径，纯 LLM 反解）
- NumericsAgent Simulator 必须能处理"等级（A/B/C/D/F）↔ 数值"双向映射，否则 §4.1 不可执行（已在风险清单 dogfood 计划 §"已知风险"3 标注）

## 7. Tuning Knobs（tuningKnobs）

集中放在 `data/tuning.json` 内，热更不重启：

| Knob | 类型 | 默认 | 说明 |
|---|---|---|---|
| `gestureWindow.tapMs` | int | 2000 | tap 选项窗时长 |
| `gestureWindow.longPressMinMs` | int | 800 | 长按最小时长 |
| `gestureWindow.swipeMinPx` | int | 120 | 拖拽最小位移 |
| `defaultPathTimeoutMs` | int | 2000 | 节点结束多久后走 default |
| `wildfireV01.threshold` | int | 2 | 触发"野火"火苗的累计 aggressive 选择数 |
| `endingMood.weights` | obj | {压抑:1.0, 野火:1.2, 老练:0.9, 纯野:1.1} | §4.4 权重 |
| `statGradeThresholds` | int[] | [10,25,40,60,80] | F→D→C→B→A→S |
| `radarChartFlashMs` | int | 1500 | 鹰眼增量浮现时长 |
| `replayHintEnabled` | bool | true | 重玩同分支显示 `(回望)` |
| `bibleVersion` | string | "v2" | progress.json 写入用，迁移钩子 |
| `videoPlaceholderBgHex` | string | "#0a0a0a" | 占位黑屏色 |
| `videoPlaceholderDurationSec` | float | 3.0 | 占位单节点时长 |
| `audioCues.heartbeatHz` | float | 1.2 | 心跳低频 |
| `audioCues.swipeWhooshDb` | float | -6.0 | 扣篮起跳音量 |

## 8. Acceptance Criteria（acceptanceCriteria）

### 8.1 内容验收（dogfood scope A）
- ✅ AC1：玩家走完一条主路径耗时 22–28 分钟（占位视频 3s × 25 节点 + 选择思考 ≈ 几分钟，但占位测试只验证流程通畅，**真实时长验收延后到有真视频**）
- ✅ AC2：5–6 个强分支点均产生"后续节点不同"的实际差异（不是字幕变了但路径一样）
- ✅ AC3：8–12 个叶分支均能在某条主路径下被解锁
- ✅ AC4：Episode 终末显示四类基调中**唯一最高**的那一类（不允许并列）
- ✅ AC5：重玩走相同选择 → 节点序列完全一致；走不同选择 → 出现至少 1 处节点差异

### 8.2 技术验收
- ✅ AC6：Godot batch export 产出 .pck/.apk，QualityChecker 不报错（dogfood 容忍 warning，errors 必须 0）
- ✅ AC7：`progress.json` schema 通过 JSON Schema 校验，含 `bibleVersion` 字段
- ✅ AC8：所有节点元数据从 `narrative-graph.json` 加载，**不在代码里硬编码节点 ID**
- ✅ AC9：StoryAgent.analyzeProse 输出的 `branches[]` 数量 ≥ 4（最小可接受），目标 5–6
- ✅ AC10：NumericsAgent 产出的 progression 报告含**沈夜 15→GSL** 的 12 维曲线，不在初始数据为字母时崩溃

### 8.3 dogfood Episode 1 完成判定
- ✅ AC11：driver 脚本 `scripts/dogfood-wildfire-if.ts` 跑完 B1–B10，**任何步骤失败也走完**到 B10 报告
- ✅ AC12：`dogfood-report.md` 落盘到 workspace 根目录，包含每步状态/耗时/错误
- ✅ AC13：报告中**有失败步骤是允许的**（dogfood 目标是暴露不是无瑕），但每个失败必须有 stack 或 message 可定位
- ✅ AC14：报告 commit 到 `gameclaw-os/docs/progress/`，PR 描述列出暴露的 bug 清单

### 8.4 不在本 Episode 验收范围
- ❌ 真视频（占位即可）
- ❌ ink runtime 在引擎内运行
- ❌ Steam 真实上架（PublishAgent 只产 PUBLISH.md）
- ❌ 多语言（仅中文）
- ❌ Episode 2+ 的 callback 实际兑现（仅埋点）
