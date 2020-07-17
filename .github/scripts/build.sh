#!/usr/bin/env bash
files=(
  "LICENSE.md"
  "README.md"
)

root="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

version=$1

if [[ -z $version ]]; then
  echo "Error: no version set."
  echo "Usage: $ build.sh [VERSION]"
  exit 1
fi

base="$root/../.."
dist="$base/dist"

# Cleanup
rm -rf "$dist"
mkdir -p "$dist"

# Copy files
for f in "$base"/src/*; do
  cp -R "$f" "$dist"
done

for f in "${files[@]}"; do
  cp "$base/$f" "$dist"
done

# Patch version
jq ".version = \"$version\"" "$base/package.json" > "$dist/package.json"

echo "Successfully build version $version"