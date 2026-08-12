%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  kuolie.cls -- 扩列图 (fandom self-introduction card) document class
%
%  A clean, Awesome-CV-flavoured card with first-class Chinese support.
%  Structure borrowed from the classic 扩列图 layout; typography borrowed from
%  posquit0/Awesome-CV.
%
%  Engine  : XeLaTeX only
%  License : MIT (see LICENSE). Bundled fonts keep their own licenses.
%
%  You normally do not need to edit this file. Everything is configurable
%  through \kuoliesetup{...} in main.tex.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kuolie}[2026/08/12 v1.0.0 Awesome-CV flavoured Chinese profile card]

\RequirePackage{iftex}
\RequireXeTeX

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt]{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{geometry}
\RequirePackage{xcolor}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage{fontawesome5}
\RequirePackage{enumitem}
\RequirePackage{ragged2e}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{parskip}
\RequirePackage{fancyhdr}
\RequirePackage[hidelinks,unicode,pdfpagelabels=false]{hyperref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Colour palette (Awesome-CV greys + accents)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{kuolie-text}{HTML}{333333}
\definecolor{kuolie-darktext}{HTML}{414141}
\definecolor{kuolie-graytext}{HTML}{5D5D5D}
\definecolor{kuolie-lighttext}{HTML}{999999}
\definecolor{kuolie-hairline}{HTML}{D8D8D8}

% Accent choices -- the first eight are Awesome-CV's own.
\definecolor{kuolie-emerald}{HTML}{00A388}
\definecolor{kuolie-skyblue}{HTML}{0395DE}
\definecolor{kuolie-red}{HTML}{DC3522}
\definecolor{kuolie-pink}{HTML}{EF4089}
\definecolor{kuolie-orange}{HTML}{FF6138}
\definecolor{kuolie-nephritis}{HTML}{27AE60}
\definecolor{kuolie-concrete}{HTML}{95A5A6}
\definecolor{kuolie-darknight}{HTML}{131A28}
% ...plus a few that suit a 扩列图 better.
\definecolor{kuolie-sakura}{HTML}{F58BA5}
\definecolor{kuolie-lavender}{HTML}{8E7CC3}
\definecolor{kuolie-cyan}{HTML}{4FB3BF}
\definecolor{kuolie-mint}{HTML}{57C7A3}

\colorlet{kuolie-accent}{kuolie-skyblue}
\colorlet{kuolie-divider}{kuolie-graytext}
\colorlet{kuolie-pagebg}{white}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Metrics -- change these to retune the whole document
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\kuolie@sectiontopskip}{4.2mm}
\newcommand{\kuolie@contenttopskip}{2.4mm}
\newcommand{\kuolie@pairsep}{1.5mm}
\newcommand{\kuolie@itemsep}{1.1mm}
\newcommand{\kuolie@dividerwidth}{0.9pt}
\newcommand{\kuolie@dividerlift}{1.6pt}
\newcommand{\kuolie@dividergap}{0.7em}
\newlength{\kuolie@colsep}   \setlength{\kuolie@colsep}{2.2em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Fonts
%
%  Latin text uses the Source Sans 3 / Roboto files bundled in fonts/, loaded
%  by *filename* so that no system installation and no fontconfig cache is
%  involved. This is what makes `git clone && latexmk` and Overleaf both work.
%
%  For CJK we cannot bundle a font (a full Han face is 8-20 MB), so the class
%  probes for one. See \kuoliesetup{fontset=...} below.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\kuolie@fontdir}{fonts/}
\newcommand*{\kuoliefontdir}[1]{\renewcommand{\kuolie@fontdir}{#1}}

\setmainfont{SourceSans3-Regular.otf}[
  Path           = \kuolie@fontdir,
  ItalicFont     = SourceSans3-It.otf,
  BoldFont       = SourceSans3-Bold.otf,
  BoldItalicFont = SourceSans3-BoldIt.otf,
  FontFace       = {l}{n}{Font = SourceSans3-Light.otf},
  FontFace       = {l}{it}{Font = SourceSans3-LightIt.otf},
]
\setsansfont{SourceSans3-Regular.otf}[
  Path           = \kuolie@fontdir,
  ItalicFont     = SourceSans3-It.otf,
  BoldFont       = SourceSans3-Bold.otf,
  BoldItalicFont = SourceSans3-BoldIt.otf,
  FontFace       = {l}{n}{Font = SourceSans3-Light.otf},
  FontFace       = {l}{it}{Font = SourceSans3-LightIt.otf},
]
\newfontfamily\kuoliedisplayfont{Roboto-Regular.ttf}[
  Path     = \kuolie@fontdir,
  BoldFont = Roboto-Bold.ttf,
  FontFace = {l}{n}{Font = Roboto-Light.ttf},
]

% Chinese has no small caps and no real italic. Awesome-CV leans hard on
% \scshape and \slshape; we translate those into size + tracking + grey instead,
% and we never fake-slant CJK.
\xeCJKsetup{AutoFakeBold=false, AutoFakeSlant=false}

\ExplSyntaxOn

\tl_new:N \l_kuolie_cjkfont_tl
\tl_new:N \l_kuolie_cjkfont_label_tl

% Load a TeX Live font by filename (works without fontconfig, e.g. on macOS).
\cs_new_protected:Npn \kuolie_cjk_fandol:
  {
    \setCJKmainfont{FandolHei-Regular.otf}[
      BoldFont   = FandolHei-Bold.otf,
      ItalicFont = FandolKai-Regular.otf,
      FontFace   = {l}{n}{Font = FandolHei-Regular.otf},
      FontFace   = {l}{it}{Font = FandolKai-Regular.otf},
    ]
    \setCJKsansfont{FandolHei-Regular.otf}[ BoldFont = FandolHei-Bold.otf ]
    \tl_set:Nn \l_kuolie_cjkfont_label_tl { Fandol~(TeX~Live~built-in) }
    \ClassWarningNoLine{kuolie}
      {
        Falling~back~to~the~Fandol~fonts.~They~cover~simplified~Chinese~only,~
        so~Japanese-only~kanji~(e.g.~U+8FBC,~U+6A0B)~will~render~as~blank~
        boxes.~Install~"Noto~Sans~CJK~SC"~for~full~coverage~--~see~README.md
      }
  }

% A regular family-name lookup, with real Light/Regular/Bold faces.
\cs_new_protected:Npn \kuolie_cjk_family:nn #1#2
  {
    \setCJKmainfont{#1}[
      UprightFont = *~Regular,
      BoldFont    = *~Bold,
      FontFace    = {l}{n}{Font = *~Light},
    ]
    \setCJKsansfont{#1}[ UprightFont = *~Regular, BoldFont = *~Bold ]
    \tl_set:Nn \l_kuolie_cjkfont_label_tl {#2}
  }

% Families that may or may not ship a separate Light face. The body text style
% asks for \fontseries{l}, so that face must always resolve to something.
\cs_new_protected:Npn \kuolie_cjk_plain:nn #1#2
  {
    \IfFontExistsTF { #1~Light }
      {
        \setCJKmainfont{#1}[ FontFace = {l}{n}{Font = *~Light} ]
        \setCJKsansfont{#1}[ FontFace = {l}{n}{Font = *~Light} ]
      }
      {
        \setCJKmainfont{#1}[ FontFace = {l}{n}{Font = *} ]
        \setCJKsansfont{#1}[ FontFace = {l}{n}{Font = *} ]
      }
    \tl_set:Nn \l_kuolie_cjkfont_label_tl {#2}
  }

\cs_new_protected:Npn \kuolie_cjk_auto:
  {
    \IfFontExistsTF { Noto~Sans~CJK~SC }
      { \kuolie_cjk_family:nn { Noto~Sans~CJK~SC } { Noto~Sans~CJK~SC } }
      {
        \IfFontExistsTF { Source~Han~Sans~SC }
          { \kuolie_cjk_family:nn { Source~Han~Sans~SC } { Source~Han~Sans~SC } }
          {
            \IfFontExistsTF { Noto~Sans~SC }
              { \kuolie_cjk_family:nn { Noto~Sans~SC } { Noto~Sans~SC } }
              {
                \IfFontExistsTF { PingFang~SC }
                  { \kuolie_cjk_plain:nn { PingFang~SC } { PingFang~SC~(macOS) } }
                  {
                    \IfFontExistsTF { Microsoft~YaHei }
                      { \kuolie_cjk_plain:nn { Microsoft~YaHei } { Microsoft~YaHei~(Windows) } }
                      {
                        \IfFontExistsTF { Hiragino~Sans~GB }
                          { \kuolie_cjk_plain:nn { Hiragino~Sans~GB } { Hiragino~Sans~GB~(macOS) } }
                          { \kuolie_cjk_fandol: }
                      }
                  }
              }
          }
      }
    \ClassInfo{kuolie}{CJK~font~resolved~to:~\l_kuolie_cjkfont_label_tl}
  }

\cs_new_protected:Npn \kuolie_set_fontset:n #1
  {
    \str_case:nnF {#1}
      {
        { auto      } { \kuolie_cjk_auto: }
        { fandol    } { \kuolie_cjk_fandol: }
        { noto      } { \kuolie_cjk_family:nn { Noto~Sans~CJK~SC }   { Noto~Sans~CJK~SC } }
        { sourcehan } { \kuolie_cjk_family:nn { Source~Han~Sans~SC } { Source~Han~Sans~SC } }
        { notosc    } { \kuolie_cjk_family:nn { Noto~Sans~SC }       { Noto~Sans~SC } }
        { macos     } { \kuolie_cjk_plain:nn  { PingFang~SC }        { PingFang~SC } }
        { windows   } { \kuolie_cjk_plain:nn  { Microsoft~YaHei }    { Microsoft~YaHei } }
      }
      { \ClassError{kuolie}{Unknown~fontset~'#1'}{Use~one~of:~auto,~fandol,~noto,~sourcehan,~notosc,~macos,~windows.} }
  }

% Escape hatch: \kuoliesetcjkfont{Family Name}[fontspec options]
\NewDocumentCommand \kuoliesetcjkfont { m O{} }
  {
    \setCJKmainfont{#1}[#2]
    \setCJKsansfont{#1}[#2]
    \tl_set:Nn \l_kuolie_cjkfont_label_tl {#1}
  }

\ExplSyntaxOff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Text styles -- one command per element, exactly like Awesome-CV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand*{\kuoliebodyfont}{\normalfont}
\newcommand*{\kuoliebodyfontlight}{\normalfont\fontseries{l}\selectfont}

% Latin runs in the name pick up Roboto (Awesome-CV's display face); CJK runs
% stay on the CJK family, which is what you want for a Chinese nickname.
\newcommand*{\kuolie@namestyle}[1]%
  {{\fontsize{30pt}{1em}\kuoliedisplayfont\bfseries\color{kuolie-text}#1}}
\newcommand*{\kuolie@aliasstyle}[1]%
  {{\fontsize{9.5pt}{1.25em}\kuoliebodyfontlight\color{kuolie-lighttext}#1}}
\newcommand*{\kuolie@profilestyle}[1]%
  {{\fontsize{8.8pt}{1.5em}\kuoliebodyfont\color{kuolie-graytext}#1}}
\newcommand*{\kuolie@iconstyle}[1]%
  {{\color{kuolie-accent}#1}}
\newcommand*{\kuolie@sectionstyle}[1]%
  {{\fontsize{15pt}{1em}\kuoliebodyfont\bfseries#1}}
\newcommand*{\kuolie@pairkeystyle}[1]%
  {{\fontsize{10pt}{1.35em}\kuoliebodyfont\bfseries\color{kuolie-darktext}#1}}
\newcommand*{\kuolie@pairvalstyle}[1]%
  {{\fontsize{10pt}{1.35em}\kuoliebodyfontlight\color{kuolie-text}#1}}
\newcommand*{\kuolie@notestyle}[1]%
  {{\fontsize{8.6pt}{1.45em}\kuoliebodyfontlight\color{kuolie-lighttext}#1}}
\newcommand*{\kuolie@itemstyle}%
  {\fontsize{9.6pt}{1.5em}\kuoliebodyfontlight\color{kuolie-text}}
\newcommand*{\kuolie@closingstyle}[1]%
  {{\fontsize{11.5pt}{1.4em}\kuoliebodyfont\color{kuolie-accent}#1}}
\newcommand*{\kuolie@footerstyle}[1]%
  {{\fontsize{8pt}{1em}\kuoliebodyfontlight\color{kuolie-lighttext}#1}}

% Inline helper: emphasise a phrase inside body text.
\newcommand*{\kuoliehl}[1]{{\bfseries\color{kuolie-accent}#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Separators and rules
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The "｜" between tags. \allowbreak so that a long tag line wraps at a
% separator instead of running into the margin. Redefine to taste.
\newcommand{\kuoliesep}{\,{\color{kuolie-hairline}\textbar}\,\allowbreak}
% The delimiter between a pair's key and value.
\newcommand{\kuoliepairdelim}{\,{\color{kuolie-lighttext}\textperiodcentered}\,}

\newcommand{\kuolie@fillrule}{%
  \leavevmode
  \leaders\hrule
    height \dimexpr\kuolie@dividerlift+\kuolie@dividerwidth\relax
    depth  -\kuolie@dividerlift
  \hfill\kern\z@}
\newcommand{\kuolie@filldots}{%
  \leavevmode
  \leaders\hbox to 0.6em{\hss\raisebox{0.15ex}{\tiny$\bullet$}\hss}\hfill\kern\z@}
% \scalebox rather than \fontsize: dropping below 5pt would drag the Computer
% Modern math families into sizes they do not ship, producing font warnings.
\newcommand{\kuolie@fillhearts}{%
  \leavevmode
  \leaders\hbox to 1.5em{\hss\raisebox{0.1ex}{\scalebox{0.42}{\faHeart}}\hss}\hfill\kern\z@}
\newcommand{\kuolie@fillnone}{\hfill}

\newcommand{\kuolie@divider}{\kuolie@fillrule}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Configuration interface
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExplSyntaxOn

\int_new:N \l_kuolie_columns_int
\int_new:N \l_kuolie_highlight_int
\fp_new:N  \l_kuolie_spread_fp

\int_set:Nn \l_kuolie_columns_int   { 2 }
\int_set:Nn \l_kuolie_highlight_int { 2 }
\fp_set:Nn  \l_kuolie_spread_fp     { 0.06 }

\cs_new_protected:Npn \kuolie_set_paper:n #1
  {
    \str_case:nnF {#1}
      {
        % Standard print sizes.
        { a4 }
          { \geometry{ paperwidth=210mm, paperheight=297mm,
                       left=20mm, right=20mm, top=16mm, bottom=18mm, footskip=8mm } }
        { letter }
          { \geometry{ paperwidth=8.5in, paperheight=11in,
                       left=20mm, right=20mm, top=16mm, bottom=18mm, footskip=8mm } }
        % 4:5 -- the aspect ratio Weibo / 小红书 / Instagram show without cropping.
        { square }
          { \geometry{ paperwidth=176mm, paperheight=220mm,
                       left=13mm, right=13mm, top=12mm, bottom=12mm, footskip=6mm } }
        { poster }
          { \geometry{ paperwidth=210mm, paperheight=263mm,
                       left=16mm, right=16mm, top=14mm, bottom=15mm, footskip=7mm } }
      }
      { \ClassError{kuolie}{Unknown~paper~'#1'}{Use~one~of:~a4,~letter,~square,~poster.} }
  }

\cs_new_protected:Npn \kuolie_set_divider:n #1
  {
    \str_case:nnF {#1}
      {
        { rule   } { \cs_set_eq:NN \kuolie@divider \kuolie@fillrule }
        { dots   } { \cs_set_eq:NN \kuolie@divider \kuolie@filldots }
        { hearts } { \cs_set_eq:NN \kuolie@divider \kuolie@fillhearts }
        { none   } { \cs_set_eq:NN \kuolie@divider \kuolie@fillnone }
      }
      { \ClassError{kuolie}{Unknown~divider~'#1'}{Use~one~of:~rule,~dots,~hearts,~none.} }
  }

\cs_new_protected:Npn \kuolie_set_cardstyle:n #1
  {
    \str_case:nnF {#1}
      {
        { flat }
          {
            \colorlet{kuolie-pagebg}{white}
            \cs_set:Npn \kuolie@headerwrap ##1 {##1}
          }
        { soft }
          {
            \colorlet{kuolie-pagebg}{kuolie-accent!7!white}
            \cs_set:Npn \kuolie@headerwrap ##1
              {
                \begin{tcolorbox}[ enhanced, arc=3.2mm,
                    colback=white, colframe=white, boxrule=0pt,
                    left=5mm, right=5mm, top=4.5mm, bottom=4.5mm, before~skip=0pt, after~skip=2mm ]
                  ##1
                \end{tcolorbox}
              }
          }
      }
      { \ClassError{kuolie}{Unknown~cardstyle~'#1'}{Use~one~of:~flat,~soft.} }
  }

\keys_define:nn { kuolie }
  {
    accent      .code:n = { \colorlet{kuolie-accent}{kuolie-#1} } ,
    accenthex   .code:n = { \definecolor{kuolie-accent}{HTML}{#1} } ,
    divider     .code:n = { \kuolie_set_divider:n {#1} } ,
    dividertint .code:n = { \colorlet{kuolie-divider}{#1} } ,
    paper       .code:n = { \kuolie_set_paper:n {#1} } ,
    fontset     .code:n = { \kuolie_set_fontset:n {#1} } ,
    cardstyle   .code:n = { \kuolie_set_cardstyle:n {#1} } ,
    columns     .int_set:N = \l_kuolie_columns_int ,
    highlight   .int_set:N = \l_kuolie_highlight_int ,
    titlespread .fp_set:N  = \l_kuolie_spread_fp ,
    columnsep   .code:n = { \setlength{\kuolie@colsep}{#1} } ,
    pairdelim   .code:n = { \renewcommand{\kuoliepairdelim}{#1} } ,
    tagsep      .code:n = { \renewcommand{\kuoliesep}{#1} } ,
  }

% Blank lines inside the option block are a natural way to group settings, so
% strip the \par tokens they produce rather than making them a syntax error.
\tl_new:N \l_kuolie_setup_tl
\NewDocumentCommand \kuoliesetup { +m }
  {
    \tl_set:Nn \l_kuolie_setup_tl {#1}
    \tl_remove_all:Nn \l_kuolie_setup_tl { \par }
    \keys_set:no { kuolie } { \l_kuolie_setup_tl }
  }

\ExplSyntaxOff

% Defaults, applied at load time.
\kuoliesetup{cardstyle=flat, paper=a4, divider=rule, fontset=auto}
\AtBeginDocument{\pagecolor{kuolie-pagebg}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Section headings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExplSyntaxOn

% Awesome-CV tints the first three characters of a section title. Three is
% wrong for Chinese ("我推和|坑"), so the count is a setting -- default 2.
\cs_new_protected:Npn \kuolie_section_title:n #1
  {
    \group_begin:
      \xeCJKsetup{ CJKglue = \hskip \fp_to_decimal:N \l_kuolie_spread_fp em }
      \addfontfeature{ LetterSpace = \fp_to_decimal:n { \l_kuolie_spread_fp * 100 } }
      \int_compare:nNnTF { \l_kuolie_highlight_int } > { 0 }
        {
          \textcolor{kuolie-accent}
            { \tl_range:nnn {#1} { 1 } { \l_kuolie_highlight_int } }
          \textcolor{kuolie-text}
            { \tl_range:nnn {#1} { \int_eval:n { \l_kuolie_highlight_int + 1 } } { -1 } }
        }
        { \textcolor{kuolie-text} {#1} }
    \group_end:
  }

\NewDocumentCommand \kuoliesection { m }
  {
    \par \addvspace{\kuolie@sectiontopskip}
    \noindent
    \kuolie@sectionstyle{ \kuolie_section_title:n {#1} }%
    \hspace{\kuolie@dividergap}%
    \textcolor{kuolie-divider}{\kuolie@divider}%
    \par
  }

\ExplSyntaxOff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExplSyntaxOn

\tl_new:N \l_kuolie_name_tl
\tl_new:N \l_kuolie_alias_tl
\tl_new:N \l_kuolie_photo_tl
\tl_new:N \l_kuolie_photoshape_tl
\tl_new:N \l_kuolie_photoborder_tl
\tl_new:N \l_kuolie_photoalign_tl
\seq_new:N \g_kuolie_profile_seq
\bool_new:N \l_kuolie_first_bool
\bool_new:N \l_kuolie_firstrow_bool

% Dedicated dims, not \l_tmpa_dim/\l_tmpb_dim: a tikzpicture sits between the
% two header minipages and those scratch registers are shared with every
% package, so tikz clobbers the width computed for the text column.
\dim_new:N \l_kuolie_photowidth_dim
\dim_new:N \l_kuolie_htextwidth_dim

\tl_new:N \l_kuolie_photoinner_tl

\tl_set:Nn \l_kuolie_photoshape_tl  { circle }
\tl_set:Nn \l_kuolie_photoborder_tl { none }
\tl_set:Nn \l_kuolie_photoalign_tl  { left }
% Fraction of the photo column that becomes tikz's "inner sep". A circle node
% takes radius = inner sep * sqrt(2) because it circumscribes the text box, so
% the factor differs per shape; both land on a node ~0.9 of the column.
\tl_set:Nn \l_kuolie_photoinner_tl  { 0.318 }

\NewDocumentCommand \name  { m } { \tl_set:Nn \l_kuolie_name_tl  {#1} }
\NewDocumentCommand \alias { m } { \tl_set:Nn \l_kuolie_alias_tl {#1} }

% \photo[circle|rectangle, edge|noedge, left|right]{path}
\NewDocumentCommand \photo { O{} m }
  {
    \tl_set:Nn \l_kuolie_photo_tl {#2}
    \clist_map_inline:nn {#1}
      {
        \str_case:nn {##1}
          {
            { circle }
              {
                \tl_set:Nn \l_kuolie_photoshape_tl { circle }
                \tl_set:Nn \l_kuolie_photoinner_tl { 0.318 }
              }
            { rectangle }
              {
                \tl_set:Nn \l_kuolie_photoshape_tl { rectangle }
                \tl_set:Nn \l_kuolie_photoinner_tl { 0.45 }
              }
            { edge }      { \tl_set:Nn \l_kuolie_photoborder_tl { kuolie-hairline } }
            { noedge }    { \tl_set:Nn \l_kuolie_photoborder_tl { none } }
            { left }      { \tl_set:Nn \l_kuolie_photoalign_tl  { left } }
            { right }     { \tl_set:Nn \l_kuolie_photoalign_tl  { right } }
          }
      }
  }

% \profileline[icon]{tag, tag, tag}
\NewDocumentCommand \profileline { O{} m }
  { \seq_gput_right:Nn \g_kuolie_profile_seq { {#1} {#2} } }

% Join a comma list with \kuoliesep.
\cs_new_protected:Npn \kuolie_joinlist:n #1
  {
    \bool_set_true:N \l_kuolie_first_bool
    \clist_map_inline:nn {#1}
      {
        \bool_if:NTF \l_kuolie_first_bool
          { \bool_set_false:N \l_kuolie_first_bool }
          { \kuoliesep }
        ##1
      }
  }

\NewDocumentCommand \kuolietags { m } { \kuolie@notestyle{ \kuolie_joinlist:n {#1} } }

\cs_new_protected:Npn \kuolie_profile_row:nn #1#2
  {
    \tl_if_blank:nF {#1} { \kuolie@iconstyle{#1} \hspace{0.45em} }
    \kuolie_joinlist:n {#2}
  }

% Rows are plain \\-separated lines rather than a tabular, so each one honours
% the header's \centering / \raggedright the way Awesome-CV's header does.
% Needs its own flag: \kuolie_joinlist:n owns \l_kuolie_first_bool.
\cs_new_protected:Npn \kuolie_profile_rows:
  {
    \bool_set_true:N \l_kuolie_firstrow_bool
    \seq_map_inline:Nn \g_kuolie_profile_seq
      {
        \bool_if:NTF \l_kuolie_firstrow_bool
          { \bool_set_false:N \l_kuolie_firstrow_bool }
          { \\[0.9mm] }
        \kuolie_profile_row:nn ##1
      }
  }

\cs_new_protected:Npn \kuolie_draw_photo:
  {
    \tl_if_empty:NF \l_kuolie_photo_tl
      {
        \begin{tikzpicture}
          % Sized off \linewidth (the photo column) rather than a fixed cm
          % value, so the avatar scales with the paper size.
          \node[ \l_kuolie_photoshape_tl, draw = \l_kuolie_photoborder_tl,
                 line~width = 0.3mm,
                 inner~sep = \l_kuolie_photoinner_tl \linewidth,
                 fill~overzoom~image = \l_kuolie_photo_tl ] () {};
        \end{tikzpicture}
      }
  }

% \makekuolieheader[C|L|R]
\NewDocumentCommand \makekuolieheader { O{C} }
  {
    \kuolie@headerwrap
      {
        % \linewidth, not \textwidth: cardstyle=soft puts this inside a
        % tcolorbox whose content is narrower than the page text block.
        \dim_zero:N \l_kuolie_photowidth_dim
        \tl_if_empty:NTF \l_kuolie_photo_tl
          { \dim_set:Nn \l_kuolie_htextwidth_dim { \linewidth } }
          {
            \dim_set:Nn \l_kuolie_photowidth_dim { 0.26\linewidth }
            \dim_set:Nn \l_kuolie_htextwidth_dim { 0.74\linewidth }
          }
        \noindent
        \str_if_eq:eeT { \l_kuolie_photoalign_tl } { left }
          {
            \begin{minipage}[c]{\l_kuolie_photowidth_dim} \raggedright \kuolie_draw_photo: \end{minipage}
          }
        \begin{minipage}[c]{\l_kuolie_htextwidth_dim}
          \str_case:nn {#1}
            { { L } { \raggedright } { R } { \raggedleft } { C } { \centering } }
          \kuolie@namestyle{ \l_kuolie_name_tl }
          \tl_if_empty:NF \l_kuolie_alias_tl
            { \\[1.2mm] \kuolie@aliasstyle{ \l_kuolie_alias_tl } }
          \seq_if_empty:NF \g_kuolie_profile_seq
            {
              \\[2.6mm]
              \kuolie@profilestyle{ \kuolie_profile_rows: }
            }
        \end{minipage}
        \str_if_eq:eeT { \l_kuolie_photoalign_tl } { right }
          {
            \begin{minipage}[c]{\l_kuolie_photowidth_dim} \raggedleft \kuolie_draw_photo: \end{minipage}
          }
        \par
      }
    \par \addvspace{2mm}
  }

\ExplSyntaxOff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  pairlist -- the two-column "作品 - 角色" block
%
%  Items fill column-major (down the left column first), which is how the
%  original hand-made cards read. Left column takes the extra item when the
%  count is odd.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExplSyntaxOn

\seq_new:N \g_kuolie_pairs_seq
\int_new:N \l_kuolie_paircount_int
\int_new:N \l_kuolie_percol_int
\int_new:N \l_kuolie_gaps_int
\int_new:N \l_kuolie_from_int
\int_new:N \l_kuolie_to_int
\dim_new:N \l_kuolie_colwidth_dim

\NewDocumentCommand \pair { m m }
  { \seq_gput_right:Nn \g_kuolie_pairs_seq { {#1} {#2} } }

\cs_new_protected:Npn \kuolie_pair_line:nn #1#2
  {
    \kuolie@pairkeystyle{#1}
    \tl_if_blank:nF {#2} { \kuoliepairdelim \kuolie@pairvalstyle{#2} }
    \par \vskip \kuolie@pairsep
  }

\cs_new_protected:Npn \kuolie_render_column:n #1
  {
    \int_set:Nn \l_kuolie_from_int { ( #1 - 1 ) * \l_kuolie_percol_int + 1 }
    \int_set:Nn \l_kuolie_to_int   { #1 * \l_kuolie_percol_int }
    \seq_map_indexed_inline:Nn \g_kuolie_pairs_seq
      {
        \int_compare:nT { \l_kuolie_from_int <= ##1 <= \l_kuolie_to_int }
          { \kuolie_pair_line:nn ##2 }
      }
  }

\cs_new_protected:Npn \kuolie_render_pairs:
  {
    \int_set:Nn \l_kuolie_paircount_int { \seq_count:N \g_kuolie_pairs_seq }
    \int_compare:nNnT { \l_kuolie_paircount_int } > { 0 }
      {
        % ceil(n / columns) -- note \int_eval's "/" rounds, so truncate
        % explicitly or 8 items across 2 columns would split 5/3.
        \int_set:Nn \l_kuolie_percol_int
          {
            \int_div_truncate:nn
              { \l_kuolie_paircount_int + \l_kuolie_columns_int - 1 }
              { \l_kuolie_columns_int }
          }
        \int_set:Nn \l_kuolie_gaps_int { \l_kuolie_columns_int - 1 }
        \dim_set:Nn \l_kuolie_colwidth_dim
          {
            ( \linewidth - \kuolie@colsep * \l_kuolie_gaps_int )
            / \l_kuolie_columns_int
          }
        \par \noindent
        \int_step_inline:nn { \l_kuolie_columns_int }
          {
            \begin{minipage}[t]{\l_kuolie_colwidth_dim}
              \raggedright
              \kuolie_render_column:n {##1}
            \end{minipage}
            \int_compare:nNnT {##1} < { \l_kuolie_columns_int }
              { \hspace{\kuolie@colsep} }
          }
        \par
      }
  }

\NewDocumentEnvironment{pairlist}{}
  {
    \seq_gclear:N \g_kuolie_pairs_seq
    \par \addvspace{\kuolie@contenttopskip}
    \setlength{\parskip}{0pt}\setlength{\parindent}{0pt}
    \ignorespaces
  }
  { \par \kuolie_render_pairs: \vskip -\kuolie@pairsep }

\ExplSyntaxOff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Notes, bullet lists, closing line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Small grey run-on paragraph, used under a pairlist.
\newcommand{\kuolienote}[1]{%
  \par\addvspace{1.6mm}%
  {\noindent\kuolie@notestyle{#1}\par}%
  \addvspace{0.6mm}}

\newenvironment{kuolieitems}{%
  \par\addvspace{\kuolie@contenttopskip}%
  \kuolie@itemstyle
  \begin{itemize}[leftmargin=1.5em, labelsep=0.6em, topsep=0pt, partopsep=0pt,
                  parsep=0pt, itemsep=\kuolie@itemsep]
  \renewcommand{\labelitemi}{\textcolor{kuolie-accent}{\raisebox{0.32ex}{\scalebox{0.34}{\faCircle}}}}%
}{%
  \end{itemize}\par\addvspace{1mm}}

\newcommand{\kuolieclosing}[1]{%
  \par\addvspace{3.5mm}%
  {\centering\kuolie@closingstyle{#1}\par}%
  \addvspace{1mm}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Footer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{empty}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\newcommand*{\makekuoliefooter}[3]{%
  \pagestyle{fancy}\fancyhf{}%
  \fancyfoot[L]{\kuolie@footerstyle{#1}}%
  \fancyfoot[C]{\kuolie@footerstyle{#2}}%
  \fancyfoot[R]{\kuolie@footerstyle{#3}}%
  \thispagestyle{fancy}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Document-wide defaults
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\parindent}{0pt}
\raggedbottom
\AtBeginDocument{\color{kuolie-text}\kuoliebodyfontlight}

\endinput
