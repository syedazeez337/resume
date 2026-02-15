%% resume.cls - Professional Resume Document Class
%% Author: Azeez
%% Description: Custom LaTeX class for professional resumes with theme support

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2025/01/01 Professional Resume Class]

\LoadClass[10pt,letterpaper]{article}

\RequirePackage[margin=0.45in, top=0.4in, bottom=0.4in]{geometry}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{hyperref}
\RequirePackage{fontawesome5}
\RequirePackage{xcolor}
\RequirePackage{parskip}
\RequirePackage{tabularx}
\RequirePackage{ifthen}
\RequirePackage{etoolbox}

\definecolor{primary}{HTML}{2C3E50}
\definecolor{secondary}{HTML}{7F8C8D}
\definecolor{accent}{HTML}{3498DB}
\definecolor{text}{HTML}{333333}
\definecolor{lightgray}{HTML}{F5F5F5}

\hypersetup{
    colorlinks=true,
    linkcolor=accent,
    urlcolor=accent,
    pdfborder={0 0 0},
    pdfauthor={Azeez Alishah Hussain Syed},
    pdftitle={Open Source Software Engineer Resume - Azeez Alishah Hussain Syed},
    pdfsubject={Systems-focused Software Engineer with expertise in cloud-native, eBPF, Kubernetes, Cilium, CoreDNS, and open source contributions},
    pdfkeywords={Software Engineer, Go, Rust, Kubernetes, eBPF, Cilium, CoreDNS, Open Source, CNCF, Systems Programming, Cloud Native}
}

\pagestyle{empty}

\titleformat{\section}{
    \Large\bfseries\color{primary}
}{}{0em}{}[\titlerule]
\titlespacing*{\section}{0pt}{8pt}{4pt}

\titleformat{\subsection}{
    \large\bfseries\color{text}
}{}{0em}{}
\titlespacing*{\subsection}{0pt}{6pt}{3pt}

\newcommand{\name}[1]{
    {\Huge\bfseries\color{primary}#1}
}

\newcommand{\tagline}[1]{
    {\large\color{secondary}#1}
}

\newcommand{\contact}[1]{
    {\small\color{text}#1}
}

\newcommand{\email}[1]{\href{mailto:#1}{\faEnvelope\ #1}}
\newcommand{\phone}[1]{\faPhone\ #1}
\newcommand{\location}[1]{\faMapMarker*\ #1}
\newcommand{\linkedin}[1]{\href{https://linkedin.com/in/#1}{\faLinkedin\ #1}}
\newcommand{\github}[1]{\href{https://github.com/#1}{\faGithub\ #1}}
\newcommand{\website}[1]{\href{https://#1}{\faGlobe\ #1}}

\newcommand{\experience}[5]{
    \subsection[#1]{#1}
    \textbf{#2} \hfill \textit{#3} \\
    {\small\color{secondary}#4}
    \begin{itemize}[leftmargin=*, nosep, topsep=4pt]
        #5
    \end{itemize}
}

\newcommand{\experiencecompact}[4]{
    \textbf{#1} -- #2 \hfill \textit{#3} \\
    {\small #4}
    \vspace{4pt}
}

\newcommand{\education}[5]{
    \textbf{#1} \hfill \textit{#4} \\
    #2, #3
    \ifstrempty{#5}{}{
        \begin{itemize}[leftmargin=*, nosep, topsep=2pt]
            #5
        \end{itemize}
    }
    \vspace{4pt}
}

\newcommand{\project}[3]{
    \textbf{#1} | {\small\color{secondary}#2} \\
    {\small #3}
    \vspace{2pt}
}

\newcommand{\projectlink}[4]{
    \textbf{\href{#2}{#1}} | {\small\color{secondary}#3} \\
    {\small #4}
    \vspace{2pt}
}

\newcommand{\skillcategory}[2]{
    \textbf{#1:} #2 \\[2pt]
}

%% OSS project block with context line and bullet list
\newcommand{\ossproject}[4]{%
    \textbf{#1} \hfill \textit{#3} \\
    {\small\color{secondary}#2}
    \begin{itemize}[leftmargin=*, nosep, topsep=1pt]
        #4
    \end{itemize}
    \vspace{2pt}
}

%% Single-line OSS project (for 1-PR contributions)
\newcommand{\ossprojectsingle}[4]{%
    \textbf{#1} \hfill \textit{#3} \\
    {\small\color{secondary}#2} \\[1pt]
    {\small #4}
    \vspace{2pt}
}

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

\newcommand{\achievement}[3]{
    \textbf{#1} \hfill \textit{#3} \\
    {\small #2}
    \vspace{4pt}
}

\newcommand{\certification}[3]{
    \textbf{#1} -- #2 \hfill \textit{#3}
    \vspace{2pt}
}

\newcommand{\publication}[4]{
    #1, ``\textit{#2},'' #3, #4.
    \vspace{2pt}
}

\newcommand{\divider}{
    \vspace{4pt}
    \hrule
    \vspace{4pt}
}

\newenvironment{sidebyside}[1][0.5]
    {\begin{minipage}[t]{#1\textwidth}}
    {\end{minipage}}

\newcommand{\loadtheme}[1]{
    \input{../themes/#1/theme.sty}
}

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

\endinput
