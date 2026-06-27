#!/usr/bin/env bash
# decentpowers structural gate - deterministic checks for the plugin's own ACs.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
fail=0
pass() { printf 'PASS  %s\n' "$1"; }
bad()  { printf 'FAIL  %s\n' "$1"; fail=1; }
check_file() { if [ -f "$1" ]; then pass "exists: $1"; else bad "missing: $1"; fi; }

# AC-1 / AC-2: manifests + hook wiring
check_file ".claude-plugin/plugin.json"
check_file ".claude-plugin/marketplace.json"
check_file "hooks/hooks.json"
check_file "hooks/run-hook.cmd"
check_file "hooks/session-start"

json_ok() {
  if   command -v node    >/dev/null 2>&1; then node -e "JSON.parse(require('fs').readFileSync('$1','utf8'))" 2>/dev/null && pass "valid JSON: $1" || bad "invalid JSON: $1";
  elif command -v python3 >/dev/null 2>&1; then python3 -c "import json; json.load(open('$1'))" 2>/dev/null && pass "valid JSON: $1" || bad "invalid JSON: $1";
  else printf 'SKIP  JSON validate (no node/python): %s\n' "$1"; fi
}
json_ok ".claude-plugin/plugin.json"
json_ok ".claude-plugin/marketplace.json"
json_ok "hooks/hooks.json"

if grep -q "run-hook.cmd" hooks/hooks.json 2>/dev/null && grep -q "session-start" hooks/hooks.json 2>/dev/null; then pass "hooks.json wires session-start"; else bad "hooks.json missing session-start wiring"; fi
if grep -q "using-decentpowers/SKILL.md" hooks/session-start 2>/dev/null; then pass "session-start injects using-decentpowers"; else bad "session-start does not inject using-decentpowers"; fi

# AC-3: exactly 7 skills, each with frontmatter
SKILLS="using-decentpowers brainstorming writing-spec implementing verifying debugging finishing"
for s in $SKILLS; do
  f="skills/$s/SKILL.md"
  if [ -f "$f" ]; then
    if grep -q "^name:" "$f" && grep -q "^description:" "$f"; then pass "frontmatter: $f"; else bad "frontmatter missing in $f"; fi
  else bad "missing skill: $f"; fi
done
if [ -d skills ]; then
  count=$(find skills -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
  if [ "$count" = "7" ]; then pass "exactly 7 skill dirs"; else bad "expected 7 skill dirs, found $count"; fi
else bad "missing skills/ directory"; fi

# AC-5: spec template has the layered sections
T="skills/writing-spec/spec-template.md"
check_file "$T"
if [ -f "$T" ]; then
  for sec in "Acceptance at a glance" "## Scope" "Requirements & design notes" "## Tasks" "End-to-end verification" "Open questions"; do
    if grep -q "$sec" "$T"; then pass "spec section: $sec"; else bad "spec template missing: $sec"; fi
  done
fi

# AC-9 / AC-10: docs exist; no placeholders in skills/
check_file "README.md"
check_file "CONTRIBUTING.md"
check_file "LICENSE"
if [ -d skills ] && grep -rnE "TBD|TODO|FIXME|implement later|fill in details" skills >/dev/null 2>&1; then
  bad "placeholder found in skills/:"; grep -rnE "TBD|TODO|FIXME|implement later|fill in details" skills;
else pass "no placeholders in skills/"; fi

echo
if [ "$fail" = "0" ]; then echo "ALL CHECKS PASSED"; else echo "CHECKS FAILED"; fi
exit "$fail"
