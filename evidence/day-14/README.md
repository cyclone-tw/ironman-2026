# Day 14 證據

> 什麼時候該收手？review 迴圈的收斂判準

## 這裡有什麼

review 輪次契約的兩個端點：出事端的「12 輪 quota 事故」與順利收斂端的「PR #140 加開 delta round 走到 approved」。

## 怎麼跑

```bash
# 看輪次失控的原發事故 PR
gh pr view 136 --repo cyclone-tw/cyclone-hermes

# 看順利收斂的 round 3（delta、Cyclone 核准加開）
gh pr view 140 --repo cyclone-tw/cyclone-hermes --json comments \
  --jq '.comments[] | select(.body | contains("round 3")) | .body'
```

## 會看到什麼

- #136 的 quota 事故背景（流程收不住；詳情見文章引用的 wiki 契約去敏節錄）
- round 3 摘要：「**VERDICT: approved** — 三項 round 2 修正確認正確，無新問題。依契約 merge」
- 「超過 2 輪未達 approved 已停下請示 Cyclone，Cyclone 核准跑 round 3 delta review」原文
