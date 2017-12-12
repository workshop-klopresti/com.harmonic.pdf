<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!--  2017-06-01 -->
    <!--  DITA for Print: Format table rules -->
    <xsl:attribute-set name="__tableframe__top" use-attribute-sets="table.rule__top"> </xsl:attribute-set>

    <xsl:attribute-set name="__tableframe__bottom" use-attribute-sets="table.rule__bottom">
        <xsl:attribute name="border-after-width.conditionality">retain</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="thead__tableframe__bottom" use-attribute-sets="table.frame__bottom"> </xsl:attribute-set>

    <xsl:attribute-set name="__tableframe__left" use-attribute-sets="table.rule__left"> </xsl:attribute-set>

    <xsl:attribute-set name="__tableframe__right" use-attribute-sets="table.rule__right"> </xsl:attribute-set>

    <xsl:attribute-set name="table__tableframe__top" use-attribute-sets="table.frame__top"> </xsl:attribute-set>

    <xsl:attribute-set name="table__tableframe__bottom" use-attribute-sets="table.frame__bottom"> </xsl:attribute-set>

    <xsl:attribute-set name="table__tableframe__right" use-attribute-sets="table.frame__right"> </xsl:attribute-set>

    <xsl:attribute-set name="table__tableframe__left" use-attribute-sets="table.frame__left"> </xsl:attribute-set>

    <!--  2017-06-01 -->
    <!--  DITA for Print: Format table cell text  -->
    <!--body cell contents-->
    <xsl:attribute-set name="tbody.row.entry__content" use-attribute-sets="common.table.body.entry">
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="color">#000000</xsl:attribute>
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="start-indent">10pt</xsl:attribute>
        <xsl:attribute name="end-indent">10pt</xsl:attribute>
    </xsl:attribute-set>

    <!--  2017-06-01 -->
    <!--  DITA for Print: Format the table heading row -->
    <!--heading cell-->
    <xsl:attribute-set name="thead.row.entry">
        <xsl:attribute name="background-color">#c1c1c1</xsl:attribute>
    </xsl:attribute-set>

    <!--heading cell contents-->
    <xsl:attribute-set name="thead.row.entry__content"
        use-attribute-sets="common.table.body.entry common.table.head.entry">
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="color">#000000</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table.title" use-attribute-sets="base-font common.title">
        <xsl:attribute name="font-weight">regular</xsl:attribute>
        <xsl:attribute name="space-before">6pt</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="line-height">12pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$text-color"/>
        </xsl:attribute>
        <!-- [SP-JLC] 2/22/16 Changed from "always" to "auto" to prevent tables from running off of pages -->
        <xsl:attribute name="keep-with-previous.within-column">auto</xsl:attribute>
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
    </xsl:attribute-set>

    <!--  DEFINITION LIST FORMATTING -->
    <!--  KLL 2016-10-07 definition list formatting for paragraph output (outputclass = dl-hortizontal)-->
    <xsl:attribute-set name="dl__paragraph"> </xsl:attribute-set>

    <xsl:attribute-set name="dlentry.dt__content__para">
        <xsl:attribute name="start-indent">from-parent(start-indent) + 0mm</xsl:attribute>
        <xsl:attribute name="keep-with-next">always</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-before">5pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlentry.dd__content__para">
        <xsl:attribute name="start-indent">from-parent(start-indent) + 5mm</xsl:attribute>
        <xsl:attribute name="space-after">5pt</xsl:attribute>
    </xsl:attribute-set>

    <!--  KLL 2016-10-07 definition list formatting for 2-column table format (default)-->
    <!-- 02-16-2016 Updated dl margins to line up with choice table-->
    <xsl:attribute-set name="dl">
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="space-before">5pt</xsl:attribute>
        <xsl:attribute name="space-after">5pt</xsl:attribute>
        <xsl:attribute name="margin-right">.2in</xsl:attribute>
    </xsl:attribute-set>

    <!-- Formats definition term table cell -->
    <xsl:attribute-set name="dlentry.dt">
        <xsl:attribute name="width">1.5in</xsl:attribute>
        <xsl:attribute name="relative-align">baseline</xsl:attribute>
    </xsl:attribute-set>

    <!-- Formats definition term text -->
    <xsl:attribute-set name="dlentry.dt__content"
        use-attribute-sets="common.table.body.entry common.table.head.entry">
        <!-- [Scriptorium] 2016-03-30 sfb: Override D4P-imposed attribute.-->
        <xsl:attribute name="keep-with-next">auto</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>


</xsl:stylesheet>
