#!/usr/bin/env bash
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
page="$repo_root/index.html"

require_text() {
  needle=$1
  file=$2
  if ! grep -Fq -- "$needle" "$file"; then
    echo "Missing expected buyer-path text in ${file#$repo_root/}: $needle" >&2
    exit 1
  fi
}

reject_text() {
  needle=$1
  file=$2
  if grep -Fq -- "$needle" "$file"; then
    echo "Found stale buyer-path text in ${file#$repo_root/}: $needle" >&2
    exit 1
  fi
}

require_text 'Try 3 Trace Sessions free' "$page"
require_text 'No card · 3 full sessions · buy only if useful' "$page"
require_text "Listed in Zustand's official third-party libraries" "$page"
require_text 'community listing, not an official recommendation' "$page"
require_text 'href="https://zustand.docs.pmnd.rs/reference/integrations/third-party-libraries"' "$page"
require_text 'href="https://opoczka.gumroad.com/l/zustand-devtools-pro"' "$page"
require_text 'base price €9.99 plus applicable tax' "$page"
require_text 'id="diagnosis"' "$page"
require_text 'Check fit — no payment yet' "$page"
require_text 'Zustand%20version%3A' "$page"
require_text 'Please%20do%20not%20include%20secrets%20or%20unredacted%20production%20state' "$page"
reject_text 'Buy Pro · €9.99 once' "$page"

for local_page in privacy.html terms.html debug-zustand-state-changes.html zustand-devtools-comparison.html; do
  if [ ! -f "$repo_root/$local_page" ]; then
    echo "Missing linked local page: $local_page" >&2
    exit 1
  fi
done

echo "Zustand buyer-path checks passed."
