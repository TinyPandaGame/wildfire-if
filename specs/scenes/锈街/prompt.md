# 场景: 锈街 — 建立图 Prompt

> **Status: FILLED (IN_REVIEW)**
>
> **出现 shots**: 04
> **输出规格**: 1920×1080 PNG
> **候选目录**: `assets/art/scenes/锈街/candidates/`
> **命名**: `YYYY-MM-DD-attempt-NN.png`
> **Canonical**: `assets/art/scenes/锈街/establish.png`

## 写 prompt 时必读

- `story/storyboard/01-01-狗笼.md` — Shot-04（城市底层生态，真实烟火+荒败）
- `story/chapters/01-01-狗笼.md` — 锈街细节：修车铺卷帘门、早餐摊收蒸笼、路边喝啤酒吹牛
- `specs/CATALOG.md` — 全局风格基线（二次元美漫融合）

## 用途说明

场景建立图作为后续 shot 的"环境参考图"——shot 生成时引用此 `establish.png` 保持视觉一致（同一场景多镜不漂移）。

## Prompt（最终用版）

### 中文版

```text
【场景建立图 — 锈街（无人物）】

铁港旧城区“锈街”，白天尾段的黄昏时刻（仍有日间亮度）。
这是从码头通往狗笼的过渡街区：真实烟火感 + 荒败工业边缘感。

街道元素：
- 一侧修车铺卷帘门已拉下，门面老旧、锈迹、油渍明显
- 早餐摊收摊状态：蒸笼、折叠桌、塑料桶、残余水渍
- 路边旧塑料凳、啤酒瓶箱、烟头、碎纸和生活杂物
- 墙面掉漆、潮湿霉斑、手写小广告残痕
- 电线杂乱、路灯杆老旧、窄巷纵深形成“通向狗笼方向”的视觉通道

光线与氛围：
脏橘色黄昏主调，混入少量冷灰阴影；
空气略潮，地面有零散反光水渍；
整体感觉是“有人生活过、正在散场、但仍粗粝紧绷”。

构图：16:9 横屏，LS，平视，强调巷道透视与纵深。
不出现任何人物或清晰人形剪影（纯场景参考）。

风格：
二次元美漫融合风（Anime × American comic hybrid）
+ 写实电影感骨架（cinematic realism foundation）
+ 赛璐璐线条清晰度 + 美漫墨线质感
+ 纪实粗粝纹理（gritty documentary texture）

输出：1920×1080 PNG

NEGATIVE:
people, human figures, character silhouettes,
clean modern commercial street, luxury urban district,
full night scene, cyberpunk neon, fantasy architecture,
over-saturated candy colors, cute cartoon style,
text watermark, logo
```

### English Version

```text
[SCENE ESTABLISH — Rust Street / 锈街 — NO CHARACTERS]

An old transition street in Tiegang, late daytime dusk (still daylight-bright),
connecting the harbor area to the Dog Cage court.
Mood: grounded street life + urban decay.

Street details:
- A closed repair shop with a pulled metal shutter, rust and grease stains
- A breakfast stall in pack-up state: steam baskets, foldable table, plastic buckets, wet traces
- Old plastic stools, beer crates, cigarette butts, paper scraps, daily clutter
- Peeling paint walls, damp mildew marks, torn handwritten ad residues
- Dense overhead cables, aging lamp posts, narrow alley perspective channeling toward Dog Cage direction

Lighting & atmosphere:
Dirty orange dusk mixed with cool gray shadows,
slightly humid air, scattered wet reflections on rough pavement.
Feels lived-in, winding down, but still tense and gritty.

Composition: 16:9 widescreen, long shot, eye-level,
emphasize alley depth and directional perspective.
No people, no visible human silhouettes (pure environment reference).

Style:
Anime × American comic hybrid,
cinematic realism foundation,
cel-shaded line clarity + US-comic ink texture,
gritty documentary-like surface detail.

Output: 1920x1080 PNG.

NEGATIVE:
people, human figures, character silhouettes,
clean modern commercial street, luxury urban district,
full night scene, cyberpunk neon, fantasy architecture,
oversaturated candy colors, cute cartoon style,
watermark, logo, text
```