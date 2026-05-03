# wildfire-if

> **野火 · 互动影游 Episode 1** — GameClawOS dogfood 项目工作仓

## 项目定位

`wildfire-if` 是 [GameClawOS](https://github.com/TinyPandaGame/GameClawOS) 的 dogfood 标的——一个基于小说《野火》第一章《狗笼》改编的横屏 PC（Steam 定位）互动影视游戏。

本仓库装：
- **生产 artifacts**：shot manifest、生成的图/视频资产、build 产物的 specs
- **dogfood 工作区**：用于真实跑 GameClawOS 端到端管线，暴露并修复 OS 缺口

## 与其它仓的关系

```
GameClawOS                   wildfire-if (本仓)              jisawStory
（OS 工具/agent/管线）   →   （游戏 demo 工作区）   ←   （剧本/世界观/分镜原料）
```

- **GameClawOS**（代码仓）：装 GDDAgent / NarrativeGenerator / BuildAgent / Godot 集成等工具
- **jisawStory**（内容仓）：装小说原文、世界观、分镜脚本——作为 wildfire-if 的 `content-source/` 子目录引入
- **wildfire-if**（本仓）：装跑 GameClawOS 后的产物 + 真实游戏 demo 资产

## 目录结构

```
wildfire-if/
├── content-source/         ← 不在本仓（gitignored），按需 clone jisawStory
├── specs/                  ← OS 派生：GDD、narrative graph、shot manifests
│   ├── gdd.md
│   ├── chapters-ink/
│   ├── source/
│   ├── truth/
│   ├── numerics/
│   └── shots/              ← 即将加入：shot manifests + character locks
├── assets/
│   ├── code/godot/         ← Godot 项目代码（GameManager.gd、Main.tscn）
│   ├── data/               ← narrative-graph.json + tuning.json
│   ├── art/
│   │   ├── characters/     ← 角色定型表（character sheets）+ ref images
│   │   └── shots/          ← 每镜静态图（shot-XX.png）
│   ├── video/
│   │   └── shots/          ← 每镜视频片段（shot-XX.mp4）
│   ├── audio/              ← BGM / 音效
│   └── MANIFEST.md
├── build/                  ← 不在本仓（gitignored），gameclaw build 自动生成
├── production/             ← session 状态记录
├── publish/                ← 商店页 / 营销素材
├── dogfood-report.md       ← dogfood 跑过的报告
└── .gameclaw/project.json  ← 项目 meta（state.json 不入版本）
```

## 起步流程

```bash
# 1. clone 工作区
git clone https://github.com/TinyPandaGame/wildfire-if.git
cd wildfire-if

# 2. clone 内容源到 content-source/（按需）
git clone https://github.com/TinyPandaGame/jisawStory.git content-source

# 3. 装 GameClawOS（如果未装）
# 见 GameClawOS repo 的 README

# 4. 跑构建
npx tsx /path/to/GameClawOS/gameclaw-os/src/index.ts build

# 5. 启动 demo（需 Godot CLI 已装）
godot --main-pack build/game.pck
```

## 当前状态

- ✅ Phase 1 端到端跑通：GameManager.gd / UIController.gd / narrative-graph 真跑，game.pck 真生成、Godot 真启动
- 🔄 视频化进行中：shot manifest + 角色定型 + 图/视频生成 + 拼装
- 📌 详见 GameClawOS 的 dogfood 进度文档

## License

MIT（暂定，以 GameClawOS 为准）
