# Day 13 證據

> AI 說我錯了，我拿實驗反駁它

## 這裡有什麼

PR #140 第二輪中「`find -mtime` 是否支援 macOS」的攻防原文。reader 可以在的環境裡自己重跑同一個實驗。

## 怎麼跑

```bash
# macOS 上實測 BSD find 是否支援小時後綴
find /some/dir -mtime -36h ; echo "exit code: $?"

# 看 PR #140 的 round 2 摘要
gh pr view 140 --repo cyclone-tw/cyclone-hermes --json comments \
  --jq '.comments[] | select(.body | contains("round 2")) | .body'
```

## 會看到什麼

- macOS 上 `-mtime -36h` 回傳 exit 0 並正確列出檔案（BSD find 支援）
- PR 留言原文：「**實驗反證**：mini 上實跑該指令 rc=0 並正確列出兩個備份檔」
- 雖然反駁成功，仍改成 `-mmin`（GNU/BSD 通用）的理由
