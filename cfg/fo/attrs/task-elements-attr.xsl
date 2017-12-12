<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <!--  2017-06-02 -->
    <!--  DITA for Print: Format task section labels and text -->
    <!-- KLL   23-March-2016 Transform Change Request consistent paragraph spacing for prereq content, similar to context paragraph -->
    <xsl:attribute-set name="task.title" use-attribute-sets="section">
        <xsl:attribute name="color">#000000</xsl:attribute>
        <xsl:attribute name="font-family">Futura, Arial, Helvetica, Tahoma</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="task__content" use-attribute-sets="section__content">
        <xsl:attribute name="font-family">Arial, Helvetica, Tahoma</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="prereq" use-attribute-sets="task.title"> </xsl:attribute-set>
    <xsl:attribute-set name="prereq__content" use-attribute-sets="task__content"> </xsl:attribute-set>

    <!-- KLL   23-March-2016 Transform Change Request consistent spacing for context -->
    <xsl:attribute-set name="context" use-attribute-sets="section">
        <xsl:attribute name="color">#000000</xsl:attribute>
        <xsl:attribute name="font-family">Arial, Helvetica, Tahoma</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="context__content" use-attribute-sets="section__content"> </xsl:attribute-set>

    <xsl:attribute-set name="info">
        <xsl:attribute name="space-before">1pt</xsl:attribute>
        <xsl:attribute name="space-after">4pt</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="stepresult">
        <xsl:attribute name="space-before">6pt</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="stepresult__content">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="space-before">6pt</xsl:attribute>
    </xsl:attribute-set>

    <!--  KLL 2017-07-28 Updated Result title to match Example title-->
    <!-- Formats Task Result title   -->
    <xsl:attribute-set name="result">
        <xsl:attribute name="font-family">Arial, Helvetica, Tahoma</xsl:attribute>
        <xsl:attribute name="space-before">6pt</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
    </xsl:attribute-set>

    <!-- Formats paragraph following  Task Result title   -->
    <xsl:attribute-set name="result__content">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="space-before">6pt</xsl:attribute>
    </xsl:attribute-set>
