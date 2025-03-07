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
%  - times (true or false)
%      - use times font
%  - draft (true or false)
%      - all figures are converted to boxes
%  - tombo (true or false)
%  - fontsize (default: 11pt)
%      - fontsize of ltjsbook class
%      - 10pt, 11pt, 12pt
%  - b5paper (true or false)
%      - if true: b5paper, else: a4paper (default)
%  - left   (default: 35truemm)
%  - right  (default: 20truemm)
%  - top    (default: 15truemm)
%  - bottom (default: 20truemm)
%      - margin dimensions at odd pages
%  - headsep (default: 10truemm)
%      - vertical length between the header and the top of the text area
%  - headrule (true or false)
%      - header => with rule
%  - headfontsc (true or false)
%      - heading font => Pagella small caps
%  - reversemarginpar (true or false)
%      - use \reversemarginpar and adjust marginparwidth
%
%  Other options:
%      same options in ltjsbook (e.g. fleqn)
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
\ProvidesExplPackage {ckthesis} {2025-01-09} {2.0} {CK PhD thesis}




%===============================%
% expl3 settings
%===============================%
\RequirePackage{ expl3, l3keys2e }
\ExplSyntaxOn

\dim_new:N  \g_ckop_margin_left_dim
\dim_new:N  \g_ckop_margin_right_dim
\dim_new:N  \g_ckop_margin_top_dim
\dim_new:N  \g_ckop_margin_bottom_dim
\dim_new:N  \g_ckop_headsep_dim
\str_new:N  \g_ckop_fontsize_str
\bool_new:N \g_ckop_bfivepaper_bool
\bool_new:N \g_ckop_draft_bool
\bool_new:N \g_ckop_tombo_bool
\bool_new:N \g_ckop_english_bool
\bool_new:N \g_ckop_times_bool
\bool_new:N \g_ckop_headrule_bool
\bool_new:N \g_ckop_headfont_sc_bool
\bool_new:N \g_ckop_reversemarginpar_bool

\dim_gset:Nn \g_ckop_margin_left_dim   { 35truemm }
\dim_gset:Nn \g_ckop_margin_right_dim  { 20truemm }
\dim_gset:Nn \g_ckop_margin_top_dim    { 15truemm }
\dim_gset:Nn \g_ckop_margin_bottom_dim { 20truemm }
\dim_gset:Nn \g_ckop_headsep_dim { 10truemm }
\str_gset:Nn \g_ckop_fontsize_str { 11pt }
\bool_gset_false:N \g_ckop_bfivepaper_bool
\bool_gset_false:N \g_ckop_draft_bool
\bool_gset_false:N \g_ckop_tombo_bool
\bool_gset_false:N \g_ckop_english_bool
\bool_gset_false:N \g_ckop_times_bool
\bool_gset_false:N \g_ckop_headrule_bool
\bool_gset_false:N \g_ckop_headfont_sc_bool
\bool_gset_false:N \g_ckop_reversemarginpar_bool



%===============================%
% Applicating options to class
%===============================%
\keys_define:nn { ckthesis } {
	left        .dim_gset:N = \g_ckop_margin_left_dim,
	right       .dim_gset:N = \g_ckop_margin_right_dim,
	top         .dim_gset:N = \g_ckop_margin_top_dim,
	bottom      .dim_gset:N = \g_ckop_margin_bottom_dim,
	headsep     .dim_gset:N = \g_ckop_headsep_dim,
	fontsize    .str_gset:N = \g_ckop_fontsize_str,
	draft      .bool_gset:N = \g_ckop_draft_bool,
	tombo      .bool_gset:N = \g_ckop_tombo_bool,
	english    .bool_gset:N = \g_ckop_english_bool,
	b5paper    .bool_gset:N = \g_ckop_bfivepaper_bool,
	times      .bool_gset:N = \g_ckop_times_bool,
	headrule   .bool_gset:N = \g_ckop_headrule_bool,
	headfontsc .bool_gset:N = \g_ckop_headfont_sc_bool,
	reversemarginpar .bool_gset:N = \g_ckop_reversemarginpar_bool
}
\ProcessKeysOptions { ckthesis }




%===============================%
% LoadClass
%===============================%
\clist_new:N \g_ltjsbook_option_clist

% standard option
\clist_set:Nn \g_ltjsbook_option_clist {
  titlepage,
  \g_ckop_fontsize_str, % fontsize option
  \g_ckop_tombo_bool
}

