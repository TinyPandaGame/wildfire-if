# Wildfire-if Episode 1 — 图 / 视频生成总目录（CATALOG）

> **本文件是 image-gen / video-gen agent 的总入口。** 任何 agent 接活前必读这一份。
>
> OS 角色：定结构 + 列槽位 + 装配最终游戏。
> Agent 角色：读 CATALOG → 挑槽位 → 写 prompt → 生成 → push 候选。
> 用户角色：审核 + 风格判断 + 锁定通过版（prompt 与成品都入库）。

---

## 全局规格（所有图/视频通用）

| 类型 | 像素 | 比例 | 格式 | 其他 |
|---|---|---|---|---|
| **角色定型表 / Character Sheet** | 1920×1080 | 16:9 | PNG | 三视图横向并排 |
| **场景建立图 / Scene Establish** | 1920×1080 | 16:9 | PNG | 用作后续 shot 参考 |
| **单镜静态图 / Shot Image** | 1920×1080 | 16:9 | PNG | — |
| **单镜视频 / Shot Video** | 1920×1080 | 16:9 | MP4 | 5–10 秒，24–30 fps，h.264 |

**Steam 横屏定位**：所有视觉资产严格 16:9 横屏。不要竖屏，不要其他比例。

---

## 全局风格基线

**二次元美漫融合风**（Anime × American comic hybrid）。

由 `specs/characters/沈夜/sheet-prompt.md` "二次元美漫融合版（本次确认版）" 章节定义为权威示例。

所有后续角色定型 / 场景建立 / shot 图都应**继承此风格基线**：
- cel-shaded line clarity（赛璐璐线条清晰度）
- US-comic ink texture（美漫墨线质感）
- 写实电影感骨架（cinematic realism foundation）
- 粗粝氛围（gritty mood）

如果某槽位需要风格偏移，请在该槽位 prompt.md 显式说明。

---

## 工作流程（agent 必看）

1. **挑槽位**：从下面三大段中找一个 `Status: NEEDED` 的
2. **读上下文**：每槽位列出了"源参考"路径（story / storyboard / 角色 lock 等），全部读完
3. **写 prompt**：在该槽位的 `prompt.md` 文件里直接写。不要在别处写，不要只口头给。
4. **生成 N 张候选**：丢到 `<slot>/candidates/` 目录，命名 `YYYY-MM-DD-attempt-NN.png/.mp4`
5. **push 候选 + prompt 草稿**：commit 信息注明做了什么（如 `feat(art): 铁柱 sheet 第 1 批候选`）
6. **改 CATALOG status**：把对应槽位 Status 从 NEEDED 改成 IN_REVIEW
7. **等用户审核**：用户筛选最佳 → 复制到 canonical 路径 → 把通过的 prompt 留在 prompt.md（删掉废稿） → status 改 DONE

**不要做的事**：
- 不删别人的候选（只能加）
- 不改 lock.md（除非用户授权）
- 不改其他槽位的 prompt.md
- 不绕过候选区直接写 canonical（必须经过用户审核）

---

## 槽位 1：角色定型表（共 5 个）

