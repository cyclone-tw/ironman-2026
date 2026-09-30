#!/usr/bin/env bash
# 重跑 PR #140 的審查攻防：留言、verdict、commit 時間軸。
# 只需要 gh CLI（https://cli.github.com），不需要任何私有存取權。
set -euo pipefail

REPO="cyclone-tw/cyclone-hermes"
PR=140

echo "== PR 標題與狀態 =="
gh pr view "$PR" --repo "$REPO" --json title,state,mergedAt \
  --jq '"\(.title) [\(.state)] merged: \(.mergedAt)"'

echo
echo "== 時間軸：commit（順序印出）=="
gh pr view "$PR" --repo "$REPO" --json commits \
  --jq '.commits[] | .committedDate + "  " + (.messageHeadline | split("\n")[0])'

echo
echo "== 審查留言（依時間）=="
gh pr view "$PR" --repo "$REPO" --json comments \
  --jq '.comments[] | "--- " + .author.login + " @ " + .createdAt + " ---", .body'

echo
echo "== VERDICT 行 =="
gh pr view "$PR" --repo "$REPO" --json comments \
  --jq '[.comments[] | .body] | join("\n") | scan("VERDICT:[^\\n]*") | .[]'
