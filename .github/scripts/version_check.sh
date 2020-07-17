#!/usr/bin/env bash
version_from_tag=${GITHUB_REF/refs\/tags\//}
version_package_json=$(jq -r .version < package.json)
version_package_lock=$(jq -r .version < package-lock.json)

if [[ "$version_from_tag" != "$version_package_json" ]]; then
  echo "::error ::Expected $version_from_tag but got $version_package_json in package.json"
fi

if [[ "$version_from_tag" != "$version_package_lock" ]]; then
  echo "::error ::Expected $version_from_tag but got $version_package_lock in package-lock.json. Run npm install to update it"
fi
