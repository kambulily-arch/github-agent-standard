#!/usr/bin/env bash
set -euo pipefail

output="REPOSITORY_INDEX.md"

echo '<!-- GENERATED FILE. Do not edit manually. -->' > "$output"
echo >> "$output"
echo '# Repository Index' >> "$output"
echo >> "$output"
echo '> Generated automatically by the repository governance workflow.' >> "$output"
echo >> "$output"
echo '## Top-level structure' >> "$output"
echo >> "$output"

find . -maxdepth 2 -type f \
  -not -path './.git/*' \
  -not -path './REPOSITORY_INDEX.md' \
  | sort \
  | sed 's#^./##' \
  | while IFS= read -r path; do
      printf '%s\n' "- \`$path\`" >> "$output"
    done

echo >> "$output"
echo '## Important rule' >> "$output"
echo >> "$output"
echo 'This file is generated. Modify the generator, not this file.' >> "$output"
