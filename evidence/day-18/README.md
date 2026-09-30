# Day 18 證據

> 那張卡片被永久鎖死了

## 這裡有什麼

鎖死事故的修復 PR（Dashboard #261），包含兩個雙重判準的實例。

## 怎麼跑

```bash
gh pr view 261 --repo cyclone-tw/Cyclone-Dashboard \
  --json title,body,state --jq '.title + "\n" + .state'
```

## 會看到什麼

修復標題本身就把根因寫清楚了：handoff 時同步把 Activity 轉 paused，卡片才會重新可認領。commit 只動一處、就動在雙判準沒疊上的地方。