| Status | 角色 | First appears | Lock | Sheet prompt | 候选区 | Canonical |
|---|---|---|---|---|---|---|
| 🟢 DONE | **沈夜** | Shot-01 | [lock.md](characters/沈夜/lock.md) ✅ | [sheet-prompt.md](characters/沈夜/sheet-prompt.md) ✅ filled example | [sheet-candidates/](../assets/art/characters/沈夜/sheet-candidates/) (1 张) | [sheet.png + ref.png](../assets/art/characters/沈夜/) ✅ |
| 🟢 DONE | **胖刘**（码头工头）| Shot-03 | [lock.md](characters/胖刘/lock.md) ✅ | [sheet-prompt.md](characters/胖刘/sheet-prompt.md) ✅ | [sheet-candidates/](../assets/art/characters/胖刘/sheet-candidates/) (1 张) | [sheet.png + ref.png](../assets/art/characters/胖刘/) ✅ |
| 🟢 DONE | **铁柱**（195cm 对手）| Shot-07 | [lock.md](characters/铁柱/lock.md) ✅ | [sheet-prompt.md](characters/铁柱/sheet-prompt.md) ✅ | [sheet-candidates/](../assets/art/characters/铁柱/sheet-candidates/) (2 张) | [sheet.png + ref.png](../assets/art/characters/铁柱/) ✅ |
| 🟢 DONE | **老刀**（导师线）| Shot-17 | [lock.md](characters/老刀/lock.md) ✅ | [sheet-prompt.md](characters/老刀/sheet-prompt.md) ✅ | [sheet-candidates/](../assets/art/characters/老刀/sheet-candidates/) (1 张) | [sheet.png + ref.png](../assets/art/characters/老刀/) ✅ |
| 🟢 DONE | **母亲** | Shot-19 | [lock.md](characters/母亲/lock.md) ✅ | [sheet-prompt.md](characters/母亲/sheet-prompt.md) ✅ | [sheet-candidates/](../assets/art/characters/母亲/sheet-candidates/) (1 张) | [sheet.png + ref.png](../assets/art/characters/母亲/) ✅ |

**写 lock 时读这些源**：
- [story/story-bible.md](../story/story-bible.md)（角色表 + 12 维数值轴）
- [story/storyboard/01-01-狗笼.md](../story/storyboard/01-01-狗笼.md)（"关键人物一致性约束" 段 + 各 shot 描写）
- [story/chapters/01-01-狗笼.md](../story/chapters/01-01-狗笼.md)（章节正文人物描写）

---

## 槽位 2：场景建立图（共 5 个）

| Status | 场景 | 出现 shots | Prompt | 候选区 | Canonical |
|---|---|---|---|---|---|
| 🟡 IN_REVIEW | **铁港码头黄昏** | Shot-01, 02, 03 | [scenes/铁港码头/prompt.md](scenes/铁港码头/) ✅ | [candidates/](../assets/art/scenes/铁港码头/candidates/) (2 张) | establish.png |
| 🔴 NEEDED | **锈街** | Shot-04 | [scenes/锈街/prompt.md](scenes/锈街/) ❌ | candidates/ | establish.png |
| 🔴 NEEDED | **狗笼外观** | Shot-05 | [scenes/狗笼-外/prompt.md](scenes/狗笼-外/) ❌ | candidates/ | establish.png |
| 🔴 NEEDED | **狗笼内场** | Shot-06–16 | [scenes/狗笼-内/prompt.md](scenes/狗笼-内/) ❌ | candidates/ | establish.png |
| 🔴 NEEDED | **沈夜家** | Shot-19, 20 | [scenes/沈夜家/prompt.md](scenes/沈夜家/) ❌ | candidates/ | establish.png |

**场景建立图用作后续 shot 的"环境参考"**——shot 生成时引用对应场景的 establish.png 保持视觉一致。

---

## 槽位 3：单镜图 + 单镜视频（共 20 镜，每镜 1 图 + 1 视频）

