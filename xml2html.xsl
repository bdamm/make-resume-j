<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>  
<xsl:output method="html" />

<xsl:template match="/resume">
<html>
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
	<body>
	<div align="center">
	<h1><xsl:value-of select="info/name"/></h1>
	<h2><xsl:value-of select="info/contact"/></h2>
	</div>
		<xsl:apply-templates/>
	</body>
</html>
</xsl:template>

<xsl:template match="info">
<!-- 'info' is already here -->
</xsl:template>

<xsl:template match="joblist">
	<h2><xsl:value-of select="title"/></h2>
	<table border="0" width="100%">
	<xsl:apply-templates select="job"/>
	</table>
</xsl:template>

<xsl:template match="job">
<tr>
<td width="30%"><b><xsl:value-of
select="group"/></b></td><td><xsl:value-of select="title"/></td><td
align="right" width="10%"><xsl:apply-templates select="timespan"/></td>
</tr>
<tr>
<td colspan="2">
<ul>
<xsl:apply-templates select="detail/jobitem" />
</ul>
</td><td></td>
</tr>
<tr><td colspan="3"><br/></td></tr>
</xsl:template>

<xsl:template match="timespan">
<xsl:apply-templates />
</xsl:template>

<xsl:template match="timespan/years">
<xsl:value-of select="@from"/>-<xsl:value-of select="@to"/>
</xsl:template>

<xsl:template match="timespan/year">
<xsl:value-of select="@value"/>
</xsl:template>

<xsl:template match="job/detail/jobitem">
<li><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="edlist">
<h2><xsl:value-of select="title"/></h2>
<xsl:apply-templates select="entity"/>
</xsl:template>

<xsl:template match="edlist/entity">
<table border="0" width="100%">
<tr>
<td><b><xsl:value-of select="institute"/></b></td><td align="right"
width="10%"><xsl:apply-templates select="timespan"/></td>
</tr>
<tr><td colspan="2"><xsl:apply-templates select="achievement"/></td></tr>
<tr><td colspan="2">
<xsl:apply-templates select="courses" />
</td></tr>
</table>
</xsl:template>

<xsl:template match="achievement">
<xsl:apply-templates select="text()"/> - <xsl:apply-templates
select="major"/> Major, <xsl:apply-templates select="minor"/> Minor.
</xsl:template>

<xsl:template match="courses">
<xsl:value-of select="comment"/>
<ul>
<xsl:apply-templates select="grouping"/>
</ul>
</xsl:template>

<xsl:template match="courses/grouping" >
<li><xsl:value-of select="text()"/></li>
</xsl:template>

<xsl:template match="portfolio">
<h2><xsl:value-of select="title"/></h2>
<xsl:value-of select="comment"/>
<table width="100%" border="0" cellpadding="2">
<xsl:apply-templates select="portfolioItem"/>
</table>
</xsl:template>

<xsl:template match="portfolioItem">
<tr><td valign="top">
<b><xsl:value-of select="title"/></b></td><td><xsl:value-of select="detail"/></td></tr>
</xsl:template>

<xsl:template match="skills">
<h2><xsl:value-of select="title"/></h2>
<xsl:apply-templates select="subgroup"/>
</xsl:template>

<xsl:template match="skills/subgroup">
	<h3><xsl:value-of select="title"/></h3>
	<ul>
	<xsl:apply-templates select="item"/>
	</ul>
</xsl:template>

<xsl:template match="subgroup/item">
	<li><xsl:value-of select="."/></li>
</xsl:template>

<xsl:template match="community">
<h2><xsl:value-of select="title"/></h2>
<xsl:apply-templates select="service"/>
</xsl:template>

<xsl:template match="community/service">
	<h3><xsl:value-of select="location"/></h3>
	<ul>
	<xsl:apply-templates select="item"/>
	</ul>
</xsl:template>

<xsl:template match="community/service/item">
	<li><xsl:value-of select="."/></li>
</xsl:template>

<xsl:template match="comment">
</xsl:template>

</xsl:stylesheet>







