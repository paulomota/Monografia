%%
%% File    : cic_unb.cls   (LaTeX2e class file)
%% Authors : José Carlos L. Ralha and Flávio Maico Costa
%% Version : 0.75 beta
%% Updates : 0.5  [?/11/2004]  - initial release. don't remember the day.
%%         : 0.75 [04/04/2005] - fixed font problems, UnB logo
%%                resolution, keywords and palavras-chave hyphenation
%%                and generation problems, and a few other problems.
%%         : 0.80 [08/01/2006] - Corrigido o problema causado por
%%                bancas com quatro membros. O quarto membro agora é 
%%                OPCIONAL.
%%                             - Foi criado um novo comando chamado
%%                               bibliografia. Esse comando tem dois
%%                               argumentos onde o primeiro especifica
%%                               o nome do arquivo de referencias
%%                               bibliograficas e o segundo argumento
%%                               especifica o formato. Como efeito
%%                               colateral, as referências aparecem no
%%                               sumário. 
%%
%%
%% This file contains a class definition, cic_unb, for the LaTeX2e
%% system which defines the layout of graduate and undergraduate
%% monographs  which are submitted in
%% the Department of Computer Science at the University of Brasilia.
%% The class was built on top of csthesis.cls.
%%
%%
%%    File : csthesis.cls    (LaTeX2e class file)
%%  Author : Martin Reddy (mxr@dcs.ed.ac.uk) 
%% Version : 2.0
%% Updates : 1.0 [9/11/95] - initial release.
%%           1.1 [24/4/96] - fixed bibliography bug caused by new report.cls 
%%           1.2 [13/5/96] - \dedication & \thesiscaption[]
%%           1.3 [28/5/96] - abbrevs, parskip, minitoc fix, \headfootstyle
%%           1.4 [12/7/96] - appendices okay now, \cleardoublepage's added
%%           1.45 [6/8/96] - added space between chapter & numb on toc
%%           1.5 [13/8/96] - tailmargin was too small by 0.7cm!!
%%           2.0 [20/9/96] - \SetPrinter for margin settings (default=hp24)
%%                           no header, more abbreviations
%% 
%% This file contains a class definition, csthesis, for the LaTeX2e
%% system which defines the layout of theses which are submitted in
%% the Department of Computer Science at the University of Edinburgh.
%%
%% For information on this class, please refer to "texdoc csthesis"
%%

\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{cic_unb}[2004/10/08  v1.01 Classe para  monografias CIC
UnB]

%%
%% --- Initial Code ---
%%

\RequirePackage{ifthen}
\RequirePackage{vmargin}
\RequirePackage{graphicx}
%\RequirePackage{calc}


\newcommand{\degreetext}{}
\newcommand{\department}{Departamento de Ci\^{e}ncia da %
  Computa\c{c}\~{a}o (CIC)}
