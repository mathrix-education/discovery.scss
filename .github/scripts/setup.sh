#!/usr/bin/env bash
# Setup the pipeline configuration based on the current context
# We will use the GITHUB_REF environment variable to setup most of the values

root="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
# shellcheck source=actions.sh
source "$root/actions.sh"

# Git-related
if [[ -z "$GITHUB_SHA" ]]; then
  sha=$(git rev-parse HEAD)
else
  sha="$GITHUB_SHA"
fi

short_sha=${sha:0:7}

version=$(jq -r .version < "$root/../../package.json")
counter="${GITHUB_RUN_NUMBER:-0000}"
semver="$version+$counter.$short_sha"

# Outputs
set_output "version" "$version"
set_output "semver" "$semver"
