#!/usr/bin/env python3
"""
Cover Letter Generator - Automated personalized cover letter generation

Usage:
    python generate_coverletter.py --company "Google" --position "Senior SWE"
    python generate_coverletter.py --company "Stripe" --position "Engineer" --hiring-manager "John Smith"
    python generate_coverletter.py --list-templates
"""

import argparse
import re
import sys
import os
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional

class CoverLetterGenerator:
    """Generate personalized cover letters from templates."""

    # Mapping of placeholder text to job_data keys
    PLACEHOLDERS = {
        'Hiring Manager': 'hiring_manager',
        'Company Name': 'company',
        'Position Title': 'position',
        'Location': 'location',
        'January 1, 2026': 'date',
        'building reliable, scalable systems': 'focus',
    }

    def __init__(self, candidate_data: Dict, template_dir: str = "src"):
        self.candidate_data = candidate_data
        self.template_dir = Path(template_dir)

    def _substitute_variables(self, content: str, job_data: Dict) -> str:
        """Substitute all template placeholders in content."""
        for placeholder, key in self.PLACEHOLDERS.items():
            if key in job_data:
                content = content.replace(placeholder, job_data[key])
        return content
    
    def _select_achievements(self, job_data: Dict) -> List[str]:
        """Select relevant achievements based on job requirements."""
        required_skills = job_data.get('required_skills', []).lower()
        achievements = []
        
        for i, ach in enumerate(self.candidate_data.get('achievements', []), 1):
            if any(skill in ach.lower() for skill in required_skills.split()):
                achievements.append(ach)
            elif len(achievements) < 2 and i <= 3:
                achievements.append(ach)
        
        return achievements[:3]
    
    def generate(self, job_data: Dict, output_path: str):
        """Generate cover letter and compile to PDF."""
        template_path = self.template_dir / "coverletter.tex"
        
        with open(template_path) as f:
            content = f.read()
        
        job_data['date'] = datetime.now().strftime("%B %d, %Y")

        achievements = self._select_achievements(job_data)
        for i, ach in enumerate(achievements, 1):
            job_data[f'ACHIEVEMENT_{i}'] = ach
        
        content = self._substitute_variables(content, job_data)
        
        output_file = Path(output_path).resolve()
        output_file.parent.mkdir(parents=True, exist_ok=True)

        tex_path = output_file.with_suffix('.tex')
        with open(tex_path, 'w') as f:
            f.write(content)

        original_dir = os.getcwd()
        os.chdir(str(output_file.parent))
        os.system(f'pdflatex -interaction=nonstopmode -jobname={output_file.stem} {tex_path.name} >/dev/null 2>&1')
        os.chdir(original_dir)

        # Cleanup all auxiliary files in output directory
        for ext in ['*.aux', '*.log', '*.out']:
            for aux_file in output_file.parent.glob(ext):
                aux_file.unlink()

        if output_file.exists():
            print(f"Generated: {output_file}")
            if tex_path.exists():
                tex_path.unlink()
        else:
            print("Error: PDF generation failed")


def load_candidate_data() -> Dict:
    """Load candidate data from configuration."""
    return {
        'CANDIDATE_NAME': 'Azeez Alishah Hussain Syed',
        'CANDIDATE_TITLE': 'Systems-focused Software Engineer',
        'CANDIDATE_EMAIL': 'azeezalishah@gmail.com',
        'CANDIDATE_PHONE': '+91 9491614908',
        'CANDIDATE_LOCATION': 'Hyderabad, India',
        'CANDIDATE_LINKEDIN': 'azeez-alishah',
        'CANDIDATE_GITHUB': 'syedazeez337',
        'CANDIDATE_SKILLS': 'Go, Rust, Kubernetes, eBPF, Cilium, CoreDNS, Cloud Native',
        'achievements': [
            'Fixed Gateway API reconciler crash when TLSRoute CRD is absent (PR #38874)',
            'Resolved routing misconfiguration by implementing proper Group and Kind validation (PR #39275)',
            'Fixed SRV record case handling to comply with RFC 6763 for proper DNS service discovery (PR #7402)',
            'Corrected TXT record comparison logic per RFC 1035, merged into v1.12.3 (PR #7413)',
            'Eliminated flaky multisocket tests via fresh port allocation and channel-based cleanup (PR #7438)',
        ]
    }


def main():
    parser = argparse.ArgumentParser(
        description='Generate personalized cover letters for job applications'
    )
    parser.add_argument('--company', required=True, help='Company name')
    parser.add_argument('--position', required=True, help='Position title')
    parser.add_argument('--hiring-manager', default='Hiring Manager', help='Hiring manager name')
    parser.add_argument('--location', default='Remote', help='Job location')
    parser.add_argument('--focus', default='building reliable, scalable systems', help='Company focus area')
    parser.add_argument('--skills', default='', help='Required skills (comma-separated)')
    parser.add_argument('--output', help='Output file path')
    parser.add_argument('--template', default='coverletter', help='Template name')
    
    args = parser.parse_args()
    
    candidate = load_candidate_data()
    
    job_data = {
        'company': args.company,
        'position': args.position,
        'hiring_manager': args.hiring_manager,
        'location': args.location,
        'focus': args.focus,
        'required_skills': args.skills,
        **candidate
    }
    
    if not args.output:
        sanitized = re.sub(r'[^\w]', '_', args.company)
        args.output = f'output/coverletter_{sanitized}.pdf'
    
    generator = CoverLetterGenerator(candidate)
    generator.generate(job_data, args.output)


if __name__ == '__main__':
    main()
