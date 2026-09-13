# Day 03 證據

> 規則要求 CI 綠燈，但那個 repo 沒有 CI

## 這裡有什麼

`check-ci.sh` —— 檢查一個 GitHub repo 有沒有 CI，以及最近的執行結果。

它回答的問題是：**「CI 綠」這個條件，在這個 repo 底下判定得出來嗎？**

這跟「CI 有沒有過」是兩回事。如果 repo 根本沒有 workflow，那這個條件不是沒通過，
是不存在——而一條寫著「CI 綠才能自動合併」的規則，在這種 repo 底下是空轉的。

## 怎麼跑

需要 [GitHub CLI](https://cli.github.com/)，而且要先 `gh auth login`。

```bash
./check-ci.sh <owner>/<repo>
```

可以一次給多個，方便做對照：

```bash
./check-ci.sh your-name/repo-a your-name/repo-b
```

私有 repo 也可以，只要目前登入的帳號有權限。

## 會看到什麼

有 CI 而且跑過的 repo：

```
=== owner/repo ===
  workflow 檔：1 個
    - ci.yml
  最近 100 次執行：成功 95，失敗 4，其他 1

  → 這個 repo 判定得出「CI 綠」。
```

沒有 CI 的 repo：

```
=== owner/repo ===
  workflow 檔：沒有（.github/workflows 不存在）

  → 這個 repo 判定不出「CI 綠」。
    不是沒通過，是這個條件在這裡不存在。
```

還有第三種，比較容易被忽略——**有 workflow 但一次都沒跑過**。
腳本會單獨標出這種情況，因為「有設定」不等於「有在跑」，這正是 Day 03 想講的事。

## 一個附註

這支腳本第一次執行的時候掛了。原因是我在字串裡用了全形的「／」，
bash 把它當成變數名的一部分，直接 unbound variable 報錯。

寫一支「檢查東西有沒有真的在跑」的腳本，結果它自己第一次就沒跑起來。
這件事我留在這裡，不修飾掉。
