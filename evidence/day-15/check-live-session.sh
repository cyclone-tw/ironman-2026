#!/usr/bin/env bash
# 接手任何既有工作目錄前的「活體」檢查。
# 用法：./check-live-session.sh <工作目錄>
set -euo pipefail
DIR="${1:?用法：check-live-session.sh <工作目錄>}"

fail=0

echo "== 1) 目標目錄最近修改的檔案 =="
recent="$(find "$DIR" -type f -mmin -60 2>/dev/null | head -10 || true)"
if [ -n "$recent" ]; then
  printf '%s\n' "$recent"
  echo "最近一小時內有檔案被改過 → 強烈的 live 訊號"
  fail=1
fi

echo
echo "== 2) IDE / agent 的 transcript 狀態 =="
# 依自己的 agent 放置路徑調整此處（Claude Code 為 .claude/projects/<project>/*.jsonl）
if [ -d "$HOME/.claude/projects" ]; then
  find "$HOME/.claude/projects" -name '*.jsonl' -mmin -10 2>/dev/null | head -5 || true
fi

echo
echo "== 3) process 掃描 =="
ps -axo pid,etime,command 2>/dev/null | grep -viE 'grep|check-live-session' \
  | grep -iE 'claude|codex|cursor' || true

echo
if [ "$fail" -eq 1 ]; then
  echo "ASSUME LIVE: 先確認活體是否仍在做，再考慮接手。"
  exit 1
fi
echo "SAFE: no live session"
