#!/bin/bash
# build-all.sh - Build all resume formats and themes
# Generates: PDF (all themes), HTML, DOCX, Markdown

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
SRC_DIR="$PROJECT_ROOT/src"
OUTPUT_DIR="$PROJECT_ROOT/output"
HTML_DIR="$PROJECT_ROOT/html"

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "=========================================="
echo "Building Resume - All Formats"
echo "=========================================="

# Navigate to source directory
cd "$SRC_DIR"

# Build default PDF
echo ""
echo "[1/7] Building default PDF..."
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" resume.tex > /dev/null
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" resume.tex > /dev/null
echo "      Created: output/resume.pdf"

# Build themed PDFs
for THEME in classic modern minimal; do
    echo ""
    echo "[Building $THEME theme PDF...]"

    # Create themed version
    sed "s|% \\\\loadtheme{$THEME}|\\\\loadtheme{$THEME}|" resume.tex > resume_temp.tex

    pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" resume_temp.tex > /dev/null
    pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" resume_temp.tex > /dev/null

    mv "$OUTPUT_DIR/resume_temp.pdf" "$OUTPUT_DIR/resume-$THEME.pdf"
    rm resume_temp.tex

    echo "      Created: output/resume-$THEME.pdf"
done

# Build ATS-optimized PDF
echo ""
echo "[5/7] Building ATS-optimized PDF..."
sed 's|% \\enableatsmode|\\enableatsmode|' resume.tex > resume_ats.tex
sed -i 's|% \\loadtheme{minimal}|\\loadtheme{minimal}|' resume_ats.tex

pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" resume_ats.tex > /dev/null
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" resume_ats.tex > /dev/null

mv "$OUTPUT_DIR/resume_ats.pdf" "$OUTPUT_DIR/resume-ats.pdf"
rm resume_ats.tex
echo "      Created: output/resume-ats.pdf"

# Check if pandoc is available for additional formats
if command -v pandoc &> /dev/null; then
    echo ""
    echo "[6/7] Building HTML version..."

    # Convert to HTML using pandoc (from LaTeX)
    pandoc resume.tex \
        -s \
        --metadata title="Resume" \
        -c "../html/style.css" \
        -o "$OUTPUT_DIR/resume.html" 2>/dev/null || echo "      HTML conversion requires pandoc LaTeX support"

    if [ -f "$OUTPUT_DIR/resume.html" ]; then
        echo "      Created: output/resume.html"
    fi

    echo ""
    echo "[7/7] Building DOCX version..."

    # Convert to DOCX
    pandoc resume.tex \
        -o "$OUTPUT_DIR/resume.docx" 2>/dev/null || echo "      DOCX conversion requires pandoc LaTeX support"

    if [ -f "$OUTPUT_DIR/resume.docx" ]; then
        echo "      Created: output/resume.docx"
    fi
else
    echo ""
    echo "[SKIP] Pandoc not found - skipping HTML and DOCX generation"
    echo "       Install pandoc for multi-format support: https://pandoc.org/"
fi

# Cleanup auxiliary files
rm -f "$OUTPUT_DIR"/*.aux "$OUTPUT_DIR"/*.log "$OUTPUT_DIR"/*.out "$OUTPUT_DIR"/*.fls "$OUTPUT_DIR"/*.fdb_latexmk

echo ""
echo "=========================================="
echo "Build Complete!"
echo "=========================================="
echo ""
echo "Generated files in output/:"
ls -la "$OUTPUT_DIR"
