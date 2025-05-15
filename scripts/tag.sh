#!/bin/bash

# Get latest tag
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
VERSION=${LATEST_TAG#v}

# Parse version
IFS='.' read -r MAJOR MINOR PATCH <<< "$VERSION"

# Check last commit message
COMMIT_MSG=$(git log -1 --pretty=%B)
if [[ $COMMIT_MSG == feat* ]]; then
    MINOR=$((MINOR + 1))
    PATCH=0
elif [[ $COMMIT_MSG == fix* ]]; then
    PATCH=$((PATCH + 1))
else
    echo "No version increment needed"
    exit 0
fi

# Create new tag
NEW_TAG="v$MAJOR.$MINOR.$PATCH"
git tag $NEW_TAG
git push origin $NEW_TAG