<!--
    <!-\-  KLL 2016-07-22 Transform change request: Updated formatting for task example titles -\->
    <xsl:attribute-set name="example">
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="border-left-style">none</xsl:attribute>
        <xsl:attribute name="border-right-style">none</xsl:attribute>
        <xsl:attribute name="space-before">6pt</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-together.within-page">auto</xsl:attribute>
    </xsl:attribute-set>

    <!-\-  KLL 2016-07-22 transform change request: font color from gray to black -\->
    <xsl:attribute-set name="example__content">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="space-before">6pt</xsl:attribute>
    </xsl:attribute-set>

    <!-\-  KLL 2017-07-28 Updated Task Result title to match Example title-\->
    <xsl:attribute-set name="task.result" use-attribute-sets="task.example">
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="task.result__content" use-attribute-sets="task.example__content"> </xsl:attribute-set>
-->
    <!--DITA for Print-->
    <xsl:attribute-set name="postreq" use-attribute-sets="section">
        <xsl:attribute name="color">#000000</xsl:attribute>
        <xsl:attribute name="font-family">Arial, Helvetica, Tahoma</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <!-- [SP] 2016-09-26 sfb: Changed space-above/below to space-before/space-after-->
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="space-after">4pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="postreq__content" use-attribute-sets="section__content"> </xsl:attribute-set>

    <!--  KLL 2016-09-02 Transform Request: add space after <cmd> and before <stepxmp> -->
    <xsl:attribute-set name="stepxmp">
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
        <xsl:attribute name="font-family">Arial, Helvetica, Tahoma</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="stepxmp__content">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
    </xsl:attribute-set>

    <!--Ordered steps-->
    <xsl:attribute-set name="steps" use-attribute-sets="ol"> </xsl:attribute-set>
    <!-- KLL   23-March-2016 Transform Change Request more space before steps  -->
    <xsl:attribute-set name="steps.step" use-attribute-sets="ol.li">
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="space-before">7pt</xsl:attribute>
    </xsl:attribute-set>

    <!--DITA for Print-->
    <xsl:attribute-set name="steps.step__label__content" use-attribute-sets="ol.li__label__content">
        <xsl:attribute name="font-family">Arial, Helvetica, Tahoma</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
        <!-- <xsl:attribute name="font-weight">bold</xsl:attribute>-->
        <xsl:attribute name="color">
            <xsl:value-of select="$text-color"/>
        </xsl:attribute>
        <!-- [SP] 2016-09-26 sfb: Changed space-above/below to space-before/space-after-->
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="space-after">0pt</xsl:attribute>
        <xsl:attribute name="line-height">12pt</xsl:attribute>
    </xsl:attribute-set>

    <!--Substeps-->
    <xsl:attribute-set name="substeps" use-attribute-sets="ol">
        <!-- [SP] 2016-09-26 sfb: Changed space-above/below to space-before/space-after-->
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="space-after">0pt</xsl:attribute>
        <xsl:attribute name="line-height">12pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="substeps.substep" use-attribute-sets="ol.li"> </xsl:attribute-set>

    <!--DITA for Print-->
    <xsl:attribute-set name="substeps.substep__label" use-attribute-sets="ol.li__label">
        <xsl:attribute name="font-family">Arial, Helvetica, Tahoma</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <!-- <xsl:attribute name="font-weight">bold</xsl:attribute>-->
        <xsl:attribute name="color">#000000</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="substeps.substep__label__content"
        use-attribute-sets="ol.li__label__content">
        <xsl:attribute name="font-family">Arial, Helvetica, Tahoma</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <!-- <xsl:attribute name="font-weight">bold</xsl:attribute>-->
        <xsl:attribute name="color">
            <xsl:value-of select="$text-color"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <!--Choicetable-->
    <xsl:attribute-set name="choicetable" use-attribute-sets="base-font">
        <!--It is a table container -->
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
    </xsl:attribute-set>

    <!--  KLL 2017-10-16 Formats text for choice table body cells-->
    <xsl:attribute-set name="choicetable__body"> </xsl:attribute-set>

    <xsl:attribute-set name="chhead"> </xsl:attribute-set>

    <xsl:attribute-set name="chhead__row"> </xsl:attribute-set>

    <!--  KLL 2017-10-16 Formats body text for choice table -->
    <xsl:attribute-set name="chrow">
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="border-right-style">none</xsl:attribute>
        <xsl:attribute name="border-left-style">none</xsl:attribute>
    </xsl:attribute-set>

    <!--  KLL 2017-10-16 Formats heading text for choice table Option column -->
    <xsl:attribute-set name="chhead.choptionhd"> </xsl:attribute-set>

    <xsl:attribute-set name="chhead.choptionhd__content"> </xsl:attribute-set>

    <!--  KLL 2017-10-16 Formats heading text for choice table Description column -->
    <xsl:attribute-set name="chhead.chdeschd"> </xsl:attribute-set>

    <xsl:attribute-set name="chhead.chdeschd__content"> </xsl:attribute-set>

    <!--  KLL 2017-07-10 Choice tables: set column 1 to 1.5inches wide -->
    <xsl:attribute-set name="chrow.choption">
        <xsl:attribute name="width">1.5in</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="chrow.choption__keycol-content">
        <xsl:attribute name="relative-align">baseline</xsl:attribute>
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="border-right-style">none</xsl:attribute>
        <xsl:attribute name="border-left-style">none</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="chrow.choption__content"> </xsl:attribute-set>

    <xsl:attribute-set name="chrow.chdesc"> </xsl:attribute-set>

    <xsl:attribute-set name="chrow.chdesc__keycol-content"> </xsl:attribute-set>

    <xsl:attribute-set name="chrow.chdesc__content">
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="border-right-style">none</xsl:attribute>
        <xsl:attribute name="border-left-style">none</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
