# Makefile for Resume Repository
# Usage: make [target]

.PHONY: all pdf html docx clean help themes ats coverletter coverletter-company

# Default target
all: pdf

# Build default PDF
pdf:
	@echo "Building PDF..."
	@cd src && pdflatex -interaction=nonstopmode -output-directory=../output resume.tex > /dev/null
	@cd src && pdflatex -interaction=nonstopmode -output-directory=../output resume.tex > /dev/null
	@rm -f output/*.aux output/*.log output/*.out
	@echo "Created: output/resume.pdf"

# Build with specific theme
classic:
	@./scripts/build.sh classic

modern:
	@./scripts/build.sh modern

minimal:
	@./scripts/build.sh minimal

# Build all themed versions
themes:
	@echo "Building all themes..."
	@./scripts/build.sh classic
	@./scripts/build.sh modern
	@./scripts/build.sh minimal
	@echo "All themes built!"

# Build ATS-optimized version
ats:
	@echo "Building ATS-optimized PDF..."
	@cd src && pdflatex -interaction=nonstopmode -output-directory=../output "\def\theme{minimal} \input{resume.tex}" > /dev/null
	@cd src && pdflatex -interaction=nonstopmode -output-directory=../output "\def\theme{minimal} \input{resume.tex}" > /dev/null
	@cp output/resume.pdf output/resume-ats.pdf
	@rm -f output/*.aux output/*.log output/*.out
	@echo "Created: output/resume-ats.pdf"

# Build HTML version (requires pandoc)
html:
	@echo "Building HTML..."
	@mkdir -p output
	@pandoc src/resume.tex -s --metadata title="Resume" -c "../html/style.css" -o output/resume.html 2>/dev/null || \
		echo "Error: pandoc required for HTML. Install from https://pandoc.org/"
	@[ -f output/resume.html ] && echo "Created: output/resume.html" || true

# Build DOCX version (requires pandoc)
docx:
	@echo "Building DOCX..."
	@mkdir -p output
	@pandoc src/resume.tex -o output/resume.docx 2>/dev/null || \
		echo "Error: pandoc required for DOCX. Install from https://pandoc.org/"
	@[ -f output/resume.docx ] && echo "Created: output/resume.docx" || true

# Build Markdown version (requires pandoc)
md:
	@echo "Building Markdown..."
	@mkdir -p output
	@pandoc src/resume.tex -o output/resume.md 2>/dev/null || \
		echo "Error: pandoc required for Markdown. Install from https://pandoc.org/"
	@[ -f output/resume.md ] && echo "Created: output/resume.md" || true

# Build all formats
build-all:
	@./scripts/build-all.sh

# Clean build artifacts
clean:
	@./scripts/clean.sh

# Watch for changes and rebuild (requires entr)
watch:
	@echo "Watching for changes... (Ctrl+C to stop)"
	@find src -name "*.tex" | entr -c make pdf

# Generate cover letter
coverletter:
	@echo "Generating cover letter..."
	@python3 scripts/generate_coverletter.py --company "$(COMPANY)" --position "$(POSITION)" --hiring-manager "$(MANAGER)" --location "$(LOCATION)" 2>/dev/null || \
		echo "Error: Run from project root directory"

# Help
help:
	@echo "Resume Makefile Commands:"
	@echo ""
	@echo "  make               Build default PDF"
	@echo "  make pdf           Build default PDF"
	@echo "  make classic       Build with classic theme"
	@echo "  make modern        Build with modern theme"
	@echo "  make minimal       Build with minimal theme"
	@echo "  make themes        Build all themed PDFs"
	@echo "  make ats           Build ATS-optimized PDF"
	@echo "  make html          Build HTML version (requires pandoc)"
	@echo "  make docx          Build Word document (requires pandoc)"
	@echo "  make md            Build Markdown version (requires pandoc)"
	@echo "  make build-all     Build all formats and themes"
	@echo "  make clean         Remove build artifacts"
	@echo "  make watch         Auto-rebuild on file changes (requires entr)"
	@echo ""
	@echo "Cover Letter Commands:"
	@echo "  make coverletter COMPANY=<name> POSITION=<title> [MANAGER=<name>]"
	@echo "      Generate cover letter for a specific company"
	@echo ""
	@echo "Examples:"
	@echo "  make coverletter COMPANY=Google POSITION=\"Senior SWE\""
	@echo "  make coverletter COMPANY=Stripe POSITION=Engineer MANAGER=\"Jane Doe\""
	@echo ""
	@echo "Output files are placed in the output/ directory"
