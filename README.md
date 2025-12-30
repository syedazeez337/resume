# Resume

[![Build Resume](https://github.com/yourusername/resume/actions/workflows/build.yml/badge.svg)](https://github.com/yourusername/resume/actions/workflows/build.yml)
[![Release](https://img.shields.io/github/v/release/yourusername/resume)](https://github.com/yourusername/resume/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Professional LaTeX resume with multiple themes, ATS optimization, and full CI/CD automation.

## Features

- **Multiple Themes**: Classic, Modern, and Minimal styles
- **ATS Optimized**: Version designed for Applicant Tracking Systems
- **Multi-Format Output**: PDF, HTML, Word (DOCX), Markdown
- **Full Automation**: GitHub Actions for building and releasing
- **GitHub Pages**: Live web version with PDF preview
- **Version Control**: Track every change to your resume

## Quick Start

### Prerequisites

- LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- Make (optional, for build automation)
- Pandoc (optional, for HTML/DOCX conversion)

### Building Locally

```bash
# Build default PDF
make pdf

# Build with specific theme
make classic
make modern
make minimal

# Build ATS-optimized version
make ats

# Build all formats
make build-all

# Clean build artifacts
make clean
```

### Manual Build

```bash
cd src
pdflatex resume.tex
pdflatex resume.tex  # Run twice for references
```

## Repository Structure

```
resume/
├── src/
│   ├── resume.tex          # Main resume document
│   ├── resume.cls          # Custom document class
│   └── sections/           # Modular content
│       ├── header.tex
│       ├── summary.tex
│       ├── experience.tex
│       ├── education.tex
│       ├── skills.tex
│       └── projects.tex
├── themes/
│   ├── classic/            # Traditional blue theme
│   ├── modern/             # Contemporary dark theme
│   └── minimal/            # Clean grayscale (ATS-friendly)
├── output/                 # Generated files
├── scripts/                # Build scripts
├── html/                   # Web version styling
└── .github/workflows/      # CI/CD automation
```

## Themes

### Classic
Traditional professional styling with navy blue accents. Best for corporate and traditional industries.

### Modern
Contemporary design with dark accents and sans-serif typography. Ideal for tech companies and startups.

### Minimal
Clean grayscale design optimized for ATS systems. Maximum compatibility with automated resume parsers.

## Customization

### Edit Content

1. Update personal information in `src/sections/header.tex`
2. Add work experience in `src/sections/experience.tex`
3. Update education in `src/sections/education.tex`
4. List skills in `src/sections/skills.tex`
5. Add projects in `src/sections/projects.tex`

### Switch Themes

Edit `src/resume.tex` and uncomment the desired theme:

```latex
% Load theme (options: classic, modern, minimal)
\loadtheme{classic}
% \loadtheme{modern}
% \loadtheme{minimal}
```

### Enable ATS Mode

For maximum ATS compatibility, enable ATS mode in `src/resume.tex`:

```latex
\enableatsmode
\loadtheme{minimal}
```

## CI/CD Automation

### On Push to Main
- Compiles all theme variants
- Commits PDFs back to repository
- Updates GitHub Pages

### On Version Tag (v*)
- Creates GitHub Release
- Uploads PDF and DOCX as release assets
- Generates release notes

### Creating a Release

```bash
git tag v1.0.0
git push origin v1.0.0
```

## Available Commands

| Command | Description |
|---------|-------------|
| `make pdf` | Build default PDF |
| `make classic` | Build with classic theme |
| `make modern` | Build with modern theme |
| `make minimal` | Build with minimal theme |
| `make ats` | Build ATS-optimized PDF |
| `make themes` | Build all themed PDFs |
| `make html` | Build HTML version |
| `make docx` | Build Word document |
| `make build-all` | Build all formats |
| `make clean` | Remove build artifacts |
| `make watch` | Auto-rebuild on changes |

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- LaTeX community for typesetting tools
- GitHub Actions for CI/CD
- [xu-cheng/latex-action](https://github.com/xu-cheng/latex-action) for LaTeX compilation

---

**Note**: Remember to update the GitHub username in badge URLs and customize the content sections before publishing.
