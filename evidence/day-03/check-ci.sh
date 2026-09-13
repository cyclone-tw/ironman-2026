#!/usr/bin/env bash
# 檢查一個 GitHub repo 有沒有 CI，以及最近的執行結果。
#
# 用法：
#   ./check-ci.sh <owner>/<repo> [<owner>/<repo> ...]
#
# 這支腳本回答的問題是：「CI 綠」這個條件，在這個 repo 底下判定得出來嗎？
# 如果 repo 根本沒有 workflow，那這個條件不是沒通過，是不存在。
set -uo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "找不到 gh（GitHub CLI）。安裝方式：https://cli.github.com/" >&2
  exit 2
fi
if ! gh auth status >/dev/null 2>&1; then
  echo "gh 尚未登入。先執行：gh auth login" >&2
  exit 2
fi
if [ $# -lt 1 ]; then
  echo "用法：$0 <owner>/<repo> [<owner>/<repo> ...]" >&2
  exit 2
fi

RUNS_TO_CHECK=100

check_one() {
  local repo="$1"
  printf '\n=== %s ===\n' "$repo"

  if ! gh repo view "$repo" >/dev/null 2>&1; then
    echo "  讀不到這個 repo（不存在、或目前帳號沒有權限）"
    return
  fi

  # 1. 有沒有 workflow 檔
  local wf
  if wf="$(gh api "repos/$repo/contents/.github/workflows" --jq '.[].name' 2>/dev/null)"; then
    local count
    count="$(printf '%s\n' "$wf" | grep -c . || true)"
    echo "  workflow 檔：$count 個"
    printf '%s\n' "$wf" | sed 's/^/    - /'
  else
    echo "  workflow 檔：沒有（.github/workflows 不存在）"
    echo
    echo "  → 這個 repo 判定不出「CI 綠」。"
    echo "    不是沒通過，是這個條件在這裡不存在。"
    echo "    如果規則寫著「CI 綠才能自動合併」，那條規則在這裡是空轉的。"
    return
  fi

  # 2. 最近的執行結果
  local runs
  runs="$(gh run list --repo "$repo" --limit "$RUNS_TO_CHECK" \
          --json conclusion --jq '.[].conclusion' 2>/dev/null || true)"
  if [ -z "$runs" ]; then
    echo "  執行紀錄：有 workflow 但一次都沒跑過"
    echo
    echo "  → 有設定不等於有在跑。這個條件一樣判定不出來。"
    return
  fi

  local total ok fail other
  total="$(printf '%s\n' "$runs" | grep -c . || true)"
  ok="$(printf '%s\n' "$runs" | grep -c '^success$' || true)"
  fail="$(printf '%s\n' "$runs" | grep -c '^failure$' || true)"
  other=$(( total - ok - fail ))

  echo "  最近 ${total} 次執行：成功 ${ok}，失敗 ${fail}，其他 ${other}"
  echo
  echo "  → 這個 repo 判定得出「CI 綠」。"
}

for repo in "$@"; do
  check_one "$repo"
done
echo
