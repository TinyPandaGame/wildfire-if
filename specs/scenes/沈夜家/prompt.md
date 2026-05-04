# 场景: 沈夜家 — 建立图 Prompt

> **Status: FILLED (IN_REVIEW)**
>
> **出现 shots**: 19,20
> **输出规格**: 1920×1080 PNG
> **候选目录**: `assets/art/scenes/沈夜家/candidates/`
> **命名**: `YYYY-MM-DD-attempt-NN.png`
> **Canonical**: `assets/art/scenes/沈夜家/establish.png`

## 写 prompt 时必读

- `story/storyboard/01-01-狗笼.md` — Shot-19/20（疲惫克制、狭小室内、尾镜钝痛希望）
- `story/chapters/01-01-狗笼.md` — 家庭空间细节：筒子楼、水泥墙脱落、窗缝海风、简陋厨房与小房间
- `specs/CATALOG.md` — 全局风格基线（二次元美漫融合）

## 用途说明

场景建立图作为后续 shot 的"环境参考图"——shot 生成时引用此 `establish.png` 保持视觉一致（同一场景多镜不漂移）。

## Prompt（最终用版）

### 中文版

```text
【场景建立图 — 沈夜家（无人物）】

铁港筒子楼四层的老旧小户型室内，夜间家用灯光。
空间不宽裕但不是极端逼仄：两室一厅的老旧小户型，
可正常活动，整体是底层家庭长期使用痕迹，简陋但有人气。

关键环境细节：
- 水泥墙腻子大面积脱落，局部潮斑
- 厨房排风扇老旧损坏，窗户关不严，窗缝能感到海风
- 晾衣绳和轻微晃动衣物
- 小餐桌与板凳、简易碗盘、家用药水（如碘伏）可作为生活痕迹
- 房间内有单人床、小书桌、摊开的课本、床边旧鞋

光线与氛围：
暖黄室内灯为主，阴影柔但空间拥挤。
情绪是“疲惫、克制、现实压力”，同时保留一点生活温度。

构图：16:9 横屏，Establishing + LS（室内全景倾向）。
强调“稍大一点”的可活动空间与功能区关系（餐桌区→过道→睡眠/书桌区），
保留破旧感但避免过度压缩成拥挤盒子。

禁止人物：不出现任何人物或清晰人形剪影（纯场景参考）。

风格：
二次元美漫融合风（Anime × American comic hybrid）
+ 写实电影感骨架（cinematic realism foundation）
+ 赛璐璐线条清晰度 + 美漫墨线质感
+ 克制的现实主义粗粝纹理

输出：1920×1080 PNG

NEGATIVE:
people, human figures, character silhouettes,
luxury apartment, modern minimalist high-end interior,
bright cheerful showroom lighting,
fantasy decorations, cyberpunk neon,
oversaturated cute cartoon palette,
watermark, logo, text
```

### English Version

```text
[SCENE ESTABLISH — Shen Ye's Home / 沈夜家 — NO CHARACTERS]

Old compact apartment interior in Tiegang at night,
inside an aging corridor-style residential building.
Space should feel modest and worn (not luxurious), slightly roomier than cramped-box interiors, low-income but lived-in.

Key environmental details:
- Concrete walls with peeling putty and damp stains
- Old broken kitchen exhaust fan
- Window that does not seal well, subtle sea-wind feeling
- Indoor laundry line with lightly shifted hanging clothes
- Small table and stools, simple bowls/utensils,
  practical home items (e.g., antiseptic bottle cues)
- Single bed, small study desk, open textbooks, worn shoes by bed

Lighting & mood:
Warm yellow domestic lighting, soft but tight interior shadows.
Emotion: fatigue, restraint, economic pressure,
with a slight trace of home warmth.

Composition: 16:9 widescreen, interior establishing long shot.
Show a slightly larger usable interior depth and clear zone relations (table area -> corridor -> bed/study area),
avoid overly cramped box-like framing.

No people, no visible human silhouettes (pure environment reference).

Style:
Anime × American comic hybrid,
cinematic realism foundation,
cel-shaded line clarity + US-comic ink texture,
restrained gritty realism texture.

Output: 1920x1080 PNG.

NEGATIVE:
people, human figures, character silhouettes,
luxury apartment, modern high-end minimalist interior,
bright cheerful showroom lighting,
fantasy decor, cyberpunk neon,
oversaturated cute-cartoon palette,
watermark, logo, text
```