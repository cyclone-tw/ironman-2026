# Day 06｜我怎麼把 issue 寫成可以驗收的工作單

我以前把 GitHub issue 當成待辦事項。標題寫要做的功能，內文補幾句背景，agent 做完後關掉。開始同時使用幾個 coding agent 之後，這種寫法很快就不夠用了。

標題只能告訴我大概要做什麼，不能告訴我做到哪裡才算結束。agent 如果需要自己補完這一段，最後仍然是它決定工作內容，再由它判斷是否完成。

我後來把開發型 issue 改成一份可以驗收的工作單。[`cyclone-agent-config` issue #70](https://github.com/cyclone-tw/cyclone-agent-config/issues/70) 是我第一次把這套做法正式寫進共用規則的紀錄。

## issue 裡要先有完成條件

issue #70 的目標，是讓幾種 coding agent 都遵守同一套進度紀錄方式。它的驗收清單一共有四項：更新共用規則、同步四種 agent 的摘要、讓 PR 通過另一個 agent review，以及把新規則安裝到實際使用的位置後執行 audit。

這四項不是工作結束後才補上的成果摘要，而是在動工前就寫進 issue。這樣 coding agent、reviewer 和我看到的是同一個完成標準。

我現在寫 issue 時，至少會交代背景、目標、範圍、非目標、風險、驗收條件和驗證方式。不是每一張都要寫得很長，但會影響行為或同時改很多地方時，這幾項不能省略。

其中最重要的是驗收條件。它要描述可以觀察的結果，不能只寫「功能正常」、「完成同步」或「確認沒有問題」。例如這次的「同步完成」，後面接著的是實際安裝和 audit。audit 會比較各處的設定內容，全部一致才算通過。

## 完成一項就更新一項

我要求 agent 在工作進行時更新 checkbox。完成規則修改，就勾對應項目；開出 PR 並取得 review 結果，再更新下一項。不能等到所有事情做完後，一次把整張清單打勾。

這樣做的好處是 session 中斷時，下一個 agent 可以直接從 issue 看出目前停在哪裡。它不用先相信上一個 agent 留下的「大致完成」，也不用重讀整段聊天紀錄。

checkbox 本身仍然不是證據。它比較像目錄，指向 commit、PR、review 留言和測試結果。只有勾選而沒有對應紀錄時，我仍然無法確認工作是否完成。

## PR 必須說明它和哪張 issue 有關

另一條一起加入的規則，是每個 PR 都要連回 issue。

如果這個 PR 做完就會完成整張 issue，PR 內文使用 `Closes #NN`。GitHub 在 PR 合併進主線後會自動關閉對應 issue。

如果它只是大型工作的一個階段，則使用 `Ref #NN` 或 `Part of #NN`。這表示兩者有關，但不會提前把整張 issue 關掉。

這裡有一個我原本不知道的細節。GitHub 使用 squash merge 時，可能把 commit message 一起整理進最後的合併訊息。如果階段性 commit 寫了 `Closes #NN`，即使 PR 本身只是第一階段，issue 還是可能被自動關閉。因此階段性 commit 也不能使用關閉關鍵字。

## 這份規則第一次送審就被退回

我寫完後開了 [PR #71](https://github.com/cyclone-tw/cyclone-agent-config/pull/71)，交給 Codex review。第一輪找到四個必須修正的問題和一個小意見。

其中一個問題是兩段規則互相衝突：前面的章節要求所有 code PR 都使用 `Closes`，新章節卻允許階段性 PR 使用 `Ref`。另一個問題是我要求 checkbox 沒勾完就不能 merge，卻沒有區分階段性 PR 和真正收尾的 PR。照原文執行，多階段工作會永遠卡住，或在第一階段就被關閉。

review 也指出，我列的 GitHub 關閉關鍵字不完整，範例指令還用了錯誤的參數。這些都不是文字好不好看的問題，而是 agent 照著規則執行時會得到不同結果。

修正後，第二輪 review 才通過。PR 合併後，我執行安裝和 audit，再把結果回寫 issue，最後才把四項驗收清單全部勾完。

這次之後，我才比較能從同一張 issue 處理三件事：coding agent 知道該做什麼，reviewer 知道要檢查什麼，我也能在工作結束後沿著紀錄確認結果。

## 明天

一張 issue 適合一個範圍明確的工作。明天會寫多階段工程怎麼用 Master issue 和 sub-issue 分開追蹤，以及為什麼 PR merge 後還不能立刻勾完成。
