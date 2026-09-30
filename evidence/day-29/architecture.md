# 把整套系統畫成一張圖

## mermaid 原始檔

```mermaid
flowchart TB
    GH["GitHub（正本）<br/>issue / PR / commit / CI"]

    RULES["規則 repo<br/>行為契約與身分定義"]
    RT["各機的 agent runtime<br/>實際執行"]
    LEDGER["工作帳本（Dashboard）<br/>Card / Activity"]

    WIKI["私有 wiki<br/>判斷、根因、方法"]
    PUB["公開 repo evidence/<br/>可重跑證據"]

    GATE["入口閘門<br/>去識別 / 假名化紅線 / 校務退場條件"]

    RULES -->|"指示範圍"| RT
    RT -->|"認領與狀態回報"| LEDGER
    RT -->|"PR / commit / CI"| GH
    RULES -->|"規格引用"| GH
    LEDGER -->|"issue / PR 連結"| GH

    GATE -->|"通過後才能進"| WIKI
    WIKI -->|"去敏後節錄"| PUB
    GH -->|"結論落點"| PUB
```

## 文字版重點

- 只有一個真相倉庫：GitHub。可交付結論必須落成 commit 或時間戳，否則不算完成。
- 規則答「誰在什麼條件下能做什麼」；runtime 答「誰現在真的在跑」；帳本答「誰在做、做到哪、由誰接」。
- 三個收納方向：結論往 GitHub、理解往 wiki、過程狀態往帳本。互不存副本。
- 紅線閘門設在入口，不設在出口：校務相關材料一進系統就分流，不可等到發布端才檢查。
