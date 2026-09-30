# Day 17 證據

> Card、Activity、Run：三種東西不能混

## 這裡有什麼

三個概念至今的實際定義文件位置。

## 怎麼跑

```bash
gh issue view 199 --repo cyclone-tw/Cyclone-Dashboard \
  --jq '.body' | sed -n '1,60p'
```

## 會看到什麼

Work Item／Execution 的原始資料模型，以及狀態欄位的清單：哪些是正式工作狀態、哪些只是衍生信號。
