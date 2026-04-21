#!/usr/bin/env bash
set -euo pipefail
BRANCH=$(git rev-parse --abbrev-ref HEAD)
PATTERN="^(main|staging|develop|(feature|fix|chore|hotfix|release|refactor|docs|test)/[a-z0-9]([a-z0-9-]*[a-z0-9])?)$"
if [[ ! "$BRANCH" =~ $PATTERN ]]; then
  echo "✖ Branch '${BRANCH}' violates naming convention."
  echo "  Allowed: main | staging | develop | feature/x | fix/x | chore/x | hotfix/x"
  exit 1
fi
echo "✔ Branch '${BRANCH}' is valid."
