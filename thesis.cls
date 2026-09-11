% thesis.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2025/07/14 Custom ETH-style Thesis Class]

%----------------------------------------------------------
% Base class
%----------------------------------------------------------
\LoadClass[a4paper,10.5pt,twoside,openright]{memoir}
\setlrmarginsandblock{35mm}{28mm}{*} % inner, outer
\setulmarginsandblock{25mm}{32mm}{*} % upper, lower
\checkandfixthelayout
%----------------------------------------------------------
% Encoding & language
%----------------------------------------------------------
%\RequirePackage[utf8]{inputenc}
\RequirePackage[french,ngerman,english]{babel}
% Ensure Utopia font and small caps support
\RequirePackage{fourier-otf}

%----------------------------------------------------------
% Fonts
%----------------------------------------------------------
\usepackage{helvet}
\usepackage{fontspec}
\usepackage{pdfpages}
\setmainfont[
  UprightFont = * ,
  ItalicFont = * Italic ,
  BoldFont = * Bold ,
  BoldItalicFont = * Bold Italic
]{Optima}

%----------------------------------------------------------
% Colors
%----------------------------------------------------------
\RequirePackage{xcolor}
\RequirePackage{colortbl}
\definecolor{grey}{HTML}{4D4D4D}
\definecolor{plot_grey}{HTML}{4D4D4D}
\definecolor{plot_blue}{HTML}{0066CC}
\definecolor{plot_red}{HTML}{FF3300}
\definecolor{plot_orange}{HTML}{FF6600}
\definecolor{plot_yellowbrown}{HTML}{FFCC00}
\definecolor{dark_blue}{HTML}{1b4f72}

%----------------------------------------------------------
% Packages (grouped)
%----------------------------------------------------------
\RequirePackage{microtype,float,adjustbox}
\RequirePackage{graphicx,subcaption,tikz}
\RequirePackage{dashrule,booktabs,longtable,pdflscape}
\RequirePackage{afterpage,enumitem,fancyvrb}
\RequirePackage{amsmath,leftidx,siunitx, unicode-math}
\RequirePackage{csvsimple,diagbox,import}
\RequirePackage{subfiles}
\RequirePackage{bookmark,hyperref}
\RequirePackage{etoolbox}
\sisetup{per-mode = fraction}
\DeclareSIUnit\ml{ml}

% LAYOUT AND FORMATTING
\RequirePackage{overpic}
\RequirePackage{chemfig}
\RequirePackage{mhchem}
\RequirePackage{fourier-otf}
\RequirePackage{bm}
\RequirePackage{mdframed}
\RequirePackage{xstring}

%----------------------------------------------------------
% Summay spacing using memoir’s own commands
%----------------------------------------------------------
\newenvironment{summaryspacing}{%
  \begingroup
  \SingleSpacing  % switch to single spacing
}{%
  \clearpage
  \endgroup
}

%----------------------------------------------------------
% Hyperref setup
%----------------------------------------------------------
\hypersetup{pdfauthor={Your Name},pdftitle={Your Thesis Title}}

