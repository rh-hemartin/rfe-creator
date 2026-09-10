#!/usr/bin/env bash
# post-rfe-creator.sh — Report agent-result.json after the sandbox exits.
set -euo pipefail

RESULT_FILE="${FULLSEND_OUTPUT_DIR}/agent-result.json"

if [[ ! -f "${RESULT_FILE}" ]]; then
  echo "ERROR: agent-result.json not found at ${RESULT_FILE}"
  exit 1
fi

ACTION=$(python3 -c "import json; print(json.load(open('${RESULT_FILE}'))['action'])")
PIPELINE=$(python3 -c "import json; print(json.load(open('${RESULT_FILE}')).get('pipeline', ''))")
SUMMARY=$(python3 -c "import json; print(json.load(open('${RESULT_FILE}')).get('summary', ''))")

echo "Result: action=${ACTION} pipeline=${PIPELINE}"
echo "Summary: ${SUMMARY}"

if [[ "${ACTION}" == "failed" ]]; then
  exit 1
fi
