# Day 27 證據

> 我把校務接進 AI，然後把學校名字拿掉

## 這裡有什麼

公開可查的是白名單與門口（頻道 gate）失效的原始 issue。

## 怎麼跑

```bash
gh issue view 282 --repo cyclone-tw/cyclone-hermes --json title --jq .title
```

## 會看到什麼

三處來源的欄位各自快照的結果與「整層白名單等於關閉」的缺陷描述。

## 什麼不會在這裡

校名、社群伺服器名、頻道名、任何 ID。文章中的學校一律以代稱敘述。