\newcommand{\university}{Universidade de Bras\'{\i}lia}
\newcommand{\@chapteralignment}{\centering}
\newcommand{\draftmessage}{}
\newboolean{draftthesis}
\newboolean{usequotemarks}
\newboolean{usesinglespacing}
\newboolean{usedoublespacing}
\newboolean{usefullspacing}
\newboolean{usedeptreport}
\newboolean{useabbrevs}


%%
%%  --- Options ---
%%
%%  Current options: phd, mphil, msc, bsc, deptreport
%%                   draft
%%                   usequotes
%%                   singlespacing, doublespacing, fullspacing
%%                   centerchapter, leftchapter, rightchapter,
%%                   + all report.cls options
%%




\newboolean{mestrado}
\newboolean{bacharelado}
\newboolean{licenciatura}

\def\prof{\@ifnextchar[%
             {\@prof@}%
             {\@prof}}

\def\@prof@[#1]#2{\setbox0=\hbox{\scriptsize \b{a}}%
                  \setbox1=\hbox{r}%
                  Prof\hskip.05em\raise\ht1\hbox{\usebox0}\kern-\wd0. #2}

\def\@prof#1{Prof. #1}

\def\dr{\@ifnextchar[%
             {\@dra@}%
             {\@dr}}

\def\@dra@[#1]#2{\setbox0=\hbox{\scriptsize \b{a}}%
                  \setbox1=\hbox{r}%
                  Dr\hskip.05em\raise\ht1\hbox{\usebox0}\kern-\wd0. #2}

\def\@dr#1{Dr. #1}

\DeclareOption{mestrado}{\setboolean{mestrado}{true}%
                     \renewcommand{\degreetext}{Mestrado}}

\DeclareOption{bacharelado}{\setboolean{bacharelado}{true}%
                     \renewcommand{\degreetext}{Bacharelado}}

\DeclareOption{licenciatura}{\setboolean{licenciatura}{true}%
                    \renewcommand{\degreetext}{Licenciatura}}

\def\capas{\capa\cip}

\newcommand\logo{
	\includegraphics[scale=.20]{unb_logo}\\
	\vspace{.5\baselineskip}
	{\Large Universidade de Bras\'{\i}lia}\\
	{\Large Instituto de Ci\^encias Exatas}\\
	{\Large Departamento de Ci\^encia da Computa\c{c}\~ao}\\
}

\newcommand\capa{%
  \begin{paginatitulo}%
       \begin{center}%
             \logo
             \null\vfill%
             \textbf{\Large \@title} \par%
             \vfill%
             {\large \@author}%
             \vfill%
             Monografia apresentada como %
             requisito parcial\\ para conclus\~ao do\  %
             \ifthenelse{\boolean{bacharelado}}%
                {Bacharelado em Ci\^encia da Computa\c{c}\~ao}%
                {\ifthenelse{\boolean{licenciatura}}
                   {Curso de Computa\c{c}\~ao -- Licenciatura}
                   {Mestrado em Inform\'atica}}
            \vfill%
            {\@sexoorientador\\ \@nomeorientador\\%
             \ifthenelse{\boolean{co@ori@}}%
                 {\vskip 1cm\@sexocoorientador\\%
                  \@nomecoorientador}%
                 {\relax}}%ramo else
            \vfill%
            {\large Bras\'{\i}lia}\\
            {\large \@ano}%
       \end{center}%
  \end{paginatitulo}%
}

\newboolean{quartomembro}\setboolean{quartomembro}{false}
\def\membroum#1#2{\def\@nomeum{#1}\def\@filium{#2}}
\def\membrodois#1#2{\def\@nomedois{#1}\def\@filidois{#2}}
\def\membrotres#1#2{\setboolean{quartomembro}{true}%
                    \def\@nometres{#1}%
                    \def\@filitres{#2}}


\newcommand\folhaaprovacao{%
  \begin{paginatitulo}%
       \begin{center}%
						 \logo
             \null\vfill%
             \textbf{\Large \@title} \par%
             \vfill%
             {\large \@author}%
             \vfill%
             Monografia apresentada como %
             requisito parcial\\ para conclus\~ao do\  %
             \ifthenelse{\boolean{bacharelado}}%
                {Bacharelado em Ci\^encia da Computa\c{c}\~ao}%
                {\ifthenelse{\boolean{licenciatura}}
                   {Curso de Computa\c{c}\~ao -- Licenciatura}
                   {Mestrado em Inform\'atica}}
            \vfill%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            {\begin{center}%já contempla as bancas de mestrado!
                \@nomeorientador\ (\@sexoorientador)\\
                \@filiorientador\\[1cm]
                
                \begin{tabular}{c c}
                \@nomeum & \@nomedois\\
                \@filium\ & \@filidois\\[1cm]
                \end{tabular}\\
                \ifthenelse{\boolean{quartomembro}}%
                 {\@nometres\\%%%%
                  \@filitres\\[1cm]}
                 {\relax}%%%bosta
                \@nomecoordenador\\
                \@sexocoordenador \ do %
                  \ifthenelse{\boolean{bacharelado}}%
                    {Bacharelado em Ci\^encia da Computa\c{c}\~ao}%
                    {\ifthenelse{\boolean{licenciatura}}
                      {Curso de Computa\c{c}\~ao -- Licenciatura}
                      {Mestrado em Inform\'atica}}
             \end{center}
            }%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            \vfill%
            {\large Bras\'{\i}lia, \@dia\ de \@mes\ de \@ano}
       \end{center}%
  \end{paginatitulo}%
}


\def\cip{%
   \begin{paginatitulo}\noindent%
         Universidade de Bras\'{\i}lia -- UnB\\
         Instituto de Ci\^{e}ncias Exatas\\
         Departamento de Ci\^encia da Computa\c{c}\~ao\\
         \ifthenelse{\boolean{bacharelado}}%
            {Curso de Bacharelado em Ci\^encia da Computa\c{c}\~ao}
            {\ifthenelse{\boolean{licenciatura}}%
                {Curso de Computa\c{c}\~ao -- Licenciatura}
                {Mestrado em Inform\'atica}}%
         \\\vfill\noindent%
         \@sexocoordenador: \@nomecoordenador\\
         \vfill\noindent%
         Banca examinadora composta por:\par\vskip 2mm%
          \indent\ifthenelse{\boolean{quartomembro}}%
                 {\begin{tabular}{l}%
                      \@nomeorientador\
                        (\@sexoorientador) -- \@filiorientador\\ 
                       \@nomeum\ -- \@filium\\
                      \@nomedois\ -- \@filidois\\
                      \@nometres\ -- \@filitres
                  \end{tabular}}%
                 {\begin{tabular}{l}%
                      \@nomeorientador\ % 
                        (\@sexoorientador) -- \@filiorientador\\
                      \@nomeum\ -- \@filium\\
                      \@nomedois\ -- \@filidois
                  \end{tabular}}%
          \vfill\noindent%
          \textbf{CIP -- Cataloga\c{c}\~{a}o Internacional na
          Publica\c{c}\~{a}o}%
          \vskip 15pt
          \@quadrado%
          \vfill\noindent%
          \begin{tabular}{ll}%
          Endere\c{c}o: & Universidade de Bras\'{\i}lia\\
          & Campus Universit\'{a}rio Darcy Ribeiro -- Asa Norte\\
          & CEP 70910--900 \\ & Bras\'{\i}lia -- DF -- Brasil
          \end{tabular}
  \end{paginatitulo}
}%fim do comando cip



\def\cipauthor{\ifthenelse{\boolean{mestrado}}
                  {\@ifnextchar[%]%Se o pentelho entrar mais de um autor
                     {\@discard@options}% então o sistema elimina o opcional!
                     {\@cip@single@author}}% Mestrado só admite um autor.
                  {\@ifnextchar[%]Não é mestrado; pode ter até dois autores.
                    {\@cip@second@author}%%% Existe um segundo autor!
                    {\@cip@single@author}}}%% Esta é obra de um único autor.

\newboolean{umautor}
\setboolean{umautor}{true}

\def\@cip@single@author#1#2{%%%
             \def\autorum{#2,\ #1}%% Único autor em ordem Nome, Prenome
             \def\autordois{#2,\ #1}%%
             \def\autortres{#1\ #2}%%% Único autor em ordem Prenome Nome
             \author{#1\ #2}}

\def\@cip@second@author[#1][#2]#3#4{\setboolean{umautor}{false}%
         \def\autorum{#2,\ #1}%% Autor secundário em ordem Nome, Prenome
         \def\autordois{#4,\ #3}%% Autor principal em ordem Nome, Prenome
         \def\autortres{#3\ #4} %% 
         \def\autorquatro{#1\ #2}%
         \author{#3\ #4\\ #1\ #2}%
}

\def\@discard@options[#1][#2]{\@cip@single@author}
 
\def\figuras{\listoffigures}
\def\tabelas{\listoftables}
\def\sumario{\tableofcontents}
\def\contracapa{\cip}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{paginatitulo}
    {\cleardoublepage%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      %\addtocounter{page}\@ne%descomente esta linha pra contar de 3
      %%%%%%%%%%%%%%%%%%%%%%%%%em 3!
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else 
        %\addtocounter{page}\@ne% VIDE ACIMA
     \fi
    }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtBeginDocument{%%%
                 \IfFileExists{\jobname.pgn}%%%%%%%%%%%%
                    {\relax}%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
                    {\@starttoc{pgn}}}%%%%%%%%%%%%%%%%%%


\AtEndDocument{\IfFileExists{\jobname.pgn}%%%%%%%%%%%%%%
                 {\openout14=\jobname.pgn%%%%%%%%%%%%%%%
                  \write14{\thepage}%%%%%%%%%%%%%%%%%%%%
                  \closeout14}%%%%%%%%%%%%%%%%%%%%%%%%%%
                 {\relax}}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@quadrado{\framebox{\openin14=\jobname.pgn\read14to\ppgge%
       \begin{tabular}{l}%
         \autortres.\\ \null\\ %
         \quad\parbox{13cm}{\@title / %
                     \ifthenelse{\boolean{umautor}}%
                               {\autortres}%
                               {\autorquatro, \autortres}.%
                     \ Bras\'{\i}lia\ :\ UnB, \@ano.}\\ 
         \quad{}\parbox{13cm}{\ppgge p. : il. ; 29,5 cm.}\\ 
                 \null\\%corrigir
         \quad{}\ifthenelse{\boolean{mestrado}}%
                    {Tese (Mestre) -- Universidade de Bras\'{\i}lia, %
                       Bras\'{\i}lia, \@ano.}%
                    {Monografia (Gradua\c{c}\~ao) -- Universidade de % ,m
                       Bras\'{\i}lia, Bras\'{\i}lia, \@ano.}\\\null\\%
         \quad{}\parbox{13cm}{\numerarcip{\@palavraschave}}%
                    \null\\\null\\
          CDU 004 
       \end{tabular}}}

%numera as palavras-chave para o CIP
\def\numerarcip#1{
	\newcounter{cipcount} \edef\more{#1}
  \begin{flushleft}%
  \ifx\more\empty\else\expandafter\numerarcipr\more,\@nil\fi
  \end{flushleft}%
}
\def\numerarcipr#1,#2\@nil{
	\stepcounter{cipcount} \def\more{#2}
	\thecipcount.~#1\ifx\more\empty\else,\numerarcipr#2\@nil\fi
}

\newenvironment{resumo}
   {\begin{paginatitulo}\null\vspace{1cm}%
       \begin{center}  \bfseries\itshape \LARGE \abstractname
       \end{center}}
       {\vskip 15pt\noindent\textbf{Palavras-chave:}\ \@palavraschave%
    \end{paginatitulo}}

\def\@palavraschave#1{\gdef\@@keys{#1}\par\vfil\null}
\def\@@keys#1{\noexpand\@palavraschave{#1}}
\def\palavraschave#1{\gdef\@palavraschave{#1}}

\def\@pc@kw#1{\gdef\@pc\par\vfil\null\endpaginatitulo}

\def\@pc{\@ifnextchar[%]
          {\@first@kw}%
          {\@finish@kw}}%%%

\newbox\cxone\newbox\cxtwo\newbox\cxthree
\newbox\cxfour\newbox\cxfive\newbox\cx
\newcounter{kwds}\setcounter{kwds}{0}
\newcounter{aux}\setcounter{aux}{0}

\def\@first@kw[#1]{\setbox\cxone=\hbox{#1}\setcounter{kwds}{1}%
                   \@rem@one@kw}
\def\@rem@one@kw{\@ifnextchar[%]
          {\@second@kw}{}}%
\def\@second@kw[#1]{\setbox\cxtwo=\hbox{#1}\setcounter{kwds}{2}%
                    \@rem@two@kw}
\def\@rem@two@kw{\@ifnextchar[%]
        {\@third@kw}{}}
\def\@third@kw[#1]{\setbox\cxthree=\hbox{#1}\setcounter{kwds}{3}%
                   \@rem@third@kw}
\def\@rem@third@kw{\@ifnextchar[%]
        {\@fourth@kw}{}}
\def\@fourth@kw[#1]{\setbox\cxfour=\hbox{#1}\setcounter{kwds}{4}%
                    \@rem@fourth@kw}
\def\@rem@fourth@kw{\@ifnextchar[%]
        {\@fiveth@kw}{}}
\def\@fiveth@kw[#1]{\setbox\cxfive=\hbox{#1}\setcounter{kwds}{5}%
                    \@finish@kw}
\def\@finish@kw#1\par{\relax}%


\newenvironment{dedicatoria}
   {\paginatitulo\null\vspace{1cm}%
    \begin{center}
       \bfseries\itshape \LARGE Dedicat\'{o}ria
    \end{center}}
   {\par\vfil\null\paginatitulo}


\newenvironment{agradecimentos}
   {\paginatitulo\null\vspace{1cm}%
    \begin{center}
       \bfseries\itshape \LARGE Agradecimentos
    \end{center}}
   {\par\vfil\null\paginatitulo}





\def\@quarto@membro[#1]#2#3#4{\gdef\@membrod{#1}\gdef\@membroa{#2}%
                              \gdef\@membrob{#3}\gdef\@membroc{#4}}
\def\@outros@tres#1#2#3{\gdef\@membroa{#1}\gdef\@membrob{#2}\gdef\@membroc{#3}}


\def\@membroa#1{\noexpand{#1}}
\def\@membrob#1{\noexpand{#1}}
\def\@membroc#1{\noexpand{#1}}
\def\@membrod#1{\noexpand{#1}}


\def\coordenador{\@ifnextchar[%]
              {\at@coorda}%Se primeiro argumento opcional chama esta
              {\at@coordo}}%senão chama esta rotina

\def\at@coorda[#1]#2#3{\def\@sexocoordenador{Coordenador#1}%
                        \def\@nomecoordenador{{#2}}%
                        \def\@filicoordenador{{#3}}}

\def\at@coordo#1#2{\def\@sexocoordenador{Coordenador}%
                        \def\@nomecoordenador{#1}%
                        \def\@filicoordenador{#2}}


\newboolean{co@ori@}\setboolean{co@ori@}{false}
\def\coorientador{\setboolean{co@ori@}{true}\@ifnextchar[%]
              {\at@coorienta}%Se primeiro argumento opcional chama esta
              {\at@cooriento}}%senao chama esta rotina

\def\at@coorienta[#1]#2#3{\def\@sexocoorientador{Coorientador#1}%
                        \def\@nomecoorientador{{#2}}%
                        \def\@filicoorientador{{#3}}}

\def\at@cooriento#1#2{\def\@sexocoorientador{Coorientador}%
                        \def\@nomecoorientador{#1}%
                        \def\@filicoorientador{#2}}



\def\orientador{\@ifnextchar[%]
              {\at@orienta}%Se primeiro argumento opcional chama esta
              {\at@oriento}}%senao chama esta rotina

\def\at@orienta[#1]#2#3{\def\@sexoorientador{Orientador#1}%
                        \def\@nomeorientador{{#2}}%
                        \def\@filiorientador{{#3}}}

\def\at@oriento#1#2{\def\@sexoorientador{Orientador}%
                        \def\@nomeorientador{#1}%
                        \def\@filiorientador{#2}}



\def\diamesano#1#2#3{\def\@mes{#2}%
                     \def\@ano{#3}%
                     \def\@dia{#1}}





\def\sumarios{\tableofcontents\listoffigures\listoftables}



\DeclareOption{phd}{\renewcommand{\degreetext}{
   Doctor of Philosophy\\ \university}}
\DeclareOption{mphil}{\renewcommand{\degreetext}{
   Master of Philosophy\\ \department\\ \university}}
\DeclareOption{msc}{\renewcommand{\degreetext}{
   Master of Science\\ \department\\ \university}}
\DeclareOption{bsc}{\renewcommand{\degreetext}{
   Batchelor of Science\\ \department\\ \university}}

\DeclareOption{centerchapter,centrechapter}
   {\renewcommand{\@chapteralignment}{\centering}}
\DeclareOption{leftchapter}
   {\renewcommand{\@chapteralignment}{\raggedright}}
\DeclareOption{rightchapter}
   {\renewcommand{\@chapteralignment}{\raggedleft}}

\DeclareOption{draft}{
   \setboolean{draftthesis}{true}
   \renewcommand{\draftmessage}{(Draft Copy)}}
\DeclareOption{usequotes}{\setboolean{usequotemarks}{true}}

\DeclareOption{abbrevs}{\setboolean{useabbrevs}{true}}

\DeclareOption{singlespacing}{\setboolean{usesinglespacing}{true}}
\DeclareOption{doublespacing}{\setboolean{usedoublespacing}{true}}
\DeclareOption{fullspacing}{\setboolean{usefullspacing}{true}}

\DeclareOption{deptreport}{\setboolean{usedeptreport}{true}}

\DeclareOption{parskip}{\AtEndOfClass{\input{parskip.clo}}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

%%\ExecuteOptions{phd,leftchapter,doublespacing} % available options
\ExecuteOptions{singlespacing,centrechapter} %the defualt options
\ProcessOptions

%%
%% --- Class Loading (built ontop of report.cls) ---
%%

\LoadClass[a4paper,12pt]{report}


%%
%% --- Main Code ---
%%

\newboolean{isspecialchapter}
\setboolean{isspecialchapter}{false}

%%
%% First we will sort out the pagelayout. The following is a brief
%% summary of the university typesetting regulations:
%%   Printed on A4 paper, entirely on rectos (single-sided)
%%   4cm binding margin
%%   2cm head margin
%%   2.5cm fore-edge margin
%%   4cm tail margin
%%   spacing: not less then 1.5 spacing (18pt leading)
%%            quotations & footnotes in single spacing
%%            bibliography may be in single spacing
%%   character size: not exceed 12pt for body text (at least 10pt)
%%   style: a serif font should be used
%%  hyphenation should be avoided if possible
%%

%% First we will set out the margins as defined above. We use the vmargin
%% package to simplify this process. However, every printer in the
%% department outputs pages of subtly different size and position. We
%% therefore provide support for a number of printers, as they are
%% currently configured.
%%
%%  \setmarginsrb{leftmargin}{topmargin}{rightmargin}{bottommargin}%
%%               {headheight}{headsep}{footheight}{footskip}

\setpapersize{A4}

\newcommand{\SetPrinterLWfourteen}{%
   \setmarginsrb{3.8cm}{0.65cm}{2.7cm}{3.3cm}% 
                {14pt}{20pt}{12pt}{22pt}%
}
\newcommand{\SetPrinterHPtwentyfour}{%
   \setmarginsrb{3.9cm}{1.05cm}{2.6cm}{3.0cm}% 
                {14pt}{20pt}{12pt}{22pt}%
}
\newcommand{\SetPrinterHPsixteen}{%
   \setmarginsrb{4.05cm}{0.9cm}{2.45cm}{3.2cm}% 
                {14pt}{20pt}{12pt}{22pt}%
}
\newcommand{\SetPrinterMPsixteen}{%
   \setmarginsrb{4.0cm}{0.8cm}{2.45cm}{3.25cm}% 
                {14pt}{20pt}{12pt}{22pt}%
}
\newcommand{\SetPrinterDraft}{%
   \setmarginsrb{1in}{0.4in}{1in}{1in}% 
                {14pt}{20pt}{12pt}{22pt}%
}

\newcommand{\PrtMsg}[1]{\typeout{NOTE: Setting page margins for printer #1.}}
\newcommand{\SetPrinter}[1]{%
   \ifthenelse{\equal{#1}{lw14}}{\SetPrinterLWfourteen\PrtMsg{#1}}{%
   \ifthenelse{\equal{#1}{hp24}}{\SetPrinterHPtwentyfour\PrtMsg{#1}}{%
   \ifthenelse{\equal{#1}{hp16}}{\SetPrinterHPsixteen\PrtMsg{#1}}{%
   \ifthenelse{\equal{#1}{mp16}}{\SetPrinterMPsixteen\PrtMsg{#1}}{%
      \typeout{WARNING: Invalid printer choice: #1. Defaulting to hp24.}
      \SetPrinterHPtwentyfour
   }}}}
}

\SetPrinterHPtwentyfour

%%
%% Hack to make minitoc work with csthesis. We declare a new chapter
%% variable called starchapter to be used by \addcontentsline when we
%% add contents lines for List of Figures/Tables. If we don't, then
%% minitoc treats the LOF/LOT sections as chapters of the thesis.
%%

\@ifundefined{chapter}{}{\let\l@starchapter\l@chapter}

%%
%% This bit will set up the header format for the thesis.
%% This currently uses a "headings" style showing the pagenumber
%% and chapter number/title. (in slanted text)
%%

\renewcommand{\chaptermark}[1]{\markboth{#1}{#1}}
\newcommand{\chapternoheader}{
  \ifthenelse{\boolean{isspecialchapter}}
    {}
    {\chaptername\ \thechapter\ \ ---\ }
}

\newcommand{\headfootstyle}{\normalsize}  % font size of headers and footers

\renewcommand{\ps@headings}{
  \renewcommand{\@oddfoot}{}
  \renewcommand{\@evenfoot}{}
  \renewcommand{\@evenhead}{\headfootstyle\thepage\hfil\sl\chapternoheader%
                            \leftmark\ \draftmessage}
  \renewcommand{\@oddhead}{\hskip -0.35em {\sl\headfootstyle\chapternoheader%
                           \rightmark\ \draftmessage}\hfil\thepage}
}

\renewcommand{\ps@plain}{
  \renewcommand{\@oddfoot}{\hfil\headfootstyle\thepage\hfil}
  \renewcommand{\@evenfoot}{\hfil\headfootstyle\thepage\hfil}
  \renewcommand{\@evenhead}{}
  \renewcommand{\@oddhead}{}
}


%%
%% And now setup that headings style as default
%%

\newcommand{\@textpagenumbering}{arabic}
\newcommand{\@preamblepagenumbering}{roman}
\newcommand{\@textpagestyle}{plain}
\newcommand{\@preamblepagestyle}{plain}

\pagestyle{\@preamblepagestyle}


\setcounter{secnumdepth}{6}



%%
%% Some sundry commands which are generally useful...
%%

\ifthenelse{\boolean{useabbrevs}}
 {\RequirePackage{xspace}
  \newcommand{\NB}{N.B.\@\xspace}
  \newcommand{\eg}{e.g.\@\xspace}
  \newcommand{\Eg}{E.g.\@\xspace}
  \newcommand{\ie}{i.e.\@\xspace}
  \newcommand{\Ie}{I.e.\@\xspace}
  \newcommand{\etc}{etc.\@\xspace}
  \newcommand{\etal}{{\em et al}.\@\xspace}
  \newcommand{\etseq}{{\em et seq}.\@\xspace}
  \newcommand{\precis}{pr\'ecis\xspace}
  \newcommand{\Precis}{Pr\'ecis\xspace}
  \newcommand{\role}{r\^ole\xspace}
  \newcommand{\Role}{R\^ole\xspace}
  \newcommand{\naive}{na\"\i ve\xspace}
  \newcommand{\Naive}{Na\"\i ve\xspace}
  \newcommand{\tm}{\raisebox{1ex}{\tiny TM}\xspace}
  \newcommand{\cpright}{\raisebox{1ex}{\tiny\copyright}\xspace}
  \newcommand{\degrees}{\raisebox{1.2ex}{\tiny\ensuremath{\circ}}\xspace}}
 {}

%%
%% Set up the double spacing and provide commands to alter the
%% spacing for the subsequent text. By default, 1.5 spacing will be
%% used. This can be modified through the singlespacing, doublespacing
%% or draft class options.
%%

\ifthenelse{\boolean{usefullspacing}}
   {\newcommand{\doublespace}{\setlength{\baselineskip}{28.8pt}}
    \newcommand{\oneandahalfspace}{\setlength{\baselineskip}{21.6pt}}}
   {\newcommand{\doublespace}{\setlength{\baselineskip}{24pt}}
    \newcommand{\oneandahalfspace}{\setlength{\baselineskip}{18pt}}}
\newcommand{\singlespace}{\setlength{\baselineskip}{14.4pt}}

\ifthenelse{\boolean{draftthesis}}
   {\AtBeginDocument{\singlespace}\SetPrinterDraft}{
   \ifthenelse{\boolean{usesinglespacing}}
      {\AtBeginDocument{\singlespace}}{
      \ifthenelse{\boolean{usedoublespacing}}
         {\AtBeginDocument{\doublespace}}
         {\AtBeginDocument{\oneandahalfspace}}
   }
}

%%
%% When printing twosided, then the title page must be followed by
%% a blank page so that the thesis begins on the right-hand page. 
%% Also we must ensure that the thesis ends on a lef-hand page. We
%% do the latter by issuing a \cleardoublepage at the end of document.
%%

\newcommand{\cscleardoublepage}%
  {\vfill\pagebreak\thispagestyle{empty}\cleardoublepage}
\AtEndDocument{\cscleardoublepage}

%%
%% A couple of commands for figures/captions
%%

\newcommand{\thesiscaption}[3][]{
   \ifthenelse{\equal{#1}{}}
     {\parbox{5in}{\caption{{\em #2\/}}\label{#3}}}
     {\parbox{5in}{\caption[#1]{{\em #2\/}}\label{#3}}}
}

%%
%% Quotations are supposed to be in single-space, so we will
%% explicitly redefine the quotation env. to support this.
%% And introduce a citetext env. which can add an attribution.
%%

\renewenvironment{quotation}
   {\begin{quote}\singlespace
    \ifthenelse{\boolean{usequotemarks}}{``}{}\sl}
   {\ifthenelse{\boolean{usequotemarks}}{\rm''}{}\end{quote}}

\newcommand{\citationname}{}
%\newenvironment{citetext}[1]
%   {\renewcommand{\citationname}{#1}\begin{quote}\singlespace
%    \ifthenelse{\boolean{usequotemarks}}{``}{}\sl}
%   {\ifthenelse{\boolean{usequotemarks}}{\rm''}{}
%    \hspace*{\fill}\nolinebreak[1]\hspace*{\fill}
%    \rm (\citationname)\end{quote}}

%%
%% Let's have a dedication page so I can thank my mummy.
%%

\newcommand{\dedication}[1]
   {\titlepage\null\vspace{2.5in}
    \begin{center}#1\end{center}
    \par\vfil\null\endtitlepage\cscleardoublepage}

%% Now let's redefine the abstract env. so that the title is 
%% comparable to other chapter headings. Also have abstract
%% start at top of page instead of floating in the middle
%%

\renewenvironment{abstract}
   {\begin{paginatitulo}\null\vspace{1cm}%
       \begin{center}  \bfseries\itshape \LARGE Abstract
       \end{center}}
       {\vskip 15pt\noindent\textbf{Keywords:}\ \@keywords%
    \end{paginatitulo}}

\def\@keywords#1{\gdef\@@keys{#1}\par\vfil\null}
\def\@@keys#1{\noexpand\@keywords{#1}}
\def\keywords#1{\gdef\@keywords{#1}}

%%
%% Based upon the above abstract env., provide wrappers for
%% an acknowledgements and declation env.
%%

\newenvironment{acknowledgements}
   {\renewcommand{\abstractname}{Acknowledgements}\begin{abstract}}
   {\end{abstract}\renewcommand{\abstractname}{Abstract}}   

\newenvironment{declaration}
   {\renewcommand{\abstractname}{Declaration}\begin{abstract}}
   {\end{abstract}\renewcommand{\abstractname}{Abstract}}   

\newcommand{\standarddeclaration}{
   \begin{declaration}
   \vspace{3cm}
   I declare that this thesis was composed by myself 
   and that the work contained therein is my own, 
   except where explicitly stated otherwise in the text.\par
   \vspace{2in}\raggedleft({\em \@author\/})
   \end{declaration}
}

\newenvironment{publications}
   {\renewcommand{\abstractname}{Publications}\begin{abstract}}
   {\end{abstract}\renewcommand{\abstractname}{Abstract}}   


%%
%% Now let's look at the format for the title page of the
%% thesis. This is done by redefining \maketitle, and allowing
%% some extra input options: \submityear and \graduationdate
%%

\def\submityear#1{\gdef\@submityear{#1}}
\gdef\@submityear{\the\year}

\def\graduationdate#1{\gdef\@graduationdate{#1}}
\gdef\@graduationdate{}

\ifthenelse{\boolean{usedeptreport}}{
   \renewcommand{\maketitle}{
      \begin{titlepage}
      \addtolength{\oddsidemargin}{-0.75cm}
      \begin{center}
      \null\vskip 6.1cm
      \begin{minipage}[t][7.6cm]{10.5cm}
         \begin{center}
         {\LARGE\bfseries \@title \par
            \ifthenelse{\boolean{draftthesis}}{\large \draftmessage}{}
         }\vfil
         {\Large\slshape \@author \par}
         \end{center}
      \end{minipage}
      \vfil
      {\Large \degreetext \par \@submityear \par}
      \ifthenelse{\equal{\@graduationdate}{}}{}
         {\vskip 1cm {\large \ttfamily (Graduation date:\@graduationdate)}}
      \end{center}
      \end{titlepage}\cscleardoublepage
   }}{
   \renewcommand{\maketitle}{
      \begin{titlepage}\begin{center}
      \null\vfil\vskip 60\p@
      {\LARGE\bfseries \@title \par
         \ifthenelse{\boolean{draftthesis}}{\large (Draft Copy)}{}
      }\vfill
      {\Large\slshape \@author \par}\vskip 1cm\vfill
      {\Large \degreetext \par \@submityear \par}
      \vskip 1cm 
      \ifthenelse{\equal{\@graduationdate}{}}{}
         {{\large \ttfamily (Graduation date:\@graduationdate)}}
      \end{center}\end{titlepage}\cscleardoublepage
   }}


%%
%% Now we can redefine the chapter headings, with the flexibility
%% to choose whether we want the headings to be left, right or
%% centre justified. N.B. Most of this code is replicated from
%% the utthesis.sty style: version 1.0, (c) 1994 Dinesh Das
%%

\newcommand{\specialchapter}[1]{
   \chapter*{\centering\itshape #1\@mkboth{\MakeUppercase#1}{\MakeUppercase#1}}
   \addcontentsline{toc}{chapter}{#1}
   \chaptermark{#1}
   \setboolean{isspecialchapter}{true}
}

\renewcommand{\chapter}{\clearpage
   \thispagestyle{plain}%
%   \setboolean{isspecialchapter}{false}
   \global\@topnum\z@
   \@afterindentfalse
%indenta o primeiro parágrafo! PQP ABNT!!!
   \secdef\@chapter\@schapter
   }

%%%
%%% Command from report.cls, (c) LaTeX3 Project.
%%%

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                      \refstepcounter{chapter}%
                      \typeout{\@chapapp\space\thechapter.}%
                      \addcontentsline{toc}{chapter}%
                             {\@chapapp\ \protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{\@chapapp\ #1}
                    \fi
                    \ifnum\value{chapter}=1\pagestyle{\@textpagestyle}\fi%
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \@makechapterhead{#2}%
                    \@afterheading
                    }
%%%
%%% Command from report.cls, (c) LaTeX3 Project.
%%%

\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \@chapteralignment \reset@font
    \ifnum \c@secnumdepth >\m@ne
      \huge\bfseries\@chapapp{}  \thechapter
      \par
      \vskip 20\p@
    \fi
    \Huge \bfseries #1\par
    \nobreak
    \vskip 40\p@
  }}
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \@chapteralignment
    \reset@font
    \Huge \bfseries  #1\par
    \nobreak
    \vskip 40\p@
  }}

%\newcommand{\setbibliographyheader}{
%   \chaptermark{\bibname}
%   \setboolean{isspecialchapter}{true}
%}

%%
%% Updated thebibliography environment. 
%% Modified from report.cls v1.3q (c) LaTeX3 Project.
%% Now includes entry in contents page & supports title rejustifying
%%

\def\bibnamenome{Refer\^{e}ncias}%desta forma evitamos que o Babel
   %substitua o \bibname por ``Referências Bibliográficas''

\renewenvironment{thebibliography}[1]
     {\specialchapter{\bibnamenome}
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

%%
%% Updated listoftables environment. 
%% Modified from report.cls v1.3q (c) LaTeX3 Project.
%% Now includes entry in contents page & supports title rejustifying
%%

\renewcommand\listoftables{%
    \chapter*{\thispagestyle{empty}\centering\itshape\listtablename
      \@mkboth{%
          \MakeUppercase\listtablename}{\MakeUppercase\listtablename}}%
     \addcontentsline{toc}{starchapter}{\listtablename}
    \@starttoc{lot}%
    }

%%
%% Updated listoffigures environment. 
%% Modified from report.cls v1.3q (c) LaTeX3 Project.
%% Now includes entry in contents page & supports title rejustifying
%%

\renewcommand\listoffigures{%
    \chapter*{\thispagestyle{empty}
      \centering\itshape\listfigurename
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}}%
    \addcontentsline{toc}{starchapter}{\listfigurename}
    \@starttoc{lof}%
    }

\renewcommand\addcontentsline[3]{%
  \addtocontents{#1}{\protect\contentsline{#2}{#3}{\thepage}}}

\renewcommand\tableofcontents{%%%%%%%%%%%%%%%%%%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\thispagestyle{empty}\centering\itshape\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }

%%
%% Redefine the appendix command to ensure that it does a pagebreak
%% (sorts problem of Appendix appearing in header of last page before
%% the first apppendix).
%%




\renewcommand{\appendix}{\vfill\pagebreak
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\chaptername{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}
}


\newcommand{\bibliografia}[2]%
   {\addcontentsline{toc}{chapter}{Refer\^{e}ncias}%
   \let\bibname=\refname
    \bibliography{#1}%%
    \bibliographystyle{#2}}


%%
%% EOF: csthesis.cls
%%
