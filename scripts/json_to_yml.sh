#!/usr/bin/env bash
set -euo pipefail

# export ESPANSO="path/to/espanso"

exec > $ESPANSO/match/global_vars_examples.yml

# Converts a JSON file into an Espanso YAML configuration with global variables and triggers.
# Usage: ./json_to_yml.sh
JSON_FILE="$ESPANSO/config/global_vars_examples.json"

# Check if JSON file exists
if [[ ! -f "$JSON_FILE" ]]; then
    echo "Error: JSON file not found at $JSON_FILE"
    exit 1
fi

echo "# ========================================"
echo "# Auto-generated from global_vars.json"
echo "# Generated on: $(LC_TIME=C date)"
echo "# ========================================"
echo ""

# Generate global_vars section
echo "global_vars:"

# Generate global_vars section - process each category separately
jq -r 'to_entries[] | .key' "$JSON_FILE" | while read -r category; do
    echo "  # --- $(echo "$category" | tr '[:lower:]' '[:upper:]') ---"
    
    jq -r --arg cat "$category" '
    .[$cat] | to_entries[] |
    "  - name: \"" + .key + "\"" + "\n" +
    "    type: echo" + "\n" +
    "    params:" + "\n" +
    "      echo: \"" + (.value | tostring) + "\""
    ' "$JSON_FILE"
    
    echo ""
done

echo ""
echo "matches:"

# Generate matches section - process each category separately
jq -r 'to_entries[] | .key' "$JSON_FILE" | while read -r category; do
    echo "# --- $(echo "$category" | tr '[:lower:]' '[:upper:]') ---"
    
    jq -r --arg cat "$category" '
    .[$cat] | to_entries[] |
    "  - trigger: \";" + .key + "\"" + "\n" +
    "    replace: \"{{" + .key + "}}\""
    ' "$JSON_FILE"
    
    echo ""
done