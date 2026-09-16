# Day 11｜怎麼確認審的人真的是它？

到昨天為止，我假設 PR 底下那則 review 留言就是 reviewer agent 留的。今天要拆掉這個假設。

一則 GitHub 留言上，我可以看到的只有帳號名稱。看到某個 bot 的頭像，我會自動把它讀成「Codex 審過了」。但留言本身記錄不了是誰寫的，記錄不了審的是哪個版本的程式碼，也記錄不了審的過程是真的花的腦筋還是複製貼上。

只要有足夠的 API 權限，任何 agent、任何腳本、任何我，都能在 PR 底下貼出一則看起來一樣的審查報告。意思是：如果整個自動 merge 流程只看「有一則 verdict 為 approved 的留言」，那麼這個流程放行與否，可以由任何一方一句話決定。

## 把審查變成可以驗證的物件

所以我讓每一輪審查除了留言之外，再多產出一份有簽章的檔案。這個檔案我叫它 review attestation，格式大致是：

```
schema=cyclone-review-attestation/1
reviewer=codex
commit=12f0884462240da1339cfc9cbab53ffc771efd40
tree=clean
verdict=changes-requested
verdict_sha256=2dc3dacd649ba83adb6...
model=gpt-5.6-luna/high
timestamp=2026-08-06T12:57:40Z
nonce=Usage:od[--port<n>]...
```

以上為 PR #132 底下公開可見的簽章檔內容節錄。重點不在每個欄位的字面意思，而在綁定關係：`reviewer` 寫的是誰，`commit` 綁的是哪一版程式，`verdict_sha256` 是對審查結論的雜湊值，最後的 `nonce` 是執行過程中真實輸出的一小段文字。每一份都拿 reviewer 專屬的 SSH key 簽章，誰也偽造不了別人的簽名。

在 PR #132 之前，agent-config #68 已經把它定為全域 merge gate：沒有可驗簽的 attestation，自動合併直接 FAIL，無後門。

## 驗證器自己也有洞

有了規則還要找洞。簽章驗證器本身也是程式，也是 AI 寫出來的，也要被審。我把兩支審查腳本的修法交給另一隻 agent 審，第一輪的時候，出現了這些 findings：

> - `verify-review-attestation.sh:199-202` 的 `Review-Round:[^\n]*` 接受空值或任意內容；malformed trailer 仍可被當成 `approved`。
> - `verify-review-attestation.sh:211-243` 缺少或未知的 `Coder:` 只警告、不拒絕，能繞過 Coder≠Reviewer 檢查。
> - `claude-review.sh:270-275` 以最大 `outputTokens` 判定模型；錯誤模型若輸出較少、而預期模型是輔助模型，仍會通過並簽章。

上面是 PR #132 第一輪 review 留言的公開原文節錄。白話是：

- 檔案裡某個欄位，只要留空也能通過驗證。有個格式錯掉的 trailer 可以被當成核可。
- 沒有填寫 Coder 是誰的簽章，驗證器只警告、照樣放行，Coder 不能自審的檢查整條被繞過。
- 想推測用來審的是哪一個模型時，用「哪個模型花了最多輸出 token」判斷。如果用錯模型又剛好輸出得比較少，驗證器還是會認、結果加上正確模型的簽章。

第一條最有趣：整組程式的設計初衷就是防偽，結果防偽程式自己有一條可以過偽的路。沒有人故意作惡，只是正規表示式寫得太鬆，malformed 與合法被同等對待。

## 洞是怎麼補上的

每條 finding 各自處理。正規表示式的檔案加上了嚴格的判定：該有的欄位缺了就不通過。模型推測改為依照主模型的名稱，輔助模型另行比對。JSON 格式錯掉的時候不再「就算了」，改為直接拒絕。

這些修改合起來，答案才完整：一個審查叫得出 reviewer 名、簽得出 reviewer 全名、簽章用過的 key 可以被追到身分、簽章的 commit 是真的，才算審過。

## 明天

機器和規則寫好了，明天讓各位看真的 Run 進去的時候，第一輪的 changes-requested 長什麼樣。
