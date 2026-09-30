# Day 26 證據

> 學生資料：這條線我不會踩

## 這裡有什麼

公開 repo 裡的真實閘門：`scripts/privacy-check.sh` 的身分證與超長數字 ID 規則。

## 怎麼跑

```bash
sed -n '36,40p' scripts/privacy-check.sh
```

## 會看到什麼

這一組規則在腳本裡最簡單（一個 regex），但它守的是機械底線；語意層的紅線，文章裡已明寫仍由人把關。
