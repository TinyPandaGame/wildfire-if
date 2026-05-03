# wildfire-if 项目结构（Agent 必读）

> 任何 agent 接手本项目前先读完本文档。它说明每个目录放什么、要修改什么去哪、生成什么写到哪。

---

## ⚡ 图 / 视频生成 agent — 直接看这里

→ **[`specs/CATALOG.md`](specs/CATALOG.md)** — 总目录，列所有需要生成的图与视频槽位（5 角色 + 5 场景 + 20 shot 图 + 20 shot 视频），含全局风格基线、像素规格、工作流程、状态追踪。

**全局规格**：所有图与视频 1920×1080（16:9 Steam 横屏）；视频 5–10s / 24–30fps / h.264。
**全局风格**：二次元美漫融合（详见 CATALOG）。

---

---

## 目录速查表

| 目录 | 内容 | 谁写谁读 |
|---|---|---|
| `story/` | **canonical 故事内容**（剧本/世界观/分镜原文）| 用户主写；AI 提建议 |
| `imports/` | **通用方法论参考**（短剧基础知识、prompt 库等借鉴材料）| 镜像；不直接编辑 |
| `specs/` | **OS 派生 + agent 可执行 specs**（GDD、prompts、manifests）| OS 写为主；agent 读 |
| `assets/` | **真实生成的产物**（图、视频、音频、Godot 代码）| Agent 写候选；用户筛选 |
| `production/` | session/sprint 状态记录 | 系统写 |
| `publish/` | 商店页 / 营销素材 | PublishAgent 写 |
| `build/` | gameclaw build 输出（**不入版本**）| BuildAgent 写 |
| `.gameclaw/` | 项目 meta（部分入版本）| OS 写 |

---

## 你想做什么 → 去哪

### 改故事内容（剧本 / 世界观 / 分镜）
→ `story/`

```
story/
├── world-bible.md              ← 世界观
├── story-bible.md              ← 故事圣经（10 篇大纲 + 角色 + 数值轴）
├── chapters/<id>.md            ← 章节正文
└── storyboard/<id>.md          ← 章节分镜（含每镜的景别/角度/动作/提示词）
```

### 角色定型图（character sheet）

**1. agent 读 prompt**：
```
specs/characters/<name>/sheet-prompt.md
```
（中英双语，复制到 GPT-Image-2 / Midjourney / 即梦 web 等直接跑）

**2. agent 写候选图**：
```
assets/art/characters/<name>/sheet-candidates/YYYY-MM-DD-attempt-NN.png
```

**3. 用户筛选 → 写入 canonical**：
```
assets/art/characters/<name>/sheet.png    ← 选定的三视图
assets/art/characters/<name>/ref.png      ← canonical 参考图
```

### 单镜静态图

**1. agent 读 prompt**：
```
specs/shots/individual/shot-XX.md         ← 详细人读版
specs/shots/shots-batch-XX.json           ← 机器读 manifest（含完整 spec）
```

**2. agent 写候选**：
```
assets/art/shots/shot-XX-candidates/<timestamp>-attempt-NN.png
```

**3. 用户筛选**：
```
assets/art/shots/shot-XX.png
```

### 单镜视频

**1. agent 读 prompt**：同上 manifest 的 `video.prompt_cn` 字段；或用预生成的 jimeng 命令 `video.jimengCommand`

**2. agent 写候选**：
```
assets/video/shots/shot-XX-candidates/<timestamp>-attempt-NN.mp4
```

**3. 用户筛选**：
```
assets/video/shots/shot-XX.mp4
```

---

## Agent 操作规范（避免互相覆盖）

1. **不要删用户的候选/定稿文件**——只能加；删除只由用户操作
2. **候选文件命名带时间戳 + attempt 序号**——避免冲突：`YYYY-MM-DD-attempt-NN.<ext>`
3. **commit message 注明做了什么**：`feat(art): 沈夜 sheet 第 2 批候选 (5 张)`
4. **修改 spec/prompt 之前先读最新 main**——其他 agent 可能已更新
5. **大批量生成（>5 张）前先小批验证**：先跑 1-2 张让用户校 prompt 质量

---

## Push 流程

```bash
git pull origin main           # 同步最新
# ... 生成文件 ...
git add <你写的具体路径>          # 不要 git add -A
git commit -m "feat(...): ..."
git push origin main
```

---

## 仓库关系

```
GameClawOS               wildfire-if (本仓)         jisawStory
（OS 工具/agent）   →    （游戏 demo 项目）   ←    （其他小说 / 通用素材）
```

- `GameClawOS`：装 agent / pipeline / 构建工具——agent 实现住这里
- `jisawStory`：装非 wildfire 的内容（《纸偶》小说、其他游戏 GDD）
- **本仓 wildfire-if**：装 wildfire 全部内容 + 全部生成产物，自包含
