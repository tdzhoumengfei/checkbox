#!/usr/bin/env bash

set -u

env | awk -F "=" '{print $1}' | while read -r CI_ENV_VAR ; do
  CI_ENV_VAR_NAME=${CI_ENV_VAR^^}
  echo "Using var ${CI_ENV_VAR_NAME}"
  echo "${CI_ENV_VAR_NAME}=${!CI_ENV_VAR}" >> .env
done