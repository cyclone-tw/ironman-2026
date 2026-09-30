# Day 15 證據

> 三個 AI 同時認領同一件事

## 這裡有什麼

`check-live-session.sh`：接手既有工作前，先檢這個目標是否「活著」的三步檢查（檔案 mtime／transcript 活躍度／process 掃描）。Day 15 撞車事件（C4）之後固定的規則，任何 session 可以直接套用。

## 怎麼跑

```bash
./evidence/day-15/check-live-session.sh <工作目錄>
```

## 會看到什麼

- 目標目錄最近修改時間排序的最前幾筆（幾十分鐘內有更新＝活躍訊號）
- 目前還在寫入的 transcript 狀態
- 掃到還活著的 agent process，就代表有人在這個目標上
- 最後一行輸出 `SAFE: no live session` 或 `ASSUME LIVE: wait`
