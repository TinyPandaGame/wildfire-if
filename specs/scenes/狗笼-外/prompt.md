# 场景: 狗笼-外 — 建立图 Prompt

> **Status: FILLED (IN_REVIEW)**
>
> **出现 shots**: 05
> **输出规格**: 1920×1080 PNG
> **候选目录**: `assets/art/scenes/狗笼-外/candidates/`
> **命名**: `YYYY-MM-DD-attempt-NN.png`
> **Canonical**: `assets/art/scenes/狗笼-外/establish.png`

## 写 prompt 时必读

- `story/storyboard/01-01-狗笼.md` — Shot-05（危险感、地下感，低角仰拍，推近铁皮门）
- `story/chapters/01-01-狗笼.md` — “狗笼从外面看就是破仓库，铁皮门歪斜，门内昏黄灯”
- `specs/CATALOG.md` — 全局风格基线（二次元美漫融合）

## 用途说明

场景建立图作为后续 shot 的"环境参考图"——shot 生成时引用此 `establish.png` 保持视觉一致（同一场景多镜不漂移）。

## Prompt（最终用版）

### 中文版

```text
【场景建立图 — 狗笼外观（无人物）】

铁港旧工业区里的地下球场入口“狗笼”外观。
外部伪装成破旧仓库：铁皮门歪斜挂在老合页上，
门体锈蚀、划痕、褪色标识与补丁焊缝清晰可见。

构图核心：歪斜铁门占画面左侧约 2/3，
门缝与门内暗部透出昏黄应急灯光，暗示内部正在活动。
周围环境包含：粗糙水泥地、旧铁丝网、废弃木箱/铁桶、潮湿墙面、
手写涂鸦与撕裂海报残片，体现地下与危险感。

时间：白天尾段黄昏（非夜景），整体仍保留日间亮度，
但局部阴影加重，形成“外部偏冷、门内偏暖”的光色对比。

镜头语言：Establishing + LS，低角仰拍，
强调入口压迫感与“即将进入禁区”的心理预期。

禁止人物：不出现任何人物或清晰人形剪影（纯场景参考）。

风格：
二次元美漫融合风（Anime × American comic hybrid）
+ 写实电影感骨架（cinematic realism foundation）
+ 赛璐璐线条清晰度 + 美漫墨线质感
+ 粗粝工业纪实纹理（gritty industrial texture）

输出：1920×1080 PNG

NEGATIVE:
people, human figures, character silhouettes,
clean modern warehouse, bright mall-like entrance,
full night scene, cyberpunk neon, fantasy architecture,
over-saturated colors, cute cartoon style,
text watermark, logo
```

### English Version

```text
[SCENE ESTABLISH — Dog Cage Exterior / 狗笼-外 — NO CHARACTERS]

Exterior entrance of the underground court "Dog Cage" in Tiegang's old industrial zone.
From outside, it looks like a decaying warehouse.
A skewed corrugated metal gate hangs on old hinges,
with visible rust, scratches, faded markings, and patch weld seams.

Composition key:
The tilted metal gate occupies roughly left two-thirds of frame.
Through the gate gap and interior darkness, dim yellow emergency light leaks out,
suggesting active life inside.

Surroundings:
Rough concrete ground, old chain-link fence, discarded crates/barrels,
damp stained walls, hand-painted graffiti, torn poster remnants.
Overall tone: underground, unsafe, illicit.

Time of day:
Late daytime dusk (not full night), still daylight-bright overall,
with deepening local shadows and warm-inside vs cool-outside contrast.

Camera language:
Establishing + long shot, low-angle upward view,
building pressure and a threshold-into-danger feeling.

No people, no visible human silhouettes (pure environment reference).

Style:
Anime × American comic hybrid,
cinematic realism foundation,
cel-shaded line clarity + US-comic ink texture,
gritty industrial documentary texture.

Output: 1920x1080 PNG.

NEGATIVE:
people, human figures, character silhouettes,
clean modern warehouse, bright commercial entrance,
full night scene, cyberpunk neon, fantasy architecture,
oversaturated colors, cute cartoon style,
watermark, logo, text
```