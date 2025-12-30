#!/bin/bash
# clean.sh - Clean build artifacts
# Removes all generated files from output directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="$PROJECT_ROOT/output"
SRC_DIR="$PROJECT_ROOT/src"

echo "Cleaning build artifacts..."

# Remove output directory contents
if [ -d "$OUTPUT_DIR" ]; then
    rm -rf "$OUTPUT_DIR"/*
    echo "Cleaned: output/"
fi

# Remove any stray auxiliary files in src
rm -f "$SRC_DIR"/*.aux
rm -f "$SRC_DIR"/*.log
rm -f "$SRC_DIR"/*.out
rm -f "$SRC_DIR"/*.fls
rm -f "$SRC_DIR"/*.fdb_latexmk
rm -f "$SRC_DIR"/*.synctex.gz

echo "Clean complete!"
