<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <!-- Harmonic programming domain attribute sets -->

    <!--  2017-05-31 -->
    <!--  DITA for Print: Format code samples and messages -->
    <xsl:attribute-set name="codeph" use-attribute-sets="base-font">
        <xsl:attribute name="background-color">#e6e6e6</xsl:attribute>
        <xsl:attribute name="font-family">monospace</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="codeblock" use-attribute-sets="pre">
        <xsl:attribute name="background-color">#e6e6e6</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
        <xsl:attribute name="start-indent">6pt + from-parent(start-indent)</xsl:attribute>
        <xsl:attribute name="end-indent">6pt + from-parent(end-indent)</xsl:attribute>
        <xsl:attribute name="padding">6pt</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
