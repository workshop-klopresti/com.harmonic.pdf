<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic="http://www.idiominc.com/opentopic" xmlns:exsl="http://exslt.org/common"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" extension-element-prefixes="exsl"
    exclude-result-prefixes="ot-placeholder opentopic exsl opentopic-index exslf opentopic-func dita2xslfo xs"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 26 3, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> Tom Voltz</xd:p>
            <xd:p>This is part of a set of DITA plugin stylesheets for Harmonic PDF to style the
                frontmatter notices</xd:p>
        </xd:desc>
    </xd:doc>


    <!-- NOTICES pages -->
    <xsl:attribute-set name="notices-container">
        <!-- available to set any global layout options for the entire flow content for notices -->
    </xsl:attribute-set>

    <!-- NOTE:  These are not attribute sets, they are standard XSLT templates, that means that they can't inherit from other templates, but 
    can use $variables, etc.  These force the font sizes so that they override these values for FO blocks that have the wrong fonts "hard wired" 
    in the main attribute sets in use by the plugin.  -->
    <xsl:template name="reset_styles_if_notices_body">
        <xsl:variable name="topicType">
            <xsl:call-template name="determineTopicType"/>
        </xsl:variable>
        <xsl:if test="$topicType = 'topicNotices'">
            <xsl:attribute name="font-size">7pt</xsl:attribute>
            <xsl:attribute name="line-height">
                <xsl:value-of select="$default-line-height"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <xsl:template name="reset_styles_if_notices_title">
        <xsl:variable name="topicType">
            <xsl:call-template name="determineTopicType"/>
        </xsl:variable>
        <xsl:if test="$topicType = 'topicNotices'">
            <xsl:attribute name="font-size">7pt</xsl:attribute>
            <xsl:attribute name="line-height">
                <xsl:value-of select="$default-line-height"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
