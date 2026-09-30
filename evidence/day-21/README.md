# Day 21 證據

> 逾時的兩個根因，我都猜錯了

## 這裡有什麼

兩個根因各自的公開痕跡。

## 怎麼跑

```bash
# 根因一的教訓（窗口大小、diff 密度）落在後續工單：
gh issue view 443 --repo cyclone-tw/Cyclone-Dashboard \
  --json title,body --jq '.title'
# 根因二的修復：把 run／export 輸出寫檔再讀
gh issue view 443 --repo cyclone-tw/Cyclone-Dashboard \
  --json comments --jq '.comments[] | .body' | sed -n '1,60p'
```

## 會看到什麼

- review-provider-timeout 根因分析的原始側錄：與 docs 類 review 幾十秒的反差例
- review-provider-artifact-invalid 的截斷根因與「導向檔案」修法
