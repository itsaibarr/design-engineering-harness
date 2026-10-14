#!/usr/bin/env bash
# audit.sh — advisory grep gate for the design-engineering harness.
#
# Usage:
#   bash audit.sh [TARGET_DIR]     # TARGET_DIR defaults to "."
#   ./audit.sh path/to/project
#
# Line-based heuristics over source files (ts/tsx/js/jsx/mjs/cjs/css/scss/html/
# vue/svelte/astro), skipping node_modules/.git/dist/build/.next/out/coverage/
# .turbo/.cache:
#   T_ALL       transition: all                 (name exact properties)
#   SCALE_ZERO  scale(0)                        (collapse should be 0.95–0.98)
#   EASE_IN     ease-in (not ease-in-out)
#   TABINDEX    tabindex > 0                    (JSX tabIndex={n} too)
#   ICON_BTN    icon-ish button line without aria-label
#   H_SCREEN    h-screen                        (prefer dvh; min/max-h-screen ok)
#   NO_ZOOM     user-scalable=no                (blocks browser zoom)
#
# Advisory: findings are heuristic (line-based — multi-line JSX can hide a case;
# a button containing an icon and a label can false-positive). Human triage
# required; add "audit-ok: <id>" context nearby or fix the finding.
#
# Exit codes: 0 = clean, 1 = findings (wire into route-task `gate:` lists),
#             2 = usage error / unreadable target.
set -euo pipefail

TARGET="${1:-.}"

if [ ! -d "$TARGET" ] || [ ! -r "$TARGET" ]; then
  echo "audit.sh: cannot read target dir: $TARGET" >&2
  exit 2
fi

INCLUDES=(
  --include='*.ts' --include='*.tsx' --include='*.js' --include='*.jsx'
  --include='*.mjs' --include='*.cjs' --include='*.css' --include='*.scss'
  --include='*.html' --include='*.vue' --include='*.svelte' --include='*.astro'
)
EXCLUDES=(
  --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=dist
  --exclude-dir=build --exclude-dir=.next --exclude-dir=out
  --exclude-dir=coverage --exclude-dir=.turbo --exclude-dir=.cache
)

FINDINGS=0

report() { # report <rule> <file:line: matched text>
  printf '  [%s] %s\n' "$1" "$2"
  FINDINGS=$((FINDINGS + 1))
}

scan() { # scan <rule> <ERE pattern>
  local rule="$1" pattern="$2" out
  out="$(grep -rnE "${INCLUDES[@]}" "${EXCLUDES[@]}" -- "$pattern" "$TARGET" 2>/dev/null || true)"
  if [ -z "$out" ]; then return 0; fi
  local line
  while IFS= read -r line; do
    report "$rule" "$line"
  done <<< "$out"
}

echo "audit.sh: scanning $TARGET"

# --- mechanical rules ------------------------------------------------------
scan "T_ALL"      "transition:[[:space:]]*[\"']?all([^a-z-]|\$)"
scan "SCALE_ZERO" 'scale\(0\)'
scan "EASE_IN"    'ease-in([^a-z-]|$)'
scan "TABINDEX"   '(^|[^[:alnum:]_-])[tT]ab[Ii]ndex[[:space:]]*=[[:space:]]*["'"'"'{]*[1-9]'
scan "H_SCREEN"   '(^|[^[:alnum:]-])h-screen([^a-z-]|$)'
scan "NO_ZOOM"    'user-scalable[[:space:]]*=[[:space:]]*["'"'"']?no'

# --- icon button without aria-label (line heuristic) -----------------------
icon_out="$(grep -rnE '<button|role="button"|role=\{"button"\}' "${INCLUDES[@]}" "${EXCLUDES[@]}" -- "$TARGET" 2>/dev/null || true)"
if [ -n "$icon_out" ]; then
  line=""
  while IFS= read -r line; do
    [ -n "$line" ] || continue
    low="$(printf '%s' "$line" | tr '[:upper:]' '[:lower:]')"
    case "$low" in
      *aria-label*|*aria-labelledby*|*sr-only*|*visually-hidden*) continue ;;
    esac
    case "$low" in
      *icon*|*'<svg'*) report "ICON_BTN" "$line" ;;
    esac
  done <<< "$icon_out"
fi

# --- summary ---------------------------------------------------------------
echo "audit.sh: ${FINDINGS} finding(s)"
if [ "$FINDINGS" -gt 0 ]; then
  exit 1
fi
exit 0