% papersize option
\clist_put_left:Nn \g_ltjsbook_option_clist {
  \bool_if:NTF \g_ckop_bfivepaper_bool {
    b5paper, papersize
  } {
    a4paper, papersize
  }
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
\bool_if:NT \g_ckop_english_bool {
  % \narrowbaselinesfalse
  \renewcommand{\baselinestretch}{1.2}
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \oddsidemargin and \fullwidth are calculated by [LeftMargin] and [RightMargin]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	\paperwidth = [LeftMargin] + \fullwidth + [RightMargin]
%
% [LeftMargin]  = 1in + \oddsidemargin
% [RightMargin] = \paperwidth - \fullwidth - [LeftMargin]
%               = \paperwidth - \fullwidth - 1in - \oddsidemargin
%   |
%   v
% \oddsidemargin = [LeftMargin] - 1in
% \evensidemargin = [right]
% \fullwidth = \paperwidth - 1in - \oddsidemargin - [RightMargin]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% * odd page margin
%     * LeftMargin: default: 40 mm
%     * RightMargin: default: 25 mm
% * \fullwidth: automatically adjusted by using [LeftMargin] and [RightMargin]
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

% set oddsidemargin
\setlength{\oddsidemargin}{\CKLeftMargin}
\addtolength{\oddsidemargin}{-1in}

% set evensidemargin
% ( => left and right margins are reversed )
\setlength{\evensidemargin}{\CKRightMargin}
\addtolength{\evensidemargin}{-1in}

% set marginpar
\setlength{\marginparsep}{10pt}
\setlength{\marginparwidth}{\paperwidth}
\addtolength{\marginparwidth}{-\fullwidth}
\addtolength{\marginparwidth}{-\marginparsep}
\bool_if:NTF \g_ckop_reversemarginpar_bool {
  \reversemarginpar
  \addtolength{\marginparwidth}{-\CKRightMargin}
}{
  \normalmarginpar
  \addtolength{\marginparwidth}{-\CKLeftMargin}
}
\setlength{\marginparwidth}{.98\marginparwidth}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \topmargin and \textheight are calculated by [TopMargin] and [BottomMargin]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	\paperheight = [TopMargin] + [BottomMargin] + \textheight
%                + \headheigh + \headsep + \footskip
%
% [TopMargin]    = 1in + \topmargin
% [BottomMargin] = \paperheight - [TopMargin] - \textheight
%                  - \headheight - \headsep -\footskip
%                = \paperheight - 1in - \topmargin - \textheight
%                  - \headheight - \headsep -\footskip
%   |
%   v
% \topmargin  = [TopMargin] - 1in
% \textheight = \paperheight - 1in - \topmargin - [BottomMargin]
%               - \headheight - \headsep -\footskip
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% define top and bottom margins
\newlength{\CKTopMargin}
\newlength{\CKBottomMargin}
\setlength{\CKTopMargin}{\g_ckop_margin_top_dim}
\setlength{\CKBottomMargin}{\g_ckop_margin_bottom_dim}

% set headsep
\setlength{\headsep}{\g_ckop_headsep_dim}

% set topmargin
\setlength{\topmargin}{\CKTopMargin}
\addtolength{\topmargin}{-1in}

% set textheight
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-1in}
\addtolength{\textheight}{-\topmargin}
\addtolength{\textheight}{-\CKBottomMargin}
\addtolength{\textheight}{-\headheight}
\addtolength{\textheight}{-\headsep}
\addtolength{\textheight}{-\footskip}




%===============================%
% Font & math font
%===============================%
\RequirePackage[ T1 ]{ fontenc }
\RequirePackage{ mlmodern }

\bool_if:NT \g_ckop_times_bool {
  %\RequirePackage{ mathptmx }
  %\RequirePackage{ qtxmath }
  %\RequirePackage{ tgtermes, tgheros }
  \RequirePackage{ tgtermes }
  \RequirePackage[ scaled ]{ helvet }
  \RequirePackage[ T1 ]{ fontenc }
  \renewcommand{\bfdefault}{bx}
  \renewcommand{\ttdefault}{lmtt}
}



%===============================%
% Math packages
%===============================%
\RequirePackage{ amsthm }




%===============================%
% Heading
%===============================%
\bool_if:NTF \g_ckop_headfont_sc_bool {
  \newcommand{\CKHeadFont}{\fontencoding{T1}\fontfamily{qpl}}
  \newcommand{\CKHeadFontSC}{\fontencoding{T1}\fontfamily{qpl}\scshape}
}{
  \newcommand{\CKHeadFont}{\fontencoding{T1}\fontfamily{ptm}}
  \newcommand{\CKHeadFontSC}{\CKHeadFont}
}
\newcommand{\CKChapterFont}{\CKHeadFontSC\HUGE\bfseries}

\RequirePackage{titlesec}

\bool_if:NTF \g_ckop_english_bool {
  \titleformat{\chapter}[display]{\CKChapterFont}{\chaptertitlename \thechapter}{0.5em}{}
  \renewcommand{\appendixname}{Appendix{\ }}
}{
  \titleformat{\chapter}[display]{\CKChapterFont}{\chaptertitlename\thechapter\postchaptername}{0.5em}{}
%  \renewcommand{\appendix}{\appendix}
  \renewcommand{\appendix}{\par
    \titleformat{\chapter}[display]{\CKChapterFont}{\chaptertitlename\thechapter}{0.5em}{}
    \setcounter{chapter}{0}%
    \setcounter{section}{0}%
    \gdef\@chapapp{\appendixname}%
    \gdef\@chappos{}%
    \gdef\thechapter{\@Alph\c@chapter}}

%  \titleformat{\chapter}[display]{\CKChapterFont}{\prechaptername\thechapter\postchaptername}{0.5em}{}
}
\titleformat*{\section}{\Large\bfseries}
\titleformat*{\subsection}{\large\bfseries}
\titleformat*{\subsubsection}{\normalsize\bfseries}





%===============================%
% Pagestyle
%===============================%
\RequirePackage{titleps}

\newcommand{\CKHeadFontShape}{}
\bool_if:NT \g_ckop_english_bool {
  \renewcommand{\CKHeadFontShape}{\itshape}
}



\newcommand{\CKHeaderFont}{\CKHeadFontSC\CKHeadFontShape}
\newcommand{\CKHeaderSubFont}{\CKHeadFont\CKHeadFontShape\small}
\newcommand{\CKHeaderNumberFont}{\CKHeadFontSC\bfseries}

\renewpagestyle{plain}{
  \sethead[
    \CKHeaderNumberFont\thepage
  ][][]{}{}{
    \CKHeaderNumberFont\thepage
    }
}

\renewpagestyle{plainhead}{
  \sethead[
    \CKHeaderNumberFont\thepage
  ][][]{}{}{
    \CKHeaderNumberFont\thepage
    }
}

\renewpagestyle{headings}{
  \bool_if:NT \g_ckop_headrule_bool { \headrule }%
  \sethead[
    \CKHeaderNumberFont\thepage
  ][][
    \CKHeaderFont%
    %
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \if@omit@number\else
          \@chapapp\thechapter\@chappos\hskip1\zw
        \fi
      \fi
    \fi
    %
    \chaptertitle
  ]{
    {\CKHeaderFont%
      \ifnum \c@secnumdepth >\z@ \thesection \hskip1\zw\fi
    }%
    \CKHeaderSubFont%
    \sectiontitle
  }{}{
    \CKHeaderNumberFont\thepage
    }
}


\newpagestyle{OnlyChapterHeadings}{
  \bool_if:NT \g_ckop_headrule_bool { \headrule }%
  \sethead[
    \CKHeaderNumberFont\thepage
  ][][
    \CKHeaderFont\chaptertitle
  ]{
    \CKHeaderFont\chaptertitle
  }{}{
    \CKHeaderNumberFont\thepage
    }
}

\newpagestyle{front}{
  \sethead[\CKHeaderNumberFont\thepage][][]{}{}{}
}




%===============================%
% Table of Contents
%===============================%
\renewcommand{\headfont}{\mcfamily\rmfamily\bfseries}

\bool_if:NT \g_ckop_headfont_sc_bool {
  \let\OriginalTableOfContents\tableofcontents
  \renewcommand{\tableofcontents}{
    {%
    \renewcommand{\headfont}{\CKHeadFontSC\bfseries}%
    % \renewcommand{\normalfont}{\CKHeadFont}%
    %\CKHeadFont%
    \OriginalTableOfContents%
    }%
  }
}




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

