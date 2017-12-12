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
            <xd:p><xd:b>Created on:</xd:b> Dec 4, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> tvoltz</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>


    <xsl:template name="processTopicNotices">
        <!-- TOMV (2014-11) Update page sequence to notice-sequence (new) -->
        <fo:page-sequence master-reference="notice-sequence"
            xsl:use-attribute-sets="__force__page__count" format="1" initial-page-number="2">
            <xsl:call-template name="insertNoticeStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block-container xsl:use-attribute-sets="notices-container">
                    <fo:block>
                        <xsl:call-template name="commonattributes"/>
                        <xsl:if test="not(ancestor::*[contains(@class, ' topic/topic ')])">
                            <fo:marker marker-class-name="current-topic-number">
                                <xsl:number format="1"/>
                            </fo:marker>
                            <fo:marker marker-class-name="current-header">
                                <xsl:for-each select="child::*[contains(@class, ' topic/title ')]">
                                    <xsl:apply-templates select="." mode="getTitle"/>
                                </xsl:for-each>
                            </fo:marker>
                        </xsl:if>
                        <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>
                        <!-- TOMV:  Note the call below to insertChapterFirstpageStaticContent 
            will allow the template to add the for meta data, but 'notices' type makes
            sure not content is not added (headers, etc.)
 -->
                        <xsl:call-template name="insertChapterFirstpageStaticContent">
                            <xsl:with-param name="type" select="'notices'"/>
                        </xsl:call-template>
                        <!-- TOMV:  SUPRESS TITLE for frontmatter  notices
                    <fo:block xsl:use-attribute-sets="topic.title">
                       <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                            <xsl:apply-templates select="." mode="getTitle"/>
                        </xsl:for-each>
                    </fo:block>
                    
-->
                        <!-- TOMV: (2014-11) since title block is suppressed, the prolog index terms (if any) need to be inserted-->
                        <fo:block>
                            <xsl:call-template name="pullPrologIndexTerms"/>
                        </fo:block>
                        <!-- TOMV: Inject the book meta data at the top of the notices -->
                        <fo:block>
                            <xsl:call-template name="reset_styles_if_notices_body"/>
                            <fo:block>
                                <xsl:call-template name="getVariable">
                                    <xsl:with-param name="id" select="'Manual Part Number'"/>
                                    <xsl:with-param name="params">
                                        <partNumber>
                                            <xsl:value-of select="$partNumber"/>
                                        </partNumber>
                                    </xsl:with-param>
                                </xsl:call-template>
                                <!--  Current format is MONTH YEAR, e.g., October 2014, should this be localized string template? -->
                                <fo:block>
                                    <xsl:choose>
                                        <xsl:when test="$productReleaseMonth">
                                            <xsl:value-of select="$productReleaseMonth"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of
                                                select="format-dateTime(current-dateTime(), '[MNn]')"
                                            />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:text> </xsl:text>
                                    <xsl:choose>
                                        <xsl:when test="$productReleaseYear">
                                            <xsl:value-of select="$productReleaseYear"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of
                                                select="format-dateTime(current-dateTime(), '[Y0001]')"
                                            />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                                <fo:block>
                                    <xsl:call-template name="getVariable">
                                        <xsl:with-param name="id"
                                            select="'Custom Copyright Statement'"/>
                                        <xsl:with-param name="params">
                                            <fromYear>
                                                <xsl:value-of select="$productCreatedDate"/>
                                            </fromYear>
                                            <toYear>
                                                <xsl:choose>
                                                  <xsl:when test="$productRevisedDate">
                                                  <xsl:value-of select="$productRevisedDate"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of
                                                  select="format-dateTime(current-dateTime(), '[Y0001]')"
                                                  />
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </toYear>
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </fo:block>
                            </fo:block>
                        </fo:block>
                        <!-- [SP] 2017-06-14 sfb: Added topic/related-links to the exclusions. -->
                        <xsl:apply-templates
                            select="
                                *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                contains(@class, ' topic/prolog ') or contains(@class, ' topic/related-links '))]"/>
                        <!-- [SP] 2017-06-14 sfb: Commented out buildRelationships. Not needed here (and this was the true source of the repeated frontmatter. -->
                        <!-- <xsl:apply-templates select="." mode="buildRelationships"/>-->
                        <!-- TOMV Note: handle the child topics in the notices container, currently these will *NOT* include the frontmatter-notices special formatting -->
                        <xsl:for-each select="*[contains(@class, ' topic/topic ')]">
                            <xsl:apply-templates select="." mode="processTopic"/>
                        </xsl:for-each>
                        <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                    </fo:block>
                </fo:block-container>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
</xsl:stylesheet>
