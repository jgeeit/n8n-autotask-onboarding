#!/bin/bash

# n8n Workflow Import Script
# This script imports all workflow JSON files into n8n via the API

set -e

# Configuration
N8N_HOST="${N8N_HOST:-localhost}"
N8N_PORT="${N8N_PORT:-5678}"
N8N_PROTOCOL="${N8N_PROTOCOL:-http}"
N8N_BASE_URL="${N8N_PROTOCOL}://${N8N_HOST}:${N8N_PORT}"
WORKFLOWS_DIR="./workflows"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "======================================"
echo "n8n Workflow Import Script"
echo "======================================"
echo ""
echo "Target n8n instance: ${N8N_BASE_URL}"
echo ""

# Check if n8n is accessible
echo "Checking n8n connectivity..."
if ! curl -s -f "${N8N_BASE_URL}/healthz" > /dev/null 2>&1; then
    echo -e "${RED}Error: Cannot connect to n8n at ${N8N_BASE_URL}${NC}"
    echo "Please ensure:"
    echo "  1. n8n is running"
    echo "  2. The URL is correct"
    echo "  3. n8n is accessible from this machine"
    exit 1
fi
echo -e "${GREEN}✓ n8n is accessible${NC}"
echo ""

# Check for authentication
if [ -n "${N8N_BASIC_AUTH_USER}" ] && [ -n "${N8N_BASIC_AUTH_PASSWORD}" ]; then
    AUTH_HEADER="-u ${N8N_BASIC_AUTH_USER}:${N8N_BASIC_AUTH_PASSWORD}"
    echo "Using basic authentication"
else
    AUTH_HEADER=""
    echo "No authentication configured"
fi
echo ""

# Function to import a workflow
import_workflow() {
    local workflow_file="$1"
    local workflow_name=$(basename "$workflow_file" .json)
    
    echo "Importing: ${workflow_name}..."
    
    # Check if file exists and is valid JSON
    if [ ! -f "$workflow_file" ]; then
        echo -e "${RED}  ✗ File not found${NC}"
        return 1
    fi
    
    if ! jq empty "$workflow_file" 2>/dev/null; then
        echo -e "${RED}  ✗ Invalid JSON${NC}"
        return 1
    fi
    
    # Import the workflow
    response=$(curl -s -w "\n%{http_code}" ${AUTH_HEADER} \
        -X POST \
        -H "Content-Type: application/json" \
        -d @"$workflow_file" \
        "${N8N_BASE_URL}/api/v1/workflows" 2>&1)
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | head -n-1)
    
    if [ "$http_code" -eq 200 ] || [ "$http_code" -eq 201 ]; then
        workflow_id=$(echo "$body" | jq -r '.id')
        echo -e "${GREEN}  ✓ Successfully imported (ID: ${workflow_id})${NC}"
        return 0
    else
        echo -e "${RED}  ✗ Failed (HTTP ${http_code})${NC}"
        echo "$body" | jq -r '.message // .error // .' 2>/dev/null || echo "$body"
        return 1
    fi
}

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}Warning: jq is not installed. JSON validation will be skipped.${NC}"
    echo "Install jq for better error handling: sudo apt-get install jq"
    echo ""
fi

# Import workflows
echo "Starting workflow import..."
echo ""

imported=0
failed=0

# Import onboarding workflows
if [ -d "${WORKFLOWS_DIR}/onboarding" ]; then
    echo "=== Onboarding Workflows ==="
    for workflow in "${WORKFLOWS_DIR}/onboarding"/*.json; do
        if [ -f "$workflow" ]; then
            if import_workflow "$workflow"; then
                ((imported++))
            else
                ((failed++))
            fi
        fi
    done
    echo ""
fi

# Import offboarding workflows
if [ -d "${WORKFLOWS_DIR}/offboarding" ]; then
    echo "=== Offboarding Workflows ==="
    for workflow in "${WORKFLOWS_DIR}/offboarding"/*.json; do
        if [ -f "$workflow" ]; then
            if import_workflow "$workflow"; then
                ((imported++))
            else
                ((failed++))
            fi
        fi
    done
    echo ""
fi

# Summary
echo "======================================"
echo "Import Summary"
echo "======================================"
echo -e "${GREEN}Successfully imported: ${imported}${NC}"
if [ $failed -gt 0 ]; then
    echo -e "${RED}Failed: ${failed}${NC}"
fi
echo ""

if [ $failed -gt 0 ]; then
    echo -e "${YELLOW}Some workflows failed to import. Please review the errors above.${NC}"
    exit 1
else
    echo -e "${GREEN}All workflows imported successfully!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Open n8n at ${N8N_BASE_URL}"
    echo "  2. Configure credentials for Autotask and other integrations"
    echo "  3. Activate the workflows"
    echo "  4. Test with sample data"
fi
