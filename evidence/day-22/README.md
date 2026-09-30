# Day 22 證據

> 裝好的技能三週沒生效，沒人發現

## 這裡有什麼

稽核 issue 本身：symlink 從未被掃描器讀到的完整時間線。

## 怎麼跑

```bash
gh issue view 133 --repo cyclone-tw/cyclone-hermes \
  --json body --jq '.body' | sed -n '1,40p'
```

## 會看到什麼

- 「照理 P1」的原文：2026-07-04 以 symlink 裝入，掃描器（Python 的遞迴目錄掃描）不跟隨目錄 symlink，三週全無訊息
- 上游搬移導致斷鏈的後續
