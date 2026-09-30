# Day 23 證據

> 升級把我的客製化蓋掉了

## 這裡有什麼

sync 工具的兩個問題，與結構性跟進 issue 的原文。

## 怎麼跑

```bash
gh issue view 133 --repo cyclone-tw/cyclone-hermes \
  --json body --jq '.body' | sed -n '40,80p'
gh issue view 135 --repo cyclone-tw/cyclone-hermes \
  --json body --jq '.body' | sed -n '1,60p'
```

## 會看到什麼

- 鏡像模式會把停用清單整批刪掉的 dry-run 實錄
- 三個結構缺陷的原文：邊界未宣告、改了 git 不一定生效、live 可被手改而正本失明
