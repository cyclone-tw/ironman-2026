# Day 19 證據

> stale 不等於死掉：十二小時的人工出口

## 這裡有什麼

reclaim 命令的實作 PR：進入條件、拒絕條件、動作範圍的最早實作紀錄。

## 怎麼跑

```bash
gh pr view 184 --repo cyclone-tw/cyclone-agent-config \
  --json title,body,state --jq '.title + "\n" + .body' | sed -n '1,60p'
```

## 會看到什麼

reclaim 進入條件的原始設計：需要真實的進度紀錄、必填理由與下一步、限救「自己的帳、舊的超過時限的 Activity」，以及被自動系統允許的範圍的邊界。
