#!/usr/bin/env bash
# 送出前的去敏閘門：掃 posts/ 與 evidence/，命中任一條就 exit 1。
# 這道閘門擋的是「公開後收不回來」的東西，不是風格問題。
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SELF="scripts/privacy-check.sh"
RG="$(command -v rg || true)"
if [ -z "$RG" ]; then
  echo "找不到 ripgrep(rg)，請先 brew install ripgrep" >&2
  exit 2
fi

TARGETS=(posts evidence README.md)
hits=0

check() {
  local label="$1" pattern="$2"
  local out
  out="$("$RG" -n --hidden --glob '!.git/**' --glob "!$SELF" \
        -e "$pattern" "${TARGETS[@]}" 2>/dev/null || true)"
  if [ -n "$out" ]; then
    printf '\n[命中] %s\n' "$label"
    printf '%s\n' "$out" | sed 's/^/    /'
    hits=$((hits + 1))
  fi
}

cd "$ROOT"

# 1. 學校可識別資訊 —— 這條最重要，一旦公開無法回收
check "學校可識別資訊"        '(?i)(ksps|國姓|國姓國小|校務台)'
# 2. 私有網段與 Tailscale IP
check "私有網段/Tailscale IP" '\b(100\.(6[4-9]|[7-9][0-9]|1[01][0-9]|12[0-7])|192\.168|10\.)\.[0-9]{1,3}\.[0-9]{1,3}\b'
# 3. Discord snowflake ID（17-19 位純數字）
check "Discord ID"            '\b[0-9]{17,19}\b'
# 4. 台灣身分證字號
check "台灣身分證字號"        '\b[A-Z][12][0-9]{8}\b'
# 5. 常見憑證與 token
check "token/secret"          '(?i)(sk-[a-z0-9]{20,}|ghp_[a-zA-Z0-9]{20,}|xox[baprs]-|bearer [a-z0-9._-]{20,}|api[_-]?key\s*[:=]\s*\S{12,}|BEGIN [A-Z ]*PRIVATE KEY)'
# 6. 本機絕對路徑（換機就壞，也洩漏帳號名）
check "本機絕對路徑"          '/Users/[a-z]'
# 7. 內部主機名
check "內部主機名"            '(?i)\b(z-c|mini-new|macmini-openab)\b'
# 8. Email
check "email"                 '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'

echo
if [ "$hits" -gt 0 ]; then
  echo "去敏檢查未通過：$hits 類命中。逐條處理後再送出。"
  echo "確認是誤報時，改寫該行讓它不再命中，不要放寬這支腳本的規則。"
  exit 1
fi
echo "去敏檢查通過。"
