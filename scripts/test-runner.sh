#!/bin/bash

set -xu

function exiting {
  docker-compose --project-name "playwright-tests" down --rmi local --volumes
  exit $EXIT
}

echo "Starting “playwright tests"
echo "Building Docker image"
docker-compose --project-name "playwright-tests" build --no-cache playwright-tests
docker-compose --project-name "playwright-tests" run playwright-tests

EXIT=$?
echo "Done!"
exiting
