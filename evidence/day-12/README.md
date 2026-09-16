# Day 12 證據

> Round 1: changes-requested —— 一次真實攻防

## 這裡有什麼

`cyclone-hermes` PR #140 第一輪的完整 findings 與修正紀錄，全部留在公開的 PR 留言裡。

## 怎麼跑

```bash
# 逐則看 PR #140 的審查攻防
gh pr view 140 --repo cyclone-tw/cyclone-hermes --json comments \
  --jq '.comments[] | .author.login, .body'
```

## 會看到什麼

- Review round 1 摘要：`VERDICT: changes-requested`，4 findings（High：檔名覆蓋＋reverse dry-run 漏抓同檔額外 hotfix）
- 修正 commit `a7942ef`：期望樹＋位元組比對取代 reverse dry-run、exit code 0/1/2 契約、105/105 測試
- 緊接著的 round 2 comment（明天 Day 13 的素材）
