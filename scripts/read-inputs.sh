#!/usr/bin/env bash

ENVIRONMENT=$1
REGION_INPUT=${2:-"all"}
OS_INPUT=${3:-"linux"}
PLATFORM_INPUT=${4:-"browser"}
TEST_GROUP_INPUT=${5:-"all"}
EVENT_NAME=$6

# Special case for scheduled Windows runs
if [ "$EVENT_NAME" = "schedule" ] && [ "$OS_INPUT" = "windows" ]; then
  echo "This is a scheduled Windows run - setting to US Windows browser tests"
  REGION_INPUT="US"
  OS_INPUT="windows"
  PLATFORM_INPUT="browser"
  TEST_GROUP_INPUT="all"
fi

if [ "$ENVIRONMENT" == "PRD" ]; then
    if [[ "$EVENT_NAME" = "schedule" || "$EVENT_NAME" = "workflow_dispatch" ]] && [ "$TEST_GROUP_INPUT" != "synthetic" ]; then
        case "$REGION_INPUT" in
            "all")
                if [ "$OS_INPUT" = "all" ]; then
                    if [ "$PLATFORM_INPUT" = "all" ]; then
                        echo -e 'region=["prd-us", "prd-eu", "prd-ca", "prd-ap", "prd-uk", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-us-linux-browser,allure-results-prd-ca-linux-browser,allure-results-prd-eu-linux-browser,allure-results-prd-ap-linux-browser,allure-results-prd-uk-linux-browser,allure-results-prd-eu-dialer-integration-1-linux-browser,allure-results-prd-us-windows-desktop,allure-results-prd-ca-windows-desktop,allure-results-prd-eu-windows-desktop,allure-results-prd-ap-windows-desktop,allure-results-prd-uk-windows-desktop,allure-results-prd-eu-dialer-integration-1-windows-desktop' >> "$GITHUB_OUTPUT"
                    elif [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-us", "prd-eu", "prd-ca", "prd-ap", "prd-uk", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-us-linux-desktop,allure-results-prd-ca-linux-desktop,allure-results-prd-eu-linux-desktop,allure-results-prd-ap-linux-desktop,allure-results-prd-eu-dialer-integration-1-linux-desktop,allure-results-prd-us-windows-desktop,allure-results-prd-ca-windows-desktop,allure-results-prd-eu-windows-desktop,allure-results-prd-ap-windows-desktop,allure-results-prd-uk-windows-desktop,allure-results-prd-eu-dialer-integration-1-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-us", "prd-eu", "prd-ca", "prd-ap", "prd-uk", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-us-linux-browser,allure-results-prd-ca-linux-browser,allure-results-prd-eu-linux-browser,allure-results-prd-ap-linux-browser,allure-results-prd-uk-linux-browser,allure-results-prd-eu-dialer-integration-1-linux-browser,allure-results-prd-us-windows-browser,allure-results-prd-ca-windows-browser,allure-results-prd-eu-windows-browser,allure-results-prd-ap-windows-browser,allure-results-prd-uk-windows-browser,allure-results-prd-eu-dialer-integration-1-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                elif [ "$OS_INPUT" = "windows" ]; then
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-us", "prd-eu", "prd-ca", "prd-ap", "prd-uk", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-us-windows-desktop,allure-results-prd-ca-windows-desktop,allure-results-prd-eu-windows-desktop,allure-results-prd-ap-windows-desktop,allure-results-prd-uk-windows-desktop,allure-results-prd-eu-dialer-integration-1-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-us", "prd-eu", "prd-ca", "prd-ap", "prd-uk", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-us-windows-browser,allure-results-prd-ca-windows-browser,allure-results-prd-eu-windows-browser,allure-results-prd-ap-windows-browser,allure-results-prd-uk-windows-browser,allure-results-prd-eu-dialer-integration-1-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                else
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-us", "prd-eu", "prd-ca", "prd-ap", "prd-uk", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-us-linux-desktop,allure-results-prd-ca-linux-desktop,allure-results-prd-eu-linux-desktop,allure-results-prd-ap-linux-desktop,allure-results-prd-uk-linux-desktop,allure-results-prd-eu-dialer-integration-1-linux-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-us", "prd-eu", "prd-ca", "prd-ap", "prd-uk", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-us-linux-browser,allure-results-prd-ca-linux-browser,allure-results-prd-eu-linux-browser,allure-results-prd-ap-linux-browser,allure-results-prd-uk-linux-browser,allure-results-prd-eu-dialer-integration-1-linux-browser' >> "$GITHUB_OUTPUT"
                    fi
                fi
                ;;
            "US")
                if [ "$OS_INPUT" = "all" ]; then
                    if [ "$PLATFORM_INPUT" = "all" ]; then
                        echo -e 'region=["prd-us"]\nallure-results=allure-results-prd-us-linux-browser,allure-results-prd-us-windows-desktop' >> "$GITHUB_OUTPUT"
                    elif [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-us"]\nallure-results=allure-results-prd-us-linux-desktop,allure-results-prd-us-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-us"]\nallure-results=allure-results-prd-us-linux-browser,allure-results-prd-us-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                elif [ "$OS_INPUT" = "windows" ]; then
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-us"]\nallure-results=allure-results-prd-us-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-us"]\nallure-results=allure-results-prd-us-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                else
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-us"]\nallure-results=allure-results-prd-us-linux-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-us"]\nallure-results=allure-results-prd-us-linux-browser' >> "$GITHUB_OUTPUT"
                    fi
                fi
                ;;
            "EU")
                if [ "$OS_INPUT" = "all" ]; then
                    if [ "$PLATFORM_INPUT" = "all" ]; then
                        echo -e 'region=["prd-eu", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-eu-linux-browser,allure-results-prd-eu-dialer-integration-1-linux-browser,allure-results-prd-eu-windows-desktop,allure-results-prd-eu-dialer-integration-1-windows-desktop' >> "$GITHUB_OUTPUT"
                    elif [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-eu", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-eu-linux-desktop,allure-results-prd-eu-dialer-integration-1-linux-desktop,allure-results-prd-eu-windows-desktop,allure-results-prd-eu-dialer-integration-1-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-eu", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-eu-linux-browser,allure-results-prd-eu-windows-browser,allure-results-prd-eu-dialer-integration-1-linux-browser,allure-results-prd-eu-dialer-integration-1-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                elif [ "$OS_INPUT" = "windows" ]; then
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-eu", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-eu-windows-desktop,allure-results-prd-eu-dialer-integration-1-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-eu", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-eu-windows-browser,allure-results-prd-eu-dialer-integration-1-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                else
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-eu", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-eu-linux-desktop,allure-results-prd-eu-dialer-integration-1-linux-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-eu", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-eu-linux-browser,allure-results-prd-eu-dialer-integration-1-linux-browser' >> "$GITHUB_OUTPUT"
                    fi
                fi
                ;;
            "CA")
                if [ "$OS_INPUT" = "all" ]; then
                    if [ "$PLATFORM_INPUT" = "all" ]; then
                        echo -e 'region=["prd-ca"]\nallure-results=allure-results-prd-ca-linux-browser,allure-results-prd-ca-windows-desktop' >> "$GITHUB_OUTPUT"
                    elif [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-ca"]\nallure-results=allure-results-prd-ca-linux-desktop,allure-results-prd-ca-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-ca"]\nallure-results=allure-results-prd-ca-linux-browser,allure-results-prd-ca-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                elif [ "$OS_INPUT" = "windows" ]; then
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-ca"]\nallure-results=allure-results-prd-ca-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-ca"]\nallure-results=allure-results-prd-ca-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                else
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-ca"]\nallure-results=allure-results-prd-ca-linux-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-ca"]\nallure-results=allure-results-prd-ca-linux-browser' >> "$GITHUB_OUTPUT"
                    fi
                fi
                ;;
            "AP")
                if [ "$OS_INPUT" = "all" ]; then
                    if [ "$PLATFORM_INPUT" = "all" ]; then
                        echo -e 'region=["prd-ap"]\nallure-results=allure-results-prd-ap-linux-browser,allure-results-prd-ap-windows-desktop' >> "$GITHUB_OUTPUT"
                    elif [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-ap"]\nallure-results=allure-results-prd-ap-linux-desktop,allure-results-prd-ap-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-ap"]\nallure-results=allure-results-prd-ap-linux-browser,allure-results-prd-ap-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                elif [ "$OS_INPUT" = "windows" ]; then
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-ap"]\nallure-results=allure-results-prd-ap-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-ap"]\nallure-results=allure-results-prd-ap-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                else
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-ap"]\nallure-results=allure-results-prd-ap-linux-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-ap"]\nallure-results=allure-results-prd-ap-linux-browser' >> "$GITHUB_OUTPUT"
                    fi
                fi
                ;;
            "UK")
                if [ "$OS_INPUT" = "all" ]; then
                    if [ "$PLATFORM_INPUT" = "all" ]; then
                        echo -e 'region=["prd-uk"]\nallure-results=allure-results-prd-uk-linux-browser,allure-results-prd-uk-windows-desktop' >> "$GITHUB_OUTPUT"
                    elif [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-uk"]\nallure-results=allure-results-prd-uk-linux-desktop,allure-results-prd-uk-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-uk"]\nallure-results=allure-results-prd-uk-linux-browser,allure-results-prd-uk-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                elif [ "$OS_INPUT" = "windows" ]; then
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-uk"]\nallure-results=allure-results-prd-uk-windows-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-uk"]\nallure-results=allure-results-prd-uk-windows-browser' >> "$GITHUB_OUTPUT"
                    fi
                else
                    if [ "$PLATFORM_INPUT" = "desktop" ]; then
                        echo -e 'region=["prd-uk"]\nallure-results=allure-results-prd-uk-linux-desktop' >> "$GITHUB_OUTPUT"
                    else
                        echo -e 'region=["prd-uk"]\nallure-results=allure-results-prd-uk-linux-browser' >> "$GITHUB_OUTPUT"
                    fi
                fi
                ;;
            *)
                # Handle comma-separated region codes (e.g., "US,EU")
                REGIONS_ARRAY=""
                ALLURE_RESULTS=""
                IFS=',' read -ra REGION_CODES <<< "$REGION_INPUT"
                for CODE in "${REGION_CODES[@]}"; do
                    CODE=$(echo "$CODE" | tr '[:upper:]' '[:lower:]' | xargs)
                    if [[ "$CODE" == prd-* ]]; then
                        REGION_NAME="$CODE"
                    else
                        REGION_NAME="prd-${CODE}"
                    fi
                    if [ -n "$REGIONS_ARRAY" ]; then
                        REGIONS_ARRAY="${REGIONS_ARRAY}, \"${REGION_NAME}\""
                    else
                        REGIONS_ARRAY="\"${REGION_NAME}\""
                    fi
                    # EU also includes dialer-integration-1
                    if [ "$CODE" = "eu" ]; then
                        REGIONS_ARRAY="${REGIONS_ARRAY}, \"prd-eu-dialer-integration-1\""
                    fi
                    # Build allure-results based on OS and platform
                    if [ "$OS_INPUT" = "all" ]; then
                        if [ "$PLATFORM_INPUT" = "all" ]; then
                            ALLURE_RESULTS="${ALLURE_RESULTS:+$ALLURE_RESULTS,}allure-results-${REGION_NAME}-linux-browser,allure-results-${REGION_NAME}-windows-desktop"
                        elif [ "$PLATFORM_INPUT" = "desktop" ]; then
                            ALLURE_RESULTS="${ALLURE_RESULTS:+$ALLURE_RESULTS,}allure-results-${REGION_NAME}-linux-desktop,allure-results-${REGION_NAME}-windows-desktop"
                        else
                            ALLURE_RESULTS="${ALLURE_RESULTS:+$ALLURE_RESULTS,}allure-results-${REGION_NAME}-linux-browser,allure-results-${REGION_NAME}-windows-browser"
                        fi
                    elif [ "$OS_INPUT" = "windows" ]; then
                        if [ "$PLATFORM_INPUT" = "desktop" ]; then
                            ALLURE_RESULTS="${ALLURE_RESULTS:+$ALLURE_RESULTS,}allure-results-${REGION_NAME}-windows-desktop"
                        else
                            ALLURE_RESULTS="${ALLURE_RESULTS:+$ALLURE_RESULTS,}allure-results-${REGION_NAME}-windows-browser"
                        fi
                    else
                        if [ "$PLATFORM_INPUT" = "desktop" ]; then
                            ALLURE_RESULTS="${ALLURE_RESULTS:+$ALLURE_RESULTS,}allure-results-${REGION_NAME}-linux-desktop"
                        else
                            ALLURE_RESULTS="${ALLURE_RESULTS:+$ALLURE_RESULTS,}allure-results-${REGION_NAME}-linux-browser"
                        fi
                    fi
                    # Add dialer-integration-1 allure-results for EU
                    if [ "$CODE" = "eu" ]; then
                        if [ "$OS_INPUT" = "all" ]; then
                            if [ "$PLATFORM_INPUT" = "all" ]; then
                                ALLURE_RESULTS="${ALLURE_RESULTS},allure-results-prd-eu-dialer-integration-1-linux-browser,allure-results-prd-eu-dialer-integration-1-windows-desktop"
                            elif [ "$PLATFORM_INPUT" = "desktop" ]; then
                                ALLURE_RESULTS="${ALLURE_RESULTS},allure-results-prd-eu-dialer-integration-1-linux-desktop,allure-results-prd-eu-dialer-integration-1-windows-desktop"
                            else
                                ALLURE_RESULTS="${ALLURE_RESULTS},allure-results-prd-eu-dialer-integration-1-linux-browser,allure-results-prd-eu-dialer-integration-1-windows-browser"
                            fi
                        elif [ "$OS_INPUT" = "windows" ]; then
                            if [ "$PLATFORM_INPUT" = "desktop" ]; then
                                ALLURE_RESULTS="${ALLURE_RESULTS},allure-results-prd-eu-dialer-integration-1-windows-desktop"
                            else
                                ALLURE_RESULTS="${ALLURE_RESULTS},allure-results-prd-eu-dialer-integration-1-windows-browser"
                            fi
                        else
                            if [ "$PLATFORM_INPUT" = "desktop" ]; then
                                ALLURE_RESULTS="${ALLURE_RESULTS},allure-results-prd-eu-dialer-integration-1-linux-desktop"
                            else
                                ALLURE_RESULTS="${ALLURE_RESULTS},allure-results-prd-eu-dialer-integration-1-linux-browser"
                            fi
                        fi
                    fi
                done
                echo -e "region=[${REGIONS_ARRAY}]\nallure-results=${ALLURE_RESULTS}" >> "$GITHUB_OUTPUT"
                ;;
        esac
    elif [ "$TEST_GROUP_INPUT" = "synthetic" ]; then
        if [ "$REGION_INPUT" = "prd-fedramp-synthetic" ]; then
            echo -e 'region=["prd-fedramp-synthetic"]\nallure-results=allure-results-prd-fedramp-synthetic-linux-browser' >> "$GITHUB_OUTPUT"
        elif [ "$REGION_INPUT" = "prd-us-east1-synthetic" ]; then
            echo -e 'region=["prd-us-east1-synthetic"]\nallure-results=allure-results-prd-us-east1-synthetic-linux-browser' >> "$GITHUB_OUTPUT"
        elif [ "$REGION_INPUT" = "prd-eu-west1-synthetic" ]; then
            echo -e 'region=["prd-eu-west1-synthetic"]\nallure-results=allure-results-prd-eu-west1-synthetic-linux-browser' >> "$GITHUB_OUTPUT"
        elif [ "$REGION_INPUT" = "all" ]; then
            echo -e 'region=["prd-us-synthetic", "prd-eu-synthetic", "prd-ca-synthetic", "prd-uk-synthetic", "prd-ap-synthetic", "prd-us-east1-synthetic", "prd-eu-west1-synthetic"]\nallure-results=allure-results-prd-us-synthetic-linux-browser,allure-results-prd-eu-synthetic-linux-browser,allure-results-prd-ca-synthetic-linux-browser,allure-results-prd-uk-synthetic-linux-browser,allure-results-prd-ap-synthetic-linux-browser,allure-results-prd-us-east1-synthetic-linux-browser,allure-results-prd-eu-west1-synthetic-linux-browser' >> "$GITHUB_OUTPUT"
        else
            # Handle comma-separated region codes (e.g., "US,EU")
            REGIONS_ARRAY=""
            ALLURE_RESULTS=""
            IFS=',' read -ra REGION_CODES <<< "$REGION_INPUT"
            for CODE in "${REGION_CODES[@]}"; do
                CODE=$(echo "$CODE" | xargs)
                # Detect full region names (e.g., prd-us-east1-synthetic) vs short codes (e.g., US)
                if [[ "$CODE" == prd-*-synthetic ]]; then
                    REGION_NAME="$CODE"
                else
                    CODE=$(echo "$CODE" | tr '[:upper:]' '[:lower:]')
                    REGION_NAME="prd-${CODE}-synthetic"
                fi
                if [ -n "$REGIONS_ARRAY" ]; then
                    REGIONS_ARRAY="${REGIONS_ARRAY}, \"${REGION_NAME}\""
                    ALLURE_RESULTS="${ALLURE_RESULTS},allure-results-${REGION_NAME}-linux-browser"
                else
                    REGIONS_ARRAY="\"${REGION_NAME}\""
                    ALLURE_RESULTS="allure-results-${REGION_NAME}-linux-browser"
                fi
            done
            echo -e "region=[${REGIONS_ARRAY}]\nallure-results=${ALLURE_RESULTS}" >> "$GITHUB_OUTPUT"
        fi
    else
        echo -e 'region=["prd-us", "prd-eu", "prd-ca", "prd-ap", "prd-uk", "prd-eu-dialer-integration-1"]\nallure-results=allure-results-prd-us-linux-browser,allure-results-prd-eu-linux-browser,allure-results-prd-ca-linux-browser,allure-results-prd-ap-linux-browser,allure-results-prd-uk-linux-browser,allure-results-prd-eu-dialer-integration-1-linux-browser' >> "$GITHUB_OUTPUT"
    fi
