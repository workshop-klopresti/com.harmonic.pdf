<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="xs">

    <!--  2017-05-31 -->
    <!--  DITA for Print: Format topic titles-->
    <!--The side column width is the amount the body text is indented relative to the margin. -->
    <xsl:variable name="side-col-width">0pt</xsl:variable>


    <!--  2017-05-26 -->
    <!--  DITA for Print: Create a back cover -->
    <xsl:variable name="generate-back-cover" select="true()"/>

    <!--  2017-05-23 -->
    <!--  DITA for Print: Basic-settings variables in attribute sets -->
    <!--  KLL 2017-05-23 Updated accent colors for 2016 rebranding-->
    <xsl:variable name="text-color">#000000</xsl:variable>
    <xsl:variable name="dark-accent-color">#005695</xsl:variable>
    <xsl:variable name="light-accent-color">#24B1D9 </xsl:variable>

    <!--  2017-05-23 -->
    <!--  DITA for Print: Set up double-sided pagination -->
    <xsl:variable name="mirror-page-margins" select="true()"/>

    <!--  2017-05-23 -->
    <!--  DITA for Print: Set page dimensions -->
    <xsl:variable name="page-width">8.5in</xsl:variable>
    <xsl:variable name="page-height">11in</xsl:variable>
    <xsl:variable name="page-width-landscape">11in</xsl:variable>
    <xsl:variable name="page-height-landscape">8.5in</xsl:variable>

    <!--  2017-05-23 -->
    <!--  DITA for Print: Set page margins -->
    <xsl:variable name="page-margins">1in</xsl:variable>
    <xsl:variable name="page-margin-landscape">.5in</xsl:variable>
    <!-- Change these if your page has different margins on different sides. -->
    <xsl:variable name="page-margin-inside" select="$page-margins"/>
    <xsl:variable name="page-margin-outside" select="$page-margins"/>
    <xsl:variable name="page-margin-top" select="$page-margins"/>
    <xsl:variable name="page-margin-bottom" select="$page-margins"/>
    <!--  DITA for Print:  Set up body regions-->
    <xsl:variable name="body-margin">1.15in</xsl:variable>
    <!--  DITA for Print:  Set up margins for font cover page -->
    <xsl:variable name="page-margin-outside-front" select="$page-margins"/>
    <xsl:variable name="page-margin-top-front" select="$page-margins"/>
    <xsl:variable name="page-margin-bottom-front" select="$page-margins"/>
    <!--  DITA for Print: Design a separate layout for first pages -->
    <xsl:variable name="page-margin-top-first">2in</xsl:variable>
    <xsl:variable name="header-extent-first">0in</xsl:variable>

    <!--  2017-05-26 -->
    <!--  DITA for Print: Set body font sizes -->
    <xsl:variable name="default-font-size">10pt</xsl:variable>
    <!--  DITA for Print: Set default line height -->
    <xsl:variable name="default-line-height">120%</xsl:variable>

</xsl:stylesheet>