%----------------------------------------------------------
% Chapter style
%----------------------------------------------------------
\makeatletter
\makechapterstyle{fancyblock}{%
  \setlength{\beforechapskip}{0em}
  \setlength{\midchapskip}{0em}
  \setlength{\afterchapskip}{0em}

  \renewcommand{\chapnamefont}{}%
  \renewcommand{\chapnumfont}{}%

  \renewcommand{\chaptitlefont}{%
    \large\scshape
  }

  \renewcommand{\printchaptername}{}%

  % --- NEW: flag to detect starred chapters ---
  \newif\if@fancy@numberedchapter
  \renewcommand{\printchapternum}{\@fancy@numberedchaptertrue}%
  \renewcommand{\printchapternonum}{\@fancy@numberedchapterfalse}%
  \renewcommand{\afterchapternum}{}%

  \renewcommand{\printchaptertitle}[1]{%
    \begin{flushleft}%
      \if@fancy@numberedchapter
      {\normalfont\bfseries\Large\color{dark_blue!60}\@chapapp~\thechapter}\par
      \fi
      \chaptitlefont \MakeUppercase{##1}\\%[0.5ex]
      \vspace{-4mm}
      \rule{\textwidth}{0.4pt}
    \end{flushleft}%
  }%
}
\makeatother
\chapterstyle{fancyblock}

%----------------------------------------------------------
% ToC entries: write literal "Chapter <n>" / "Appendix <letter>" into .toc
%----------------------------------------------------------
\makeatletter
\renewcommand*{\cftchaptername}{\chaptername\space}
\renewcommand*{\cftappendixname}{\appendixname\space}
\setlength{\cftchapternumwidth}{2.0em}
\makeatother

%----------------------------------------------------------
% Section titles
%----------------------------------------------------------
\setsubsecheadstyle{\normalsize\MakeUppercase}
\setsubsubsecheadstyle{\normalsize\MakeUppercase}
\setsecheadstyle{\normalsize\MakeUppercase}
\setparaheadstyle{\bfseries\normalsize}
\setbeforesecskip{2.2ex}
\setaftersecskip{0.2ex}

%----------------------------------------------------------
% Captions
%----------------------------------------------------------
%\RequirePackage[font=small,labelfont={sc,bf},labelsep=quad]{caption}
\setlength{\captionmargin}{5pt}
\setlength{\intextsep}{30pt plus 1.0pt minus 2.0pt}
\RequirePackage{sidecap}
\sidecaptionvpos{table}{t}

%----------------------------------------------------------
% Spacing & layout
%----------------------------------------------------------
\linespread{1.3}
\feetatbottom
\setlength{\footmarkwidth}{1em}
\setlength{\footmarksep}{0em}
\setlength{\parskip}{4pt}
\setlength{\parindent}{0cm}
\setcounter{LTchunksize}{50}

%----------------------------------------------------------
% Math operators
%----------------------------------------------------------
\DeclareMathOperator{\YFP}{YFP}
\DeclareMathOperator{\OD}{OD}
\DeclareMathOperator{\s}{s}
\DeclareMathOperator{\logit}{logit}

%----------------------------------------------------------
% Autoref labels
%----------------------------------------------------------
\addto\extrasenglish{%
  \def\chapterautorefname{\textsc{Chapter}}%
  \def\sectionautorefname{\textsc{Section}}%
  \def\subsectionautorefname{\textsc{Section}}%
  \def\subsubsectionautorefname{\textsc{Section}}%
  \def\figureautorefname{\textsc{Figure}}%
  \def\figurename{\textsc{Figure}}%
  \def\tableautorefname{\textsc{Table}}%
  \def\appendixautorefname{\textsc{Appendix}}%
}

\AtBeginDocument{%
  \renewcommand*{\sectionautorefname}{Appendix}%
  \renewcommand*{\subsectionautorefname}{Appendix}%
  \renewcommand*{\subsubsectionautorefname}{Appendix}%
}

%----------------------------------------------------------
% Page styles
%----------------------------------------------------------
\copypagestyle{pst_e}{ruled}
\setlength{\headsep}{30pt}
\setlength{\headheight}{24pt}

% even (left) page: chapter title only (no number)
\makeevenhead{pst_e}{\footnotesize\scshape\leftmark}{}{}

% odd (right) page: "Chapter 1.3 Results" / "Appendix A.3 Figures"
\makeoddhead{pst_e}{}{}{\footnotesize\scshape\rightmark}

\aliaspagestyle{plain}{empty}

\makeatletter

% left header mark = CHAPTER TITLE (uppercase)
\renewcommand*{\chaptermark}[1]{%
  \markboth{\MakeUppercase{#1}}{}%
}

% right header mark = "CHAPTER 1.3 RESULTS" / "APPENDIX A.3 FIGURES" (uppercase)
\renewcommand*{\sectionmark}[1]{%
  \markright{\MakeUppercase{\@chapapp\space\thesection\space #1}}%
}

% plain marks (toc/lof/lot/...)
\makepsmarks{pst_e}{%
  \createplainmark{toc}{both}{\contentsname}%
  \createplainmark{lof}{both}{\listfigurename}%
  \createplainmark{lot}{both}{\listtablename}%
  \createplainmark{bib}{both}{\bibname}%
  \createplainmark{index}{both}{\indexname}%
  \createplainmark{glossary}{both}{\glossaryname}%
}

\copypagestyle{pst_app}{pst_e}
\makepsmarks{pst_app}{%
  \createplainmark{toc}{both}{\contentsname}%
  \createplainmark{lof}{both}{\listfigurename}%
  \createplainmark{lot}{both}{\listtablename}%
  \createplainmark{bib}{both}{\bibname}%
  \createplainmark{index}{both}{\indexname}%
  \createplainmark{glossary}{both}{\glossaryname}%
}

\makeatother

\copypagestyle{pst_front}{empty}
\makeevenfoot{pst_front}{\footnotesize\thepage}{}{}
\makeoddfoot{pst_front}{}{}{\footnotesize\thepage}

% Auto-switch matter styles
\makeatletter
\pretocmd{\frontmatter}{\pagestyle{pst_front}}{}{}
\pretocmd{\mainmatter}{\pagestyle{pst_e}}{}{}
\pretocmd{\appendix}{\pagestyle{pst_app}}{}{}
\makeatother

%----------------------------------------------------------
% Bibliography (Biber + biblatex)
%----------------------------------------------------------
\RequirePackage[
  backend=biber,
  sorting=none,
  style=numeric-comp,
  maxnames=5,
  giveninits=true,
  defernumbers=true
]{biblatex}

\addbibresource{bibliographies/template.bib}

% optional font for bib
\AtBeginBibliography{\scriptsize}

% -------------------------------------------------
%  Environment  compactbib  (needs biblatex loaded)
% -------------------------------------------------
\AtBeginDocument{%
  \defbibenvironment{compactbib}                % <- correct macro
  {%
    \list
    {\printtext[labelnumberwidth]{%
    \printfield{labelprefix}\printfield{labelnumber}}}%
    {%
      % hanging‑indent layout
      \setlength{\labelwidth}{\labelnumberwidth}%
      \setlength{\labelsep}{\biblabelsep}%
      \setlength{\leftmargin}{\dimexpr\labelwidth+\labelsep\relax}%
      % tighter vertical spacing
      \setlength{\itemsep}{0.1\baselineskip}%
      \setlength{\parsep}{0pt}%
      \setlength{\parskip}{0pt}%
    }%
  }%
  {\endlist}%
  {
\item}%
}

% -------------------------------------------------
%  Subunit command
% -------------------------------------------------
\newcommand{\subunit}[1]{%
  \begin{refsection}
    \subfile{#1}%
    \clearpage
    \section*{Bibliography}%
    \printbibliography[heading=none,env=compactbib]%
  \end{refsection}
}

% -------------------------------------------------
%  Front matter blocks for included manuscripts (paper-style)
% -------------------------------------------------
\makeatletter

\newcommand{\mabstract}{}
\newcommand{\mauthors}{}
\newcommand{\maffiliations}{}
\newcommand{\mpublished}{}
\newcommand{\mcontributions}{}

\newcommand{\manuscriptabstract}[1]{\gdef\mabstract{#1}}
\newcommand{\manuscriptauthors}[1]{\gdef\mauthors{#1}}

\newcommand{\affil}[2]{%
  \g@addto@macro\maffiliations{\textsuperscript{#1}#2\par}%
}

\newcommand{\manuscriptpublished}[1]{\gdef\mpublished{#1}}
\newcommand{\authorcontributions}[1]{\gdef\mcontributions{#1}}

\newcommand{\manuscriptreset}{%
  \gdef\mabstract{}%
  \gdef\mauthors{}%
  \gdef\maffiliations{}%
  \gdef\mpublished{}%
  \gdef\mcontributions{}%
}

\newcommand{\printmanuscriptauthors}{%
  \textbf{Authors:}
  \ifx\mauthors\@empty
  {\normalfont \@author\par}%
  \else
  {\normalfont \mauthors\par}%
  \fi
}

\newcommand{\printmanuscriptmeta}{%
  {\itshape\small
    \ifx\maffiliations\@empty\else
    \maffiliations
    \vspace{0.35\baselineskip}%
    \fi
  }%
  {\normalfont\small
    \ifx\mcontributions\@empty\else
    \noindent\textbf{Contributions:} \mcontributions\par
    \vspace{0.35\baselineskip}%
    \fi
  }%
  \vspace{0.4\baselineskip}%
  \rule{\textwidth}{0.4pt}\par
  \vspace{0.75\baselineskip}%
}

\newcommand{\manuscriptfront}{%
  \chapter{\@title}%
  \printmanuscriptauthors
  \printmanuscriptmeta
  \begin{abstract}
    \mabstract
  \end{abstract}
  \vfill
  {\normalfont\small
    \ifx\mpublished\@empty\else
    \textit{\mpublished}\par
    \fi
  }%
  \clearpage
  \manuscriptreset
}

\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% APPENDIX FRONT PAGE STYLE %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\newcounter{appendixitem}

\newcommand{\appendixfront}{%
  \refstepcounter{appendixitem}%
  \chapter{\@title}%
  \printmanuscriptauthors
  {\itshape\small
    \ifx\maffiliations\@empty\else
    \maffiliations
    \fi
  }%
  \vspace{0.4\baselineskip}%
  \rule{\textwidth}{0.4pt}\par

  \vspace*{4.0cm}%
  {\normalfont\huge\itshape Supplementary Information\par}%
  \vspace*{1.25\baselineskip}%
  \clearpage
  \manuscriptreset
}

\makeatother

%% Commands
\newcommand{\panelref}[2]{\autoref{#1}{#2}}

%----------------------------------------------------------
% Placeholder figure box (used throughout this template so it
% compiles without any real image assets). Replace with a real
% \includegraphics once you have actual figures.
% Usage: \placeholderfigure[Optional label]{width}{height}
%----------------------------------------------------------
\usetikzlibrary{calc}
\newcommand{\placeholderfigure}[3][Figure Placeholder]{%
  \centering
  \begin{tikzpicture}
    \draw[thick,gray,fill=gray!5] (0,0) rectangle (#2,#3);
    \draw[gray] (0,0) -- (#2,#3) (0,#3) -- (#2,0);
    \node[gray,font=\itshape,align=center,fill=white,inner sep=2pt]
      at ($(0,0)!0.5!(#2,#3)$) {#1};
  \end{tikzpicture}%
}
