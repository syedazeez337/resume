%% resume.cls - Professional Resume Document Class
%% Author: Azeez
%% Description: Custom LaTeX class for professional resumes with theme support

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2025/01/01 Professional Resume Class]

%% Base class
\LoadClass[11pt,letterpaper]{article}

%% Required packages
\RequirePackage[margin=0.5in]{geometry}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{hyperref}
\RequirePackage{fontawesome5}
\RequirePackage{xcolor}
\RequirePackage{parskip}
\RequirePackage{tabularx}
\RequirePackage{ifthen}
\RequirePackage{etoolbox}

%% Default colors (can be overridden by themes)
\definecolor{primary}{HTML}{2C3E50}
\definecolor{secondary}{HTML}{7F8C8D}
\definecolor{accent}{HTML}{3498DB}
\definecolor{text}{HTML}{333333}
\definecolor{lightgray}{HTML}{F5F5F5}

%% Hyperlink setup
\hypersetup{
    colorlinks=true,
    linkcolor=accent,
    urlcolor=accent,
    pdfborder={0 0 0}
}

%% Remove page numbers
\pagestyle{empty}

%% Section formatting
\titleformat{\section}{
    \Large\bfseries\color{primary}
}{}{0em}{}[\titlerule]
\titlespacing*{\section}{0pt}{12pt}{8pt}

%% Subsection formatting
\titleformat{\subsection}{
    \large\bfseries\color{text}
}{}{0em}{}
\titlespacing*{\subsection}{0pt}{8pt}{4pt}

%% Custom commands for header
\newcommand{\name}[1]{
    {\Huge\bfseries\color{primary}#1}
}

\newcommand{\tagline}[1]{
    {\large\color{secondary}#1}
}

\newcommand{\contact}[1]{
    {\small\color{text}#1}
}

%% Contact item commands
\newcommand{\email}[1]{\href{mailto:#1}{\faEnvelope\ #1}}
\newcommand{\phone}[1]{\faPhone\ #1}
\newcommand{\location}[1]{\faMapMarker*\ #1}
\newcommand{\linkedin}[1]{\href{https://linkedin.com/in/#1}{\faLinkedin\ #1}}
\newcommand{\github}[1]{\href{https://github.com/#1}{\faGithub\ #1}}
\newcommand{\website}[1]{\href{https://#1}{\faGlobe\ #1}}

%% Experience entry command
%% Usage: \experience{Title}{Company}{Location}{Date}{Description}
\newcommand{\experience}[5]{
    \subsection[#1]{#1}
    \textbf{#2} \hfill \textit{#3} \\
    {\small\color{secondary}#4}
    \begin{itemize}[leftmargin=*, nosep, topsep=4pt]
        #5
    \end{itemize}
}

%% Simplified experience entry (for compact layouts)
\newcommand{\experiencecompact}[4]{
    \textbf{#1} -- #2 \hfill \textit{#3} \\
    {\small #4}
    \vspace{4pt}
}

%% Education entry command
%% Usage: \education{Degree}{Institution}{Location}{Date}{Details}
\newcommand{\education}[5]{
    \textbf{#1} \hfill \textit{#4} \\
    #2, #3
    \ifthenelse{\equal{#5}{}}{}{
        \begin{itemize}[leftmargin=*, nosep, topsep=2pt]
            #5
        \end{itemize}
    }
    \vspace{4pt}
}

%% Project entry command
%% Usage: \project{Name}{Technologies}{Description}
\newcommand{\project}[3]{
    \textbf{#1} | {\small\color{secondary}#2} \\
    {\small #3}
    \vspace{4pt}
}

%% Project with link
%% Usage: \projectlink{Name}{URL}{Technologies}{Description}
\newcommand{\projectlink}[4]{
    \textbf{\href{#2}{#1}} | {\small\color{secondary}#3} \\
    {\small #4}
    \vspace{4pt}
}

%% Skills formatting
%% Usage: \skillcategory{Category}{Skills}
\newcommand{\skillcategory}[2]{
    \textbf{#1:} #2 \\[2pt]
}

%% Skill bar (visual representation)
\newcommand{\skillbar}[2]{
    #1 \hfill
    \foreach \x in {1,...,5}{
        \ifnum\x>#2
            \textcolor{lightgray}{\faCircle}
        \else
            \textcolor{accent}{\faCircle}
        \fi
    } \\[2pt]
}

%% Achievement/Award entry
\newcommand{\achievement}[3]{
    \textbf{#1} \hfill \textit{#3} \\
    {\small #2}
    \vspace{4pt}
}

%% Certification entry
\newcommand{\certification}[3]{
    \textbf{#1} -- #2 \hfill \textit{#3}
    \vspace{2pt}
}

%% Publication entry
\newcommand{\publication}[4]{
    #1, ``\textit{#2},'' #3, #4.
    \vspace{2pt}
}

%% Horizontal rule
\newcommand{\divider}{
    \vspace{4pt}
    \hrule
    \vspace{4pt}
}

%% Two-column layout helper
\newenvironment{twocolumn}[1][0.5]
    {\begin{minipage}[t]{#1\textwidth}}
    {\end{minipage}}

%% Theme loading command
\newcommand{\loadtheme}[1]{
    \input{../themes/#1/theme.sty}
}

%% ATS-friendly mode (disables colors and icons)
\newif\ifatsmode
\atsmodefalse

\newcommand{\enableatsmode}{
    \atsmodetrue
    \definecolor{primary}{HTML}{000000}
    \definecolor{secondary}{HTML}{333333}
    \definecolor{accent}{HTML}{000000}
    \definecolor{text}{HTML}{000000}
    \hypersetup{colorlinks=false}
}

%% End of class
\endinput
