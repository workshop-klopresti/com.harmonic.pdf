<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <!--  2017-05-25 -->
    <!--  DITA for Print: Design a separate layout for first pages -->
    <xsl:attribute-set name="region-body.first">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$page-margin-top-first"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$page-margin-bottom"/>
        </xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-left' else 'margin-right'}">
            <xsl:value-of select="$page-margin-inside"/>
        </xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-right' else 'margin-left'}">
            <xsl:value-of select="$page-margin-outside"/>
        </xsl:attribute>
        <!--  KLL 2017-10-16 Use color attribute for testing first page margins-->
        <!--#c0ffc0 color is a light green    -->
        <!--        <xsl:attribute name="background-color"> #c0ffc0 </xsl:attribute>
-->
    </xsl:attribute-set>

    <xsl:attribute-set name="region-before.first">
        <xsl:attribute name="extent">
            <xsl:value-of select="$header-extent-first"/>
        </xsl:attribute>
        <xsl:attribute name="display-align">before</xsl:attribute>
    </xsl:attribute-set>

    <!--DITA for Print Exercise-->
    <!--Front Page of PDF with Harmonic background-->
    <!-- Scriptorium 25-March-2016 changed margin values from null to 0in -->
    <xsl:attribute-set name="region-body__frontmatter.first">
        <xsl:attribute name="margin-top">0in</xsl:attribute>
        <xsl:attribute name="margin-bottom">0in</xsl:attribute>
        <xsl:attribute name="margin-left">0in</xsl:attribute>
        <xsl:attribute name="margin-right">0in</xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-left' else 'margin-right'}"
            >0in</xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-right' else 'margin-left'}"
            >0in</xsl:attribute>
        <!--        <!-\-  #ffc000 color is a light orange    -\->
        <xsl:attribute name="background-color">#ffc000</xsl:attribute>-->
        <!--  2017-05-25 -->
        <!--  DITA for Print: Add background image to a page -->
        <xsl:attribute name="background-image">
            <xsl:choose>
                <xsl:when test="$DRAFT = 'yes'"
                    >url(Customization/OpenTopic/common/artwork/manual_cover_draft.tif)</xsl:when>
                <xsl:otherwise>url(Customization/OpenTopic/common/artwork/manual_cover.tif)</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <!-- <xsl:attribute name="background-image"
            >url(Customization/OpenTopic/common/artwork/manual_cover.tif)</xsl:attribute>-->
        <xsl:attribute name="background-repeat">no-repeat</xsl:attribute>
        <xsl:attribute name="background-position">"0,0"</xsl:attribute>
    </xsl:attribute-set>

    <!--  2017-05-25 -->
    <!--  DITA for Print: Set margins for font cover page -->
    <xsl:attribute-set name="region-body__frontmatter.odd" use-attribute-sets="region-body.odd">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$page-margin-top-front"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$page-margin-bottom-front"/>
        </xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-left' else 'margin-right'}">
            <xsl:value-of select="$page-margin-inside"/>
        </xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-right' else 'margin-left'}">
            <xsl:value-of select="$page-margin-outside-front"/>
        </xsl:attribute>
        <!--#ffc000 color is a light orange -->
        <xsl:attribute name="background-color">#ffc0ff</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="region-body__frontmatter.even" use-attribute-sets="region-body.even">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$page-margin-top-front"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$page-margin-bottom-front"/>
        </xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-left' else 'margin-right'}">
            <xsl:value-of select="$page-margin-inside"/>
        </xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-right' else 'margin-left'}">
            <xsl:value-of select="$page-margin-outside-front"/>
        </xsl:attribute>
        <!--#ffc000 color is a light orange -->
        <xsl:attribute name="background-color">#ffc0ff</xsl:attribute>
    </xsl:attribute-set>

    <!--  2017-05-25 -->
    <!--  DITA for Print:  Set up body regions-->
    <xsl:attribute-set name="region-body.odd">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$body-margin"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$body-margin"/>
        </xsl:attribute>
        <!--#C0C0C0 color is a gray -->
        <!--<xsl:attribute name="background-color">#C0C0C0</xsl:attribute>-->
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-left' else 'margin-right'}">
            <xsl:value-of select="$page-margin-inside"/>
        </xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-right' else 'margin-left'}">
            <xsl:value-of select="$page-margin-outside"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="region-body.even">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$body-margin"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$body-margin"/>
        </xsl:attribute>
        <!--#C0C0C0 color is a gray -->
        <!--<xsl:attribute name="background-color">#C0C0C0</xsl:attribute>-->
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-left' else 'margin-right'}">
            <xsl:value-of select="$page-margin-outside"/>
        </xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-right' else 'margin-left'}">
            <xsl:value-of select="$page-margin-inside"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <!--  KLL 2017-05-26 Back cover body region-->
    <xsl:attribute-set name="region-backmatter.last">
        <xsl:attribute name="margin-top">0in</xsl:attribute>
        <xsl:attribute name="margin-bottom">0in</xsl:attribute>
        <xsl:attribute name="margin-left">0in</xsl:attribute>
        <xsl:attribute name="margin-right">0in</xsl:attribute>
        <!--#a9b0e8 color is a lavender -->
        <!--<xsl:attribute name="background-color">#a9b0e8</xsl:attribute>-->
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-left' else 'margin-right'}"
            >0in</xsl:attribute>
        <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-right' else 'margin-left'}"
            >0in</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
