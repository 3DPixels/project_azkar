#!/bin/bash

# 1. Error Handling Setup
# 'set -e' stops the script immediately on any error.
# 'trap' catches the error and prints exactly which line and command failed.
set -e
trap 'echo -e "\n❌ Error: Script failed at line $LINENO while executing command: $BASH_COMMAND"; exit 1' ERR

# 2. Extract and Parse the Current Version
CURRENT_VERSION=$(grep '^version: ' pubspec.yaml | sed -E 's/version: (.*)/\1/')
echo -e "Current full version: \033[1;36m$CURRENT_VERSION\033[0m"

# Parse the version into Base (1.2.2), Pre-release (beta.1), and Build (3) using Regex
if [[ "$CURRENT_VERSION" =~ ^([0-9]+\.[0-9]+\.[0-9]+)(-([a-zA-Z0-9.]+))?(\+([0-9]+))?$ ]]; then
    OLD_BASE="${BASH_REMATCH[1]}"
    OLD_PRE="${BASH_REMATCH[3]}"
    OLD_BUILD="${BASH_REMATCH[5]}"
else
    OLD_BASE="$CURRENT_VERSION"
fi

# 3. Input with Pre-fill
# 'read -e -i' pre-fills the input field so you can edit it or just press Enter.
read -e -i "$OLD_BASE" -p "Enter the base version (Major.Minor.Patch): " NEW_BASE

# 4. Input Validation
# Check for disallowed characters (only numbers and dots allowed)
if ! [[ "$NEW_BASE" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "❌ Error: Invalid format. Use only numbers and dots (e.g., 1.2.2)."
    exit 1
fi

# Prevent decreasing the version using awk to compare the two strings
IS_VALID=$(awk -v v1="$NEW_BASE" -v v2="$OLD_BASE" 'BEGIN {
    split(v1, a, "."); split(v2, b, ".");
    for (i=1; i<=3; i++) {
        if (a[i] < b[i]) { print 0; exit; }
        if (a[i] > b[i]) { print 1; exit; }
    }
    print 1; # Equal is valid
}')

if [ "$IS_VALID" -eq 0 ]; then
    echo "❌ Error: You cannot decrease the base version below $OLD_BASE."
    exit 1
fi

# 5. Version Flag Logic
# The capital 'Y' indicates the default.
read -p "Is this a pre-release? (Y/n): " IS_PRE_INPUT
# If the user just presses Enter, force the variable to 'y'
IS_PRE_INPUT=${IS_PRE_INPUT:-y} 

FINAL_VERSION=""
IS_PRERELEASE_FLAG="n"

if [[ -n "$OLD_PRE" ]]; then
    # Scenario: It WAS a pre-release before
    if [[ "$IS_PRE_INPUT" == "y" || "$IS_PRE_INPUT" == "Y" ]]; then
        IS_PRERELEASE_FLAG="y"
        if [[ "$NEW_BASE" == "$OLD_BASE" ]]; then
            NEW_BUILD=$(( ${OLD_BUILD:-0} + 1 ))
            FINAL_VERSION="${NEW_BASE}-${OLD_PRE}+${NEW_BUILD}"
        else
            FINAL_VERSION="${NEW_BASE}-beta.1+1"
        fi
    else
        read -p "Warning: The previous version was a pre-release. Are you sure you want to leave pre-release? (Y/n): " CONFIRM_LEAVE
        CONFIRM_LEAVE=${CONFIRM_LEAVE:-y}
        if [[ "$CONFIRM_LEAVE" == "y" || "$CONFIRM_LEAVE" == "Y" ]]; then
            FINAL_VERSION="$NEW_BASE"
        else
            echo "Aborting release process."
            exit 1
        fi
    fi
else
    # Scenario: It was NOT a pre-release before
    if [[ "$IS_PRE_INPUT" == "y" || "$IS_PRE_INPUT" == "Y" ]]; then
        IS_PRERELEASE_FLAG="y"
        FINAL_VERSION="${NEW_BASE}-beta.1+1"
    else
        FINAL_VERSION="$NEW_BASE"
    fi
fi

echo -e "\nTarget Version: \033[1;32m$FINAL_VERSION\033[0m\n"

# 6. Gather Release Info
# Automatically detect the current Git branch
TARGET_BRANCH=$(git branch --show-current)
echo "Target branch automatically set to: $TARGET_BRANCH"

echo "Opening editor for release notes..."
TMP_FILE=$(mktemp)
nano "$TMP_FILE" 
RELEASE_NOTES=$(cat "$TMP_FILE")
rm "$TMP_FILE"

# Automatically append the hardware explanations
RELEASE_NOTES="$RELEASE_NOTES
- app-x86_64 is for emulators.
- app-arm64-v8a is for modern phones."

# 7. Execute Build and Upload
sed -i "s/^version: $CURRENT_VERSION/version: $FINAL_VERSION/" pubspec.yaml
echo "✅ pubspec.yaml updated."

echo "⏳ Building Flutter release split APKs..."
flutter build apk --release --split-per-abi
echo "✅ Build successful."

APK_ARM="build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
APK_X86_64="build/app/outputs/flutter-apk/app-x86_64-release.apk"
TAG_NAME="v$FINAL_VERSION"

echo "⏳ Uploading to GitHub..."
if [ "$IS_PRERELEASE_FLAG" == "y" ]; then
    gh release create "$TAG_NAME" "$APK_ARM" "$APK_X86_64" --target "$TARGET_BRANCH" --title "Internal $TAG_NAME" --notes "$RELEASE_NOTES" --prerelease
else
    gh release create "$TAG_NAME" "$APK_ARM" "$APK_X86_64" --target "$TARGET_BRANCH" --title "Release $TAG_NAME" --notes "$RELEASE_NOTES"
fi

# This line will ONLY execute if every command above it succeeded.
echo -e "\n🎉 Upload complete! Release $TAG_NAME is live."