#!/usr/bin/env bash
#
# deploy.sh — publish the freight.ai pre-release landing to GitHub Pages.
#
# Run it from this directory (site/):
#   bash deploy.sh
#
# Requirements: git, and the gh CLI already authenticated (`gh auth status`).
# No secrets live in this file; the owner is resolved from your gh login.
#
set -euo pipefail

REPO="freight-ai"
BRANCH="main"

# GitHub owner comes from the authenticated gh account — never hardcoded.
OWNER="$(gh api user --jq '.login')"
echo ">> Publishing as ${OWNER}/${REPO}"

# 1) Make sure this directory is a git repository on the right branch.
if [ ! -d .git ]; then
  git init --initial-branch="${BRANCH}" 2>/dev/null || git init
fi

# 2) Commit the current state of the site.
git add -A
git commit -m "Publish freight.ai pre-release landing" \
  || echo ">> Nothing new to commit, continuing"

# 3) Create the public repo (first run) or push to the existing one.
if gh repo view "${OWNER}/${REPO}" > /dev/null 2>&1; then
  git remote add origin "https://github.com/${OWNER}/${REPO}.git" 2>/dev/null || true
  git push -u origin "${BRANCH}"
else
  gh repo create "${REPO}" --public --source=. --push
fi

# 4) Serve the repo root of main through GitHub Pages.
gh api -X POST "repos/${OWNER}/${REPO}/pages" \
  -f "source[branch]=${BRANCH}" \
  -f "source[path]=/" \
  || echo ">> Pages may already be enabled — ignoring"

echo ">> Done. Site: https://${OWNER}.github.io/${REPO}/"
