# 场景: 狗笼-内 — 建立图 Prompt

> **Status: FILLED (IN_REVIEW)**
>
> **出现 shots**: 06,07,08,09,10,11,12,13,14,15,16,17,18
> **输出规格**: 1920×1080 PNG
> **候选目录**: `assets/art/scenes/狗笼-内/candidates/`
> **命名**: `YYYY-MM-DD-attempt-NN.png`
> **Canonical**: `assets/art/scenes/狗笼-内/establish.png`

## 写 prompt 时必读

- `story/storyboard/01-01-狗笼.md` — 狗笼内段落（无裁判无规则、残酷对抗、群体噪声）
- `story/chapters/01-01-狗笼.md` — 内场细节：昏黄应急灯、铁丝网、水泥地、汗味烟味咸腥味
- `specs/CATALOG.md` — 全局风格基线（二次元美漫融合）

## 用途说明

场景建立图作为后续 shot 的"环境参考图"——shot 生成时引用此 `establish.png` 保持视觉一致（同一场景多镜不漂移）。

## Prompt（最终用版）

### 中文版

```text
【场景建立图 — 狗笼内场（无人物）】

铁港地下球场“狗笼”内部空间，非法野球场质感。
空间是改造仓库内场：低矮顶棚、裸露钢梁、铁丝网围挡、
粗糙水泥地与临时拼接篮球架。

光线：昏黄应急灯作为主光，局部混入冷白杂散灯，
形成高反差阴影和脏雾感；整体偏压抑、闷热、粗粝。

场地细节：
- 地面为粗糙水泥球场地（非木地板），磨损明显，有球鞋摩擦痕与灰尘，不要油膜镜面反光
- 篮筐与铁架有锈蚀和震动磨损痕迹
- 场边有简陋板凳、啤酒箱、塑料桶、旧毛巾、零散杂物
- 墙面有剥落涂层、潮斑、涂鸦与破损海报
- 空气感要体现“烟、汗、海风咸腥混合”的闷场

构图：16:9 横屏，Establishing + LS。
给出更大尺度的完整内场结构（篮筐、边线缓冲区、围挡外观众可站立区关系），
用于后续 shot-06 到 shot-18 保持空间一致。

禁止人物：不出现任何人物或清晰人形剪影（纯场景参考）。

风格：
二次元美漫融合风（Anime × American comic hybrid）
+ 写实电影感骨架（cinematic realism foundation）
+ 赛璐璐线条清晰度 + 美漫墨线质感
+ 粗粝纪实纹理（gritty documentary texture）

输出：1920×1080 PNG

NEGATIVE:
people, human figures, character silhouettes,
clean professional arena, NBA-style modern stadium,
wood flooring, glossy varnished floor, oily reflective floor,
bright cheerful lighting, full night exterior sky,
cyberpunk neon, fantasy architecture,
oversaturated cartoon colors,
text watermark, logo
```

### English Version

```text
[SCENE ESTABLISH — Dog Cage Interior / 狗笼-内 — NO CHARACTERS]

Interior of the underground illegal streetball court "Dog Cage" in Tiegang.
A converted warehouse court: low ceiling, exposed steel beams,
chain-link enclosures, rough concrete floor, improvised old hoop structure.

Lighting:
Dim yellow emergency lamps as key light,
with occasional cold-white spill creating harsh contrast and dirty haze.
Overall mood is oppressive, humid, gritty.

Court details:
Floor is rough concrete court (NOT wooden floor), heavily worn with shoe friction marks and dust; avoid oily glossy reflections.
- Rusted rim/backboard supports with impact wear
- Sideline clutter: simple benches, beer crates, plastic buckets, old towels
- Walls with peeling paint, damp patches, graffiti, torn posters
- Air feeling should imply smoke + sweat + salty harbor humidity

Composition: 16:9 widescreen, establishing long shot.
Show a larger full interior layout (hoop, sideline buffer zones, and standing spectator area outside the cage enclosure)
so shots 06–18 can stay spatially consistent.

No people, no visible human silhouettes (pure environment reference).

Style:
Anime × American comic hybrid,
cinematic realism foundation,
cel-shaded line clarity + US-comic ink texture,
gritty documentary-like surface detail.

Output: 1920x1080 PNG.

NEGATIVE:
people, human figures, character silhouettes,
clean professional arena, modern NBA-like stadium,
bright cheerful lighting, exterior night sky framing,
cyberpunk neon, fantasy architecture,
oversaturated cartoon colors,
watermark, logo, text
```