elif [ "$ENVIRONMENT" == "QA" ]; then
    if [[ "$EVENT_NAME" = "schedule" || "$EVENT_NAME" = "workflow_dispatch" ]] && [ "$TEST_GROUP_INPUT" != "synthetic" ]; then
        if [ "$OS_INPUT" = "all" ]; then
            if [ "$PLATFORM_INPUT" = "all" ]; then
                echo -e 'allure-results=allure-results-qa-us-linux-browser,allure-results-qa-us-windows-desktop' >> "$GITHUB_OUTPUT"
            elif [ "$PLATFORM_INPUT" = "desktop" ]; then
                echo -e 'allure-results=allure-results-qa-us-linux-desktop,allure-results-qa-us-windows-desktop' >> "$GITHUB_OUTPUT"
            else
                echo -e 'allure-results=allure-results-qa-us-linux-browser,allure-results-qa-us-windows-browser' >> "$GITHUB_OUTPUT"
            fi
        elif [ "$OS_INPUT" = "linux" ]; then
            if [ "$PLATFORM_INPUT" = "desktop" ]; then
                echo -e 'allure-results=allure-results-qa-us-linux-desktop' >> "$GITHUB_OUTPUT"
            else
                echo -e 'allure-results=allure-results-qa-us-linux-browser' >> "$GITHUB_OUTPUT"
            fi
        else
            if [ "$PLATFORM_INPUT" = "desktop" ]; then
                echo -e 'allure-results=allure-results-qa-us-windows-desktop' >> "$GITHUB_OUTPUT"
            else
                echo -e 'allure-results=allure-results-qa-us-windows-browser' >> "$GITHUB_OUTPUT"
            fi
        fi
    elif [ "$TEST_GROUP_INPUT" = "synthetic" ]; then
        if [ "$REGION_INPUT" = "qa-us-synthetic-debug" ]; then
            echo -e 'allure-results=allure-results-qa-us-synthetic-debug-linux-browser' >> "$GITHUB_OUTPUT"
        else
            echo -e 'allure-results=allure-results-qa-us-synthetic-linux-browser' >> "$GITHUB_OUTPUT"
        fi
    else
        echo -e 'allure-results=allure-results-qa-us-linux-browser' >> "$GITHUB_OUTPUT"
    fi
