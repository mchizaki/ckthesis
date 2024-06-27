%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  %====================================%
%  % `ckthesis` class for CK PhD thesis %
%  %====================================%
%  - written by CK
%
%  %====================================%
%  % options                            %
%  %====================================%
%  - english (true or false)
%  - draft (true or false)
%      - all figures are converted to boxes
%  - fontsize (default: 10pt)
%      - fontsize of ltjsbook class
%      - 10pt, 11pt, 12pt
%  - mtpro2 (true or false)
%      - MathTime Professional 2 are used
%  - left  (default: 40truemm)
%  - right (default: 25truemm)
%      - margin dimensions at odd pages
%
%  %====================================%
%  % variables setting commands         %
%  %====================================%
%  [required variables]
%  - \title
%  - \date
%  - \author
%
%  [optional variables]
%  - \University
%  - \Department
%  - \SideTextAboveTitle
%  - \CenterTextAboveTitle
%
%  %====================================%
%  % note                               %
%  %====================================%
%  - this class is created by using ltjsbook class
%  - please use LuaLaTeX to typeset your document
%  - operation check: TeX Live 2024
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat {LaTeX2e}
\ProvidesExplPackage {ckthesis} {2024-06-27} {1.0.0} {CK PhD thesis}




%===============================%
% expl3 settings
%===============================%
\RequirePackage{ expl3, l3keys2e }
\ExplSyntaxOn

\dim_new:N  \g_ckop_margin_left_dim
\dim_new:N  \g_ckop_margin_right_dim
\str_new:N  \g_ckop_fontsize_str
\bool_new:N \g_ckop_draft_bool
\bool_new:N \g_ckop_english_bool
\bool_new:N \g_ckop_mtpro_bool

\dim_gset:Nn \g_ckop_margin_left_dim  { 40truemm }
\dim_gset:Nn \g_ckop_margin_right_dim { 25truemm }
\str_gset:Nn \g_ckop_fontsize_str { 10pt }
\bool_gset_false:N \g_ckop_draft_bool
\bool_gset_false:N \g_ckop_english_bool
\bool_gset_false:N \g_ckop_mtpro_bool




%===============================%
% Applicating options to class
%===============================%
\keys_define:nn { ckthesis } {
	left      .dim_gset:N = \g_ckop_margin_left_dim,
	right     .dim_gset:N = \g_ckop_margin_right_dim,
	fontsize  .str_gset:N = \g_ckop_fontsize_str,
	draft    .bool_gset:N = \g_ckop_draft_bool,
	english  .bool_gset:N = \g_ckop_english_bool,
	mtpro2   .bool_gset:N = \g_ckop_mtpro_bool
}
\ProcessKeysOptions { ckthesis }




%===============================%
% LoadClass
%===============================%
\clist_new:N \g_ltjsbook_option_clist

% standard option
\clist_set:Nn \g_ltjsbook_option_clist {
  a4paper,
  titlepage,
  \g_ckop_fontsize_str % fontsize option
}

% english option
\bool_if:NT \g_ckop_english_bool {
  \clist_put_left:Nn \g_ltjsbook_option_clist {
    english
  }
}

% LoadClass
\PassOptionsToClass { \g_ltjsbook_option_clist } { ltjsbook }
\LoadClass { ltjsbook }




%===============================%
% Draft
%===============================%
% draft option
\bool_if:NT \g_ckop_draft_bool {
  \PassOptionsToPackage{ draft }{ graphicx }
}

% [draft] graphicx
% \bool_if:NTF \g_ckop_draft_bool {
% 	\tl_set:Nn \l__ckop_graphicx_tl { draft, }
% }{
% 	\tl_set:Nn \l__ckop_graphicx_tl { }
% }
% \RequirePackage[
% 	\l__ckop_graphicx_tl
% ]{ graphicx }




