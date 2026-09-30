# Day 28 證據

> 完整重跑：從 issue 到證據

## 這裡有什麼

`replay-140.sh`：把 `cyclone-hermes` PR #140 的兩輪半審查攻防，用公開的 GitHub 紀錄重跑一遍。Day 12 到 14 三天的原始材料全部來自這條命令的輸出。

## 怎麼跑

```bash
chmod +x evidence/day-28/replay-140.sh
./evidence/day-28/replay-140.sh
```

只需要 GitHub CLI（`gh`）登入，不需要任何私有 repo 的存取權。

## 會看到什麼

- Round 1：`VERDICT: changes-requested`，4 findings（最重的一條：檔名覆蓋＋reverse dry-run 漏抓同檔額外 hotfix）
- 修正 commit `a7942ef`：期望樹＋逐檔位元組比對、exit code 0/1/2 契約、105/105 測試
- Round 2：3 條新 findings（含「我拿來反駁的證據，在另一平台跑不動」那條）
- Round 3：`VERDICT: approved`（delta review，只審第二次修正之後的變更）
- 每一輪之間的實際時間差（時間戳比文字敘述誠實）
