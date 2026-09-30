# Day 16 證據

> V1 做錯了，我把它整個拆掉重做

## 這裡有什麼

這一天的證據是兩張公開工單的對照：V1 防護層的設計（queue／receipt／session binding）與八月十日的裁決（全部作廢、改直接同步 CLI）。

## 怎麼跑

```bash
gh issue view 199 --repo cyclone-tw/Cyclone-Dashboard \
  --jq '.body' | sed -n '1,80p'
```

## 會看到什麼

- Work Ledger 的原始設計文件：request file、durable queue、receipt、session binding 的每層對應的假想威脅
- （在 issue 留言與後續工單）截斷這些層的裁決：內部可信看板、同步 CLI
