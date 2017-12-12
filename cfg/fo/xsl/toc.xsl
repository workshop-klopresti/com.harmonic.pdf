<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:exsl="http://exslt.org/common" xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    extension-element-prefixes="exsl"
    exclude-result-prefixes="xs exsl opentopic exslf opentopic-func ot-placeholder" version="2.0">


    <!--<!-\-  KLL 2016-06-29 Updated chapter numbers to continue sequentially even when bookmap has parts -\->
    <xsl:template
        match="
            *[contains(@class, ' bookmap/chapter ')] |
            *[contains(@class, ' boookmap/bookmap ')]/opentopic:map/*[contains(@class, ' map/topicref ')]"
        mode="tocPrefix" priority="-1">
        <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Table of Contents Chapter'"/>
            <xsl:with-param name="params">
                <number>
                    <xsl:variable name="id" select="@id"/>
                    <xsl:variable name="topicChapters">
                        <xsl:copy-of select="$map//*[contains(@class, ' bookmap/chapter ')]"/>
                    </xsl:variable>
                    <xsl:variable name="chapterNumber">
                        <xsl:number format="1"
                            value="count($topicChapters/*[@id = $id]/preceding-sibling::*) + 1"/>
                    </xsl:variable>
                    <xsl:value-of select="$chapterNumber"/>
                </number>
                <!-\-<number>
                    <xsl:apply-templates select="." mode="topicTitleNumber"/>
                </number>-\->
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
-->

    <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="toc">
        <xsl:param name="include"/>
        <xsl:variable name="topicLevel" as="xs:integer">
            <xsl:apply-templates select="." mode="get-topic-level"/>
        </xsl:variable>
        <xsl:if test="$topicLevel &lt; $tocMaximumLevel">
            <xsl:variable name="mapTopicref" select="key('map-id', @id)[1]"/>
            <xsl:choose>
                <!-- In a future version, suppressing Notices in the TOC should not be hard-coded. -->
                <xsl:when test="$mapTopicref/self::*[contains(@class, ' bookmap/notices ')]"/>
                <xsl:when
                    test="
                        $mapTopicref[@toc = 'yes' or not(@toc)] or
                        (not($mapTopicref) and $include = 'true')">
                    <fo:block xsl:use-attribute-sets="__toc__indent">
                        <xsl:variable name="tocItemContent">
                            <fo:basic-link xsl:use-attribute-sets="__toc__link">
                                <xsl:attribute name="internal-destination">
                                    <xsl:call-template name="generate-toc-id"/>
                                </xsl:attribute>
                                <xsl:apply-templates select="$mapTopicref" mode="tocPrefix"/>
                                <fo:inline xsl:use-attribute-sets="__toc__title">
                                    <xsl:call-template name="getNavTitle"/>
                                </fo:inline>
                                <fo:inline xsl:use-attribute-sets="__toc__page-number">
                                    <!--DITA for Print-->
                                    <fo:leader xsl:use-attribute-sets="__toc__leader"/>

                                    <!--   <xsl:call-template name="getChapterPrefix" />                                 
								  <xsl:text>-</xsl:text>-->
                                    <fo:page-number-citation>
                                        <xsl:attribute name="ref-id">
                                            <xsl:call-template name="generate-toc-id"/>
                                        </xsl:attribute>
                                    </fo:page-number-citation>
                                </fo:inline>
                            </fo:basic-link>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="not($mapTopicref)">
                                <xsl:apply-templates select="." mode="tocText">
                                    <xsl:with-param name="tocItemContent" select="$tocItemContent"/>
                                    <xsl:with-param name="currentNode" select="."/>
                                </xsl:apply-templates>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="$mapTopicref" mode="tocText">
                                    <xsl:with-param name="tocItemContent" select="$tocItemContent"/>
                                    <xsl:with-param name="currentNode" select="."/>
                                </xsl:apply-templates>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
                    <xsl:apply-templates mode="toc">
                        <xsl:with-param name="include" select="'true'"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="toc">
                        <xsl:with-param name="include" select="'true'"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template
        match="
            *[contains(@class, ' bookmap/chapter ')] |
            *[contains(@class, ' boookmap/bookmap ')]/opentopic:map/*[contains(@class, ' map/topicref ')]"
        mode="tocPrefix" priority="-1">
        <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Table of Contents Chapter'"/>
            <xsl:with-param name="params">
                <!--  KLL 2016-06-29 Updated chapter numbers to continue sequentially even when bookmap has parts -->
                <number>
                    <xsl:variable name="id" select="@id"/>
                    <xsl:variable name="topicChapters">
                        <xsl:copy-of select="$map//*[contains(@class, ' bookmap/chapter ')]"/>
                    </xsl:variable>
                    <xsl:variable name="chapterNumber">
                        <xsl:number format="1"
                            value="count($topicChapters/*[@id = $id]/preceding-sibling::*) + 1"/>
                    </xsl:variable>
                    <xsl:value-of select="$chapterNumber"/>
                </number>
                <!--<number>
                    <xsl:apply-templates select="." mode="topicTitleNumber"/>
                </number>-->
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
