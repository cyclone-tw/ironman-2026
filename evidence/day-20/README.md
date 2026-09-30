# Day 20 證據

> 不確定就拒絕，不要硬做

## 這裡有什麼

公開 repo 裡可直接讀到的 fail-closed 閘門本體：`scripts/privacy-check.sh`。私有側（語意層的錯誤碼規範）不放在這裡。

## 怎麼跑

```bash
sed -n '17,54p' scripts/privacy-check.sh
```

## 會看到什麼

八類機械規則與 exit code。注意設計的取捨：規則卡守衛的面只有機械字串，語意層必須靠人（Day 25 的負荷來源）。
