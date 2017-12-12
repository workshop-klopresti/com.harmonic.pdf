<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic-mapmerge="http://www.idiominc.com/opentopic/mapmerge"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="dita-ot opentopic-mapmerge opentopic-func related-links xs"
    version="2.0">

    <!--  KLL 2017-07-24 -->
    <!-- Create list with createMapLinks to generate Prereqs list, similar to WebHelp output. -->
    <xsl:template name="createMapLinks">
        <xsl:param name="nodeSet"/>
        <xsl:param name="title"/>
        <xsl:param name="listType" select="'none'"/>
    </xsl:template>

    <!--  2017-07-24 -->
    <!--  DITA for Print: Add a divider above the Related Links section  -->
    <xsl:template match="*[contains(@class, ' topic/related-links ')]">
        <xsl:if test="exists($includeRelatedLinkRoles)">

            <xsl:variable name="topicType">
                <xsl:for-each select="parent::*">
                    <xsl:call-template name="determineTopicType"/>
                </xsl:for-each>
            </xsl:variable>

            <xsl:variable name="collectedLinks">
                <xsl:apply-templates>
                    <xsl:with-param name="topicType" select="$topicType"/>
                </xsl:apply-templates>
            </xsl:variable>

            <xsl:variable name="linkTextContent" select="string($collectedLinks)"/>

            <xsl:if test="normalize-space($linkTextContent) != ''">
                <fo:block xsl:use-attribute-sets="related-links">
                    <fo:block-container width="3in" padding-top="6pt">
                        <fo:block xsl:use-attribute-sets="related-links.title">
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Related information'"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:block-container>
                    <fo:block xsl:use-attribute-sets="related-links__content">
                        <xsl:copy-of select="$collectedLinks"/>
                    </fo:block>
                </fo:block>
            </xsl:if>

            <!--  KLL 2017-07-24 Uncomment to see related links by topic type: concept, reference, task-->
            <!--          <fo:block xsl:use-attribute-sets="related-links">
                <fo:block xsl:use-attribute-sets="related-links__content">
                    <xsl:if test="$includeRelatedLinkRoles = ('child', 'descendant')">
                        <xsl:call-template name="ul-child-links"/>
                        <xsl:call-template name="ol-child-links"/>
                    </xsl:if>
                    <!-\-xsl:if test="$includeRelatedLinkRoles = ('next', 'previous', 'parent')">
            <xsl:call-template name="next-prev-parent-links"/>
          </xsl:if-\->
                    <xsl:variable name="unordered-links" as="element()*">
                        <xsl:apply-templates select="." mode="related-links:group-unordered-links">
                            <xsl:with-param name="nodes"
                                select="
                                    descendant::*[contains(@class, ' topic/link ')]
                                    [not(related-links:omit-from-unordered-links(.))]
                                    [generate-id(.) = generate-id(key('hideduplicates', related-links:hideduplicates(.))[1])]"
                            />
                        </xsl:apply-templates>
                    </xsl:variable>
                    <xsl:apply-templates select="$unordered-links"/>
                    <!-\-linklists - last but not least, create all the linklists and their links, with no sorting or re-ordering-\->
                    <xsl:apply-templates select="*[contains(@class, ' topic/linklist ')]"/>
                </fo:block>
            </fo:block>-->
        </xsl:if>
    </xsl:template>

    <xsl:template name="insertPageNumberCitation">
        <xsl:param name="isTitleEmpty" as="xs:boolean" select="false()"/>
        <xsl:param name="destination" as="xs:string"/>
        <xsl:param name="element" as="element()?"/>

        <xsl:choose>
            <xsl:when test="not($element) or ($destination = '')"/>
            <xsl:when test="$isTitleEmpty">
                <fo:inline>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Page'"/>
                        <xsl:with-param name="params">
                            <pagenum>
                                <fo:inline>
                                    <fo:page-number-citation ref-id="{$destination}"/>
                                </fo:inline>
                            </pagenum>
                        </xsl:with-param>
                    </xsl:call-template>
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline xsl:use-attribute-sets="link__page">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'On the page'"/>
                        <xsl:with-param name="params">
                            <pagenum>
                                <fo:inline>
                                    <fo:page-number-citation ref-id="{$destination}"/>
                                </fo:inline>
                            </pagenum>
                        </xsl:with-param>
                    </xsl:call-template>
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/link ')]" mode="processLink">
        <xsl:variable name="destination" select="opentopic-func:getDestinationId(@href)"/>
        <xsl:variable name="element" select="key('key_anchor', $destination, $root)[1]"/>

        <xsl:variable name="referenceTitle" as="node()*">
            <xsl:apply-templates select="." mode="insertReferenceTitle">
                <xsl:with-param name="href" select="@href"/>
                <xsl:with-param name="titlePrefix" select="''"/>
                <xsl:with-param name="destination" select="$destination"/>
                <xsl:with-param name="element" select="$element"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:variable name="linkScope" as="xs:string">
            <xsl:call-template name="getLinkScope"/>
        </xsl:variable>

        <fo:block xsl:use-attribute-sets="link">
            <fo:inline xsl:use-attribute-sets="link__content">
                <fo:basic-link>
                    <xsl:call-template name="buildBasicLinkDestination">
                        <xsl:with-param name="scope" select="$linkScope"/>
                        <xsl:with-param name="href" select="@href"/>
                    </xsl:call-template>
                    <xsl:choose>
                        <xsl:when test="not($linkScope = 'external') and exists($referenceTitle)">
                            <xsl:copy-of select="$referenceTitle"/>
                        </xsl:when>
                        <xsl:when test="not($linkScope = 'external')">
                            <xsl:call-template name="insertPageNumberCitation">
                                <xsl:with-param name="isTitleEmpty" select="true()"/>
                                <xsl:with-param name="destination" select="$destination"/>
                                <xsl:with-param name="element" select="$element"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="*[contains(@class, ' topic/linktext ')]"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:basic-link>
            </fo:inline>
            <xsl:if test="not($linkScope = 'external') and exists($referenceTitle)">
                <xsl:call-template name="insertPageNumberCitation">
                    <xsl:with-param name="destination" select="$destination"/>
                    <xsl:with-param name="element" select="$element"/>
                </xsl:call-template>
            </xsl:if>
            <!--  KLL 2017-07-24 Uncomment to view short description in Related Links -->
            <!--<xsl:call-template name="insertLinkShortDesc">
                <xsl:with-param name="destination" select="$destination"/>
                <xsl:with-param name="element" select="$element"/>
                <xsl:with-param name="linkScope" select="$linkScope"/>
            </xsl:call-template>-->
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
