# Resume

LaTeX resume with themes and cover letter generator.

## Build

```bash
make pdf              # Default PDF
make themes           # All themes (classic, modern, minimal)
make ats              # ATS-optimized version
```

## Cover Letter

```bash
make coverletter COMPANY="Company" POSITION="Role"
```

Or use the script directly:

```bash
python3 scripts/generate_coverletter.py --company "Company" --position "Role" --hiring-manager "Name"
```

## Structure

```
src/
├── resume.tex        # Main document
├── resume.cls        # Document class
├── coverletter.tex   # Cover letter template
└── sections/         # Content sections
themes/               # classic, modern, minimal
output/               # Generated PDFs
scripts/              # Build scripts
```

## Requirements

- TeX Live / MacTeX / MiKTeX
- Python 3 (for cover letter generator)
