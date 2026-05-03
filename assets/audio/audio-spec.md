# Audio Specification

Generated: 2026-04-27T08:53:53.564Z
Game: （overview）

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

## Assets

- `assets/audio/bgm/dock_dusk.mp3` — 码头黄昏环境氛围：海风、远处货轮汽笛、低频 pad (bgm)
- `assets/audio/bgm/cage_tension.mp3` — 狗笼对打张力底鼓：心跳低频 60-90 BPM，可循环 (bgm)
- `assets/audio/sfx/dunk_rim_clang.mp3` — 暴扣后铁框震动：金属嗡鸣余响 1.5s (sfx)
- `assets/audio/sfx/gesture_swipe_whoosh.mp3` — 拖拽起跳音效：低频 whoosh + 屏幕拉伸感 (sfx)
- `assets/audio/sfx/tap_click.mp3` — tap 选项轻闪音：短促 30ms (sfx)