#!/bin/bash
# build.sh - Build resume PDF with optional theme
# Usage: ./build.sh [theme]
# Themes: classic, modern, minimal (default: none)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
SRC_DIR="$PROJECT_ROOT/src"
OUTPUT_DIR="$PROJECT_ROOT/output"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Get theme argument
THEME="${1:-}"

# Navigate to source directory
cd "$SRC_DIR"

# If theme is specified, create a temporary file with theme loaded
if [ -n "$THEME" ]; then
    echo "Building with theme: $THEME"

    # Create a copy of resume.tex with theme enabled
    sed "s|% \\\\loadtheme{$THEME}|\\\\loadtheme{$THEME}|" resume.tex > resume_themed.tex

    # Compile the themed version
    pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" resume_themed.tex
    pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" resume_themed.tex

    # Rename output
    mv "$OUTPUT_DIR/resume_themed.pdf" "$OUTPUT_DIR/resume-$THEME.pdf"

    # Cleanup temporary file
    rm resume_themed.tex

    echo "Output: $OUTPUT_DIR/resume-$THEME.pdf"
else
    echo "Building with default styling"

    # Compile resume
    pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" resume.tex
    pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" resume.tex

    echo "Output: $OUTPUT_DIR/resume.pdf"
fi

# Cleanup auxiliary files
rm -f "$OUTPUT_DIR"/*.aux "$OUTPUT_DIR"/*.log "$OUTPUT_DIR"/*.out

echo "Build complete!"
