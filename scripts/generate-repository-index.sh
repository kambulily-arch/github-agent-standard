#!/usr/bin/env bash
set -euo pipefail

output="REPOSITORY_INDEX.md"

{
  echo '<!-- GENERATED FILE. Do not edit manually. -->'
  echo
  echo '# Repository Index'
  echo
  echo '> Generated automatically from the repository tree.'
  echo
  echo '## Top-level structure'
  echo
  find . -maxdepth 1 -mindepth 1 \( -type d -o -type f \) -printf '%f\n' \
    | sort \
    | while IFS= read -r path; do
        case "$path" in
          .git|REPOSITORY_INDEX.md) continue ;;
        esac
        printf '%s\n' "- \`$path\`"
      done
  echo
  echo '## Important rule'
  echo
  echo 'This file is generated. Modify the generator or repository source, not this file.'
} > "$output"
