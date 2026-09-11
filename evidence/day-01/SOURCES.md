<!-- 這份不發布，只給自己追蹤用 -->

# Day 01 來源追蹤

## 三個開場案例的 wiki 來源

1. **測試全綠，但綠燈是假的**
   `Core/_inbox/coding-sessions/macbook-claude/2026-08-09-ckp-62-lexical-cutoff-honest-fail.md`
   > ckp#62 lexical cutoff：量測推翻開票假設，全綠改誠實 fail 的數據證明

   重點：不是改到全綠就收工，是先懷疑「這個綠燈是不是假的」，用量測推翻自己原本的假設。

2. **兩個 AI 同時改同一個檔案，互相蓋掉**
   `Core/_inbox/coding-sessions/macbook-claude/2026-08-05-c4-duplicate-session-collision.md`
   > C4 撞車：同一份 handoff prompt 被兩個 session 執行的復盤

   重點：同一份交接指令被兩個 session 同時接走，兩邊都以為自己在做、都回報做完了。

3. **裝好的功能三週後才發現沒生效**
   `Core/_inbox/coding-sessions/macbook-claude/2026-07-26-cyclone-hermes-hub-sync-git-runtime-drift.md`
   > symlink 裝的 skill 三週沒生效、兩個 bundled skill 的「停用」從第一天就是假的、
   > 四支腳本漏同一個排除項

   重點：安裝成功、沒有任何錯誤訊息、但東西從第一天就沒在跑。沒有人發現，因為沒人去驗證。

## 立論出處

`Core/projects/ithome-ironman-2026/index.md` 的「一句話主張」段落。

## 去敏處理項目

- [ ] 不出現校名、Discord ID、Tailscale IP、本機絕對路徑
- [ ] 私有 repo 內容標明「以下為去敏後節錄」
- [ ] 送出前跑 `scripts/privacy-check.sh`

## 發布追蹤

- iThome 網址：
- 發布日期：2026-09-11
