<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <!--  2017-05-26 -->
    <!--  DITA for Print: Format content on the back cover -->
    <xsl:attribute-set name="__backmatter__container">
        <xsl:attribute name="position">absolute</xsl:attribute>
        <xsl:attribute name="top">10in</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__backmatter__publish">
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="text-indent">.75in</xsl:attribute>
    </xsl:attribute-set>

    <!--  KLL 2016-09-16 Updated font for 2016 rebranding-->
    <xsl:attribute-set name="__backmatter__website">
        <xsl:attribute name="color">
            <xsl:value-of select="$light-accent-color"/>
        </xsl:attribute>
        <xsl:attribute name="font-family">Mr Jones</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="text-indent">.75in</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
