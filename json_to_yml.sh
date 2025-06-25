#!/bin/bash

# Script to convert JSON file to YAML format for espanso global_vars
# Usage: ./json_to_yml.sh > match/global_vars.yml

JSON_FILE="$HOME/github/espanso/state/global_vars.json"

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