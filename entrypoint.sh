#!/bin/bash

set -e

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN env variable."
  exit 1
fi

if [[ -z "$GITHUB_REPOSITORY" ]]; then
  echo "Set the GITHUB_REPOSITORY env variable."
  exit 1
fi

if [[ -z "$GITHUB_EVENT_PATH" ]]; then
  echo "Set the GITHUB_EVENT_PATH env variable."
  exit 1
fi

if [[ -z "$WIP_LABELS" ]]; then
  echo "Set the WIP_LABELS env variable."
  exit 1
fi

echo "checking if it's a PR"
echo $GITHUB_EVENT_PATH
(jq -r ".pull_request.url" "$GITHUB_EVENT_PATH") || exit 78

URI="https://api.github.com"
API_HEADER="Accept: application/vnd.github.v3+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

number=$(jq -r ".pull_request.number" "$GITHUB_EVENT_PATH")

check_contains_wip_label() {
  RESPONSE=$(
    curl -s \
      -X POST
    -H "${AUTH_HEADER}" \
      -H "${API_HEADER}" \
      "${URI}/repos/${GITHUB_REPOSITORY}/pulls/${number}"
  )

  labels=$(jq ".labels" <<<"$RESPONSE")

  if echo "${labels}" | grep -iE "$WIP_LABELS"; then
    return 1
  else
    return 0
  fi
}

check_contains_wip_label
