#!/bin/bash

# Script to create a JSON index of all espanso triggers by file
# Usage: ./generate_trigger_index.sh

MATCH_DIR="$HOME/Desktop/github/espanso/match"
OUTPUT_FILE="$HOME/Desktop/github/espanso/state/trigger_index.json"

# Check if match directory exists
if [[ ! -d "$MATCH_DIR" ]]; then
    echo "Error: Match directory not found at $MATCH_DIR"
    exit 1
fi

# Ensure output directory exists
mkdir -p "$(dirname "$OUTPUT_FILE")"

echo "Generating trigger index from $MATCH_DIR..."
echo "Output: $OUTPUT_FILE"

# Create temporary file for JSON construction
temp_json=$(mktemp)

# Start with empty JSON object
echo '{}' > "$temp_json"

# Process each .yml file in the match directory
for yml_file in "$MATCH_DIR"/*.yml; do
    if [[ -f "$yml_file" ]]; then
        filename=$(basename "$yml_file")
        echo "Processing: $filename"
        
        # Extract triggers using various methods
        triggers=()
        
        # Method 1: Extract simple triggers (- trigger: ";something")
        while IFS= read -r line; do
            if [[ $line =~ ^[[:space:]]*-[[:space:]]+trigger:[[:space:]]*[\"\']([^\"\']+)[\"\'] ]]; then
                trigger="${BASH_REMATCH[1]}"
                triggers+=("$trigger")
            fi
        done < "$yml_file"
        
        # Method 2: Extract triggers array (- triggers: [";good", ";emoji"])
        while IFS= read -r line; do
            if [[ $line =~ ^[[:space:]]*-[[:space:]]+triggers:[[:space:]]*\[(.*)\] ]]; then
                # Parse the array content
                array_content="${BASH_REMATCH[1]}"
                # Remove quotes and split by comma
                IFS=',' read -ra ADDR <<< "$array_content"
                for trigger in "${ADDR[@]}"; do
                    # Clean up whitespace and quotes
                    clean_trigger=$(echo "$trigger" | sed 's/^[[:space:]]*["\'\'']*//;s/["\'\'']*[[:space:]]*$//')
                    if [[ -n "$clean_trigger" ]]; then
                        triggers+=("$clean_trigger")
                    fi
                done
            fi
        done < "$yml_file"
        
        # Method 3: Extract regex triggers (- regex: ";\\((?P<command>.*)\\)")
        while IFS= read -r line; do
            if [[ $line =~ ^[[:space:]]*-[[:space:]]+regex:[[:space:]]*[\"\']([^\"\']+)[\"\'] ]]; then
                regex_trigger="${BASH_REMATCH[1]}"
                triggers+=("$regex_trigger")
            fi
        done < "$yml_file"
        
        # Remove duplicates and sort
        IFS=$'\n' sorted_triggers=($(printf '%s\n' "${triggers[@]}" | sort -u))
        
        # Convert bash array to JSON array
        triggers_json="[]"
        for trigger in "${sorted_triggers[@]}"; do
            triggers_json=$(echo "$triggers_json" | jq --arg t "$trigger" '. += [$t]')
        done
        
        # Add file data to main JSON object
        temp_json_new=$(jq --arg filename "$filename" \
                          --argjson triggers "$triggers_json" \
                          --argjson count "${#sorted_triggers[@]}" \
                          '.[$filename] = {"triggers": $triggers, "count": $count}' \
                          "$temp_json")
        echo "$temp_json_new" > "$temp_json"
    fi
done

# Move the final formatted JSON to output location
mv "$temp_json" "$OUTPUT_FILE"

# Generate summary
total_files=$(jq 'keys | length' "$OUTPUT_FILE")
total_triggers=$(jq '[.[] | .count] | add' "$OUTPUT_FILE")

echo ""
echo "✅ Trigger index generated successfully!"
echo "📁 Files processed: $total_files"
echo "🎯 Total triggers: $total_triggers"
echo "💾 Saved to: $OUTPUT_FILE"

echo ""
echo "Most active files:"
jq -r 'to_entries | sort_by(.value.count) | reverse | .[0:5] | .[] | "  \(.key): \(.value.count) triggers"' "$OUTPUT_FILE"

echo ""
echo "📖 JSON is pre-formatted and ready to use!"