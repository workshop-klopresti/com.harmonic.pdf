<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">
    <xsl:template name="insertBodyStaticContents">
        <!-- [SP] 2016-07-29 sfb: type allows us to indicate chapters and appendixes. -->
        <xsl:param name="type" select="'#none#'"/>
        <xsl:call-template name="insertBodyFootnoteSeparator"/>
        <xsl:call-template name="insertBodyOddFooter"/>
        <xsl:if test="$mirror-page-margins">
            <xsl:call-template name="insertBodyEvenFooter"/>
        </xsl:if>
        <xsl:call-template name="insertBodyOddHeader"/>
        <xsl:if test="$mirror-page-margins">
            <xsl:call-template name="insertBodyEvenHeader">
                <xsl:with-param name="type" select="$type"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="insertBodyFirstHeader"/>
        <xsl:call-template name="insertBodyFirstFooter"/>
        <xsl:call-template name="insertBodyLastHeader"/>
        <xsl:call-template name="insertBodyLastFooter"/>
    </xsl:template>

    <!--  2017-05-26 -->
    <!--  DITA for Print: Create new header and footer definitions -->
    <xsl:template name="insertTocStaticContents">
        <xsl:call-template name="insertTocOddFooter"/>
        <xsl:if test="$mirror-page-margins">
            <xsl:call-template name="insertTocEvenFooter"/>
        </xsl:if>
        <xsl:call-template name="insertTocOddHeader"/>
        <xsl:if test="$mirror-page-margins">
            <xsl:call-template name="insertTocEvenHeader"/>
        </xsl:if>
        <xsl:call-template name="insertTocFirstHeader"/>
        <xsl:call-template name="insertTocFirstFooter"/>
    </xsl:template>

    <!--  2017-05-25 -->
    <!--  DITA for Print:  Set up odd footers -->
    <xsl:template name="insertBodyOddFooter">
        <fo:static-content flow-name="odd-body-footer">
            <!-- TOMV: simple footer that uses fo:leader to align right page no.  Alternative would be to use a three column table if some text is needed on the right. -->
            <fo:block xsl:use-attribute-sets="__body__odd__footer" margin-left="4.21in"
                text-align="justify" text-align-last="justify">
                <fo:inline xsl:use-attribute-sets="__body__odd__footer__pagenum">
                    <fo:page-number/>
                </fo:inline>
                <fo:leader leader-pattern="space"/>
                <fo:inline xsl:use-attribute-sets="footer__text">
                    <xsl:value-of select="$bc.productName"/>&#160;<xsl:value-of
                        select="$productRelease"/>&#160;<xsl:value-of select="$documentCategory"/>
                </fo:inline>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertTocOddFooter">
        <fo:static-content flow-name="odd-toc-footer">
            <fo:block xsl:use-attribute-sets="__toc__odd__footer" margin-left="4.21in"
                text-align="justify" text-align-last="justify">
                <fo:inline xsl:use-attribute-sets="__toc__odd__footer__pagenum">
                    <fo:page-number/>
                </fo:inline>
                <fo:leader leader-pattern="space"/>
                <fo:inline xsl:use-attribute-sets="footer__text">
                    <xsl:value-of select="$bc.productName"/>&#160;<xsl:value-of
                        select="$productRelease"/>&#160;<xsl:value-of select="$documentCategory"/>
                </fo:inline>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyEvenFooter">
        <fo:static-content flow-name="even-body-footer">
            <fo:block xsl:use-attribute-sets="__body__even__footer">
                <fo:inline xsl:use-attribute-sets="__body__even__footer__pagenum">
                    <fo:page-number/>
                </fo:inline>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertTocEvenFooter">
        <fo:static-content flow-name="even-toc-footer">
            <fo:block xsl:use-attribute-sets="__toc__even__footer">
                <fo:inline xsl:use-attribute-sets="__toc__even__footer__pagenum">
                    <fo:page-number/>
                </fo:inline>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!--  2017-05-25 -->
    <!--  DITA for Print: Set up headers that include map metadata  -->
    <!--  KLL 2016-07-21 Added chapter name/number to header -->
    <!-- [SP] 2016-07-29 sfb: Added type param to identify chapter and appendix headers. -->
    <xsl:template name="insertBodyEvenHeader">
        <xsl:param name="type" select="'#none#'"/>
        <!-- [SP] 2016-07-29 sfb: Get the ID of the current topic, then use a key to find it in the map. -->
        <xsl:variable name="id" select="@id"/>
        <xsl:variable name="topicref" select="key('map-id', $id)"/>
        <fo:static-content flow-name="even-body-header">
            <fo:block xsl:use-attribute-sets="__body__even__header">
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Body even header'"/>
                    <xsl:with-param name="params">
                        <title>
                            <xsl:choose>
                                <xsl:when test="$type = 'chapter'">
                                    <!-- [SP] 2016-07-29 sfb: TODO: use insertVariable to fetch this. -->
                                    <xsl:text>Chapter </xsl:text>
                                    <fo:inline
                                        xsl:use-attribute-sets="__body__even__header__heading">
                                        <!-- use preceding, because with parts, they may not all be siblings. -->
                                        <xsl:number format="1"
                                            value="count($topicref/preceding::*[contains(@class, ' bookmap/chapter ')]) + 1"/>
                                        <!--                                        <xsl:number format="1"  
                                            value="count($topicref/preceding-sibling::*[contains(@class,' bookmap/chapter ')]) + 1"/>-->
                                        <xsl:text>: </xsl:text>
                                        <fo:retrieve-marker retrieve-class-name="current-header"/>
                                    </fo:inline>
                                </xsl:when>
                                <xsl:when test="$type = 'appendix'">
                                    <!-- [SP] 2016-07-29 sfb: TODO: use insertVariable to fetch this. -->
                                    <xsl:text>Appendix </xsl:text>
                                    <fo:inline
                                        xsl:use-attribute-sets="__body__even__header__heading">
                                        <!-- use preceding, because with parts, they may not all be siblings. -->
                                        <xsl:number format="A"
                                            value="count($topicref/preceding::*[contains(@class, ' bookmap/appendix ')]) + 1"/>
                                        <!--                                        <xsl:number format="A"  
                                            value="count($topicref/preceding-sibling::*[contains(@class,' bookmap/appendix ')]) + 1"/>-->
                                        <xsl:text>: </xsl:text>
                                        <fo:retrieve-marker retrieve-class-name="current-header"/>
                                    </fo:inline>
                                </xsl:when>
                            </xsl:choose>
                            <!--                            <fo:inline
                                xsl:use-attribute-sets="__body__even__header__heading">
                                <xsl:variable name="chapterNumber">
                                    <xsl:number format="1"
                                        value="count($topicChapters/*[@id = $id]/preceding-sibling::*) + 1"
                                    />
                                </xsl:variable>
                                <xsl:value-of select="$chapterNumber"/>
                                <xsl:text>: </xsl:text>
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
-->
                        </title>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
            <fo:block>
                <xsl:call-template name="insertDraftImage"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertTocEvenHeader">
        <fo:static-content flow-name="even-toc-header">
            <fo:block xsl:use-attribute-sets="__toc__even__header">
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Toc even header'"/>
                    <xsl:with-param name="params">
                        <title>
                            <xsl:value-of select="$bc.bookTitle"/>
                        </title>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
            <fo:block>
                <xsl:call-template name="insertDraftImage"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!--  2017-05-25 -->
    <!--  DITA for Print: Use specific title level in running header -->
    <!--  DITA for Print: Set up headers that include generated text -->
    <xsl:template name="insertBodyOddHeader">
        <fo:static-content flow-name="odd-body-header">
            <fo:block xsl:use-attribute-sets="__body__odd__header">
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Body odd header'"/>
                    <xsl:with-param name="params">
                        <!--<prodname>
                            <xsl:value-of select="$bc.productName"/>
                        </prodname>-->
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__odd__header__heading">
                                <!--  KLL 2016-09-07 New header definition -->
                                <fo:retrieve-marker retrieve-class-name="current-h2"/>
                            </fo:inline>
                        </heading>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
            <fo:block>
                <xsl:call-template name="insertDraftImage"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!--  2017-05-25 -->
    <!--  DITA for Print: Set up headers that include boilerplate text -->
    <xsl:template name="insertTocOddHeader">
        <fo:static-content flow-name="odd-toc-header">
            <fo:block xsl:use-attribute-sets="__toc__odd__header">
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Toc odd header'"/>
                    <xsl:with-param name="params">
                        <!--                        <prodname>
                            <xsl:value-of select="$bc.productName"/>
                        </prodname>-->
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__odd__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__toc__odd__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
                <!-- <fo:inline>
                    <fo:external-graphic
                        src="url(Customization/OpenTopic/common/artwork/harmonic_logo_1inch.png)"/>
                </fo:inline>-->
            </fo:block>
            <fo:block>
                <xsl:call-template name="insertDraftImage"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!--  2017-05-25 -->
    <!--  DITA for Print: Set up headers to include external files -->
    <xsl:template name="insertBodyFirstHeader">
        <fo:static-content flow-name="first-body-header">
            <fo:block xsl:use-attribute-sets="__body__first__header">
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Body first header'"/>
                    <xsl:with-param name="params">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__first__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__first__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
                <!--                <fo:inline>
                    <fo:external-graphic
                        src="url(Customization/OpenTopic/common/artwork/harmonic_logo_1inch.png)"/>
                </fo:inline>-->
            </fo:block>
            <fo:block>
                <xsl:call-template name="insertDraftImage"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyFirstFooter">
        <fo:static-content flow-name="first-body-footer">
            <fo:block xsl:use-attribute-sets="__body__first__footer">
                <xsl:call-template name="getVariable">
                    <xsl:with-param name="id" select="'Body first footer'"/>
                    <xsl:with-param name="params">
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__first__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!--  KLL 2017-05-26 First page of TOC has blank header -->
    <xsl:template name="insertTocFirstHeader">
        <fo:static-content flow-name="first-toc-header">
            <fo:block xsl:use-attribute-sets="__body__first__header"> </fo:block>
            <fo:block>
                <xsl:call-template name="insertDraftImage"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertTocFirstFooter">
        <fo:static-content flow-name="first-toc-footer">
            <fo:block xsl:use-attribute-sets="__body__odd__footer" margin-left="4.21in"
                text-align="justify" text-align-last="justify">
                <fo:inline xsl:use-attribute-sets="__body__odd__footer__pagenum">
                    <fo:page-number/>
                </fo:inline>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!-- TOMV: (2014-11) new static content for front matter -->
    <!-- mostly based on body elements, with a few notice specific items -->
    <xsl:template name="insertNoticeStaticContents">
        <xsl:call-template name="insertBodyFootnoteSeparator"/>
        <xsl:call-template name="insertBodyOddFooter"/>
        <xsl:if test="$mirror-page-margins">
            <xsl:call-template name="insertBodyEvenFooter"/>
        </xsl:if>
        <xsl:call-template name="insertNoticeOddHeader"/>
        <xsl:if test="$mirror-page-margins">
            <xsl:call-template name="insertNoticeEvenHeader"/>
        </xsl:if>
        <!-- No special first or last headers -->
        <!-- 
        <xsl:call-template name="insertBodyFirstHeader"/>
        <xsl:call-template name="insertBodyFirstFooter"/>
        <xsl:call-template name="insertBodyLastHeader"/>
        <xsl:call-template name="insertBodyLastFooter"/>
        -->
    </xsl:template>

    <!--TOMV (2014-11) New simple header blocks for notices section, just show the
    top border -->
    <xsl:template name="insertNoticeOddHeader">
        <fo:static-content flow-name="odd-notice-header">
            <fo:block xsl:use-attribute-sets="__body__odd__header">
                <!--  NOTICES ODD HEADER HERE -->
            </fo:block>
            <fo:block>
                <xsl:call-template name="insertDraftImage"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertNoticeEvenHeader">
        <fo:static-content flow-name="even-notice-header">
            <fo:block xsl:use-attribute-sets="__body__even__header">
                <!--     NOTICES EVEN HEADER HERE -->
            </fo:block>
            <fo:block>
                <xsl:call-template name="insertDraftImage"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!--  KLL 2017-08-09 -->
    <!--    Adding a Watermark to PDF output    -->
    <xsl:template name="insertDraftImage">
        <xsl:if test="$DRAFT = 'yes'">
            <fo:block-container text-align="center" margin-top="3.25in">
                <fo:block>
                    <fo:external-graphic
                        src="url({concat($customizationDir.url, $imageWatermarkPath)})"
                        xsl:use-attribute-sets="image"/>
                </fo:block>
            </fo:block-container>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
