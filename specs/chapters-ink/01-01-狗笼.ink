// wildfire-if Episode 1 · 狗笼
// 由 StoryAgent.analyzeProse 从 01-01-狗笼.md 生成

VAR pwr = 0
VAR mnd = 0
VAR wld = 0
VAR jmp = 0
VAR aggressive = 0
VAR mentor_path = false
VAR mood = "野火"

-> dock_signoff

=== dock_signoff ===
沈夜扛着最后一箱冻虾从货车上跳下来。胖刘把夹板递过来。
"又去狗笼？你那小身板，早晚被人打断腿。"

* [沉默走开] -> dock_silent
* ["今晚就打断他。"] -> dock_taunt
* ["还能多搬几箱吗？"] -> dock_extra

=== dock_silent ===
~ mnd = mnd - 1
~ wld = wld + 1
沈夜没回头。脚步快了一点。
-> rust_street

=== dock_taunt ===
~ wld = wld + 2
~ aggressive = aggressive + 1
胖刘愣了一下，然后笑出声。这话明天会传到铁柱耳朵里。
-> rust_street

=== dock_extra ===
~ pwr = pwr + 1
~ mnd = mnd + 1
胖刘从兜里多掏出十块零钱。'这小子，懂事。'
-> rust_street

=== rust_street ===
锈街灯下穿过，巷口有人喊：'野狗！今晚来不来？'
沈夜：'来。'
-> cage_door

=== cage_door ===
铁皮门嘎吱响着推开。两拨人已经在打。
* [直接脱外套上场] -> cage_enter
* [在铁丝网边蹲守听 1.5s] -> cage_watch

=== cage_enter ===
沈夜把外套扔在铁丝网上。
-> first_attack

=== cage_watch ===
~ mnd = mnd + 1
他听到有人说铁柱的腰伤复发了。
-> first_attack

=== first_attack ===
铁柱压过来。一米九五的身体像移动的墙，封死内线。队友被撞开、被扇飞。球滚到沈夜脚边。
他弯腰捡起来。整个狗笼的声音被调低了。
* [tap 上篮 — 低调过铁柱] -> low_layup
* [拖拽向上 — 暴扣] -> dunk
* [拖拽向左 — 急停假动作] -> fake_layup

=== low_layup ===
~ mnd = mnd + 1
沈夜从铁柱左侧半步空档钻进去，一个低弧度上篮。球贴板进框。'压得住。'场边一个老头说。
-> mid_game

=== dunk ===
~ jmp = jmp + 3
~ wld = wld + 2
~ aggressive = aggressive + 1
码头练出来的双腿像弹簧展开。一米七三的身体越过铁柱伸出的手臂。
他没有上篮。他把球砸进了篮筐里。嘭——铁框都在震。
手指蹭到铁框边缘割破。血珠渗出来。他不在乎。
-> mid_game

=== fake_layup ===
~ wld = wld + 1
沈夜一个生硬的急停后撤步上篮。命中。但场边老头皱了下眉，没说话就走了。
-> mid_game

=== mid_game ===
比赛继续。沈夜一个人扛着——抢篮板，自己上。十个球拿了七个。
最后一个球，铁柱豁出去用身体撞翻沈夜。后背摔在水泥地上。但球已经出手——歪歪扭扭的抛射，在筐上转两圈滚进。10-6。
* [立刻起身] -> stand_up
* [躺地长按看天 1s] -> lie_back
* [盯铁柱不动两秒] -> stare_iron

=== stand_up ===
~ wld = wld + 1
~ mnd = mnd + 1
沈夜从地上爬起来。后背火辣辣，明天搬货又要疼。
-> old_blade

=== lie_back ===
~ mnd = mnd + 2
他偏头看铁丝网外那一块天。第一次想到了爸。
-> old_blade

=== stare_iron ===
~ wld = wld + 2
~ mnd = mnd - 1
~ aggressive = aggressive + 1
两秒。铁柱把眼神别开。但记住了。
-> old_blade

=== old_blade ===
场边铁丝网上靠着一个瘦长老头。叼着没点的烟。
'起来，野狗。你扣篮落地的方式不对。再这么落，膝盖撑不过二十岁。'
'……你谁啊。'
'刀。他们叫我老刀。我可以教你打球。'
* [tap '为什么？' 然后接受] -> accept_mentor
* [tap '不要钱我也不要' 转身] -> refuse_mentor
* [长按沉默 — 不答应不拒绝] -> defer_mentor

=== accept_mentor ===
~ mnd = mnd + 1
~ mentor_path = true
'明天来不来？''来。'老刀走路有点跛。
-> go_home

=== refuse_mentor ===
~ wld = wld + 3
~ mnd = mnd - 2
~ aggressive = aggressive + 1
沈夜转身往铁皮门走。老刀没追。'残缺野火'路径触发。
-> go_home

=== defer_mentor ===
~ mnd = mnd + 2
~ wld = wld + 1
沈夜没说话。三天后老刀又会来。
-> go_home

=== go_home ===
筒子楼四层。厨房灯亮着。妈妈在桌边算账，桌上盖盘子的鸡蛋面。
'吃。后背怎么了？''搬货蹭的。'
碘伏放上桌。
'你爸要是在，不会让你去那个地方。'
* [tap '我爸要是在，我就不用去码头搬货了。'] -> echo_wildfire
* [tap '知道了，妈。' 默默吃面] -> echo_silent
* [长按把今晚赢的钱放桌上 — 不说话] -> echo_seasoned

=== echo_wildfire ===
~ mood = "野火"
母亲沉默。背身洗手。沈夜回房，被子拉过头顶，在汽笛声里睡着。
'你不会打篮球。'老刀那句话在脑子里反复回放。
-> ending

=== echo_silent ===
~ mood = "压抑"
母亲明显松一口气。沈夜端起碗喝完面汤。明天上午会去学校。
-> ending

=== echo_seasoned ===
~ mood = "老练"
母亲愣了一下，没说话。第二天她在鱼市对老顾客说：'我家那小子，长大了。'
-> ending

=== ending ===
Episode 1 结束。基调：{mood}。野火火苗：{aggressive >= 2: 已点亮 | 未点亮}。
-> END
