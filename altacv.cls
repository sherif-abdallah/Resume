%%%%%%%%%%%%%%%%%
% This is altacv.cls (v1.7.1, 25 Aug 2023) written by
%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%%
%%
% Contributions:

%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{altacv}[2023/08/25 AltaCV v1.7.1, yet another alternative class for a resume/curriculum vitae.]

%% v1.1: Optionally load academicons
%% v1.4: Nope, academicons is unnecessary; fontawesome5 has \faOrcid.
\DeclareOption{academicons}{\ClassWarning{altacv}{academicons option is now obsolete and unnecessary.}}
%% v1.1.3: Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\newif\if@raggedtwoe
\DeclareOption{ragged2e}{\@raggedtwoetrue}
%% v1.3: load hyperref for clickable hyperlinks
\newif\if@withhyper
\DeclareOption{withhyper}{\@withhypertrue}
\ProcessOptions\relax

\LoadClass{extarticle}
%% v1.3.2 Hopefully this helps make the PDF
%% file more 'friendly' with copy-paste etc
\RequirePackage{etoolbox}
\RequirePackage[a-1b]{pdfx}
\RequirePackage{accsupp}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage[fixed]{fontawesome5}
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{scrlfile}
\RequirePackage{xparse}

%% v1.1.5: added for convenience
\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\ifxetexorluatex
  \RequirePackage{fontspec}
\else
  %% v1.3.2 attempts to make ligatures
  %% copy-paste as normal characters
  \RequirePackage{cmap}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[T1]{fontenc}
  \input{glyphtounicode}
  \pdfglyphtounicode{f_f}{FB00}
  \pdfglyphtounicode{f_f_i}{FB03}
  \pdfglyphtounicode{f_f_l}{FB04}
  \pdfglyphtounicode{f_i}{FB01}
  \pdfgentounicode=1
\fi

\if@raggedtwoe
  \RequirePackage[newcommands]{ragged2e}
\fi

\if@withhyper
  \AtBeginDocument{%
    \hypersetup{hidelinks}
    \urlstyle{same}
  }
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{emphasis}{black}
\colorlet{heading}{black}
\colorlet{headingrule}{black}
\colorlet{subheading}{emphasis}
\colorlet{body}{black!80!white}
\colorlet{name}{heading}
\colorlet{tagline}{accent}
% Renamed or added v1.7
\newcommand{\cvItemMarker}{{\small\textbullet}}
\newcommand{\cvRatingMarker}{\faCircle}
\let\itemmarker\cvItemMarker      % for backward compatibility
\let\ratingmarker\cvRatingMarker  % for backward compatibility
\newcommand{\cvDateMarker}{\faCalendar[regular]}
\newcommand{\cvLocationMarker}{\faMapMarker}
\newcommand{\locationname}{Location}
\newcommand{\datename}{Date}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage[inline]{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vspace{0.25\baselineskip}}
\setlist[itemize]{label=\cvItemMarker}
\RequirePackage{graphicx}
\RequirePackage{trimclip}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
  {\end{adjustwidth}}

