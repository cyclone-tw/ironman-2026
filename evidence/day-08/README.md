# Day 08 證據

> 垂直切片：為什麼不要一次做完

## 這裡有什麼

本篇的主要證據是 GitHub 上的 issue / PR 本身：怎麼把範圍和非目標寫死、驗收清單怎麼擋住「空殼的第一刀」。

## 怎麼跑

```bash
# 看第一刀的範圍與非目標怎麼寫
gh issue view 201 --repo cyclone-tw/cyclone-agent-config

# 看對應 PR 的實際 diff 範圍
gh pr view 202 --repo cyclone-tw/cyclone-agent-config
```

## 會看到什麼

- issue #201 的「範圍」只有四行、「非目標」列出這次不做的事。
- 驗收清單裡有一項是 `check_plan.py --first-slice` 的退出碼要求：第一刀切得不垂直、驗收空殼、沒寫測試指令時直接擋下。
