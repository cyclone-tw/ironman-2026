# Day 28｜完整重跑：從 issue 到證據

最後三天換方向。前二十七天的主詞都是我，今天開始是讀者：把過去引用過的一條完整工作線，用公開紀錄重跑一次。不信任我的敘述，用你自己的終端機驗證。

## 為什麼是「重跑」而不是「重述」

這個系列引用最多次的單一證據，是 `cyclone-hermes` 的 [PR #140](https://github.com/cyclone-tw/cyclone-hermes/pull/140)：兩輪正式 review、一個被我反證又被抓的新問題、最後第三輪收斂到 approved，全在公開的留言間。重述它只需要摘要能力；重跑它需要的是你的 `gh`。我選後者。

重跑的線路是：從 PR 的開頭看「改了什麼」；從 review 留言看「審的人抓到什麼、我怎麼回」；從 commit 與測試數字看「怎麼證明修正有效」；從 merge 的時間戳看這場攻防實際多久。這條線的每一步，不需要我的任何授權。

## 這件事的腳本

我把這條線寫成一小支腳本，放在 `evidence/day-28/replay-140.sh`。它做三件事：列出 PR #140 的每一則留言與作者、抽出其中的 `VERDICT` 行、按時間列出 commit。全部輸出到標準輸出，用這個 repo 就足夠，不需要任何私有存取。

```bash
# 等價的手動版（腳本只是把它包起來）
gh pr view 140 --repo cyclone-tw/cyclone-hermes --json comments \
  --jq '.comments[] | .author.login, .body'
gh pr view 140 --repo cyclone-tw/cyclone-hermes --json files,commits,commits \
  --jq '.commits[] | .committedDate, .messageHeadline'
```

跑完會看到的東西，就是 Day 12 到 14 三天的原始材料：Round 1 的四條 findings 與 `VERDICT: changes-requested`、commit `a7942ef`、Round 2 的三條新 findings、Round 3 的 `approved`。

## 重跑會多看到什麼

時間戳是最有意思的部分。讀留言時感覺攻防節奏很快，但時間戳會顯示每一輪之間實際隔多久、每次修正讓 reviewer 等了幾個小時。我自己在復盤時，曾被自己的筆記誤導過先後順序，最後靠時間戳重排。

另一個是單位。留言裡的「105/105 測試通過」是文字；對照 commit 裡新增的測試檔，才能確認那個數字對應的真實檔案存在。證據練到第二層，比第一層的引述要多花五分鐘，但它的可信度完全不同。

## 我的稽核也是同一條命令

老實講一件事：這支腳本最常見的使用者是我自己。文章裡每一個引用的 PR 細節，我寫進去之前就是用這組命令核對的。讀者驗證我的敘述用的，和我驗證自己的記憶用的，是同一條線路。這是這個系列在設計上最想要的一個細節。

## 還沒解決的

留言與 commit 是永久公開的，但 PR 描述裡引用的部分外部工件（例如我當時貼的測試輸出片段），不保證永遠有效。如果要長期保存的證據，我目前的做法是把它重製到這個 repo 的 `evidence/`，由這個 repo 的 git 歷史背書。

## 明天

明天把過去二十幾天拆過的全部零件，畫成一張圖。
