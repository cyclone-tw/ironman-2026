#!/usr/bin/env bash
# 產生某一天的文章骨架與證據目錄。
# 用法：scripts/new-day.sh 07 "為什麼引用一定要綁 commit 和行號"
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ $# -lt 2 ]; then
  echo "用法：scripts/new-day.sh <NN> \"<標題>\"" >&2
  exit 2
fi

n="$(printf '%02d' "$((10#$1))")"
title="$2"
post="$ROOT/posts/day-$n.md"
evdir="$ROOT/evidence/day-$n"

if [ -e "$post" ]; then
  echo "已存在，不覆蓋：posts/day-$n.md" >&2
  exit 1
fi

mkdir -p "$evdir"

cat > "$post" <<POST
# Day ${n}｜${title}

## 今天要解的問題

## 當時發生什麼

## 為什麼會這樣

## 我改成什麼

## 本篇證據

<!-- 一手證據放這裡：issue／PR 編號、review 往返、CI 結果。
     私有 repo 的內容貼去敏後的片段，並註明「此為私有 repo，以下為去敏後節錄」。
     可執行的部分放 evidence/day-$n/，讀者能自己跑。 -->

## 還沒解決的

## 明天

POST

cat > "$evdir/README.md" <<EV
# Day $n 證據

> $title

## 這裡有什麼

## 怎麼跑

\`\`\`bash
# 讀者可以複製貼上的指令
\`\`\`

## 會看到什麼

EV

cat > "$evdir/SOURCES.md" <<SRC
<!-- 這份不發布，只給自己追蹤用 -->

# Day $n 來源追蹤

- wiki 來源 note：
- GitHub issue／PR：
- 去敏處理項目：
- iThome 網址：
- 發布日期：
SRC

echo "已建立："
echo "  posts/day-$n.md"
echo "  evidence/day-$n/README.md"
echo "  evidence/day-$n/SOURCES.md"
