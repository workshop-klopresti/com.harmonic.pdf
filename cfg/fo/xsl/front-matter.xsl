<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:opentopic="http://www.idiominc.com/opentopic"
    exclude-result-prefixes="opentopic" version="2.0">

    <xsl:template name="createFrontMatter">
        <xsl:if test="$generate-front-cover">
            <fo:page-sequence master-reference="front-matter"
                xsl:use-attribute-sets="page-sequence.cover">
                <xsl:call-template name="insertFrontMatterStaticContents"/>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block-container xsl:use-attribute-sets="__frontmatter">
                        <xsl:call-template name="createFrontCoverContents"/>
                    </fo:block-container>
                </fo:flow>
            </fo:page-sequence>
        </xsl:if>
    </xsl:template>

    <xsl:template name="createFrontCoverContents">
        <!-- set the title -->
        <fo:block xsl:use-attribute-sets="__frontmatter__title">
            <xsl:choose>
                <xsl:when test="$map/*[contains(@class, ' topic/title ')][1]">
                    <xsl:apply-templates select="$map/*[contains(@class, ' topic/title ')][1]"/>
                </xsl:when>
                <xsl:when test="$map//*[contains(@class, ' bookmap/mainbooktitle ')][1]">
                    <xsl:apply-templates
                        select="$map//*[contains(@class, ' bookmap/mainbooktitle ')][1]"/>
                </xsl:when>
                <xsl:when test="//*[contains(@class, ' map/map ')]/@title">
                    <xsl:value-of select="//*[contains(@class, ' map/map ')]/@title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="/descendant::*[contains(@class, ' topic/topic ')][1]/*[contains(@class, ' topic/title ')]"
                    />
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
        <!-- set the subtitle -->
        <xsl:apply-templates select="$map//*[contains(@class, ' bookmap/booktitlealt ')]"/>
        <!-- set the product release number -->
        <fo:block xsl:use-attribute-sets="__frontmatter__release">
            <xsl:choose>
                <xsl:when
                    test="$map/*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/prodinfo ')]/*[contains(@class, ' topic/vrmlist ')]/*[contains(@class, ' topic/vrm ')]/@release != ''">
                    <xsl:text>Release </xsl:text>
                    <xsl:value-of select="$productRelease"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
        <!-- set the guide type: installation, user, etc. -->
        <fo:block xsl:use-attribute-sets="__frontmatter__document__category">
            <xsl:value-of select="$documentCategory"/>
        </fo:block>
        <fo:block-container xsl:use-attribute-sets="__frontmatter__draft__container">
            <fo:block>
                <xsl:choose>
                    <xsl:when test="$DRAFT = 'yes'">
                        <fo:block xsl:use-attribute-sets="__frontmatter__draft">
                            <xsl:value-of select="$currentDate"/>
                        </fo:block>
                        <fo:block xsl:use-attribute-sets="__frontmatter__draft">Draft Copy Not for
                            Distribution</fo:block>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </fo:block>
        </fo:block-container>

        <!-- set the revision letter -->
        <fo:block-container xsl:use-attribute-sets="__frontmatter__revision__container">
            <fo:block xsl:use-attribute-sets="__frontmatter__revision">Revision&#160;<xsl:value-of
                    select="$documentRevision"/>
            </fo:block>
        </fo:block-container>
    </xsl:template>
</xsl:stylesheet>