| # | 标题 | 角色 | 场景 | 图 status | 视频 status |
|---|---|---|---|---|---|
| 01 | [開场建立](shots/individual/shot-01.md) | 沈夜 | 铁港码头 | 🔴 | 🔴 |
| 02 | [劳损细节](shots/individual/shot-02.md) | 沈夜（手）| 铁港码头 | 🔴 | 🔴 |
| 03 | [签字离场](shots/individual/shot-03.md) | 沈夜 + 胖刘 | 铁港码头 | 🔴 | 🔴 |
| 04 | [锈街过渡](shots/individual/shot-04.md) | 沈夜 | 锈街 | 🔴 | 🔴 |
| 05 | [狗笼外观建立](shots/individual/shot-05.md) | （场景）| 狗笼-外 | 🔴 | 🔴 |
| 06 | [入场亮相](shots/individual/shot-06.md) | 沈夜 | 狗笼-内 | 🔴 | 🔴 |
| 07 | [对位铁柱](shots/individual/shot-07.md) | 沈夜 + 铁柱 | 狗笼-内 | 🔴 | 🔴 |
| 08 | [狗笼规则](shots/individual/shot-08.md) | 看客群像 | 狗笼-内 | 🔴 | 🔴 |
| 09 | [第一次突破起手](shots/individual/shot-09.md) | 沈夜 | 狗笼-内 | 🔴 | 🔴 |
| 10 | [换手与起跳](shots/individual/shot-10.md) | 沈夜 | 狗笼-内 | 🔴 | 🔴 |
| 11 | [扣篮命中](shots/individual/shot-11.md) | 沈夜 + 篮筐 | 狗笼-内 | 🔴 | 🔴 |
| 12 | [群体反应](shots/individual/shot-12.md) | 观众-铁柱-沈夜 | 狗笼-内 | 🔴 | 🔴 |
| 13 | [血口细节](shots/individual/shot-13.md) | 沈夜（手）| 狗笼-内 | 🔴 | 🔴 |
| 14 | [抢板快攻蒙太奇](shots/individual/shot-14.md) | 沈夜 | 狗笼-内 | 🔴 | 🔴 |
| 15 | [冲撞摔地](shots/individual/shot-15.md) | 沈夜 | 狗笼-内 | 🔴 | 🔴 |
| 16 | [绝杀滚筐](shots/individual/shot-16.md) | 球 + 人群 | 狗笼-内 | 🔴 | 🔴 |
| 17 | [老刀登场](shots/individual/shot-17.md) | 老刀 | 狗笼-内 | 🔴 | 🔴 |
| 18 | [对话压轴](shots/individual/shot-18.md) | 沈夜 + 老刀 | 狗笼-内 | 🔴 | 🔴 |
| 19 | [家中夜面](shots/individual/shot-19.md) | 沈夜 + 母亲 | 沈夜家 | 🔴 | 🔴 |
| 20 | [尾镜睡前](shots/individual/shot-20.md) | 沈夜 | 沈夜家 | 🔴 | 🔴 |

每个 shot 文件里有该镜的：分镜源参考、参与角色 ref、场景 ref、输出路径、prompt 待填区。

---

## 依赖关系（agent 必读，决定生成顺序）

```
角色定型表（5 个）  ─ 完成后 sheet.png + ref.png 才能给 shot 用 ─→ shot 图 (20)
场景建立图（5 个）  ─ 完成后 establish.png 才能给 shot 用     ─→ shot 图 (20)
shot 图（20）       ─ 完成后才能用作 video 的首帧/参考       ─→ shot 视频 (20)
```

**强烈建议生成顺序**：
1. 角色 sheet（5 个，可并行）
2. 场景 establish（5 个，可并行）
3. shot 图（20 个，按镜号顺序，依赖前两步）
4. shot 视频（20 个，依赖 shot 图）

---

## 状态图例

- 🔴 **NEEDED** — 待 agent 接活
- 🟡 **IN_REVIEW** — agent 已交付候选，等用户审核
- 🟢 **DONE** — 用户已选定 canonical，prompt 已锁定入库
- ⚪ **DEFERRED** — 暂时不做（如 Phase 1 不需要的）

---

## 第一阶段（Phase 1 demo）目标

跑通：剧本分支 → 不同选择播不同视频片段 → 玩家可见可玩。

**MVP 完成标准**：
- 5 角色 sheet 全 DONE
- 5 场景 establish 全 DONE
- 至少 5 个 shot（任选，含分支起点）的图 + 视频 DONE
- 装配进 Godot demo，玩家点击触发对应视频播放

之后再扩到全 20 镜。

---

## Push 流程

```bash
git pull origin main
# 写 prompt / 生图 / 改 CATALOG status
git add <你写的具体路径>
git commit -m "feat(art|video): <slot> 第 N 批候选"
git push origin main
```

**冲突处理**：如果 push 前 main 有更新，先 `git pull --rebase`，再 push。