%===============================%
% Skip/Margin
%===============================%
\renewcommand{\baselinestretch}{1.3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \oddsidemargin and \fullwidth are calculated by [leftmargin] and [rightmargin]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	\paperwidth = [leftmargin] + \fullwidth + [rightmargin]
%
% [leftmargin]  = 1in + \oddsidemargin
% [rightmargin] = \paperwidth - \fullwidth - [leftmargin]
%               = \paperwidth - \fullwidth - 1in - \oddsidemargin
%   |
%   v
% \oddsidemargin = [leftmargin] - 1in
% \evensidemargin = [right]
% \fullwidth = \paperwidth - 1in - \oddsidemargin - [rightmargin]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% * odd page margin
%     * leftmargin: default: 40 mm
%     * rightmargin: default: 25 mm
% * \fullwidth: automatically adjusted by using [leftmargin] and [rightmargin]
%     * e.g. if a4paper ( \paperwidth = 210 mm )
%       => \fullwidth = 210 - 40 - 25 = 145 mm
%     * note: ltjsbook default => \fullwidth = 142.3 mm
% * \textwidth is set equal to \fullwidth
%

% define left and right margins
\newlength{\CKLeftMargin}
\newlength{\CKRightMargin}
\setlength{\CKLeftMargin}{\g_ckop_margin_left_dim}
\setlength{\CKRightMargin}{\g_ckop_margin_right_dim}

% set textwidth and fullwidth
\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-\CKLeftMargin}
\addtolength{\textwidth}{-\CKRightMargin}
\setlength{\fullwidth}{\textwidth}

% oddsidemargin
\setlength{\oddsidemargin}{\CKLeftMargin}
\addtolength{\oddsidemargin}{-1in}

% evensidemargin
% ( => left and right margins are reversed )
\setlength{\evensidemargin}{\CKRightMargin}
\addtolength{\evensidemargin}{-1in}




%===============================%
% Heading
%===============================%
\renewcommand{\headfont}{\mcfamily\rmfamily\bfseries}


\RequirePackage{titlesec}

\titleformat{\chapter}[display]{\Huge\bfseries}{\chaptertitlename \thechapter}{0.5em}{}

\titleformat*{\section}{\Large\bfseries}
\titleformat*{\subsection}{\large\bfseries}
\titleformat*{\subsubsection}{\large\bfseries}

\renewcommand{\appendixname}{Appendix{\ }}




%===============================%
% Pagestyle
%===============================%
\RequirePackage{titleps}
\newpagestyle{chapter}{
  \headrule
  \sethead[
    \textbf{\thepage}
  ][][
    \thechapter \quad \chaptertitle
  ]{
    \thesection\quad\sectiontitle
  }{}{
    \textbf{\thepage}
    }
}
\newpagestyle{front}{
  \sethead[\textbf{\thepage}][][]{}{}{}
}
% \renewpagestyle{plain}{
%   \headrule
%   \sethead[][][]{}{}{}
% }




%===============================%
% Font & math font
%===============================%
\bool_if:NTF \g_ckop_mtpro_bool {
  % mtpro2
  \RequirePackage{ tgtermes, tgheros }
  \RequirePackage[ T1 ]{ fontenc }
  \renewcommand{\bfdefault}{bx}
  \renewcommand{\ttdefault}{lmtt}
  \renewcommand{\rmdefault}{ptm}
  \RequirePackage{ amsmath }
%  \RequirePackage[ T1 ]{ fontenc }
%  \RequirePackage{ textcomp }
%  \renewcommand{\rmdefault}{ptm}
%  \RequirePackage[ scaled=0.92 ]{ helvet }
  \RequirePackage[
    subscriptcorrection,
    slantedGreek,
    nofontinfo
  ]{ mtpro2 }

}{
  % tgtermes
  \RequirePackage{ amsmath, amssymb }
  \RequirePackage{ qtxmath }
  \RequirePackage{ tgtermes, tgheros }
  \RequirePackage[ T1 ]{ fontenc }
  \renewcommand{\bfdefault}{bx}
  \renewcommand{\ttdefault}{lmtt}
}




%===============================%
% Math packages
%===============================%
\RequirePackage{ amsthm    }
\RequirePackage{ bm        }
\RequirePackage{ mathtools }
\RequirePackage{ empheq    }




%===============================%
% Other packages
%===============================%
\RequirePackage{ graphicx }




%===============================%
% Theorem
%===============================%
\theoremstyle{definition}
\RequirePackage{mdframed}
\newmdtheoremenv[default]{theorem}{Theorem}[chapter] % { envname }{ title }




