# Day 07｜多階段工作怎麼用 Master issue 追蹤

昨天寫的是一張 issue 怎麼變成可以驗收的工作單。但有些工作不是一張 issue、一個 PR 就能完成。

我做比較大的功能時，常會先有一份完整計畫，再拆成幾個階段實作。第一個 PR 可能只建立資料結構，第二個接操作介面，第三個才安裝到實際環境。如果只看各張 PR，很容易每一張都顯示已合併，整個功能卻還不能使用。

我以前試過把架構、施工步驟和每天的進度都寫在同一份計畫文件裡。開始工作後，agent 會一直更新它：加上 commit、修改狀態、補測試結果。過一段時間，原本用來說明設計的段落也跟著進度改動，很難再看出最初怎麼規劃。

後來我把這兩種用途拆開。repo 裡的計畫文件保存設計、依賴、步驟和完整驗收條件；GitHub 的 Master issue 記錄目前做到哪裡。各階段再各自建立 sub-issue，放自己的範圍和驗收清單。

## 一次實際的紀錄

[`cyclone-agent-config` issue #107](https://github.com/cyclone-tw/cyclone-agent-config/issues/107) 是我建立這套規則時使用的工作單，對應 [PR #108](https://github.com/cyclone-tw/cyclone-agent-config/pull/108)。

這次本身只有一個工作包，所以沒有為了形式再多開一張空的 Master issue。issue #107 同時負責需求和整體追蹤。如果是一個有多個工作包、會開兩張以上 PR，或跨 repo 的工程，才需要另外建立 Master issue，再把各張 sub-issue 掛上去。

這樣做是為了讓追蹤層級跟實際工作一致，不是每個小修改都多包一層。

issue #107 的紀錄依工作進度分成幾次更新。

第一次是 commit 完成後，寫下 commit 編號、已完成的清單和測試結果。第二次是 PR 開出來後，補上 PR 連結、這次修改的範圍和接下來等待的 review。第三次記錄 reviewer、審查輪次和結果。

PR #108 在第一輪收到 `nits-only`，也就是沒有阻擋合併的問題，只剩幾個不影響出貨的小意見。之後 PR 合併進主線，issue 裡再記下 main 的 squash SHA。

到這裡，工作仍然沒有勾完成。

## merge 後還有一個狀態

PR 合併只證明程式碼已經進入主線，不能證明新規則已安裝到我實際使用的 agent，也不能證明安裝後讀到的是同一份內容。

所以當時 issue 上寫的是 `merged, awaiting evidence`，也就是「已合併，等待驗證」。checkbox 繼續保持未勾選。

接下來我從穩定的 main 執行 contract test、shell 語法檢查、備份、安裝和 audit。確認四種 agent 的規則都和 repo 一致，而且使用者自己管理的內容沒有被安裝流程覆蓋，才補上最後一則 production／runtime evidence，將工作勾選完成並關閉 issue。

這段紀錄現在仍留在 issue #107。從第一個 commit、PR、review、merge SHA，到實際安裝後的證據，一共分成五個事件。任何一段停下來，都能看出最後完成的是哪一步。

## 計畫和進度分開保存

我現在把 repo plan 和 Master issue 當成兩種不同的紀錄。

repo plan 是施工藍圖，主要回答要做什麼、為什麼這樣拆、有哪些依賴和風險。它會跟著程式碼保存版本，但不需要每發生一件事就修改。

Master issue 是工作帳本，記錄目前的 commit、PR、main SHA、CI 和實際環境證據。這些狀態一發生就更新，讓下一個 agent 不需要讀完整份計畫才知道現在卡在哪裡。

我還加了一條限制：合併後不要為了把 merge SHA 寫回 repo plan，另外製造一個只做紀錄的 commit。因為新 commit 又會產生新的 SHA，追蹤紀錄會開始追蹤自己。合併事件先寫到 GitHub，repo plan 等下一個相關 PR 或里程碑整理時再更新。

這套做法比只看 PR 是否關閉多了一些紀錄工作，但它解決的是我實際遇過的狀況：程式已經合併，安裝或正式環境卻沒有跟上。只要驗證證據還沒出現，那一格就留著不勾。

## 明天

明天會寫工作怎麼切小。重點不是把一件大事拆成很多零散任務，而是先做出一條範圍很小、可以從頭驗證到尾的功能。