elif [ "$ENVIRONMENT" == "STG" ]; then
    if [[ "$EVENT_NAME" = "schedule" || "$EVENT_NAME" = "workflow_dispatch" ]] && [ "$TEST_GROUP_INPUT" != "synthetic" ]; then
        if [ "$OS_INPUT" = "all" ]; then
            if [ "$PLATFORM_INPUT" = "all" ]; then
                echo -e 'allure-results=allure-results-stg-us-linux-browser,allure-results-stg-us-windows-desktop' >> "$GITHUB_OUTPUT"
            elif [ "$PLATFORM_INPUT" = "desktop" ]; then
                echo -e 'allure-results=allure-results-stg-us-linux-desktop,allure-results-stg-us-windows-desktop' >> "$GITHUB_OUTPUT"
            else
                echo -e 'allure-results=allure-results-stg-us-linux-browser,allure-results-stg-us-windows-browser' >> "$GITHUB_OUTPUT"
            fi
        elif [ "$OS_INPUT" = "linux" ]; then
            if [ "$PLATFORM_INPUT" = "desktop" ]; then
                echo -e 'allure-results=allure-results-stg-us-linux-desktop' >> "$GITHUB_OUTPUT"
            else
                echo -e 'allure-results=allure-results-stg-us-linux-browser' >> "$GITHUB_OUTPUT"
            fi
        else
            if [ "$PLATFORM_INPUT" = "desktop" ]; then
                echo -e 'allure-results=allure-results-stg-us-windows-desktop' >> "$GITHUB_OUTPUT"
            else
                echo -e 'allure-results=allure-results-stg-us-windows-browser' >> "$GITHUB_OUTPUT"
            fi
        fi
    elif [ "$TEST_GROUP_INPUT" = "synthetic" ]; then
        echo -e 'allure-results=allure-results-stg-us-synthetic-linux-browser' >> "$GITHUB_OUTPUT"
    else
        echo -e 'allure-results=allure-results-stg-us-linux-browser' >> "$GITHUB_OUTPUT"
    fi

