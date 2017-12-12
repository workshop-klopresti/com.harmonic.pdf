<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <!--  KLL 2016-09-16 Updated font styles and placement for 2016 rebranding-->

    <xsl:attribute-set name="__frontmatter">
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="margin-top">1.75in</xsl:attribute>
        <xsl:attribute name="margin-bottom">1.0in</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__title" use-attribute-sets="common.title">
        <xsl:attribute name="font-family">Mr Jones</xsl:attribute>
        <xsl:attribute name="font-size">28pt</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="margin-left">.625in</xsl:attribute>
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__subtitle" use-attribute-sets="common.title">
        <xsl:attribute name="color">#bcbec0</xsl:attribute>
        <xsl:attribute name="font-family">Mr Jones</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="line-height">90%</xsl:attribute>
        <xsl:attribute name="margin-bottom">15pt</xsl:attribute>
        <xsl:attribute name="margin-left">.625in</xsl:attribute>
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="text-transform">uppercase</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__release">
        <xsl:attribute name="color">
            <xsl:value-of select="$light-accent-color"/>
        </xsl:attribute>
        <xsl:attribute name="font-family">Mr Jones</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="line-height">90%</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="margin-bottom">.15in</xsl:attribute>
        <xsl:attribute name="margin-left">.625in</xsl:attribute>
    </xsl:attribute-set>

    <!--Applied to the value of $documentCategory-->
    <xsl:attribute-set name="__frontmatter__document__category">
        <xsl:attribute name="font-family">Mr Jones</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="space-before">2pt</xsl:attribute>
        <xsl:attribute name="margin-left">.625in</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__version">
        <xsl:attribute name="font-size">24pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="margin-left">2.3in</xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$dark-accent-color"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__draft">
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
        <xsl:attribute name="background-color">#ffff80</xsl:attribute>
        <xsl:attribute name="line-height">100%</xsl:attribute>
        <xsl:attribute name="padding">1mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__draft__container">
        <xsl:attribute name="position">absolute</xsl:attribute>
        <xsl:attribute name="top">8.5in</xsl:attribute>
        <xsl:attribute name="left">1in</xsl:attribute>
        <xsl:attribute name="width">2.75in</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__revision">
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__revision__container">
        <xsl:attribute name="position">absolute</xsl:attribute>
        <xsl:attribute name="top">8.25in</xsl:attribute>
        <xsl:attribute name="left">1in</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter_copyright">
        <xsl:attribute name="font-size">10pt</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>
