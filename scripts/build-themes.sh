#!/bin/bash
set -e

# Detect where we are and where the files are
if [ -f "resume.cls" ]; then
    # We are already in src/ (likely via GitHub Action)
    SRC_DIR="."
    OUTPUT_DIR="../output"
elif [ -f "src/resume.cls" ]; then
    # We are in the root
    SRC_DIR="src"
    OUTPUT_DIR="output"
else
    echo "Error: Could not find resume.cls"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

# Themes to build
THEMES=("minimal" "classic" "modern")

echo "Starting Multi-Theme Build..."
echo "Source Dir: $SRC_DIR"
echo "Output Dir: $OUTPUT_DIR"

for theme in "${THEMES[@]}"; do
    echo "----------------------------------------"
    echo "Building Theme: $theme"
    echo "----------------------------------------"
    
    # Compile using pdflatex, injecting the \theme definition
    # We run from the directory where resume.cls is
    (cd "$SRC_DIR" && pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" -jobname="Azeez_resume_${theme}" "\def\theme{$theme} \input{resume.tex}" > /dev/null)
    (cd "$SRC_DIR" && pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" -jobname="Azeez_resume_${theme}" "\def\theme{$theme} \input{resume.tex}" > /dev/null)
    
    echo "✔ Created $OUTPUT_DIR/Azeez_resume_${theme}.pdf"
done

# Cleanup aux files
rm "$OUTPUT_DIR"/*.aux "$OUTPUT_DIR"/*.log "$OUTPUT_DIR"/*.out 2>/dev/null || true

echo "----------------------------------------"
echo "Build Complete!"
echo "----------------------------------------"