else
    echo "Error: Unknown environment '$ENVIRONMENT'. Supported environments are 'PRD', 'QA', and 'STG'." >&2
    exit 1
fi

# Set test group
if [ -z "$TEST_GROUP_INPUT" ] || [ "$TEST_GROUP_INPUT" = "all" ]; then
    echo 'test_group=--grep-invert @lighthouse' >> "$GITHUB_OUTPUT"
elif [ "$TEST_GROUP_INPUT" = "lighthouse" ]; then
    echo 'test_group=--grep @lighthouse' >> "$GITHUB_OUTPUT"
elif [ "$REGION_INPUT" = "prd-fedramp-synthetic" ]; then
    echo "test_group=--grep '^(?=.*@synthetic)(?=.*@fedramp).*$'" >> "$GITHUB_OUTPUT"
else
    echo "test_group=--grep @$TEST_GROUP_INPUT" >> "$GITHUB_OUTPUT"
fi

echo "platform_type=$PLATFORM_INPUT" >> "$GITHUB_OUTPUT"
echo "OS: $OS_INPUT, Region: $REGION_INPUT, Test Group: $TEST_GROUP_INPUT, Platform: $PLATFORM_INPUT"
echo "github_output: $(cat $GITHUB_OUTPUT)"

echo "Script execution completed."

