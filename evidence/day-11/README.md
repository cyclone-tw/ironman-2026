# Day 11 證據

> 怎麼確認審的人真的是它？

## 這裡有什麼

Review attestation 的實際內容（簽章檔）與第一輪針對簽章驗證器本身的 findings 原文。

## 怎麼跑

```bash
# 看 PR #132 底下的 review 留言與 attestation 範本
gh pr view 132 --repo cyclone-tw/cyclone-agent-config --json comments \
  --jq '.comments[] | .body'
```

## 會看到什麼

- `schema=cyclone-review-attestation/1` 的欄位：reviewer／commit／verdict／verdict_sha256／nonce
- 第一輪 Codex 對 `verify-review-attestation.sh`、`claude-review.sh` 的 findings：
  - `Review-Round` 接受空值
  - 未知的 `Coder:` 只警告不拒絕
  - 以 `outputTokens` 推測模型會誤判
  - malformed JSON fail-open
- 文章裡的 attestation 節錄可逐字對照上述留言
