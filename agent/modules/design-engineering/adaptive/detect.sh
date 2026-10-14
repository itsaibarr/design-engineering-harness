#!/usr/bin/env bash
# detect.sh — stack detection for the design-engineering harness (read-only).
#
# Usage:
#   bash detect.sh [TARGET_DIR]     # TARGET_DIR defaults to "."
#   ./detect.sh path/to/project
#
# Inspects package.json and config files in TARGET_DIR and prints one line per
# axis: framework, styling, animation, components. Feeds adaptive/routing.md.
#
# Read-only: never creates, edits, or deletes anything in TARGET_DIR.
# Idempotent: repeated runs produce identical output (no state, no writes).
# Exit codes: 0 = success (including "nothing detected"), 2 = unreadable target.
set -euo pipefail

TARGET="${1:-.}"

if [ ! -d "$TARGET" ] || [ ! -r "$TARGET" ]; then
  echo "detect.sh: cannot read target dir: $TARGET" >&2
  exit 2
fi

PKG="$TARGET/package.json"

# has_pkg <ERE> — true if package.json matches (false when package.json absent).
has_pkg() {
  [ -f "$PKG" ] || return 1
  grep -Eq "$1" "$PKG" 2>/dev/null
}

# first_config <glob...> — print first existing config file basename, else nothing.
first_config() {
  local g f
  for g in "$@"; do
    for f in "$TARGET"/$g; do
      [ -e "$f" ] || continue
      printf '%s' "${f##*/}"
      return 0
    done
  done
  return 0
}

# ---------------------------------------------------------------------------
# Framework
# ---------------------------------------------------------------------------
framework="unknown"
if has_pkg '"next"[[:space:]]*:'; then
  if [ -d "$TARGET/app" ] || [ -d "$TARGET/src/app" ]; then
    framework="next (App Router)"
  else
    framework="next"
  fi
elif has_pkg '"nuxt"[[:space:]]*:'; then
  framework="nuxt"
elif has_pkg '"@sveltejs/kit"[[:space:]]*:'; then
  framework="sveltekit"
elif has_pkg '"astro"[[:space:]]*:'; then
  framework="astro"
elif has_pkg '"@remix-run/(react|node)"'; then
  framework="remix"
elif has_pkg '"gatsby"[[:space:]]*:'; then
  framework="gatsby"
elif has_pkg '"react-scripts"[[:space:]]*:'; then
  framework="create-react-app"
elif has_pkg '"vue"[[:space:]]*:'; then
  framework="vue"
elif has_pkg '"svelte"[[:space:]]*:'; then
  framework="svelte"
elif has_pkg '"@angular/core"[[:space:]]*:'; then
  framework="angular"
elif has_pkg '"react"[[:space:]]*:'; then
  framework="react (no framework detected)"
fi
if [ "$framework" = "unknown" ]; then
  cfg="$(first_config 'next.config.*' 'nuxt.config.*' 'svelte.config.*' 'astro.config.*' 'vite.config.*' 'remix.config.*')"
  if [ -n "$cfg" ]; then framework="config: $cfg"; fi
fi

# ---------------------------------------------------------------------------
# Styling (may be multiple — routing rule: keep one system at a time)
# ---------------------------------------------------------------------------
styling=""
add_styling() {
  if [ -z "$styling" ]; then styling="$1"; else styling="$styling + $1"; fi
}

if has_pkg '"tailwindcss"[[:space:]]*:'; then
  tw_ver="$(grep -Eo '"tailwindcss"[[:space:]]*:[[:space:]]*"[^"]*"' "$PKG" 2>/dev/null \
    | head -n 1 | grep -Eo '[0-9]+(\.[0-9]+)+' | head -n 1 || true)"
  add_styling "tailwind${tw_ver:+ v$tw_ver}"
fi
if has_pkg '"styled-components"'; then add_styling "styled-components (css-in-js)"; fi
if has_pkg '"@emotion/(react|styled)"'; then add_styling "emotion (css-in-js)"; fi
if has_pkg '"@vanilla-extract/'; then add_styling "vanilla-extract"; fi
if has_pkg '"linaria"'; then add_styling "linaria"; fi

css_modules="$(find "$TARGET" \( -name node_modules -o -name .git -o -name dist -o -name build -o -name .next \) -prune \
  -o -name '*.module.css' -print 2>/dev/null | head -n 1 || true)"
if [ -n "$css_modules" ]; then add_styling "css-modules"; fi

if [ -z "$styling" ]; then
  if [ -f "$PKG" ]; then styling="plain css (no library detected)"; else styling="unknown (no package.json)"; fi
fi

# ---------------------------------------------------------------------------
# Animation
# ---------------------------------------------------------------------------
animation=""
add_anim() {
  if [ -z "$animation" ]; then animation="$1"; else animation="$animation + $1"; fi
}

if has_pkg '"motion"[[:space:]]*:'; then add_anim "motion"; fi
if has_pkg '"framer-motion"[[:space:]]*:'; then add_anim "framer-motion (motion legacy)"; fi
if has_pkg '"gsap"[[:space:]]*:' || has_pkg '"@gsap/react"'; then add_anim "gsap"; fi
if has_pkg '"react-spring"[[:space:]]*:' || has_pkg '"@react-spring/'; then add_anim "react-spring"; fi
if has_pkg '"animejs"[[:space:]]*:' || has_pkg '"@animejs/'; then add_anim "animejs"; fi
if has_pkg '"react-transition-group"'; then add_anim "react-transition-group"; fi

if [ -z "$animation" ]; then
  if [ -f "$PKG" ]; then
    animation="css transitions/WAAPI (no library)"
  else
    animation="unknown (no package.json)"
  fi
fi

# ---------------------------------------------------------------------------
# Component library
# ---------------------------------------------------------------------------
components=""
add_comp() {
  if [ -z "$components" ]; then components="$1"; else components="$components + $1"; fi
}

if [ -f "$TARGET/components.json" ]; then add_comp "shadcn (components.json)"; fi
if has_pkg '"@radix-ui/react-'; then add_comp "radix-ui"; fi
if has_pkg '"@base-ui-components/'; then add_comp "base-ui"; fi
if has_pkg '"react-aria"|"@react-aria/|"react-aria-components"'; then add_comp "react-aria"; fi
if has_pkg '"@headlessui/react"'; then add_comp "headlessui"; fi
if has_pkg '"@mui/'; then add_comp "mui"; fi
if [ -z "$components" ]; then
  if [ -f "$PKG" ]; then components="none detected (hand-rolled)"; else components="unknown (no package.json)"; fi
fi

# ---------------------------------------------------------------------------
# Report (stdout only; nothing written to disk)
# ---------------------------------------------------------------------------
printf 'project:   %s\n' "$TARGET"
printf 'framework: %s\n' "$framework"
printf 'styling:   %s\n' "$styling"
printf 'animation: %s\n' "$animation"
printf 'components: %s\n' "$components"
exit 0
