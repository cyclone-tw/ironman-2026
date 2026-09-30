# Day 24 證據

> CI 紅燈那四次

## 這裡有什麼

這一篇的重點是「這個稽核可以隨時重跑」，下面的命令就是當天的稽核本身。

## 怎麼跑

```bash
gh run list -R cyclone-tw/Cyclone-Dashboard --limit 100 \
  --json conclusion --jq '[.[]|select(.conclusion=="success")]|length'
gh run list -R cyclone-tw/Cyclone-Dashboard --limit 100 \
  --json conclusion,createdAt --jq '[.[]|select(.conclusion=="failure")]|length'
gh run list -R cyclone-tw/Cyclone-Dashboard --limit 100 \
  --json conclusion,createdAt,displayTitle \
  --jq '.[]|select(.conclusion=="failure")|.createdAt+" "+.displayTitle'
```

## 會看到什麼

近一百次的綠紅分布與每個紅的 commit 訊息。Day 24 截稿時的數字是 92 綠 5 紅；這個數字本來就會動，重點是紅燈有沒有對應的 fix。
