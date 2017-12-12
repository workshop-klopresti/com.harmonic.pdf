<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <!--  2017-06-02 -->
    <!--  DITA for Print: Change the format of cross-references -->
    <xsl:attribute-set name="xref" use-attribute-sets="common.link">
        <xsl:attribute name="color">
            <xsl:value-of select="$light-accent-color"/>
        </xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>

    <!--  2017-06-02 -->
    <!--  DITA for Print: Add divider above the related links section -->
    <xsl:attribute-set name="related-links.title">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="border-top">2pt solid #E6E6E6</xsl:attribute>
        <xsl:attribute name="padding-top">3pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>

    </xsl:attribute-set>

    <!--  2017-07-24 -->
    <!--  DITA for Print:  Change the format of related links-->
    <xsl:attribute-set name="link__content" use-attribute-sets="common.link">
        <xsl:attribute name="color">
            <xsl:value-of select="$light-accent-color"/>
        </xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:attribute-set>

    <!--  2017-07-17 -->
    <!--  DITA for Print: Change the format of related links -->
    <xsl:attribute-set name="link__page" use-attribute-sets="base-font">
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>


    <!-- KLL  29 February 2016 variable for links to steps in the same task             	-->
    <xsl:attribute-set name="xref_step">
        <xsl:attribute name="color">
            <xsl:value-of select="$light-accent-color"/>
        </xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
