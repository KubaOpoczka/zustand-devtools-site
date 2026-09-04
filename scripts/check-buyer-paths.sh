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
require_text '"softwareVersion": "1.1.2"' "$page"
require_text '107 automated tests' "$page"
require_text 'extension 1.1.2 / bridge 0.2.1' "$page"
require_text "Listed on Zustand's third-party libraries page" "$page"
require_text 'community listing, not an official recommendation' "$page"
require_text 'href="https://zustand.docs.pmnd.rs/reference/integrations/third-party-libraries"' "$page"
require_text 'href="https://opoczka.gumroad.com/l/zustand-devtools-pro"' "$page"
require_text 'base price €9.99 plus applicable tax' "$page"
require_text 'id="diagnosis"' "$page"
require_text 'Zustand Bug Clinic' "$page"
require_text 'First five suitable bugs · no charge' "$page"
require_text 'open through 18 Sep' "$page"
require_text 'Submit a bug for the free clinic' "$page"
require_text 'I%20can%20answer%203%20short%20follow-up%20questions' "$page"
require_text 'Check paid diagnosis fit' "$page"
require_text 'Zustand%20version%3A' "$page"
require_text 'Please%20do%20not%20include%20secrets%20or%20unredacted%20production%20state' "$page"
require_text 'Submit it to the Zustand Bug Clinic' "$repo_root/debug-zustand-state-changes.html"
require_text 'Any request to publish an anonymized case summary is separate and' "$repo_root/terms.html"
reject_text 'Buy Pro · €9.99 once' "$page"

for local_page in privacy.html terms.html name-zustand-stores-actions.html debug-zustand-state-changes.html zustand-devtools-comparison.html; do
  if [ ! -f "$repo_root/$local_page" ]; then
    echo "Missing linked local page: $local_page" >&2
    exit 1
  fi
done

naming_guide="$repo_root/name-zustand-stores-actions.html"
require_text '"@type": "TechArticle"' "$naming_guide"
require_text "'cart/addItem'" "$naming_guide"
require_text "name: 'cart'" "$naming_guide"
require_text 'utm_source=zustand_naming_guide' "$naming_guide"
require_text 'utm_campaign=zustand_trace_launch' "$naming_guide"
require_text 'founder disclosure:' "$naming_guide"
require_text 'Kuba builds Zustand' "$naming_guide"
reject_text 'official recommendation' "$naming_guide"

require_text 'name-zustand-stores-actions.html' "$repo_root/sitemap.xml"
require_text 'name-zustand-stores-actions.html' "$repo_root/llms.txt"
require_text 'utm_source=zustand_comparison_guide' "$repo_root/zustand-devtools-comparison.html"
require_text 'utm_campaign=zustand_trace_launch' "$repo_root/zustand-devtools-comparison.html"

echo "Zustand buyer-path checks passed."
