%
% Copyright (c) 2014, Jonathan Anderson <jonathan.anderson@mun.ca>.
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice,
% this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright notice,
% this list of conditions and the following disclaimer in the documentation
% and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.
%

% Modified 06 July 2019 by Jacob House <me@jwfh.ca>

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mun-report}[2014/06/16 Academic report template]

% Use the basic article structure.
\LoadClass{article}

\RequirePackage{mun-fonts}
\RequirePackage{mun-colour}

\RequirePackage{calc}
\RequirePackage{fancyhdr}
\RequirePackage[right=1.25in, left=1.25in, top=1in, bottom=1in, includeheadfoot]{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{ifthen}
\RequirePackage[framemethod=tikz]{mdframed}
\RequirePackage{parskip}
\RequirePackage{tabularx}
\RequirePackage{titlesec}
\RequirePackage{verbatim}

%
% Use the names "Engineering", "Faculty of Engineering and Applied Science"
% and "ENGI" in the appropriate places. Emit the Engineering-specific policy
% on academic integrity and professional conduct.
%
% Other Faculties and Departments should add similar class options here.
%
\newif\if@engineering
\@engineeringfalse
\DeclareOption{engineering}{\@engineeringtrue}

%
% Include answers in the output.
%
\newif\if@showanswers
\@showanswersfalse
\DeclareOption{answerkey}{\@showanswerstrue \newcommand{\showanswers}{}}

\newif\if@bigtitle
\@bigtitlefalse
\DeclareOption{bigtitle}{\@bigtitletrue}

%
% Pass the remaining options to 'article'.
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\makeatletter


%
% Internal macros that represent key course information:
%
\newcommand{\@faculty}{Unknown Faculty}
\newcommand{\@shortfaculty}{Unknown}

\if@engineering
\renewcommand{\@faculty}{Faculty of Engineering and Applied Science}
\renewcommand{\@shortfaculty}{Engineering}
\fi

\newcommand{\@courseprefix}{ENGI}
\newcommand{\@coursename}{Short Name}
\newcommand{\@coursenumber}{XXXX}

\newcommand{\@reportnumber}{XX}
\newcommand{\@reporttitle}{An unnamed report}
\newcommand{\@reportdate}{XX YYY ZZZZ}
\newcommand{\@reporttype}{Assignment}


%
% Externally-visible commands to define course information.  These are
% documented in the header comment at the top of this file, so if you add new
% commands, please also add documentation there!
%
\newcommand{\coursename}[1]{\renewcommand\@coursename{#1}}
\newcommand{\coursenumber}[1]{\renewcommand\@coursenumber{#1}}

\newcommand{\reportnumber}[1]{\renewcommand\@reportnumber{#1}}
\newcommand{\reporttitle}[1]{\renewcommand\@reporttitle{#1}}
\newcommand{\reportdate}[1]{\renewcommand\@reportdate{#1}}
\newcommand{\reporttype}[1]{\renewcommand\@reporttype{#1}}

\newcommand{\@XX}{XX}


%
% Page headers:
%
\pagestyle{fancy}
% \setlength{\headheight}{.75in}
\renewcommand{\headrulewidth}{0.0pt}

\fancyhead{}
\fancyfoot{}

\fancyhead[L] {\neutralcolour \it \@shortfaculty~\@coursenumber:~\@coursename}
\fancyhead[R] {\headercolour \it \@reporttype\ifx\@reportnumber\@XX\relax~---~\else:~\fi\@reporttitle}
\fancyfoot[C] {\neutralcolour \bf \thepage}

\fancypagestyle{plain}{
% \setlength{\headheight}{.25in}
\fancyhead{}
\fancyfoot[C] {\neutralcolour \bf \thepage}
}


%
% No paragraph indentation:
%
\setlength{\parindent}{0cm}


%
% Customised title:
%
\renewcommand{\arraystretch}{1}
\newcommand{\head}[1]{\textbf{\headercolour #1}}
\newcommand{\wide}[1]{\multicolumn{3}{p{0.85 \hsize}}{#1}}

\renewcommand{\maketitle}
{%
  \thispagestyle{plain}
  \vspace*{-0.75in}

  \mbox{%
    \parbox{3.25in}{%
      \includegraphics[width=1.1in]{memorial} \vspace{6pt} \\
      {\neutralcolour \bf \hspace{1pt}\@faculty}
    }
    \parbox{2in}{
      \neutralcolour \bf
      \@reporttype \\
      \@courseprefix \@coursenumber \\
      \\
      \@reportdate
    }
  }

  \vspace{.2in}

  \if@bigtitle
	  {\bf \LARGE \headercolour~\@reporttitle}
  \else
	  {\bf \LARGE \headercolour \@reporttype~\ifx\@reportnumber\@XX\relax~---~\else\@reportnumber:~\fi\@reporttitle}
  \fi
}


%
% Section, etc. headings:
%
\titlespacing{\section}{0pt}{1.5em}{.75em}
\titlespacing{\subsection}{0pt}{1em}{0.25em}
\titlespacing{\subsubsection}{0pt}{1em}{0em}

\titleformat{name=\section}{\Large \bf \headercolour}{\thesection}{.5em}{}
\titleformat{name=\subsection}{\large \bf \headercolour}{\thesubsection}{.5em}{}
\titleformat{name=\subsubsection}{\bf \headercolour}{\thesubsubsection}{.5em}{}


\newenvironment{answer}
{
  \ifthenelse{\isundefined{\showanswers}}
  {\expandafter\comment}
  {\begin{mdframed}[frametitle=Answer,
    linecolor=MidnightBlue, backgroundcolor=AliceBlue!50,
    leftmargin=1em, rightmargin=1em,
    skipabove=1em, skipbelow=1em,
    outerlinewidth=1pt, roundcorner=.5em,
    frametitlefont={\normalfont\bfseries\color{MidnightBlue}},
    ]
  }
}
{
  \ifthenelse{\isundefined{\showanswers}}
  {\expandafter\endcomment}
  {\end{mdframed}}
}

\makeatother

\endinput
