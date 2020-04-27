%% klausur.sty


%%
%% dvips -t a4
%% psnup -2 -Pa4
%% ps2pdf -sPAPERSIZE=a4
%%


%%% Infos fuer TeX
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{snetTeaching}[2016/04/01 Lehre SNET]
\ClassInfo{snetTeaching}{2016/04/01 v0.2 style for SNET Teaching Tasks, K. Grunert}


% Key-Value Optionen für Classes
% http://ctan.space-pro.be/tex-archive/macros/latex/contrib/oberdiek/kvoptions.pdf
%http://vesta.informatik.rwth-aachen.de/ftp/pub/mirror/ctan/macros/latex/contrib/oberdiek/kvoptions.pdf
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
	family = snet,	% Default-Familie für alle Keys
	prefix = snet@	% Defalut-Prefix zum Aufruf der Keys
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% notwendige Definitionen für Class-Optionen %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\dokumentTyp}[1]{\renewcommand{\dokumentTyp@}{#1}}
\newcommand{\dokumentTyp@}{\ClassError{snetTeaching}{Kein \protect\dokumentTyp{Klausur|Uebung}\space angegeben.}{Bitte \protect\dokumentTyp{Klausur|Uebung}\space definieren.}}

% intern für Entscheidung
\newcommand{\documentTypeIntern@}{exercise}
\newcommand{\latexDocumentType@}{article}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Class-Optionen %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareVoidOption{exam}{
	\dokumentTyp{Klausur}
	\renewcommand{\documentTypeIntern@}{exam}
	%Füge am Ende des Dokuments etwas ein
	\AtEndDocument{
		\ifdefined\loesungen
			%nichts
		\else
			%leere Seite für Klausur am Ende einfügen
			\newpage ~
		\fi
		\label{LastPage}
	}
}

\DeclareVoidOption{exercise}{
	\dokumentTyp{\"Ubung}
	\renewcommand{\documentTypeIntern@}{exercise}
}

%Für längere Berichte 
\DeclareVoidOption{report}{
	\renewcommand{\latexDocumentType@}{report}
	\renewcommand{\documentTypeIntern@}{report}
	\dokumentTyp{Report} %in Datei bitte ändern, weil in Header und Metadaten
}


%restliche Optionen, die nicht deklariert wurden, werden an article-Class übergeben (das ist nicht das Laden der Klasse)
\DeclareDefaultOption{
	\ClassInfo{snetTeaching}{Achtung: nicht spezifizierte Option \CurrentOption; weiterreichen an article-Class} 
%	\PassOptionsToClass{\CurrentOption}{scrartcl}
	\PassOptionsToClass{\CurrentOption}{\latexDocumentType@}
}






% Option zum Verändern der Farbe des Lösungstextes
% Mögliche Werte sind alle vordefinierten Farben von color und [dvipsnames]xcolor
% siehe: https://en.wikibooks.org/wiki/LaTeX/Colors#Predefined_colors
\DeclareStringOption[BlueViolet]{lsgColor}[BlueViolet]
\typeout{Die gewählte Lösungsfarbe ist: \snet@lsgColor}

%set defaults
\ExecuteOptions{exercise}
%terminate the option processing
\ProcessKeyvalOptions*
\LoadClass[a4paper]{\latexDocumentType@}
%\LoadClass{scrartcl}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eingabe: https://de.wikipedia.org/wiki/LaTeX#Schriftart.2C_Zeichenkodierung_und_Sonderzeichen
\RequirePackage[utf8]{inputenc}		% \begin{tabulary} verträgt sich anscheinend nicht mit utf8 -> zu utf8x ändern, falls benötigt, http://en.wikibooks.org/wiki/LaTeX/Colors
\RequirePackage[T1]{fontenc}			% Schriftarten in verschiedenen Encodings möglich
\RequirePackage{lmodern,textcomp}		% Damit Vektorschirft und Legaturen gut gesetzt werden
\RequirePackage{microtype}					% improves the spacing between words and letters
\RequirePackage[ngerman]{babel}			% neue Rechtschreibung
\RequirePackage{ae,pifont}				

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Standardschriftart für den Text festlegen
\RequirePackage{times}                    		%% Standardfont: Times (PS)
%\usepackage{utopia}               			%% Standardfont: Utopia
%\usepackage{arial}
%\usepackage{palatino}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Farbdefinitionen
\RequirePackage[dvipsnames]{xcolor}         %% Farbgebung: usenames -> Namen der Farben benutzen, dvipsnames & svgnames -> mehr Farbnamen, table -> b
\definecolor{TUB_ROT}{HTML}{C50E1F}          %% TUB Rote Logo-Farbe
\definecolor{TUB_GRAU}{HTML}{717171}			%% TUB Grau

% Define Color für Aufgaben-Priorisierung
\definecolor{colImportant}{HTML}{71A6D2} %Blau
\definecolor{colComplementary}{HTML}{B2EC5D} %Hellgrün
\definecolor{colAdditional}{HTML}{FCF75E} %Gelb

%% ein paar Abkuerzungen
\newcommand{\red}[1]{\textcolor{TUB_ROT}{#1}}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% zusätzliche Packages
\RequirePackage{ifthen}							% \ifthenelse{test}{then clause}{else clause}
\RequirePackage{todonotes}						% Notizen am Rand oder inline
\RequirePackage{ifdraft}						% \ifdraft{Draft-Text}{Final-Text}
\RequirePackage{lipsum}
%\RequirePackage{mathtools}						% für Mathesymbole, lädt und erweitert {amsmath}
\RequirePackage{amsmath}						% für Mathesymbole, lädt und erweitert {amsmath}
\RequirePackage{amssymb}						
\RequirePackage{adjustbox}
\RequirePackage{url}							% \url{URL}
\RequirePackage{comment,verbatim}				% zum Auskommentieren der Lösungen
\RequirePackage[final]{hyperref}				% Option final = also enable Links in Draft mode
\RequirePackage{array}							% Für Tabular-Kommandos
\RequirePackage{caption}						% Überschriften, für lstlisting und subcaption



	% mit \myhref{URL}{Ankertext} wird der Ankertext im Dokument angezeigt, der eine bestimmte URL refrenziert; 
	% zusätzlich wird die URL nochmal als Fußnote angezeigt
	\newcommand{\myhref}[2]{\href{#1}{#2}\footnote{\url{#1}}}
	\newcommand{\myhrefemph}[2]{\href{#1}{\emph{#2}\footnote{\url{#1}}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sub-Bilder nebeneinander
%%
%%	\subcaptionbox[list entry]{heading\label{key}}[width][inner-pos]{contents}
%%	\subcaptionbox*{heading\label{key}}[width][inner-pos]{contents}
%% 	\subref{reference/display only subcaption}
%%
%%erste Variante (mit Rahmen):
%%\begin{figure}
%%	\begin{tcolorbox}
%%		\centering
%%		\setlength{\fboxsep}{5pt}
%%		\setlength{\fboxrule}{1pt}
%%		\fbox{
%%			\subcaptionbox{
%%				Subcaption A
%%				\label{fig:sub:subcaptionA}
%%				}
%%				[0.45\linewidth]	%Breite der Box
%%				[c]				%innere Ausrichtung: c, l, r, s (keine)
%%				{
%%					\includegraphics[width=0.20\textwidth]{snet}
%%				}
%%		}	
%%		\hfill
%%		\fbox{
%%			\subcaptionbox[arabic]{
%%				Test B: eine sehr lange Beschriftung die nicht in eine Zeile passt
%%				\label{fig:sub:picTwo}
%%				}
%%				[0.45\linewidth]	%Breite der Box
%%				[c]				%innere Ausrichtung: c, l, r, s (keine)
%%				{\includegraphics[width=0.20\textwidth]{tub}}%
%%		}
%%		\caption{Caption}
%%		\label{fig:twoPictures}
%%	\end{tcolorbox}
%%\end{figure}
%%
%%
%%Test: \subref{fig:sub:picTwo}
%%Ref: \ref{fig:sub:picTwo}
%%
%% andere Variante (mit tcolorbox oder fbox Rahmen noch ergänzen):
%%\begin{figure}[htb]
%%	\begin{tcolorbox}
%%	\centering
%%	\begin{minipage}[t]{0.45\linewidth}
%%		\centering
%%		\includegraphics[width=\linewidth]{snet}
%%		\subcaption{Test A}
%%		\label{lbl:Gesamt:A}
%%	\end{minipage}
%%	\hfill
%%	\begin{minipage}[t]{0.45\linewidth}
%%		\centering
%%		\includegraphics[width=\linewidth]{tub}
%%		\subcaption{Test B: eine sehr lange Beschriftung die nicht in eine Zeile passt}
%%		\label{lbl:Gesamt:B}
%%	\end{minipage}
%%	\caption{Test C}
%%	\label{lbl:GesamtPage}
%%	\end{tcolorbox}
%%\end{figure}
\RequirePackage{tcolorbox}  		% colorierte Rahmen, man kann viel machen; TODO!
\RequirePackage[					% Unter-Überschriften; gleiche Optionen wie caption, gelten nur für subcaption, https://mirror.unicorncloud.org/CTAN/macros/latex/contrib/caption/caption-eng.pdf
%	indention=10pt,
%	position=top,
%	margin=0pt,
%	font=small,
%	labelformat=parens,
%	labelsep=space,
%	skip=6pt,
	labelformat=empty,
	hypcap=true,	% Springe bei ref auf das Bild (true) oder Unterschrift (false)
	font=scriptsize,	% Bezeichner (a, b, ...) fett
	margin=0pt,
	width=0pt,
	list=false,		% subcaptions werden (nicht) im Bilder- bzw. Tabellenverzeichnis gelistet
%	textfont=sf
]{subcaption}		% http://ftp.uni-erlangen.de/ctan/macros/latex/contrib/caption/subcaption.pdf

%\DeclareCaptionSubType*	% Definiere Nummerierung von Unter-Überschriften, Stern=> Typ.Subtyp
%	[arabic] 	% Nummerierung: arabic, roman, Roman, alph (default), Alph, fnsymbol, etc. 
%	{figure}	% Wleches Env


%% \begin{Rahmen}
%%		\ProzessOK[Breite]{Sub-Caption\label{fig:subcap}}{Bild}
%%		\hfill
%%		\ProzessWRONG[Breite]{Sub-Caption\label{fig:subcap}}{Bild}
%%		\caption{text}
%%		\label{key}
%% \end{Rahmen}

\newenvironment{Rahmen}{
	\begin{figure}[h!]
		\begin{tcolorbox}
			\centering
	}{
		\end{tcolorbox}
	\end{figure}
}

\newenvironment{RahmenNoFloat}{
%	\begin{figure}[h!]
		\begin{tcolorbox}
			\centering
	}{
		\end{tcolorbox}
%	\end{figure}
}

\newcommand{\DrawProzess}[3][0.46\linewidth]{%
		\setlength{\fboxsep}{3pt}%
		\setlength{\fboxrule}{1pt}%
		\subcaptionbox{#2}		%Sub-Caption + Label
%				[0.45\linewidth]	%Breite der Box
%				[c]					%innere Ausrichtung: c, l, r, s (keine)
			{\fcolorbox{white}{ProzessBackgroundColor}{%
				\includegraphics[width=#1,trim = 19mm 18mm 19mm 35mm, clip=true]{#3}
				}%
			}%	
%		\hfill%
}%

\newcommand{\ProzessOK}[3][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{234,255,234} %hellgrün
	\DrawProzess[#1]{#2}{#3}
}
\newcommand{\ProzessWRONG}[3][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{255,234,234} %hellrot
	\DrawProzess[#1]{#2}{#3}
}

\newcommand{\ProzessNEUTRAL}[3][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{255,255,255} 
	\DrawProzess[#1]{#2}{#3}
}

% Activate for new measurements of signavios pdf export
%

\newcommand{\DrawNewProzess}[3][0.46\linewidth]{%
		\setlength{\fboxsep}{3pt}%
		\setlength{\fboxrule}{1pt}%
		\subcaptionbox{#2}		%Sub-Caption + Label
%				[0.45\linewidth]	%Breite der Box
%				[c]					%innere Ausrichtung: c, l, r, s (keine)
			{\fcolorbox{white}{ProzessBackgroundColor}{%
				\includegraphics[width=#1,trim = 19mm 0mm 19mm 35mm, clip=true]{#3}
				}%
			}%	
%		\hfill%
}%

\newcommand{\ProzessNewOK}[3][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{234,255,234} %hellgrün
	\DrawNewProzess[#1]{#2}{#3}
}
\newcommand{\ProzessNewWRONG}[3][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{255,234,234} %hellrot
	\DrawNewProzess[#1]{#2}{#3}
}

\newcommand{\ProzessNewNEUTRAL}[3][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{255,255,255} 
	\DrawNewProzess[#1]{#2}{#3}
}

\newcommand{\DrawCmmnProzess}[3][0.46\linewidth]{%
		\setlength{\fboxsep}{3pt}%
		\setlength{\fboxrule}{1pt}%
		\subcaptionbox{#2}		%Sub-Caption + Label
%				[0.45\linewidth]	%Breite der Box
%				[c]					%innere Ausrichtung: c, l, r, s (keine)
			{\fcolorbox{white}{ProzessBackgroundColor}{%
				\includegraphics[width=#1]{#3}
				}%
			}%	
%		\hfill%
}%



\newcommand{\ProzessCmmnOK}[3][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{234,255,234} %hellgrün
	\DrawCmmnProzess[#1]{#2}{#3}
}
\newcommand{\ProzessCmmnWRONG}[3][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{255,234,234} %hellrot
	\DrawCmmnProzess[#1]{#2}{#3}
}

\newcommand{\ProzessCmmnNEUTRAL}[3][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{255,255,255} 
	\DrawCmmnProzess[#1]{#2}{#3}
}




\newcommand{\DrawCmmnProzessNoFloat}[2][0.46\linewidth]{%
		\setlength{\fboxsep}{3pt}%
		\setlength{\fboxrule}{1pt}%
%		\subcaptionbox{#2}		%Sub-Caption + Label
%				[0.45\linewidth]	%Breite der Box
%				[c]					%innere Ausrichtung: c, l, r, s (keine)
			{\fcolorbox{white}{ProzessBackgroundColor}{%
				\includegraphics[width=#1]{#2}
				}%
			}%	
%		\hfill%
}%

\newcommand{\ProzessCmmnOKNoFloat}[2][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{234,255,234} %hellgrün
	\DrawCmmnProzessNoFloat[#1]{#2}
}

\newcommand{\ProzessCmmnWRONGNoFloat}[2][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{255,234,234} %hellrot
	\DrawCmmnProzessNoFloat[#1]{#2}
}

\newcommand{\ProzessCmmnNEUTRALNoFloat}[2][0.46\linewidth]{%
	\definecolor{ProzessBackgroundColor}{RGB}{255,255,255} 
	\DrawCmmnProzessNoFloat[#1]{#2}
}






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Geometrisches Klausur
% Seitenmaße festlegen - bei purer Angabe von a4paper, finde ich, wird zu wenig Platz genutzt
% zur Übersicht was welche Größe ist, see: http://en.wikibooks.org/wiki/LaTeX/Page_Layout
% top, bottom, left, right -> Abstand bis zur ersten Box
\RequirePackage[a4paper, includeheadfoot, top=1.2cm, bottom=1.5cm, left=2.5cm, right=2.5cm]{geometry}
\setlength{\footskip}{40pt}					% Höhe Body-Ende bis Footer-Ende
\setlength{\headheight}{16pt}				% Höhe des Header festlegen

\setlength{\parskip}	  {0.3cm plus2mm minus1mm}	% Legt den zusätzlichen Platz nach einem Absatz fest, plus und minus sind Ranges die Latex auslotet
\setlength{\parindent}	  {0mm}				% legt die Weite des Zeileneinzugs fest am Anfang eines Absatzes
%\AtBeginDocument{
%\setlength{\baselineskip} {2cm}			% Legt den Zwischenraum zw. 2 Zeilen fest -> muss in \begin{document} sein
%}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Seitenlayout
%%
%%
\RequirePackage{fancyhdr}

%definiere normales Aussehen von Seite
\pagestyle{fancy}

\renewcommand{\footrulewidth}{0.0pt}
\renewcommand{\headrulewidth}{0.4pt}
%\renewcommand\headrule{\makebox[\textwidth]{\rule{\textwidth}{\headrulewidth}}}
%\renewcommand{\headrule}{\vbox to 0pt{\hbox to \headwidth{\dotfill}\vss}} %definiere Head-Linie um
%\fancyheadoffset{0.7cm} % Setzt Header länger als Text um den Wert

%% Header definieren
\ifthenelse{\equal{\documentTypeIntern@}{report}}
	{
	 %TODO: ordentlichen Header
	}
{
	\lhead{\sf \dokumentTyp@{} \ifthenelse{\equal{\documentTypeIntern@}{exercise}\and\value{uebungNr@}>-1 }{\theuebungNr@}}
	\chead{\lvname}
	\ifthenelse{ \equal{\documentTypeIntern@}{exam}}{
		\rhead{\sf \@date}
	}{%else exercise
	\ifthenelse{ \equal{\documentTypeIntern@}{exercise}}{
		\rhead{\sf \semester@}
	}}
}

% Footer definieren
\lfoot{\sf \large \footersnet}
\cfoot{\thepage}
\rfoot{\sf \large \footertub}

%es gibt eine Möglichkeit auf Float-Pages die Headings zu deaktivieren mit iffloatpage, etc.

%definiere Stil für alle Seiten die Format "plain" verwenden (z.B. Chapter und Titelblatt)
% \chapter{} und \maketitle rufen automatisch \thispagestyle{plain} auf!!!
\fancypagestyle{plain}{%
	\fancyhf{} % Alle Felder löschen
	\renewcommand{\footrulewidth}{0.0pt}
	\renewcommand{\headrulewidth}{0.0pt}
	\cfoot{}
	\lfoot{\footersnet}
	\rfoot{\footertub}
}

%\headheight=14pt	%% Unterdr"ucken von Overfull \vbox (1.59999pt too high) has.. 

\newcommand{\blankpage}{% Leerseite ohne Seitennummer, n"achste Seite rechts
	\clearpage{\pagestyle{empty}\cleardoublepage}
}







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Neue Var-Definitionen   %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\dokumentTyp{Klausur} 					%im Header, z.B. Klausur oder Übung, optional
%\title{text} 							%im Titel, Pflicht: exercise
%\uebungNr{14}							%im Titel, Pflicht: exercise 
%\lehrveranstaltung{Webtechnologien} 	%im Titel und Header&Footer, Pflicht
%\semester{Wintersemester 2015/16} 		%im Header, Pflicht: exercise
%\date{31.03.2016}						%im Header, Pflicht: exam
%\dateLang{31. März 2016}				%im Titel, Pflicht
%\author{Kai Grunert}					%in PDF-Eigenschaften, optional
%\email{Kai.Grunert@tu-berlin.de}		%in PDF-Eigenschaften, optional
%\hochschule{TU Berlin}					%in PDF-Eigenschaften, optional



\newcommand{\lehrveranstaltung}[1]{\renewcommand{\lvname}{#1}}
\newcommand{\lvname}{\ClassError{snetTeaching}{Keine \protect\lehrveranstaltung{Name}\space angegeben.}{Bitte \protect\lehrveranstaltung{Name}\space definieren.}}


\newcommand{\semester}[1]{\renewcommand{\semester@}{#1}}
\newcommand{\semester@}{\ClassError{snetTeaching}{Kein Semester \protect\semester{WS 15/16}\space angegeben}{Bitte \protect\semester{WS 15/16}\space definieren.}}





\newcommand{\dateLang}[1]{\renewcommand{\dateLang@}{#1}}
%Wenn exam und kein dateLang angegeben, dann Fehler, ansonsten Warning
\ifthenelse{ \equal{\documentTypeIntern@}{exam}}{
	\newcommand{\dateLang@}{\ClassError{snetTeaching}{Kein ausgeschriebenes Datum \protect\dateLang{1. Januar 2016}\space angegeben}{Bitte \protect\dateLang{1. Januar 2016}\space definieren.}}
}{ \ifthenelse{ \equal{\documentTypeIntern@}{exercise}}{
		%dateLang@ leer lassen, damit später darauf geprüft werden kann
		\newcommand{\dateLang@}{}
		%Wenn dateLang nie gesetzt wird, dann gebe Warnung aus
		\AtBeginDocument{
			\ifthenelse{ \equal{\dateLang@}{}}{
				\ClassWarning{snetTeaching}{Kein ausgeschriebenes Datum \protect\dateLang{1. Januar 2016}\space angegeben. Bitte angeben, damit das Enddatum im Titel vermerkt werden kann.}
			}
		}
  }
}



\newcommand{\email}[1]{\renewcommand{\email@}{#1}}
\newcommand{\email@}{\ClassInfo{snetTeaching}{Keine Kontakt-Email \protect\email{adresse}\space angegeben. Wenn angegeben, wird in den PDF-Metadaten hinterlegt.}}

\newcommand{\hochschule}[1]{\renewcommand{\hochschule@}{#1}}
\newcommand{\hochschule@}{\ClassInfo{snetTeaching}{Keine Hochschule \protect\hochschule{uni}\space angegeben. Wenn angegeben, wird in den PDF-Metadaten hinterlegt.}}

\newcounter{uebungNr@}
\setcounter{uebungNr@}{-1}
\newcommand{\uebungNr}[1]{
	\setcounter{uebungNr@}{#1}
}

%\newcounter{maxPunkte@}
%\setcounter{maxPunkte@}{0}
%\newcommand{\maxPunkte}[1]{
%	\setcounter{maxPunkte@}{#1}
%}

\newlength{\maxPunkte@}
\setlength{\maxPunkte@}{0pt}
\newcommand{\maxPunkte}[1]{
	\setlength{\maxPunkte@}{#1pt}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Environments und Kommandos für die Lehre
%%
%% Voraussetzung: Variable \loesungen{} ist definiert
%%

%https://tex.stackexchange.com/questions/11349/how-do-you-define-your-environment-such-as-to-use-for-some-parameters
% ftp://ftp.tu-chemnitz.de/pub/tex/macros/latex/contrib/l3packages/xparse.pdf
% m = verpflichtende Parameter, Angabe in geschweiften Klammern
% o = optional; O{Default} = optional mit Default, Angabe in eckigen Klammern
\usepackage{xparse} % um Environments mit optionalen Argumenten zu erstellen


% Environment kann im Aufgabentext eingesetzt werden, verschwindet aber in Musterlösung, z.B. um bis zur nächsten Seite Platz zu lassen
\newenvironment{Pruefung}{}{} 
% Umgebung mit Lösungen
\newenvironment{Loesung}{\comment}{\endcomment} 
\newenvironment{LoesungItemize}{\comment}{\endcomment} 


\newcommand{\Lsg}[2]{#1} % für kurze Lösungstexte
\newcommand{\Korrektur}[1]{}  % zusaetzlicher Korrekturhinweis, z.B. Punkteverteilun


\newcommand{\AWrong}[2][0.9\textwidth]{
	\begin{tabular}{lp{#1}}
		$\square$ & #2  \\[1ex]
	\end{tabular}
}
\newcommand{\ACorrect}[2][0.9\textwidth]{\AWrong[#1]{#2}}

\newenvironment{MC-Question}[1][\textwidth]{
	\begin{minipage}{#1}
	}{
	\end{minipage}
	\\[2ex]
}

\newcommand{\kleinerUndKursiv}[1]{\small \textit{#1}}
\newcommand{\rechtsBuendig@}{l}


%
% \begin{MC-Frage}*{Frage?}[Ja][Nein][0.7\textwidth]
% * = optional: wenn angegeben, dann rechtsbündig
% Frage = verpflichtend
% Ja, Nein = optional: Überschrift über Kästchen
% 0.7\textwidth = optional: Breite des Antwort-Textes, muss eventuell angepasst werden, wenn "Ja" und "Nein" zu lang sind
\NewDocumentEnvironment{MC-Frage}{s m O{Wahr} O{Falsch} O{0.8\textwidth}}
	{ % bei \begin{}
		%Wenn zuerst ein Stern, dann ist es rechtsbündig (für \ARichtig und \AFalsch)
		\IfBooleanTF{#1}{
			\renewcommand{\rechtsBuendig@}{r}
		}{
			\renewcommand{\rechtsBuendig@}{l}
		}
		\begin{minipage}{\textwidth}
			#2 
			%Kreuze rechts
			\ifthenelse{ \equal{\rechtsBuendig@}{r}}{
				\\
				\begin{tabular}{p{#5} c c}
				 & \kleinerUndKursiv{#3} & \kleinerUndKursiv{#4} \\
			}{% Kreuze links
				\\[1ex]
				\begin{tabular}{c c p{#5}}
				\kleinerUndKursiv{#3} & \kleinerUndKursiv{#4} &  \\
			}	 
	}{ %bei \end{}
			\end{tabular}
		\end{minipage}
		\\[1ex]
}



\newcommand{\ARichtig}[1]{
	\ifthenelse{ \equal{\rechtsBuendig@}{r}}{
		#1 &	$\square$ &  $\square$   \\[1ex]
	}{
		$\square$ &  $\square$ & #1  \\[1ex]
	}
}
\newcommand{\AFalsch}[1]{\ARichtig{#1}}



%Hintergrundfarbe der Überschriften setzen
\newcommand{\SetTaskImportant}{\renewcommand{\AufgabenColor@}{colImportant}}
\newcommand{\SetTaskComplementary}{\renewcommand{\AufgabenColor@}{colComplementary}}
\newcommand{\SetTaskAdditional}{\renewcommand{\AufgabenColor@}{colAdditional}}
\newcommand{\ResetTaskClassification}{\renewcommand{\AufgabenColor@}{white}}
\newcommand{\AufgabenColor@}{white} % Default: weißer Hintergrund bei einer Überschrift



%% deprecated!!!
\newcommand{\Uebung}[3]{
	\ClassWarning{snetTeaching}{Das Kommando \protect\Uebung\space ist deprecated! \MessageBreak
	Bitte verwenden Sie stattdessen im Head: \MessageBreak
	\protect\uebungNr{#1}, \protect\title{#2}\space und \protect\dateLang{#3}. \MessageBreak
	Nutzen Sie dann zum Generieren des Titels \protect\maketitle\space im Body.}

	\setcounter{uebungNr@}{#1}
	\title{#2}
	\dateLang{#3}
	% Ausgabe
	\@printUebungTitle
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Überschreiben der Kommandos für das Lösungs-PDF
%%
%%
%%
\ifdefined\loesungen
	\newlength{\normalParSkip}
	\setlength{\normalParSkip}{\parskip}
	

	% Environments für Musterlösungen
	
%	\renewcommand{\Lsg}[2]{\color{myLsgColor} #2 \color{black}}   
	\renewcommand{\Lsg}[2]{\color{\snet@lsgColor} #2 \color{black}}   
	\renewenvironment{Loesung}{
		~ \\
		\red{-----------Beginn Lösung-----------} \\*
		\small \color{\snet@lsgColor} }
		%
		%hier steht der Text
		%
		{ ~ \\* \red{-----------Ende Lösung-----------} 
		\color{black}\normalsize }
%		\color{TUB_ROT}}{\color{black}}
	\renewenvironment{LoesungItemize}{
		\red{-----------Beginn Lösung-----------}
		\small \color{\snet@lsgColor} \setlength{\parskip}{0pt} 
		\begin{itemize} }
		%
		%\item hier steht der Text
		%
		{ \end{itemize}
			\red{-----------Ende Lösung-----------} 
			\color{black}\normalsize \setlength{\parskip}{\normalParSkip}}
		
	\renewcommand{\Korrektur}[1]{\hspace{0,5cm} \red{[#1]}}
	
	\renewenvironment{Pruefung}{\comment}{\endcomment}
	
	\renewcommand{\ACorrect}[2][0.9\textwidth]{
		\begin{tabular}{lp{#1}}
			$\square$ \hspace{-0.5cm} \textcolor{red}{\textbf{X}} & #2 \\[1ex]
		\end{tabular}
	}
	
	\renewcommand{\ARichtig}[1]{
		\ifthenelse{ \equal{\rechtsBuendig@}{r}}{
			#1 &	$\square$ \hspace{-0.5cm} \textcolor{red}{\textbf{X}} &  $\square$   \\[1ex]
		}{
			$\square$ \hspace{-0.5cm} \textcolor{red}{\textbf{X}} &  $\square$ & #1  \\[1ex]
		}
	}
	
	\renewcommand{\AFalsch}[1]{
		\ifthenelse{ \equal{\rechtsBuendig@}{r}}{
			#1 &	$\square$  &  $\square$ \hspace{-0.5cm} \textcolor{red}{\textbf{X}}  \\[1ex]
		}{
			$\square$  &  $\square$ \hspace{-0.5cm} \textcolor{red}{\textbf{X}} & #1  \\[1ex]
		}
	}


	%Wasserzeichen im Hintergrund
	\RequirePackage{draftwatermark}
	\SetWatermarkText{Musterlösung}
	\SetWatermarkLightness{0.92}
	\SetWatermarkFontSize{3cm}
	\SetWatermarkAngle{50}  

\fi




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Hilfs-Kommandos
%%
%% 
%%
%  addPDFMetadata
%  printUebungTitle
%  footersnet
%  footertub

\newcommand{\addPDFMetadata}{
	%% Informationen f"ur die PDF-Datei
	\newcommand{\pdftitel@}{\dokumentTyp@{}}
	\newcommand{\pdfsubject@}{\@title{}}
	
	\ifthenelse{ \equal{\documentTypeIntern@}{exam}}{
		%Klausuren
		\renewcommand{\pdftitel@}{\lvname{} -- \dokumentTyp@{}, \semester@{} \@date{}}
		\renewcommand{\pdfsubject@}{\dokumentTyp@{} \lvname{}, \dateLang@{}}
	}{\ifthenelse{ \equal{\documentTypeIntern@}{exercise}}{
		%Übungen
		\renewcommand{\pdftitel@}{\lvname{} -- \dokumentTyp@{} Nr. \theuebungNr@, \semester@{}}
		\renewcommand{\pdfsubject@}{\@title{}, Abgabe: \dateLang@{}}
	}}
	
	\hypersetup{
		pdftitle={\pdftitel@},
		pdfauthor={\@author{}, \email@{}, \hochschule@{}},
		pdfsubject={\pdfsubject@},
%		bookmarks=true,
%		unicode=true,
%		pdftoolbar=true,
%		pdfmenubar=true,
%		pdffitwindow=false,
%		pdfstartview={FitH},
%		pdfcreator={Creator},
%		pdfproducer={Producer},
%		pdfkeywords={keyword1} {key2} {key3},
%		pdfnewwindow=true,
%		colorlinks=false,
%		linkcolor=red,
%		citecolor=green,
%		filecolor=magenta,
%		urlcolor=cyan
%% siehe: https://de.wikibooks.org/wiki/LaTeX-W%C3%B6rterbuch:_hyperref
	}
}

\ifthenelse{ \equal{\documentTypeIntern@}{exercise}}{
	
	\newcommand{\@printUebungTitle}{
		%Wenn keine Übungsnummer angegeben ist, dann gebe Warnung aus
		\ifthenelse{\value{uebungNr@}=-1}{
			\ClassWarning{snetTeaching}{keine Uebungsblatt-Nummer angegeben. \MessageBreak
				\protect\uebungNr{Nummer}\space angeben}
		}{
			%Übungsnummer angegeben, dann setze Absatznummern richtig
			\renewcommand{\thesection}{\theuebungNr@ .\arabic{section}}
		}

		\begin{center}
			\pdfbookmark[0]{\"Ubungsblatt \theuebungNr@}{} 
			{\LARGE \sf 
			\ifthenelse{ \value{uebungNr@}=-1 }{ }{\textbf{Übungsblatt \theuebungNr@ :}}
			\textbf{\@title}}\\
			\normalsize
			%Wenn dateLang angegeben, dann schreibe Text
			\ifthenelse{\equal{\dateLang@}{}}{ }{Vorstellung in den Tutorien am \dateLang@\\}
%			\ifthenelse{\value{maxPunkte@}=0}{}{(maximal erreichbare Punktzahl: \themaxPunkte@{} Punkte)}
			\ifthenelse{\maxPunkte@=0}{}{(maximal erreichbare Punktzahl: \strip@pt\maxPunkte@{} Punkte)}
			
			
		\end{center}
		\vspace*{0.2cm}
	}
}

\newcommand{\footersnet}
{
	\begin{minipage}{.2\textwidth}
		\includegraphics[width=\textwidth]{images/snet.png}
	\end{minipage}
}

\newcommand{\footertub}
{
	\begin{minipage}{.2\textwidth}
		\includegraphics[width=\textwidth]{images/tub.png}
	\end{minipage}
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Überschreibe Latex-Kommandos
%
% \section: Hintergrundfarbe berücksichtigen
% \maketitle
%




\renewcommand\section{ \@startsection {section}{1}{\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex}%
	{2.3ex \@plus.2ex}%
	{\normalfont\Large\bfseries\colorbox{\AufgabenColor@}}}


\ifthenelse{\equal{\documentTypeIntern@}{exercise}\or\equal{\documentTypeIntern@}{exam} }
{
	\renewcommand{\maketitle}{
		%exercise
		\ifthenelse{ \equal{\documentTypeIntern@}{exercise} }
		{ 		
				\@printUebungTitle
		%exam
		}{\ifthenelse{ \equal{\documentTypeIntern@}{exam}}
		{			
				\thispagestyle{plain}
				\ifdefined\loesungen
						\SetWatermarkText{Musterlösung}
						\SetWatermarkColor{red}
						\SetWatermarkFontSize{3cm}
						\SetWatermarkAngle{50}  			
				\fi
				
				\begin{center}
				\Large \sf \textbf{\dokumentTyp@{}: \lvname}\\ \normalsize \dateLang@
				\end{center}
				\vspace*{0.1cm}
				
				\small
				Dies ist die schriftliche Abschlussprüfung der Lehrveranstaltung \lvname{}. Bitte füllen Sie die Tabelle auf diesem Deckblatt aus und unterschreiben Sie den unten stehenden Hinweis.
				
				
				\textbf{Hinweise:}
				\begin{itemize}
					\item \textbf{Sie dürfen kein Blatt herausreißen}! Bewertet werden nur die zusammengehefteten Blätter. 
					
					\item Falls Sie mehr als die vorgesehenen Bereiche zum Beschreiben benötigen, können Sie die leere Seite am Ende der Klausur nutzen. Machen Sie eine Weiterführung der Antwort eindeutig kenntlich.
					
					\item Die Verwendung von eigenem Papier ist nicht erlaubt. Sie können uns nach Schmierblättern fragen.
					
					\item Bitte achten Sie darauf, dass Sie alle {\pageref{LastPage}} Seiten der Klausur vorliegen haben.
					
					\item Auf ihrem Platz darf sich nichts befinden außer: einem Lineal, mehreren Stiften, ihrem Personal- und Studierendenausweis. Sie dürfen keine Unterlagen verwenden. Alle elektronischen Geräte (auch Smartwatches) gehören ausgeschaltet in ihren Rucksack oder Tasche. Diese müssen Sie in der Reihe vor Ihnen abstellen.
						
					\item Sie dürfen \textbf{keinen} roten und nur dokumentenechte Stifte verwenden! Das bedeutet, Sie dürfen weder einen Füller noch einen Bleistift verwenden.
				\end{itemize}
				
				
				\begin{table}[h]
					\centering
					\begin{tabular}{|p{0.4\textwidth}|p{0.55\textwidth}|}
						\hline
						\textbf{Matrikelnummer} & \hspace{6cm} \\[2ex]
						\hline
						\textbf{Name} &  \\[2ex]
						\hline
						\textbf{Vorname} &  \\[2ex]
						\hline
						\textbf{Studiengang} &  \\[2ex]
						\hline
						\multicolumn{2}{|p{\textwidth}|}{Hiermit bestätige ich, dass ich die Hinweise verstanden habe und mich in der Lage fühle diesen Test durchzuführen.} \\[4ex]
						\multicolumn{2}{|l|}{\textbf{{\large Unterschrift:}}}\\[4ex]
						\hline
	%					Ich benötige einen "Schein" \newline (Erasmus, Nebenhörer, Gasthörer) & \hspace{0.5cm}$\square$ \\
	%					\hline
					\end{tabular}
				\end{table}
				
				\vspace{1cm}		
		}}
	}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vorläufig: neuer Latex-Kommando für Titelseite bei Prog2-Klausur
%	
% \maketitleProg2
%
\newcommand{\maketitleProg}{
	%exercise
	\ifthenelse{ \equal{\documentTypeIntern@}{exercise} }
	{ 		
			\@printUebungTitle
	%exam
	}{\ifthenelse{ \equal{\documentTypeIntern@}{exam}}
	{
			\thispagestyle{plain}
			\ifdefined\loesungen
					\SetWatermarkText{Musterlösung}
					\SetWatermarkColor{red}
					\SetWatermarkFontSize{3cm}
					\SetWatermarkAngle{50}  			
			\fi
%% Titel:			
%			\begin{center}
%			\Large \sf \textbf{\dokumentTyp@{}: \lvname}\\ \normalsize \dateLang@
%			\end{center}
%			\vspace*{0.1cm}
			\begin{center}
				\vspace*{-2cm}
				\Huge{Klausur PROG 2}\\
				\Large{\lvname \\
				\dateLang@}\vspace{-0.7cm}
			
			%\setkomafont{title}{\normalfont\Huge}
			
			\normalsize{
			
				\vspace{1.6cm}
				\begin{tabular}{ll}
				Name: & .................................... \vspace{0.5cm}\\
				Vorname: & .................................... \vspace{0.5cm}\\
				Matr.-Nr.: & .................................... \vspace{0.5cm}\\
				Studiengang: & ....................................
				\end{tabular}
			}
			%\setkomafont{date}{\normalfont\normalsize}
			
			\vspace{0.3cm}
			Bearbeitungszeit: 150 Minuten
			%\maketitle
			\end{center}
			
			\begin{itemize}
				\renewcommand{\labelitemi}{$\Rightarrow$}
				\item Bitte legen Sie vor der Klausur alle nicht zugelassenen Hilfsmittel in Ihre verschlossene Tasche.
				\item Es ist ein doppelseitig handbeschriebenes DIN-A4 Blatt als Hilfsmittel (Spickzettel) zugelassen, wenn es Ihren Namen und Ihre Matrikelnummer trägt.
				\item Am Platz sind die folgenden Hilfsmittel erlaubt: Schreibutensilien, Studenten-/Personalausweis, Getränke und der Spickzettel. Bitte wenden Sie sich an die Betreuer, sofern Sie weitere Hilfsmittel nutzen möchten.
				\item Bitte legen Sie Ihren Personal- und Studentenausweis zur Kontrolle bereit. % während der Klausur
				\item Benutzen Sie für die Lösung der Aufgaben \textbf{nur} das ausgeteilte Papier, weiteres erhalten Sie auf Anfrage. 
				Verwenden Sie auch die Rückseiten.
				Schreiben Sie nur in \textbf{blau} oder \textbf{schwarz}! 
				Schreiben Sie \textbf{nicht} mit Bleistift!
				\item Tragen Sie jetzt (vor Beginn der Bearbeitungszeit!) auf \underline{allen} Blättern Ihren Namen und Ihre Matrikelnummer ein.
				\item Lassen Sie sich nicht von vorgegebenen Freiräumen irritieren! Je nach Aufgabe fallen sie größer bzw. kleiner aus.
			\end{itemize}
			
			
			Hiermit bestätige ich, dass ich die Hinweise verstanden habe und mich gesundheitlich in der Lage fühle, diese schriftliche Prüfung durchzuführen. (§39 (10) Satz 6+7 AllgStuPO vom 8.5.2013)
			
			\textbf{{\large Unterschrift:}} 
			\\
			\\ 		
	}}
}






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bilder einbinden
%	
%	http://en.wikibooks.org/wiki/LaTeX/Importing_Graphics
%	
%	\begin{figure}
%	\centering
%	\includegraphics[width=xx,height=xx,keepaspectratio=true,scale=xx,angle=xx,trim=l b r t,clip=true,page=x]{file}
%	\caption[short]{title}
%	\label{key}
%	\end{figure}}
%
\RequirePackage{graphicx}                         %% Einbinden von Grafiken

% Grafik-Path anpassen
\graphicspath{
	{images/}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PDF output oder DVI output erkennen
% Infos schreiben
%
\RequirePackage{ifpdf}

\ifpdf
%Definiere nutzbare Grafiktypen: \DeclareGraphicsExtensions{.pdf,.jpg,.png}
%die Reihenfolge ist entscheidend: (.pdf,.jpg,.png) = zuerst suche pdf, dann jpg, dann png
%gut, wenn man noch in Entwurfsphase ist Minderwertige Bilder sehen möchte (Bitmaps)
% PDF = Vektor- oder Bitmaps-Images (aber zum Einbinden ganzer Seiten besser usepackage{pdfpages} nutzen: http://en.wikibooks.org/wiki/LaTeX/Importing_Graphics#Including_full_PDF_pages)
% JPG = Bitmap, Verlustbehaftet, für Fotos
% PNG = Bitmap, Verlustfrei, für Screenshots und Diagramme (wenn nicht Vektorgrafik)
	\DeclareGraphicsExtensions{.pdf,.jpg,.png}
	
	\AtBeginDocument{
		\addPDFMetadata{}
	}
	% mehr Optionen zu PDF und hyperref
	\message{***********************************************pdfLaTeX is used}

\else
	% EPS = Vektor und Bitmap-Grafik (Bitmap am besten nicht benutzen, da seeehr groß)
	\DeclareGraphicsExtensions{.eps}
	\message{***********************************************no pdfLaTeX is used}
\fi







				



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Quell- und Sourcecode
% see: http://mirror.math.ku.edu/tex-archive/macros/latex/contrib/listings/listings.pdf
%
% Einbinden:
%1) \lstinline[morekeywords={allowtransparency,...}]$ CODE $ %anstatt $ kann beliebiges Zeichen verwendet werden
%
%2) \lstinputlisting[]{Datei}
%
%3)	\begin{lstlisting}[language=HTML,float=tp,caption={Datenstruktur Profile.java},label={lst:Profile}, firstline=2, lastline=5]
%	...
%	
%	public class Profile implements Serializable {
%	
%		/**
%		 * 
%		 */
%		private static final long serialVersionUID = -3743062417683419875L;
%		
%		//Begin Meta-Data
%		private boolean spammer;
%		transient private SpammerCategoryEnum spammerCategory;
%		
%		//Begin profile data
%		private int numberOfFriends;
%		private String aMContent;
%		private int aMLength;
%		private int age;
%		private MartialStatusEnum martialStatus;
%		private GenderEnum gender;
%		
%		public Profile(){ ... }
%		
%		public Instance writeProfileToARFFInstance(Instances arffProfileData){ ... }
%		
%		...
%		
%	}
%	\end{lstlisting}
%

% Define Color für Listings
\definecolor{numberStyleColor}{rgb}{0.5,0.5,0.5} %Zeilennummern: Grau
\definecolor{basicStyleColor}{named}{black} %Grundfarbe
\definecolor{identifierStyleColor}{named}{black} %Variablen und Funktionsnamen
\definecolor{keywordStyle1Color}{named}{blue} % Struktur-Keyword, Symbole, HTML-Elemente, CSS-Eigenschaften
\definecolor{keywordStyle2Color}{named}{ForestGreen} % häufige Funktionen/Objekte, HTML-Attribute, CSS-Werte
\definecolor{keywordStyle3Color}{named}{Brown} % Kontrollstrukturen, CSS-PseudoXX
\definecolor{stringStyleColor}{named}{YellowOrange} % Strings, CSS-Selektoren
\definecolor{commentStyleColor}{RGB}{80,80,80}    %Grau





\usepackage{listings}
\lstloadlanguages{% Check Dokumentation for further languages ...
	[Visual]Basic,
	Pascal,
	C,
	[ISO]C++,
	XML,
	HTML,
	Java,
	bash
}
\lstset{	
	%for options see: http://mirror.math.ku.edu/tex-archive/macros/latex/contrib/listings/listings.pdf	
	breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace
	upquote=true,					% richtige einfache Anführungszeichen
	%captionpos=b,                    % sets the caption-position to bottom
	%deletekeywords={...},            % if you want to delete keywords from the given language
	%escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
	keepspaces=true,                 % keeps spaces in text, useful for keeping indentation of code (possibly needs columns=flexible)
	language=Java,                 % the language of the code
	%title=\lstname                   % show the filename of files included with \lstinputlisting; also try caption instead of title
	numbers=none,               % where to put the line-numbers; possible values are (none, left, right)
	%stepnumber=2,               % Abstand zwischen den Zeilennummern
	numbersep=5pt,              % Abstand der Nummern zum Text
	tabsize=2,                  % Groesse von Tabs
	extendedchars=true,         % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
	breaklines=true,            % Zeilen werden Umgebrochen
	%
	%
	% Style
	basicstyle=\scriptsize\ttfamily\color{basicStyleColor}, % Grundlegender Style für alle vererbt, the size of the fonts that are used for the code
	identifierstyle=\color{identifierStyleColor},	% Variablen und Funktionsnamen
	keywordstyle=[1]\color{keywordStyle1Color},
	keywordstyle=[2]\color{keywordStyle2Color},	% green
	keywordstyle=[3]\color{keywordStyle3Color},
	stringstyle=\color{stringStyleColor}, % gelb Farbe der String
	commentstyle=\itshape\color{commentStyleColor},    % comment style: Grau
	numberstyle=\tiny\color{commentStyleColor},          % Stil der Zeilennummern
	rulecolor=\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
	%
	%
	showspaces=false,           % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
	showtabs=false,             % show tabs within strings adding particular underscores
	xleftmargin=17pt, %17
	frame=b,				%<none|leftline (l)|topline (t)|bottomline (b)|lines (top und bottom)|single|shadowbox|TRBL (2 lines Oben,Rechts,Unten,Links)>    draws either no frame, a single line on the left, at the top, at the bottom, at the top and bottom, a whole single frame, or a shadowbox. The shadow color is [rulesepcolor]
	framexleftmargin=17pt, %17
	%framexrightmargin=5pt, %5
	framexbottommargin=4pt, %4
	%backgroundcolor=\color{lightgray},		% choose the background color; you must add \usepackage{color} or \usepackage{xcolor}
	showstringspaces=false,      % underline spaces within strings only
	literate=% Um Umlaute in Kommentaren zu verwenden
	  {á}{{\'a}}1 {é}{{\'e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ú}{{\'u}}1
	  {Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1
	  {à}{{\`a}}1 {è}{{\`e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1 {ù}{{\`u}}1
	  {À}{{\`A}}1 {È}{{\'E}}1 {Ì}{{\`I}}1 {Ò}{{\`O}}1 {Ù}{{\`U}}1
	  {ä}{{\"a}}1 {ë}{{\"e}}1 {ï}{{\"i}}1 {ö}{{\"o}}1 {ü}{{\"u}}1
	  {Ä}{{\"A}}1 {Ë}{{\"E}}1 {Ï}{{\"I}}1 {Ö}{{\"O}}1 {Ü}{{\"U}}1
	  {â}{{\^a}}1 {ê}{{\^e}}1 {î}{{\^i}}1 {ô}{{\^o}}1 {û}{{\^u}}1
	  {Â}{{\^A}}1 {Ê}{{\^E}}1 {Î}{{\^I}}1 {Ô}{{\^O}}1 {Û}{{\^U}}1
	  {œ}{{\oe}}1 {Œ}{{\OE}}1 {æ}{{\ae}}1 {Æ}{{\AE}}1 {ß}{{\ss}}1
	  {ű}{{\H{u}}}1 {Ű}{{\H{U}}}1 {ő}{{\H{o}}}1 {Ő}{{\H{O}}}1
	  {ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1 {å}{{\r a}}1 {Å}{{\r A}}1
	  {€}{{\euro}}1 {£}{{\pounds}}1 {«}{{\guillemotleft}}1
	  {»}{{\guillemotright}}1 {ñ}{{\~n}}1 {Ñ}{{\~N}}1 {¿}{{?`}}1
	  {€}{{\texteuro}}1
}	






%\DeclareCaptionFont{blue}{\color{blue}} 

%\captionsetup[lstlisting]{singlelinecheck=false, labelfont={blue}, textfont={blue}}
\DeclareCaptionFont{white}{\color{white}}
\DeclareCaptionFormat{listing}{
	\colorbox[cmyk]{0.43, 0.35,0.35,0.01}{
		\parbox{\textwidth-6pt}{\hspace{15pt}#1#2#3}
	}
}
\captionsetup[lstlisting]{format=listing,labelfont=white,textfont=white, singlelinecheck=false, margin=0pt, font={bf,footnotesize}}

%Code-Styles für Schwarz-Weiß-Druck definieren, Wenn Lsg: wieder in Farbe
\ifdefined\loesungen
	%normal in Farbe
	\lstdefinestyle{swHTML}{}
	\lstdefinestyle{swCSS}{}
	\lstdefinestyle{swJS}{}
\else
	\lstdefinestyle{swHTML}{
		basicstyle=\scriptsize\ttfamily\color{basicStyleColor}, % Grundlegender Style 
		tagstyle=\color{black},	%Spitze Klammer und jedes HTML-Attribut
		identifierstyle=\color{identifierStyleColor},	% Text-Nodes (innerhalb der Tags)
		keywordstyle=[1]\color[RGB]{50,50,50}\itshape,  % Html-Element
		keywordstyle=[2],	% 
		keywordstyle=[3],	%
		stringstyle=\itshape\color[RGB]{50,50,50}, % Dunkelgrau
		commentstyle=\itshape\color{commentStyleColor},    % comment style: Grau
	}
	\lstdefinestyle{swCSS}{
		basicstyle=\scriptsize\ttfamily\color{basicStyleColor}, % Grundlegender Style 
		identifierstyle=\color{identifierStyleColor} ,	% Selektor
		keywordstyle=[1]\color[RGB]{50,50,50}\itshape,  % Eigenschaften
		keywordstyle=[2],	%
		keywordstyle=[3],  %
		stringstyle=\itshape\color[RGB]{50,50,50}, % Dunkelgrau
		commentstyle=\itshape\color{commentStyleColor},    % comment style: Grau
		moredelim=[s][\color{darkgray}\itshape]{:}{\{},	 % für Pseudoklassen, helleres Grün
		moredelim=[s][\color{darkgray}\itshape]{::}{\{}, % für Pseudoelemente
		moredelim=[s][\color{black}]{:\ }{;}		% Werte
	}
	\lstdefinestyle{swJS}{
		basicstyle=\scriptsize\ttfamily\color{basicStyleColor}, % Grundlegender Style 
		identifierstyle=\color{identifierStyleColor}\bfseries ,	% Variablen und Funktionsnamen
		keywordstyle=[1]\color[RGB]{50,50,50},  %function, var, etc
		keywordstyle=[2]\color[RGB]{50,50,50}\itshape,	% require, request, log
		keywordstyle=[3]\color[RGB]{50,50,50},  %if, else
		stringstyle=\itshape\color[RGB]{50,50,50}, % Dunkelgrau
		commentstyle=\itshape\color{commentStyleColor},    % comment style: Grau
	}
\fi


% CSS
\lstdefinelanguage{css}{
	morekeywords=[1]{accelerator,azimuth,background,background-attachment,
		background-color,background-image,background-position,
		background-position-x,background-position-y,background-repeat,
		background-size,
		behavior,border,border-bottom,border-bottom-color,
		border-bottom-style,border-bottom-width,border-collapse,
		border-color,border-left,border-left-color,border-left-style,
		border-left-width,border-radius,border-right,border-right-color,
		border-right-style,border-right-width,border-spacing,
		border-style,border-top,border-top-color,border-top-style,
		border-top-width,border-width,bottom,box-shadow,caption-side,clear,
		clip,color,content,counter-increment,counter-reset,cue,
		cue-after,cue-before,cursor,direction,display,elevation,
		empty-cells,filter,float,font,font-family,font-size,
		font-size-adjust,font-stretch,font-style,font-variant,
		font-weight,height,ime-mode,include-source,
		grid-template-columns, grid-template-rows, grid-area, grid-template-areas,
		grid-column-start, grid-row-start, grid-column-end, grid-row-end,
		justify-content,
		layer-background-color,layer-background-image,layout-flow,
		layout-grid,layout-grid-char,layout-grid-char-spacing,
		layout-grid-line,layout-grid-mode,layout-grid-type,left,
		letter-spacing,line-break,line-height,list-style,
		list-style-image,list-style-position,list-style-type,margin,
		margin-bottom,margin-left,margin-right,margin-top,
		marker-offset,marks,max-height,max-width,min-height,
		min-width,-moz-binding,-moz-border-radius,
		-moz-border-radius-topleft,-moz-border-radius-topright,
		-moz-border-radius-bottomright,-moz-border-radius-bottomleft,
		-moz-border-top-colors,-moz-border-right-colors,
		-moz-border-bottom-colors,-moz-border-left-colors,-moz-opacity,
		-moz-outline,-moz-outline-color,-moz-outline-style,
		-moz-outline-width,-moz-user-focus,-moz-user-input,
		-moz-user-modify,-moz-user-select,orphans,outline,
		outline-color,outline-style,outline-width,overflow,
		overflow-X,overflow-Y,padding,padding-bottom,padding-left,
		padding-right,padding-top,page,page-break-after,
		page-break-before,page-break-inside,pause,pause-after,
		pause-before,pitch,pitch-range,play-during,position,quotes,
		-replace,richness,right,ruby-align,ruby-overhang,
		ruby-position,-set-link-source,size,speak,speak-header,
		speak-numeral,speak-punctuation,speech-rate,stress,
		scrollbar-arrow-color,scrollbar-base-color,
		scrollbar-dark-shadow-color,scrollbar-face-color,
		scrollbar-highlight-color,scrollbar-shadow-color,
		scrollbar-3d-light-color,scrollbar-track-color,table-layout,
		text-align,text-align-last,text-decoration,text-indent,
		text-justify,text-overflow,text-shadow,text-transform,
		text-autospace,text-kashida-space,text-underline-position,top,transform,
		unicode-bidi,-use-link-source,vertical-align,visibility,
		voice-family,volume,white-space,widows,width,word-break,
		word-spacing,word-wrap,writing-mode,z-index,zoom},
	sensitive=false,
	moredelim=[s][\color{keywordStyle3Color}\itshape]{:}{\{},	 % für Pseudoklassen, Media-Queries
	moredelim=[s][\color{keywordStyle3Color}\itshape]{::}{\{},	 % für Pseudoelemente	 
%	
	moredelim=[s][\color{keywordStyle2Color}]{:\ }{;},  % Css-Werte - ein Leerzeichen davor ist nötig
%
	morecomment=[s]{/*}{*/},
	morecomment=[l]{//},
	alsoletter={*\#},
	alsodigit={-},
	%
	identifierstyle=\color{stringStyleColor} %Selektoren-Farbe
}





\lstdefinelanguage{js}{
	% reserved Keywords
	morekeywords=[1]{
		await,break,case,catch,class,const,continue,
		debugger,default,delete,do,
		else,enum,export,extends,
		false,finally,for,function,
		if,import,in,instanceof,let,
		new,null,
		return,static,super,switch,
		this,throw,true,try,typeof,
		undefined,
		var,void,while,with,yield
	}, 
	otherkeywords={ %Zeichen, die zur Gruppe "`other"' gehören und nicht in ein "`letter"' gewandelt werden sollen, also "`other"' bleiben sollen
		% aber mit keywordstyle[1] angezeigt werden
		[,],=,.,+,<,?,!,:
	},
	%Built-in JS Objects
	morekeywords=[1]{
		Array, console, Error, JSON, Math, Object
	},
	%
	morekeywords=[3]{
		%
	},
	% Built-in JS Funktionen 
	morekeywords=[2]{
		 alert, ajax,
		 call, ceil, concat, constructor, create,
		 error, exec, exports, 
		 filter, forEach, 
		 getPrototypeOf, indexOf, join,
		 keys, length, log, 
		 map, max, module, 
		 parse, pop, prototype, push, 
		 reduce, replace, reverse,   
		 setPrototypeOf, sort, split, 
		 toString
	}, 
	%Dom-Objekte 
	morekeywords=[1]{
		document, window, location
	}, 
	%Node-Objekte 
	morekeywords=[1]{
		http, request, response, url
	}, 
	%Funtionen/Propertries auf DOM-Objekten
	morekeywords=[2]{
		addEventListener, appendChild, 
		body,
		childNodes, createElement, clientX, clientY,
		getAttribute, getElementById, getElementsByClassName, getElementsByName, getElementsByTagName, 
		getAllResponseHeaders, getResponseHeader, %Ajax
		hasAttribute, innerHTML,
		key, keyCode, % KeyboardEvent
		onreadystatechange, open, %Ajax
		querySelector, querySelectorAll, 
		onload, 
		pageX, pageY, preventDefault,
		removeChild,
		readyState,  response, responseText, responseType, responseURL, responseXML, %Ajax
		send, setRequestHeader, status, statusText, %Ajax 
		style,
		textContent, timeout, XMLHttpRequest %Ajax
	},
	%Jquery Objekte
	morekeywords=[1]{
		\$, jQuery
	},
	%Jquery Funktionen
	morekeywords=[2]{
		ajax, get, getJSON, post, %Ajax
		after, append, appendTo, attr, before,
		click, css, each, 
		insertAfter, insertBefore,  
		html, prepend, prependYo, ready, text, 
		val, wrap, wrapAll
	},
	%Jquery Kontrollstrukturen
	morekeywords=[3]{
		always, done, fail 
	},
	%Node.js Funktionen und Parameter
	morekeywords=[2]{
		all, createServer, end, 
		headers, host, 
		listen, 
		method, 
		path, pathname, 
		pipe, port, 
		query,
		require, 
		statusCode, 
		use, 
		write, writeHead,
	},
	sensitive=true,
%	alsodigit={.},
	alsoletter={?!:\$},	
	moredelim=[is][stringstyle]{@<}{>@}, % reg.Expr müssen in unsichtbare Abgrenzer eingebunden werden, z.B. var test = @</abc/>@
	morecomment=[s]{/*}{*/},
	morecomment=[l]//,
	morestring=[bd]",
	morestring=[b]',
%	emptylines=0
}




\lstdefinelanguage{html5}{
	%	Probleme/Verbesserungen:
	%	- Spitze Klammern und = werden im  Attribut-Stil (keywordStyle2Color) gefärbt, weil alles innerhalb eines Tags einfach mit tagstyle gefärbt wird
	%	- Strings werden auch im normalen Text markiert
%		- großes Problem: Keywords werden bei Verwendung von "tag" nicht mehr gefunden, deshalb
	%	- kein CSS Highlighting
	%	- kein JS
%	alsolanguage=js,
%	alsolanguage=css,
	tag=**[s]<>,
	sensitive=false,
	tagstyle=\color{keywordStyle2Color}, %alle Inhalte in einem Tag (d.h. Attribute), die keinen anderen Stil haben, werden eingefärbt
	markfirstintag=true, %erstes Wort in Tag wird mit keywordstyle1 markiert
	otherkeywords={ %mit keywordstyle1 färben
		=
	},
	alsoletter={-},
	morestring=[d]",
	morestring=[d]',
	morecomment=[s]{<!--}{-->}	
}


\lstdefinelanguage{html5test}{
	%	keywordsprefix=<,
	%	emph=[2]{
	%	        accept, accept-charset, accesskey, action, align, alt, async, autocomplete, autofocus, autoplay, autosave, bgcolor, border, buffered, challenge, charset, checked, cite, class, codebase, color, cols, colspan, content, contenteditable, contextmenu, controls, coords, data, datetime, default, defer, dir, dirname, disabled, download, draggable, dropzone, enctype, for, form, formaction, headers, height, hidden, high, href, hreflang, http-equiv, icon, id, ismap, itemprop, keytype, kind, label, lang, language, list, loop, low, manifest, max, maxlength, media, method, min, multiple, name, novalidate, open, optimum, pattern, ping, placeholder, poster, preload, pubdate, radiogroup, readonly, rel, required, reversed, rows, rowspan, sandbox, scope, scoped, seamless, selected, shape, size, sizes, span, spellcheck, src, srcdoc, srclang, start, step, style, summary, tabindex, target, title, type, usemap, value, width, wrap        
	%	},
	%	alsoletter={},
	%	alsodigit={-},
	%%	markfirstintag=\color{blue}\ttfamily,
	%	alsolanguage=HTML,
	%  	keywordstyle=[1]\color{red}\ttfamily	% keyword style
	alsolanguage=html,
	%   	alsodigit={<>/.:;},
	%	    tagstyle=\color{blue}\ttfamily, % definiert einen Stil für den default-Inhalt von Tags
	alsoletter={-},
	morekeywords=[1]{
		abbr,address,area,article,aside,audio,
		blockquote,button,
		canvas,caption,cite,code,col,colgroup,
		data,datalist,del,details,
		em,fieldset,figcaption,figure,footer,
		header,
		keygen,
		label,legend,link,
		main,map,mark,menu,menuitem,meta,meter,
		nav,noscript,
		object,optgroup,option,output,
		param,progress,
		samp,section,select,small,source,strong,summary,svg,
		tbody,template,tfoot,thead,time,track,
		var,video,
		wbr
	},  
	deletekeywords={
		accept, accept-charset, accesskey, action, align, alt, async, autocomplete, autofocus, autoplay, autosave, bgcolor, border, buffered, challenge, charset, checked, cite, class, code, codebase, color, cols, colspan, content, contenteditable, contextmenu, controls, coords, data, datetime, default, defer, dir, dirname, disabled, download, draggable, dropzone, enctype, for, form, formaction, headers, height, hidden, high, href, hreflang, http-equiv, icon, id, ismap, itemprop, keytype, kind, label, lang, language, list, loop, low, manifest, max, maxlength, media, method, min, multiple, name, novalidate, open, optimum, pattern, ping, placeholder, poster, preload, pubdate, radiogroup, readonly, rel, required, reversed, rows, rowspan, sandbox, scope, scoped, seamless, selected, shape, size, sizes, span, spellcheck, src, srcdoc, srclang, start, step, summary, tabindex, target, title, type, usemap, value, width, wrap        
	},
	morekeywords=[2]{
		% General
		% HTML attributes
		accept, accept-charset, accesskey, action, align, allowfullscreen, alt, async, autocomplete, autofocus, autoplay, autosave, bgcolor, border, buffered, challenge, charset, checked, cite, class, code, codebase, color, cols, colspan, content, contenteditable, contextmenu, controls, coords, data, datetime, default, defer, dir, dirname, disabled, download, draggable, dropzone, enctype, for, form, formaction, headers, height, hidden, high, href, hreflang, http-equiv, icon, id, ismap, itemprop,
		itemtype, itemscope, keytype, kind, label, lang, language, list, loop, low, manifest, max, maxlength, media, method, min, multiple, name, novalidate, open, optimum, pattern, ping, placeholder, poster, preload, pubdate, radiogroup, readonly, rel, required, reversed, rows, rowspan, sandbox, scope, scoped, seamless, selected, shape, size, sizes, span, spellcheck, src, srcdoc, srclang, start, step, style, summary, tabindex, target, title, type, usemap, value, width, wrap,
		% CSS properties
		accelerator:,azimuth:,background:,background-attachment:,
		background-color:,background-image:,background-position:,
		background-position-x:,background-position-y:,background-repeat:,
		behavior:,border:,border-bottom:,border-bottom-color:,
		border-bottom-style:,border-bottom-width:,border-collapse:,
		border-color:,border-left:,border-left-color:,border-left-style:,
		border-left-width:,border-right:,border-right-color:,
		border-right-style:,border-right-width:,border-spacing:,
		border-style:,border-top:,border-top-color:,border-top-style:,
		border-top-width:,border-width:,bottom:,caption-side:,clear:,
		clip:,color:,content:,counter-increment:,counter-reset:,cue:,
		cue-after:,cue-before:,cursor:,direction:,display:,elevation:,
		empty-cells:,filter:,float:,font:,font-family:,font-size:,
		font-size-adjust:,font-stretch:,font-style:,font-variant:,
		font-weight:,height:,ime-mode:,include-source:,
		layer-background-color:,layer-background-image:,layout-flow:,
		layout-grid:,layout-grid-char:,layout-grid-char-spacing:,
		layout-grid-line:,layout-grid-mode:,layout-grid-type:,left:,
		letter-spacing:,line-break:,line-height:,list-style:,
		list-style-image:,list-style-position:,list-style-type:,margin:,
		margin-bottom:,margin-left:,margin-right:,margin-top:,
		marker-offset:,marks:,max-height:,max-width:,min-height:,
		min-width:,transition-duration:,transition-property:,
		transition-timing-function:,transform:,
		-moz-transform:,-moz-binding:,-moz-border-radius:,
		-moz-border-radius-topleft:,-moz-border-radius-topright:,
		-moz-border-radius-bottomright:,-moz-border-radius-bottomleft:,
		-moz-border-top-colors:,-moz-border-right-colors:,
		-moz-border-bottom-colors:,-moz-border-left-colors:,-moz-opacity:,
		-moz-outline:,-moz-outline-color:,-moz-outline-style:,
		-moz-outline-width:,-moz-user-focus:,-moz-user-input:,
		-moz-user-modify:,-moz-user-select:,orphans:,outline:,
		outline-color:,outline-style:,outline-width:,overflow:,
		overflow-X:,overflow-Y:,padding:,padding-bottom:,padding-left:,
		padding-right:,padding-top:,page:,page-break-after:,
		page-break-before:,page-break-inside:,pause:,pause-after:,
		pause-before:,pitch:,pitch-range:,play-during:,position:,quotes:,
		-replace:,richness:,right:,ruby-align:,ruby-overhang:,
		ruby-position:,-set-link-source:,size:,speak:,speak-header:,
		speak-numeral:,speak-punctuation:,speech-rate:,stress:,
		scrollbar-arrow-color:,scrollbar-base-color:,
		scrollbar-dark-shadow-color:,scrollbar-face-color:,
		scrollbar-highlight-color:,scrollbar-shadow-color:,
		scrollbar-3d-light-color:,scrollbar-track-color:,table-layout:,
		text-align:,text-align-last:,text-decoration:,text-indent:,
		text-justify:,text-overflow:,text-shadow:,text-transform:,
		text-autospace:,text-kashida-space:,text-underline-position:,top:,
		unicode-bidi:,-use-link-source:,vertical-align:,visibility:,
		voice-family:,volume:,white-space:,widows:,width:,word-break:,
		word-spacing:,word-wrap:,writing-mode:,z-index:,zoom:,
		oobbt
	},  
	sensitive=false,
	%        alsodigit={.}, 
	morecomment=[s]{<!--}{-->},
	morestring=[b]',
	morestring=[b]",
	%
	keywordstyle=[2]\color[RGB]{30,120,35}\ttfamily,	% green
	keywordstyle=[1]\color{red}\ttfamily,	% keyword style
	stringstyle=\color{blue}\ttfamily, % Farbe der String
	commentstyle=\color[RGB]{80,80,80},    % comment style: Grau
	tag=[<>]
}




\endinput
%% End of file `snetBewertungen.sty'