%% v1.3.1 \detokenize will break UTF-8 in pdflatex
\newcommand{\utffriendlydetokenize}[1]{%
\scantokens{%
  \catcode`\_=12%
%   \catcode`\^=12%
%   \catcode`\{=12%
%   \catcode`\}=12%
  \catcode`\&=12%
  \catcode`\$=12%
  \catcode`\#=12%
  \catcode`\~=12%
%   \catcode`\\=12%
  {#1}%
}%
}
%% v1.3: Incorporating hyperlinks
%% v1.3.1: using \unfriendlydetokenize to avoid breaking unicode
%% v1.6: Use accsupp so that when copying/pasting the icon from PDF to a text
%%       file, the icon name is pasted
%% v1.7: Some tweaks/corrections so that accsupp is for icons only
%% v1.7.1: Bugfix to support some symbol commands e.g. academicons commands 
\ExplSyntaxOn
\NewDocumentCommand{\printinfo}{m m o}{%
  \IfNoValueTF{#3}{%
    \mbox{\textcolor{accent}%
    {\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
    ~\utffriendlydetokenize{#2}\hspace{2em}}%
  }{%
     \if@withhyper%
      \mbox{\textcolor{accent}%
      {\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
      ~\href{#3}{\utffriendlydetokenize{#2}}\hspace{2em}}
     \else%
       \ClassWarning{Please specify [withhyper] option to enable hyperlinks. Printing out full hyperlink prefix #1 for now.}%
      \mbox{\textcolor{accent}
      {\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
      ~{\utffriendlydetokenize{#3#2}}\hspace{2em}}%
     \fi%
  }%
}%


%% v1.3: Exploring convenient creation of fields
%% v1.6: Add starred mode to create \printinfo with full URL
\NewDocumentCommand{\NewInfoField}{s m m o}{%
  \IfBooleanF{#1}{
    \IfNoValueF{#4}{\csdef{#2 hyperprefix}{#4}}%
  }
  \csdef{#2 symbol}{#3}%
  \IfBooleanTF{#1}
    { \csdef{#2}##1##2{%
        \if@withhyper
          \IfNoValueTF {##2}
            {\printinfo{\csuse{#2 symbol}}{##1}}%
            {\printinfo{\csuse{#2 symbol}}{##1}[##2]}%
        \else
          \printinfo{\csuse{#2 symbol}}{##1}%
        \fi%
      }%
    }
    { \csdef{#2}##1{%
        \if@withhyper
          \IfNoValueTF {#4}
            {\printinfo{\csuse{#2 symbol}}{##1}}%
            {\printinfo{\csuse{#2 symbol}}{##1}[\csuse{#2 hyperprefix}##1]}%
        \else
          \printinfo{\csuse{#2 symbol}}{##1}%
        \fi%
      }%
    }
}
\ExplSyntaxOff

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}
\NewInfoField{email}{\faAt}[mailto:]
\NewInfoField{mailaddress}{\faEnvelope}
\NewInfoField{phone}{\faPhone}[tel:]
\NewInfoField{homepage}{\faGlobe}[https://]
\NewInfoField{twitter}{\faTwitter}[https://twitter.com/]
\NewInfoField{linkedin}{\faLinkedin}[https://linkedin.com/in/]
\NewInfoField{github}{\faGithub}[https://github.com/]
% v1.?? Use fontawesome5 for Orcid symbol
\NewInfoField{orcid}{\faOrcid}[https://orcid.org/]
\NewInfoField{location}{\cvLocationMarker}

% v1.2: Support for multiple photos
\newlength{\altacv@photos@width}
\newlength{\altacv@photo@diam@left}
\newlength{\altacv@photo@diam@right}
\def\altacv@left@photos{}
\def\altacv@right@photos{}

\newcommand{\@makeaphoto}[2]{%
  \begin{minipage}{#1}%
    \if@normalphoto
      \includegraphics[width=\linewidth]{#2}
    \else
      \tikz\path[fill overzoom image={#2}]circle[radius=0.5\linewidth];
    \fi%
  \end{minipage}%
}

\newcommand{\altacv@add@photo@left}[1]{%
  \appto{\altacv@left@photos}{%
    \@makeaphoto{\altacv@photo@diam@left}{#1}\hspace{1ex}%
  }%
  \addtolength{\altacv@photos@width}{\altacv@photo@diam@left}%
  \addtolength{\altacv@photos@width}{1ex}%
}
\newcommand{\altacv@add@photo@right}[1]{%
  \appto{\altacv@right@photos}{%
    \@makeaphoto{\altacv@photo@diam@right}{#1}\hspace{1ex}%
  }%
  \addtolength{\altacv@photos@width}{\altacv@photo@diam@right}%
  \addtolength{\altacv@photos@width}{1ex}%
}
\newcommand{\photoL}[2]{%
  \setlength{\altacv@photo@diam@left}{#1}%
  \forcsvlist{\altacv@add@photo@left}{#2}%
}
\newcommand{\photoR}[2]{%
  \setlength{\altacv@photo@diam@right}{#1}%
  \forcsvlist{\altacv@add@photo@right}{#2}%
}
\let\photo\photoR

\newcommand{\namefont}{\Huge\bfseries}
\newcommand{\taglinefont}{\large\bfseries}
\newcommand{\personalinfofont}{\footnotesize\bfseries}
\newcommand{\cvsectionfont}{\LARGE\bfseries}
\newcommand{\cvsubsectionfont}{\large\bfseries}

\newcommand{\makecvheader}{%
  \begingroup
    \altacv@left@photos\hfill%
    \begin{minipage}{\dimexpr\linewidth-\altacv@photos@width}%
    \raggedright%
    {\namefont\color{name}\MakeUppercase{\@name}\par}
    \medskip
    {\taglinefont\color{tagline}\@tagline\par}
    \medskip
    {\personalinfofont\@personalinfo\par}
    \end{minipage}\hfill%
    \altacv@right@photos\par%
  \endgroup\medskip
}

\renewenvironment{quote}{\color{accent}\itshape\large}{\par}

\newcommand{\cvsection}[2][]{%
  \nointerlineskip\bigskip%  %% bugfix in v1.6.2
  \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}%
  {\color{heading}\cvsectionfont\MakeUppercase{#2}}\\[-1ex]%
  {\color{headingrule}\rule{\linewidth}{2pt}\par}\medskip
}

\newcommand{\cvsubsection}[1]{%
  \smallskip%
  {\color{subheading}\cvsubsectionfont{#1}\par}\medskip
}

% v1.1.4: fixes inconsistent font size
% v1.7: adds accsupp ActualText for location and date markers
\newcommand{\cvevent}[4]{%
  {\large\color{emphasis}#1\par}
  \smallskip\normalsize
  \ifstrequal{#2}{}{}{
  \textbf{\color{accent}#2}\par
  \smallskip}
  \ifstrequal{#3}{}{}{%
    {\small\makebox[0.5\linewidth][l]%
      {\BeginAccSupp{method=pdfstringdef,ActualText={\datename:}}\cvDateMarker\EndAccSupp{}%
      ~#3}%
    }}%
  \ifstrequal{#4}{}{}{%
    {\small\makebox[0.5\linewidth][l]%
      {\BeginAccSupp{method=pdfstringdef,ActualText={\locationname:}}\cvLocationMarker\EndAccSupp{}%
        ~#4}%
    }}\par
  \medskip\normalsize
}

% v1.7: adds accsupp for the icon as well
\newcommand{\cvachievement}[3]{%
  \begin{tabularx}{\linewidth}{@{}p{2em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
  \multirow{2}{*}{\Large\color{accent}\BeginAccSupp{method=escape,ActualText={#1: }}#1\EndAccSupp{}} & \bfseries\textcolor{emphasis}{#2}\\
  & #3
  \end{tabularx}%
  \smallskip
}

\newcommand{\cvtag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{#1};
}

% v1.6: Use accsupp so that the actual numeric value is copied/pasted
%       and also support 0.5, 1.5, 2.5, 3.5, 4.5
\newcommand{\cvskill}[2]{%
  \textcolor{emphasis}{\textbf{#1}}\hfill
  \BeginAccSupp{method=plain,ActualText={#2}}
  \foreach \x in {1,...,5}{%
    \ifdimequal{\x pt - #2 pt}{0.5pt}%
    {\clipbox*{0pt -0.25ex {.5\width} {\totalheight}}{\color{accent}\cvRatingMarker}%
     \clipbox*{{.5\width} -0.25ex {\width} {\totalheight}}{\color{body!30}\cvRatingMarker}}
    {\ifdimgreater{\x bp}{#2 bp}{\color{body!30}}{\color{accent}}\cvRatingMarker}%
  }\EndAccSupp{}\par%
}

\newcommand{\wheelchart}[4][0]{%
    \begingroup\centering
    \def\innerradius{#3}%
    \def\outerradius{#2}%
    % Calculate total
    \pgfmathsetmacro{\totalnum}{0}%
    \foreach \value/\colour/\name in {#4} {%
        \pgfmathparse{\value+\totalnum}%
        \global\let\totalnum=\pgfmathresult%
    }%
    \begin{tikzpicture}

      % Calculate the thickness and the middle line of the wheel
      \pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
      \pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}
      \pgfmathsetmacro{\totalrot}{-90 + #1}

      % Rotate so we start from the top
      \begin{scope}[rotate=\totalrot]

      % Loop through each value set. \cumnum keeps track of where we are in the wheel
      \pgfmathsetmacro{\cumnum}{0}
      \foreach \value/\width/\colour/\name in {#4} {
            \pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}

            % Calculate the percent value
            \pgfmathsetmacro{\percentage}{\value/\totalnum*100}
            % Calculate the mid angle of the colour segments to place the labels
            \pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}

            % This is necessary for the labels to align nicely
            \pgfmathparse{
               (-\midangle>180?"west":"east")
            } \edef\textanchor{\pgfmathresult}
            \pgfmathparse{
               (-\midangle>180?"flush left":"flush right")
            } \edef\textalign{\pgfmathresult}
            \pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}

            % Draw the color segments. Somehow, the \midrow units got lost, so we add 'pt' at the end. Not nice...
            \filldraw[draw=white,fill=\colour] (-\cumnum:\outerradius) arc (-\cumnum:-(\newcumnum):\outerradius) --
            (-\newcumnum:\innerradius) arc (-\newcumnum:-(\cumnum):\innerradius) -- cycle;

            % Draw the data labels
            % v1.6: Use accsupp so that the numeric number is copied/pasted too
            \draw  [*-,thin,emphasis] node [append after command={(\midangle:\midradius pt) -- (\midangle:\outerradius + 1ex) -- (\tikzlastnode)}] at (\midangle:\outerradius + 1ex) [xshift=\labelshiftdir*0.5cm,inner sep=1ex, outer sep=0pt, text width=\width,anchor=\textanchor,align=\textalign,font=\small,text=body]{\BeginAccSupp{method=pdfstringdef,ActualText={\name: \value}}\name\EndAccSupp{}};
            % Set the old cumulated angle to the new value
            \global\let\cumnum=\newcumnum
        }
      \end{scope}
%      \draw[gray] (0,0) circle (\outerradius) circle (\innerradius);
    \end{tikzpicture}\par
    \endgroup
}

\newcommand{\cvref}[3]{%
  \smallskip
  \textcolor{emphasis}{\textbf{#1}}\par
  \begin{description}[font=\color{accent},style=multiline,leftmargin=1.35em,align=left]
  \item[\small\normalfont\emailsymbol] #2
  \item[\small\normalfont\mailaddresssymbol] #3
  \end{description}
%   \medskip
}

\newenvironment{cvcolumn}[1]{\begin{minipage}[t]{#1}\raggedright}{\end{minipage}}

% v1.5 Move biblatex-related code to separate .cfg file
% so that it's easier to change and customise the style for
% publication lists

% v1.1.2: make it easier to add a sidebar aligned with top of next page
\RequirePackage{afterpage}
\newcommand{\addsidebar}[2][]{\marginpar{%
  \ifstrequal{#1}{}{}{\vspace*{#1}}%
  \input{#2}}%
}
\newcommand{\addnextpagesidebar}[2][]{\afterpage{\addsidebar[#1]{#2}}}

% v1.6.5 But provide for ability to highlight names in publication list
\RequirePackage{pgffor}
\def\my@namelist{}
\newcommand{\mynames}[1]{\def\my@namelist{#1}}
\newtoggle{boldname}
\AddToHook{package/biblatex/after}{
\renewcommand*{\mkbibnamefamily}[1]{%
  \global\togglefalse{boldname}%
  \foreach \my@fname / \my@gname in \my@namelist {%
    \ifboolexpr{ test {\ifdefstrequal{\namepartfamily}{\my@fname}}
                 and
                 test {\ifdefstrequal{\namepartgiven}{\my@gname}}}
      {\global\toggletrue{boldname}}{}%
  }%
  \iftoggle{boldname}{\textbf{#1}}{#1}%
}

\renewcommand*{\mkbibnamegiven}[1]{%
  \global\togglefalse{boldname}%
  \foreach \my@fname / \my@gname in \my@namelist{%
    \ifboolexpr{ test {\ifdefstrequal{\namepartfamily}{\my@fname}}
                 and
                 test {\ifdefstrequal{\namepartgiven}{\my@gname}}}
      {\global\toggletrue{boldname}\breakforeach}{}%
  }%
  \iftoggle{boldname}{\textbf{#1}}{#1}%
}
}

\AddToHook{begindocument/before}{%
  \pagestyle{empty}
  \color{body}
  \raggedright
}