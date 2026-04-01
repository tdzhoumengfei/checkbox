#!/usr/bin/env bash

set -euo pipefail

# Usage: ./scripts/read-inputs.sh <ENV> <REGION> <OS> <PLATFORM_TYPE> <TEST_GROUP> <EVENT_NAME>
# Example: ./scripts/read-inputs.sh "PRD" "all" "linux" "browser" "synthetic" "workflow_dispatch"

ENV="${1:-PRD}"
REGION_INPUT="${2:-all}"
OS="${3:-linux}"
PLATFORM_TYPE="${4:-browser}"
TEST_GROUP="${5:-synthetic}"
EVENT_NAME="${6:-schedule}"

# Define available regions per environment
declare -A REGION_MAP
REGION_MAP=(
  ["US"]="${ENV}-US"
  ["EU"]="${ENV}-EU"
  ["CA"]="${ENV}-CA"
  ["AP"]="${ENV}-AP"
  ["UK"]="${ENV}-UK"
)

ALL_REGIONS=("US" "EU" "CA" "AP" "UK")

# Build region JSON array
if [ "$REGION_INPUT" = "all" ]; then
  SELECTED_REGIONS=("${ALL_REGIONS[@]}")
else
  IFS=',' read -ra SELECTED_REGIONS <<< "$REGION_INPUT"
fi

# Build JSON array for matrix strategy
REGION_JSON="["
ALLURE_RESULTS=""
FIRST=true
for r in "${SELECTED_REGIONS[@]}"; do
  REGION_KEY="${REGION_MAP[$r]:-$r}"
  if [ "$FIRST" = true ]; then
    REGION_JSON+="\"${REGION_KEY}\""
    ALLURE_RESULTS+="${REGION_KEY}"
    FIRST=false
  else
    REGION_JSON+=",\"${REGION_KEY}\""
    ALLURE_RESULTS+=",${REGION_KEY}"
  fi
done
REGION_JSON+="]"

# Build allure-results compressed files pattern
ALLURE_RESULTS_FILES=""
FIRST=true
for r in "${SELECTED_REGIONS[@]}"; do
  REGION_KEY="${REGION_MAP[$r]:-$r}"
  if [ "$FIRST" = true ]; then
    ALLURE_RESULTS_FILES+="allure-results-${REGION_KEY}-${OS}.zip"
    FIRST=false
  else
    ALLURE_RESULTS_FILES+=",allure-results-${REGION_KEY}-${OS}.zip"
  fi
done

echo "region=${REGION_JSON}" >> "$GITHUB_OUTPUT"
echo "allure-results=${ALLURE_RESULTS_FILES}" >> "$GITHUB_OUTPUT"
echo "platform_type=${PLATFORM_TYPE}" >> "$GITHUB_OUTPUT"

# Set test_group based on input
if [ "$TEST_GROUP" = "synthetic" ]; then
  echo "test_group=--grep @synthetic" >> "$GITHUB_OUTPUT"
elif [ "$TEST_GROUP" = "all" ]; then
  echo "test_group=--grep-invert @lighthouse" >> "$GITHUB_OUTPUT"
elif [ "$TEST_GROUP" = "lighthouse" ]; then
  echo "test_group=--grep @lighthouse" >> "$GITHUB_OUTPUT"
else
  echo "test_group=--grep @${TEST_GROUP}" >> "$GITHUB_OUTPUT"
fi

echo "::notice::Environment: ${ENV}"
echo "::notice::Regions: ${REGION_JSON}"
echo "::notice::OS: ${OS}"
echo "::notice::Platform Type: ${PLATFORM_TYPE}"
echo "::notice::Test Group: ${TEST_GROUP}"
echo "::notice::Event: ${EVENT_NAME}"
