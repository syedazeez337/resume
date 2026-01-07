#!/bin/bash
set -e

# Directory setup
mkdir -p output

# Themes to build
THEMES=("minimal" "classic" "modern")

echo "Starting Multi-Theme Build..."

for theme in "${THEMES[@]}"; do
    echo "----------------------------------------"
    echo "Building Theme: $theme"
    echo "----------------------------------------"
    
    # Compile using pdflatex, injecting the \theme definition
    # We run it twice to ensure references/labels are correct
    # We run from src/ directory so that resume.cls and sections/ are found
    (cd src && pdflatex -interaction=nonstopmode -output-directory=../output -jobname="Azeez_resume_${theme}" "\def\theme{$theme} \input{resume.tex}" > /dev/null)
    (cd src && pdflatex -interaction=nonstopmode -output-directory=../output -jobname="Azeez_resume_${theme}" "\def\theme{$theme} \input{resume.tex}" > /dev/null)
    
    echo "✔ Created output/Azeez_resume_${theme}.pdf"
done

# Cleanup aux files
rm output/*.aux output/*.log output/*.out 2>/dev/null || true

echo "----------------------------------------"
echo "Build Complete! Check 'output/' folder."
echo "----------------------------------------"
