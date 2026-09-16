# Day 10 證據

> Coder 不能是 Reviewer：AI 不能球員兼裁判

## 這裡有什麼

一個被這條規則「合規地卡死」的真實案例：規則只建了單邊簽章路徑時，一個已經 nits-only 的 PR 被自動 gate 擋住。

## 怎麼跑

```bash
# 看 PR #132 描述裡記錄的卡死過程與解法
gh pr view 132 --repo cyclone-tw/cyclone-agent-config
```

## 會看到什麼

- 「Cyclone-Dashboard#209 現在就卡在這裡……gate 機械性 FAIL」的原文
- 解法：`scripts/claude-review.sh`、`review/allowed_signers` 新增 Claude Code reviewer 信任根
- 正式規則明文的硬停：Coder 不能自審自批後自動 merge
