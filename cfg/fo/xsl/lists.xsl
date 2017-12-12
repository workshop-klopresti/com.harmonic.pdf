<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <!--  2017-05-23 -->
    <!--  DITA for Print: Select specific elements by context -->
    <xsl:template match="*[contains(@class, ' topic/ul ')]/*[contains(@class, ' topic/li ')]">
        <xsl:choose>
            <xsl:when test="not(preceding-sibling::li)">
                <fo:list-item xsl:use-attribute-sets="ul.li.first">
                    <xsl:apply-templates
                        select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]"
                        mode="flag-attributes"/>
                    <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
                        <fo:block xsl:use-attribute-sets="ul.li__label__content">
                            <fo:inline>
                                <xsl:call-template name="commonattributes"/>
                            </fo:inline>
                            <xsl:choose>
                                <xsl:when test="../@outputclass = 'checklist'">
                                    <fo:inline font-size="18pt" baseline-shift="-8%">
                                        <xsl:call-template name="getVariable">
                                            <xsl:with-param name="id" select="'Checklist bullet'"/>
                                        </xsl:call-template>
                                    </fo:inline>
                                </xsl:when>
                                <xsl:when test="ancestor::*[contains(@class, ' topic/li ')]">
                                    <xsl:call-template name="getVariable">
                                        <xsl:with-param name="id"
                                            select="'Unordered List bullet nested'"/>
                                    </xsl:call-template>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:call-template name="getVariable">
                                        <xsl:with-param name="id" select="'Unordered List bullet'"/>
                                    </xsl:call-template>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body xsl:use-attribute-sets="ul.li__body">
                        <fo:block xsl:use-attribute-sets="ul.li__content">
                            <xsl:apply-templates/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-item xsl:use-attribute-sets="ul.li">
                    <xsl:apply-templates
                        select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]"
                        mode="flag-attributes"/>
                    <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
                        <fo:block xsl:use-attribute-sets="ul.li__label__content">
                            <fo:inline>
                                <xsl:call-template name="commonattributes"/>
                            </fo:inline>
                            <xsl:choose>
                                <xsl:when test="../@outputclass = 'checklist'">
                                    <fo:inline font-size="18pt" baseline-shift="-8%">
                                        <xsl:call-template name="getVariable">
                                            <xsl:with-param name="id" select="'Checklist bullet'"/>
                                        </xsl:call-template>
                                    </fo:inline>
                                </xsl:when>
                                <xsl:when test="ancestor::*[contains(@class, ' topic/li ')]">
                                    <xsl:call-template name="getVariable">
                                        <xsl:with-param name="id"
                                            select="'Unordered List bullet nested'"/>
                                    </xsl:call-template>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:call-template name="getVariable">
                                        <xsl:with-param name="id" select="'Unordered List bullet'"/>
                                    </xsl:call-template>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body xsl:use-attribute-sets="ul.li__body">
                        <fo:block xsl:use-attribute-sets="ul.li__content">
                            <xsl:apply-templates/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>