%===============================%
% Abstract
%===============================%
\newcommand{\ckCenterTitle}[1]{%
\phantomsection%
	\begin{center}%
		\huge\bfseries{#1}%
	\end{center}
	\vspace{2em}
}




%===============================%
% Table of Contents
%===============================%
% \newcommand{\cklistfigures}[1]{%
%   \iftotalfigures
%     \addcontentsline{toc}{chapter}{\listfigurename}
%     \listoffigures
%   \fi
% }

% \newcommand{\cklisttables}[1]{%
%   \iftotaltables
%     \addcontentsline{toc}{chapter}{\listtablename}
%     \listoftables
%   \fi
% }




%===============================%
% titlepage
%===============================%
\tl_new:N  \g_titlepage_university_tl
\tl_new:N  \g_titlepage_department_tl
\tl_new:N  \g_titlepage_side_text_above_title_tl
\tl_new:N  \g_titlepage_center_text_above_title_tl

\newcommand{\University}[1]{
  \tl_gset:Nn \g_titlepage_university_tl { #1 }
}
\newcommand{\Department}[1]{
  \tl_gset:Nn \g_titlepage_department_tl { #1 }
}
\newcommand{\SideTextAboveTitle}[1]{
  \tl_gset:Nn \g_titlepage_side_text_above_title_tl { #1 }
}
\newcommand{\CenterTextAboveTitle}[1]{
  \tl_gset:Nn \g_titlepage_center_text_above_title_tl { #1 }
}

\if@titlepage
  \renewcommand{\maketitle}{%
    \begin{titlepage}%
      %
      \vfill
      %
      %===============================%
      % Block1: text above title
      %===============================%
      %-------------------------------%
      % center text
      %-------------------------------%
      \tl_if_empty:NTF { \g_titlepage_center_text_above_title_tl }{
        \relax
      }{
        \begin{center}
          \noindent \Huge%
          \g_titlepage_center_text_above_title_tl
        \end{center}
      }
      %-------------------------------%
      % left text
      %-------------------------------%
      \tl_if_empty:NTF { \g_titlepage_side_text_above_title_tl }{
        \relax
      }{
        \begin{flushleft}
          \noindent \LARGE%
          \g_titlepage_side_text_above_title_tl
        \end{flushleft}
      }
      %
      \vskip 1.5em
      %
      %===============================%
      % Block2: title and date
      %===============================%
      \begin{center}%
        %-------------------------------%
        % title
        %-------------------------------%
        {
          \fontsize{35pt}{30pt} \selectfont \@title \par
        }
        %
        \vskip 1em
        %
        %-------------------------------%
        % date
        %-------------------------------%
        {
          \huge \@date \par
        }
      \end{center}
      %
      %
      %
      \vfill
      \vfill
      \vfill
      %
      %
      %
      %===============================%
      % Block3: author and university
      %===============================%
      \begin{center}
        %-------------------------------%
        % author
        %-------------------------------%
        {
          \HUGE \@author \par
        }
        %
        \vfill
        %
        %-------------------------------%
        % department
        %-------------------------------%
        \tl_if_empty:NTF { \g_titlepage_department_tl }{
          \relax
        }{
          \fontsize{22pt}{20pt} \selectfont%
          \g_titlepage_department_tl\par
          %
          \vskip -.5em
          %
        }
        %-------------------------------%
        % university
        %-------------------------------%
        \tl_if_empty:NTF { \g_titlepage_university_tl }{
          \relax
        }{
          \HUGE\scshape%
          \g_titlepage_university_tl \par
        }
      \end{center}%
      %
      \vfill
      %
    \end{titlepage}%
    \setcounter{footnote}{0}%
    % \global\let\thanks\relax
    % \global\let\maketitle\relax
    % \global\let\@thanks\@empty
    % \global\let\@author\@empty
    % \global\let\@date\@empty
    % \global\let\@title\@empty
    % \global\let\title\relax
    % \global\let\author\relax
    % \global\let\date\relax
    % \global\let\and\relax
  }%
\fi



\ExplSyntaxOff




%===============================%
% Math Operator
%===============================%
\DeclareMathOperator{\sinc}{sinc}




%===============================%
% other settings
%===============================%
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

\renewcommand{\labelenumi}{(\arabic{enumi})}

% reference
\newcommand{\myeqref}[1]{Eq.~\eqref{#1}}
\newcommand{\myeqsref}[1]{Eqs.~\eqref{#1}}
\newcommand{\thref}[1]{Th.~\ref{#1}}
\newcommand{\appendixref}[1]{Appendix \ref{#1}}

\newcommand{\ckunderline}[3][-3pt]{%
  \sbox0{#3}%
  \ooalign{\copy0\cr\rule[\dimexpr#1-#2\relax]{\wd0}{#2}}%
}
\newcommand{\emphline}[1]{%
	\ckunderline[-1.5pt]{1pt}{#1}%
}
