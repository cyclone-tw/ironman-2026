# Day 09 證據

> 一個人怎麼做 code review？答案是不要自己做

## 這裡有什麼

無人值守 review 迴圈的第一版規格：中文需求、Coder/Reviewer 配對、verdict 分級、輪次上限。

## 怎麼跑

```bash
# 看規格原文
gh issue view 66 --repo cyclone-tw/cyclone-agent-config
```

## 會看到什麼

- 「先問再 push 會讓自動化卡住」的需求背景
- Acceptance 區塊有明文：coder/reviewer 配對、輸上限、nits-only 可 merge、雙 reviewer 失敗才問人
- 明文不允許「Coder 自審自批後自動 merge」
