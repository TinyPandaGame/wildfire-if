# 场景: 铁港码头 — 建立图 Prompt

> **Status: FILLED (IN_REVIEW)**
>
> **出现 shots**: 01,02,03
> **输出规格**: 1920×1080 PNG
> **候选目录**: `assets/art/scenes/铁港码头/candidates/`
> **命名**: `YYYY-MM-DD-attempt-NN.png`
> **Canonical**: `assets/art/scenes/铁港码头/establish.png`

## 写 prompt 时必读

- `story/storyboard/01-01-狗笼.md` — Shot-01 的开场建立要求
- `story/chapters/01-01-狗笼.md` — “码头黄昏很短、脏橘→惨白探照灯切割”的环境细节
- `specs/CATALOG.md` — 全局风格基线（二次元美漫融合）

## 用途说明

场景建立图作为后续 shot 的"环境参考图"——shot 生成时引用此 `establish.png` 保持视觉一致（同一场景多镜不漂移）。

## Prompt（最终用版）

### 中文版

```text
【场景建立图 — 铁港码头黄昏（无人物）】

铁港工业海港，黄昏即将入夜的瞬间。
天空呈“脏橘色快速转暗蓝黑”的过渡，太阳已沉到海平面下缘。
巨量旧集装箱形成“集装箱森林”，层层堆叠，占据画面上半部主体。
集装箱表面有掉漆、锈蚀、编号磨损、盐雾腐蚀痕迹。

港区地面潮湿粗糙，可见油污、水渍、轮胎与拖拽痕迹。
远处有货车、吊机、缆绳、金属护栏与港口探照灯塔。
探照灯从高处打下冷白硬光，把环境切成明暗碎片。
整体气氛压抑、粗粝、有海风咸腥感与工业噪声感。

构图：16:9 横屏，ELS 大远景，略高角俯视 45°，
强调“上方巨型工业结构压住下方活动空间”的压迫关系。
不出现任何人物或清晰人形剪影（用于纯场景参考）。

风格：
二次元美漫融合风（Anime × American comic hybrid）
+ 写实电影感骨架（cinematic realism foundation）
+ 赛璐璐线条清晰度 + 美漫墨线质感
+ 粗粝纪实质感（gritty texture）

输出：1920×1080 PNG

NEGATIVE:
people, human figure, character silhouette,
clean modern harbor, bright cheerful travel photo,
sunny blue sky, cyberpunk neon, fantasy architecture,
over-saturated colors, soft dreamy haze,
cartoon cute style, low-detail blur, text watermark, logo
```

### English Version

```text
[SCENE ESTABLISH — Tiegang Harbor at Dusk — NO CHARACTERS]

A decaying industrial harbor at the edge of sunset into night.
Sky transitions from dirty orange to deep blue-black; sun already below horizon.
Massive stacks of old cargo containers form a “container forest,”
dominating the upper half of the frame.
Container surfaces show peeling paint, rust, worn serial markings,
and salt-air corrosion.

Ground is rough and damp with oil stains, water streaks,
tire tracks and dragged-cargo marks.
In distance: cargo trucks, cranes, steel cables, railings,
and high-mounted searchlights.
Searchlights cast cold white hard beams that slice the space into fragmented highlights/shadows.
Mood is oppressive, gritty, wind-swept, salty, industrial.

Composition: 16:9 widescreen, extreme long shot,
slightly high 45° oblique view,
emphasize heavy industrial mass pressing down on human-scale space.
No people, no visible human silhouettes (pure environment reference).

Style:
Anime × American comic hybrid,
cinematic realism foundation,
cel-shaded line clarity + US-comic ink texture,
gritty documentary-like finish.

Output: 1920x1080 PNG.

NEGATIVE:
people, human figures, character silhouettes,
clean modern port, bright cheerful travel look,
clear sunny sky, cyberpunk neon, fantasy architecture,
oversaturated palette, dreamy haze,
cute cartoon style, low-detail blur, watermark, logo, text
```