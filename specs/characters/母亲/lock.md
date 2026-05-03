# 母亲 — Character Lock

> 角色锁是 scene-agnostic：跨任意镜头/场景，母亲 的外形必须保持一致。
> 任何含 母亲 的 shot prompt 都要把本文档的视觉字段嵌入。
>
> **Status: TODO** — 此文件待 agent 填充。参考 `specs/characters/沈夜/lock.md` 的字段结构。

## 上下文（写时读）

- [story/story-bible.md](../../../story/story-bible.md)（角色表，如果 母亲 在表里）
- [story/storyboard/01-01-狗笼.md](../../../story/storyboard/01-01-狗笼.md)（"关键人物一致性约束"段 + 出现 shots 的描写）
- [story/chapters/01-01-狗笼.md](../../../story/chapters/01-01-狗笼.md)（章节正文里的人物描写）
- 全局风格基线: 二次元美漫融合（[specs/CATALOG.md](../../CATALOG.md)）

## 字段（按沈夜模板填）

- 基础（年龄/身高/体型/背景）
- 脸（脸型/五官/表情基线/肤色）
- 发（发型/发色）
- 服装
- 标志性细节
- 气质 / 姿态
- 负面约束

## 配套资产

- 三视图定型表: `assets/art/characters/母亲/sheet.png`
- canonical reference: `assets/art/characters/母亲/ref.png`
- 生成 prompt: `specs/characters/母亲/sheet-prompt.md`
