#!/bin/bash
if [ "$GITHUB_REF" = "refs/heads/main" ]; then
  latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
  new_version=$(echo $latest_tag | awk -F. '{printf("v%d.%d.%d", $1, $2, $3+1)}')
  echo "NEW_VERSION=$new_version" >> $GITHUB_ENV
  git tag $new_version
  git push origin $new_version
fi
