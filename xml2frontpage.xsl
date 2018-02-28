<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>  
<xsl:import href="xml2html.xsl"/>
<xsl:output method="html" />

<xsl:template match="/resume">
<html>
<!-- xml2frontpage.xsl -->
	<head>
		<title>Resume of <xsl:value-of select="info/name"/></title>
		<style>
body
{
	color: #000000;
	background-color: #FFF8F2;
}

h1
{
	font-size: 150%;
	font-family: "verdana","helvetica",sans-serif;
}

h2
{
	font-size: 130%;
	font-family: "verdana","helvetica",sans-serif;
}

p
{
}

a
{
	color: #0000FF;
	background-color: transparent;
}

a:active
{
	color: #FF0000;
	background-color: transparent;
}

a:visited
{
	color: #000000;
	background-color: transparent;
}
a:hover
{
	color: #777700;
	background-color: transparent;
}

p.itemHead
{
	border-style: solid;
	border-width: 1px;
	text-indent: 2%;
	font-size: 120%;
	padding: 2mm;
	background-color: #EEEEEE;
	color: inherit;
	font-family: "verdana","helvetica",sans-serif;
}

p.description
{
	padding: 3mm;
	font-family: "verdana","helvetica",sans-serif;
}
		</style>
	</head>
<body bgcolor="#FFF8F2">
<div align="center">
<h1><xsl:value-of select="info/name"/></h1>
<h2><xsl:value-of select="info/contact"/></h2>

</div>

<xsl:comment>
<!-- insert text to be included as an HTML comment here. -->
</xsl:comment>

<!-- XXX Insert prologue for HTML content here. -->
<!-- Insert prologue for HTML content here. -->
<!-- Insert prologue for HTML content here. -->
<!-- Insert prologue for HTML content here. -->

<h2>Formats</h2>
<ul>
<!-- XXX modify filenames -->
<li><a href="Resume.pdf">PDF</a></li>
<li><a href="Resume.html">HTML</a></li>
</ul>

	<xsl:apply-templates/>
	</body>
</html>
</xsl:template>
</xsl:stylesheet>







