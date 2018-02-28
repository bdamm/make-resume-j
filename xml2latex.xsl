<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>  
<xsl:output omit-xml-declaration="yes" />

<!-- Root -->
<xsl:template match="resume">

<xsl:text disable-output-escaping="no">
%********************************************************************************************
%*      Based on work (xml to latex, general) by:                                           *
%*                  Original Author: Tayeb Lemlouma, june 2001                              *
%*   http://www.inrialpes.fr/opera/people/Tayeb.Lemlouma/MULTIMEDIA/XSLT/XML2LaTeX.xsl      *
%*      Heavily modified (xml to latex, resume specific) by:                                *
%*                  Ben Damm, July 2003                                                     *
%********************************************************************************************
\documentclass{article}

%%
% Set margins
%%
\usepackage[left=1in,top=1in,bottom=0.5in]{geometry}

%%%%
% Define "Resume" typeset nicely, use in header below.
%%
\newcommand\Resume{{R\'{e}sum\'{e}}}

% ---------------
% Headers package
%
\usepackage{fancyhdr}

% No page number in the footer
\cfoot{}

\lhead{ \it{\Resume} }% header, right side
\rhead{ {\it </xsl:text><xsl:value-of select="info/name"/><xsl:text>}} % header, right side

% No line at the top
\renewcommand{\headrulewidth}{0pt}
%
% ---------------

%%
% Define what a list of stuff looks like
%%
\newenvironment{resitems}
{ 
	\begin{itemize}
	\itemsep -2pt
}
{
	\end{itemize}
}

%% Define what sections look like
\newcommand\ressection[1]{\section*{{\textsf{#1}}}}
\newcommand\ressubsection[1]{\noindent {{\textsf{#1}}}}

</xsl:text>
<!-- ======= Document Begining ====== -->
<xsl:text>

\begin{document}

% No headers/footers for the first page
\thispagestyle{empty}

% The second page can have the custom header
\pagestyle{fancyplain}
%\pagestyle{fancy} % this page has no header  

\begin{center}
\noindent
{\textbf {\huge {</xsl:text><xsl:value-of select="info/name"/><xsl:text>}}}\\
\textsf{</xsl:text><xsl:value-of select="info/contact"/><xsl:text>}\\
\textsf{</xsl:text><xsl:value-of select="info/phone"/><xsl:text>}

\end{center}

\hrule

%% Define what a job experience looks like
% \job{title}{company}{years}
\newcommand\job[3]{
\noindent
{\textsf{\bf #2}}\ \ #1 \hfill #3\\}

\newenvironment{joblist}
{

\hskip -15pt
\begin{minipage}{5.8in}
\vskip -10pt
\begin{itemize}
 \itemsep -2pt
}
{
\end{itemize}
\vskip 2pt
\end{minipage}
}

% Same as joblist, just skip down instead of skip up
\newenvironment{edlist}
{

\hskip -15pt
\begin{minipage}{5.8in}
\vskip 2pt
\begin{itemize}
 \itemsep -2pt
}
{
\end{itemize}
\vskip 2pt
\end{minipage}
}


\newcommand\jobitem[1]{
\item #1
}


%==============================Document Body=================================================
</xsl:text>

<!-- Objective -->
<!-- Exp -->
<!-- Edu -->
<!-- newpage -->

<!-- Portfolio -->
<!-- Service -->

<xsl:apply-templates select="skills"/>
<xsl:apply-templates select="joblist" />
<xsl:apply-templates select="edlist"/>

<!-- newpage -->
<!--xsl:text>
\newpage
</xsl:text-->

<xsl:apply-templates select="portfolio"/>
<xsl:apply-templates select="community" />


<xsl:text>
\end{document}
%==============================End of Document===============================================
</xsl:text>
</xsl:template>
<!-- END root -->

<xsl:template match="joblist">
<xsl:text>
\ressection{</xsl:text><xsl:value-of select="title"/><xsl:text>}
</xsl:text>
<!-- now apply each job listing -->
<xsl:apply-templates select="job" />
</xsl:template>
<!-- end of joblist -->

<!-- how to format a job -->
<xsl:template match="job">

<xsl:text>
\job{</xsl:text><xsl:value-of select="title"/><xsl:text>}
{</xsl:text><xsl:value-of select="group"/><xsl:text>}
{</xsl:text><xsl:apply-templates select="timespan"/><xsl:text>}
\begin{joblist}
</xsl:text>
<xsl:apply-templates select="detail/jobitem" />
<xsl:text>
\end{joblist}

</xsl:text>
</xsl:template>
<!-- end of job -->

<xsl:template match="timespan">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="timespan/years">
<xsl:value-of select="@from"/>--<xsl:value-of select="@to"/>
</xsl:template>

<xsl:template match="timespan/year">
<xsl:value-of select="@value"/>
</xsl:template>

<xsl:template match="detail/jobitem">
\jobitem{<xsl:apply-templates />}
</xsl:template>

<!-- How to format the education section -->
<xsl:template match="edlist">

\ressection{<xsl:value-of select="title"/>}
<xsl:apply-templates select="entity" />
</xsl:template>

<xsl:template match="edlist/entity">
{\bf <xsl:value-of select="institute"/>}\hfill <xsl:apply-templates select="timespan"/>\\
<xsl:apply-templates select="achievement"/>\ 
<xsl:apply-templates select="courses" />

</xsl:template>

<xsl:template match="achievement" >
<xsl:value-of select="text()"/> --- <xsl:value-of select="major"/> Major,
<xsl:value-of select="minor"/> Minor.\\

</xsl:template>

<xsl:template match="entity/courses">
	<xsl:value-of select="comment"/>
\begin{edlist}
<xsl:apply-templates select="grouping"/>
\end{edlist}
</xsl:template>

<xsl:template match="courses/grouping">
\jobitem{<xsl:value-of select="text()"/>}
</xsl:template>

<xsl:template match="portfolio">
\ressection{<xsl:value-of select="title"/>}

<xsl:value-of select="comment"/>


\begin{resitems}
<xsl:apply-templates select="portfolioItem"/>
\end{resitems}
</xsl:template>

<xsl:template match="portfolioItem" >
{\item {\bf <xsl:value-of select="title"/>}\ \ <xsl:value-of select="detail"/>}
</xsl:template>

<xsl:template match="skills">
\ressection{<xsl:value-of select="title"/>}
<xsl:apply-templates select="subgroup"/>
</xsl:template>

<xsl:template match="skills/subgroup">
\ressubsection{<xsl:value-of select="title"/>}
\begin{resitems}
<xsl:apply-templates select="item"/>
\end{resitems}
</xsl:template>

<xsl:template match="skills/subgroup/item">
\item <xsl:call-template name="TextCall"/>
</xsl:template>

<xsl:template match="community">
\ressection{<xsl:value-of select="title"/>}
<xsl:apply-templates select="service"/>
</xsl:template>

<xsl:template match="community/service">
\ressubsection{<xsl:value-of select="location" />}
\begin{resitems}
<xsl:apply-templates select="item" />
\end{resitems}
</xsl:template>

<xsl:template match="community/service/item">
\item <xsl:call-template name="TextCall"/>
</xsl:template>

<!-- ============================================================== -->
<!--  That's it for the main stuff.  Everything below this is 
      LaTeX specific machinery. 
  -->

<!-- Text Process Template -->
<xsl:template name="TextCall">
<xsl:variable name="S">
<xsl:value-of select="normalize-space()" />
</xsl:variable>

<xsl:if test="string-length($S)>0">

<xsl:call-template name="LaTeXChar">

<xsl:with-param name="i" select="string-length($S)"/>
<xsl:with-param name="l" select="string-length($S)"/>

</xsl:call-template>
</xsl:if>

</xsl:template>
<!-- End of the Text Process Template -->


<!-- LaTeXChar: A recursif function that generates LaTeX special characters -->
<xsl:template name="LaTeXChar">
<xsl:param name="i"/>
<xsl:param name="l"/>

<xsl:variable name="SS">
<xsl:value-of select="substring(normalize-space(),$l - $i + 1,1)" />
</xsl:variable>

<xsl:if test="$i > 0">

<xsl:choose>
 <xsl:when test="$SS = '#'">
  <xsl:text>\#</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'é'">
 <xsl:text>\'{e}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'ê'">
 <xsl:text>\^{e}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'è'">
 <xsl:text>\`{e}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'ï'">
 <xsl:text>\"{\i}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'î'">
 <xsl:text>\^{i}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'à'">
 <xsl:text>\`{a}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'á'">
 <xsl:text>\'{a}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'â'">
 <xsl:text>\^{a}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'ç'">
 <xsl:text>\c{c}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'ô'">
 <xsl:text>\^{o}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'ù'">
 <xsl:text>\`{u}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = 'û'">
 <xsl:text>\^{u}</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = '|'">
 <xsl:text>$|$</xsl:text>
 </xsl:when>
 <xsl:when test="$SS = '_'">
 <xsl:text>\_</xsl:text>
 </xsl:when>
 <xsl:otherwise><xsl:value-of select="$SS"/></xsl:otherwise>
</xsl:choose>

<xsl:text></xsl:text> 

<xsl:call-template name="LaTeXChar">
<xsl:with-param name="i" select="$i - 1"/>
<xsl:with-param name="l" select="$l"/>

</xsl:call-template>
</xsl:if>

</xsl:template>
<!-- End of LaTeXChar template -->

</xsl:stylesheet>
<!-- End of the StyleSheet -->

