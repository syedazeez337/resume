%% coverletter.cls - Professional Cover Letter Document Class
%% Author: Azeez
%% Description: LaTeX class for automated cover letter generation

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{coverletter}[2026/01/03 Cover Letter Class]

\LoadClass[11pt,letterpaper]{article}

\RequirePackage[margin=1in]{geometry}
\RequirePackage{titlesec}
\RequirePackage{fontawesome5}
\RequirePackage{xcolor}
\RequirePackage{parskip}
\RequirePackage{hyperref}
\RequirePackage{ifthen}
\RequirePackage{tabularx}
\RequirePackage[utf8]{inputenc}

\definecolor{primary}{HTML}{2C3E50}
\definecolor{secondary}{HTML}{7F8C8D}
\definecolor{accent}{HTML}{3498DB}
\definecolor{text}{HTML}{333333}

\geometry{letterpaper, margin=1in}
\pagestyle{empty}
\urlstyle{same}

\titleformat{\section}{\Large\bfseries\color{primary}}{}{0em}{}[\titlerule]
\titlespacing*{\section}{0pt}{20pt}{12pt}

\newcommand{\candidateName}[1]{{\LARGE\bfseries\color{primary}#1}}
\newcommand{\candidateTitle}[1]{{\large\color{secondary}#1}}
\newcommand{\coverletterdate}[1][\today]{{\color{secondary}#1}}

\newcommand{\companyInfo}[4]{%
    \begin{flushright}%
        \begin{tabular}{l r}%
            \textbf{To:} & #1 \\%
            \textbf{Company:} & #2 \\%
            \textbf{Position:} & #3 \\%
            \textbf{Location:} & #4%
        \end{tabular}%
    \end{flushright}%
    \vspace{20pt}%
}

\newcommand{\openingParagraph}[1]{%
    \begin{smaller}%
    \textit{#1}%
    \end{smaller}%
    \vspace{12pt}%
}

\newenvironment{bodyParagraph}%
    {\par\addvspace{12pt}\begin{adjustwidth}{0.3in}{0in}}%
    {\end{adjustwidth}\par\addvspace{12pt}}

\newcommand{\achievementHighlight}[2]{%
    \begin{adjustwidth}{0.3in}{0in}%
    \textbf{#1}: #2%
    \end{adjustwidth}%
    \vspace{6pt}%
}

\newcommand{\callToAction}[2]{%
    \begin{center}%
    \textit{#1} \\%
    \textbf{#2}%
    \end{center}%
    \vspace{16pt}%
}

\newif\ifsinglepage
\singlepagefalse

\newcommand{\enableatsmode}{
    \singlepagetrue
    \definecolor{primary}{HTML}{000000}
    \definecolor{secondary}{HTML}{333333}
    \definecolor{accent}{HTML}{000000}
    \definecolor{text}{HTML}{000000}
}

\endinput
