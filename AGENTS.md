# ironman-2026 工作規則

2026 iThome 鐵人賽的連載 repo。**這裡是寫文章的地方，不是工程專案。**

## 這個 repo 不走的流程

全域規則裡的 issue-first、PR、跨 agent review、無人值守出貨，在這個 repo **一律不適用**：

- 不開 issue（唯一的 issue #1 是 30 天進度 ledger，不是工作單）
- 不開 PR、不做 code review
- 直接 commit 到 main 然後 push

理由：這是個人寫作，不是多人協作的程式碼。對散文跑 code review 沒有意義。

## 唯一的硬閘門

送出前一定要跑：

```bash
./scripts/privacy-check.sh
```

沒過不准 commit。這道閘門擋的是公開後收不回來的東西：學校可識別資訊、Discord ID、
內部主機名與私有網段 IP、token、本機絕對路徑、email。

確認是誤報時，改寫該行讓它不再命中，**不要放寬腳本規則**。

## 三層分工

| 層 | 位置 | 擁有什麼 |
|---|---|---|
| 知識正本 | cyclone-wiki（私有） | 素材、根因、判斷、去敏決策 |
| 公開成品 | 本 repo | 文章正文與可執行證據 |
| 發布 | iThome | 貼文與讀者互動 |

**文章正文只存在這裡，wiki 不放副本。**

寫每篇之前先讀 wiki 的 `Core/projects/ithome-ironman-2026/source-map.md`，
那裡記錄了每一天要用哪些 GitHub issue／PR（一手證據）與哪些復盤筆記（二手敘述）。

## 每天的流程

```bash
./scripts/new-day.sh NN "標題"
# 寫 posts/day-NN.md，可跑的東西放 evidence/day-NN/
./scripts/privacy-check.sh
git add -A && git commit && git push
# 貼 iThome，然後回填網址到 README 與 issue #1
```

## 寫作規則

- 全篇第一人稱。不要用「你」對讀者說話，也不要營造對話感；
  少數泛指用法（例如「如果你在公司寫程式」）由 Cyclone 個別決定保留與否。
- 每篇至少 300 字（官方要求），實際約 1500 到 2000 字。
- 引用不得超過全文三分之一。
- 私有 repo 的內容一律標明「以下為去敏後節錄」。
- 一手證據（issue／PR／CI）與事後敘述（復盤筆記）在文中要分清楚。
- commit message 不加 Co-Authored-By。
- 參賽期間不刪除已發布文章。

## 高風險篇目

Day 25、26、27 涉及去識別與教育現場。自動閘門擋不了語意層的可識別性，
這三篇發布前需要 Cyclone 本人逐字複核。Day 27 的學校一律用代稱。
