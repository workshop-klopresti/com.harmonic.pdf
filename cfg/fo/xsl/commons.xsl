<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    exclude-result-prefixes="dita-ot ot-placeholder opentopic opentopic-index opentopic-func dita2xslfo xs"
    version="2.0">

    <xsl:template match="*" mode="processTopicTitle">
        <xsl:variable name="level" as="xs:integer">
            <xsl:apply-templates select="." mode="get-topic-level"/>
        </xsl:variable>
        <xsl:variable name="attrSet1">
            <xsl:apply-templates select="." mode="createTopicAttrsName">
                <xsl:with-param name="theCounter" select="$level"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:variable name="attrSet2" select="concat($attrSet1, '__content')"/>
        <fo:block>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="processAttrSetReflection">
                <xsl:with-param name="attrSet" select="$attrSet1"/>
                <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
            </xsl:call-template>
            <fo:block>
                <xsl:call-template name="processAttrSetReflection">
                    <xsl:with-param name="attrSet" select="$attrSet2"/>
                    <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
                </xsl:call-template>
                <xsl:if test="$level = 1">
                    <fo:marker marker-class-name="current-header">
                        <xsl:apply-templates select="." mode="getTitle"/>
                    </fo:marker>
                </xsl:if>
                <xsl:if test="$level = 2">
                    <fo:marker marker-class-name="current-h2">
                        <xsl:apply-templates select="." mode="getTitle"/>
                    </fo:marker>
                </xsl:if>
                <fo:inline id="{parent::node()/@id}"/>
                <fo:inline>
                    <xsl:attribute name="id">
                        <xsl:call-template name="generate-toc-id">
                            <xsl:with-param name="element" select=".."/>
                        </xsl:call-template>
                    </xsl:attribute>
                </fo:inline>
                <xsl:call-template name="pullPrologIndexTerms"/>
                <xsl:apply-templates select="." mode="getTitle"/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <!--  2017-05-23 -->
    <!--  DITA for Print: Change TOC numbering formats -->
    <xsl:template
        match="
            *[contains(@class, ' bookmap/chapter ')] |
            opentopic:map/*[contains(@class, ' map/topicref ')]"
        mode="topicTitleNumber" priority="-1">
        <xsl:variable name="chapters">
            <xsl:document>
                <xsl:for-each select="$map/descendant::*[contains(@class, ' bookmap/chapter ')]">
                    <xsl:sequence select="."/>
                </xsl:for-each>
            </xsl:document>
        </xsl:variable>
        <xsl:for-each select="$chapters/*[current()/@id = @id]">
            <xsl:number format="1" count="*[contains(@class, ' bookmap/chapter ')]"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="
            *[contains(@class, ' bookmap/appendix ')]"
        mode="topicTitleNumber">
        <xsl:number format="A" count="*[contains(@class, ' bookmap/appendix ')]"/>
    </xsl:template>

    <xsl:template match="
            *[contains(@class, ' bookmap/part ')]" mode="topicTitleNumber">
        <xsl:number format="I" count="*[contains(@class, ' bookmap/part ')]"/>
    </xsl:template>

    <!--  2017-05-26 -->
    <!--  DITA for Print: Put the chapter, appendix, or part label, number and title on same line -->
    <xsl:template name="insertChapterFirstpageStaticContent">
        <xsl:param name="type"/>
        <fo:block>
            <xsl:attribute name="id">
                <xsl:call-template name="generate-toc-id"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="$type = 'chapter'">
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Chapter with number'"/>
                            <xsl:with-param name="params">
                                <!--  KLL 2016-06-29 Put chapter title on separate line below  number-->
                                <number>
                                    <fo:inline>
                                        <xsl:variable name="id" select="@id"/>
                                        <xsl:variable name="topicChapters">
                                            <xsl:copy-of
                                                select="$map//*[contains(@class, ' bookmap/chapter ')]"
                                            />
                                        </xsl:variable>
                                        <xsl:variable name="chapterNumber">
                                            <xsl:number format="1"
                                                value="count($topicChapters/*[@id = $id]/preceding-sibling::*) + 1"
                                            />
                                        </xsl:variable>
                                        <xsl:value-of select="$chapterNumber"/>
                                    </fo:inline>
                                    <fo:block xsl:use-attribute-sets="topic.title">
                                        <xsl:value-of select="*[contains(@class, ' topic/title ')]"
                                        />
                                    </fo:block>
                                </number>
                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$type = 'appendix'">
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Appendix with number'"/>
                            <xsl:with-param name="params">
                                <!--DITA for Print-->
                                <number>
                                    <fo:inline
                                        xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                        <xsl:apply-templates select="key('map-id', @id)[1]"
                                            mode="topicTitleNumber"/>
                                    </fo:inline>

                                    <fo:block xsl:use-attribute-sets="topic.title">
                                        <xsl:value-of select="*[contains(@class, ' topic/title ')]"
                                        />
                                    </fo:block>
                                </number>
                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$type = 'appendices'">
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Appendix with number'"/>
                            <xsl:with-param name="params">
                                <number>
                                    <fo:inline
                                        xsl:use-attribute-sets="__chapter__frontmatter__number__container"> </fo:inline>
                                    <fo:block xsl:use-attribute-sets="topic.title">
                                        <xsl:value-of select="*[contains(@class, ' topic/title ')]"
                                        />
                                    </fo:block>
                                </number>
                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$type = 'part'">
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Part with number'"/>
                            <xsl:with-param name="params">
                                <!--DITA for Print-->
                                <number>
                                    <fo:inline
                                        xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                        <xsl:apply-templates select="key('map-id', @id)[1]"
                                            mode="topicTitleNumber"/>
                                    </fo:inline>

                                    <fo:block xsl:use-attribute-sets="topic.title">
                                        <xsl:value-of select="*[contains(@class, ' topic/title ')]"
                                        />
                                    </fo:block>
                                </number>

                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$type = 'preface'">
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Preface title'"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$type = 'notices'">
                    <!-- TOMV (2014-11-14) For Notices section, suppress the title  -->
                    <!-- 
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Notices title'"/>
                        </xsl:call-template>
                    </fo:block>
                    -->
                </xsl:when>
            </xsl:choose>
        </fo:block>
    </xsl:template>

    <xsl:template match="*" mode="topicTitleNumber" priority="-10">
        <xsl:message>No topicTitleNumber mode template for <xsl:value-of select="name()"
            /></xsl:message>
    </xsl:template>


    <!--  2017-05-23 -->
    <!--  DITA for Print: Format mini-TOC links-->
    <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="in-this-chapter-list">
        <xsl:variable name="topicref"
            select="key('map-id', parent::*[tokenize(@class, '\s+') = 'topic/topic']/@id)"/>
        <fo:list-item xsl:use-attribute-sets="ul.li">
            <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
                <fo:block xsl:use-attribute-sets="ul.li__label__content">
                    <xsl:choose>
                        <xsl:when test="$topicref/@collection-type = 'sequence'">

                            <xsl:value-of
                                select="concat(count(preceding-sibling::*[tokenize(@class, '\s+') = 'topic/topic']) + 1, '.')"
                            />
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
                    <fo:basic-link internal-destination="{@id}"
                        xsl:use-attribute-sets="xref__mini__toc">
                        <xsl:value-of select="child::*[contains(@class, ' topic/title ')]"/>
                    </fo:basic-link>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ')]">
        <fo:block xsl:use-attribute-sets="fig.title">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Figure.title'"/>
                <xsl:with-param name="params">
                    <number>
                        <xsl:call-template name="getChapterPrefix"/>
                        <xsl:text>-</xsl:text>
                        <xsl:choose>
                            <xsl:when
                                test="count(ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = last()][count(preceding-sibling::*[contains(@class, ' topic/topic ')]) &gt; 0])">
                                <xsl:value-of
                                    select="count(./preceding::*[contains(@class, ' topic/fig ')][child::*[contains(@class, ' topic/title ')]][ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = last()]]) - count(ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = last()]/preceding-sibling::*[contains(@class, ' topic/topic ')]//*[contains(@class, ' topic/fig ')][child::*[contains(@class, ' topic/title ')]]) + 1"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of
                                    select="count(./preceding::*[contains(@class, ' topic/fig ')][child::*[contains(@class, ' topic/topic ')][position() = last()]]) + 1"
                                />
                            </xsl:otherwise>
                        </xsl:choose>
                    </number>
                    <title>
                        <xsl:apply-templates/>
                    </title>
                </xsl:with-param>
            </xsl:call-template>
        </fo:block>
    </xsl:template>

    <!--  KLL 2017-06-08 -->
    <xsl:template match="*[contains(@class, ' topic/lines ')]">
        <xsl:call-template name="setSpecTitle"/>
        <fo:block xsl:use-attribute-sets="lines">
            <xsl:call-template name="commonattributes"/>
            <!-- TOMV: special handling when rendering in notices section of frontmattter -->
            <xsl:call-template name="reset_styles_if_notices_body"/>
            <xsl:call-template name="setFrame"/>
            <xsl:call-template name="setScale"/>
            <xsl:call-template name="setExpanse"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!--  2017-05-26 -->
    <!--  DITA for Print: Format trademark symbols -->
    <xsl:template match="*[contains(@class, ' topic/tm ')]">
        <fo:inline xsl:use-attribute-sets="tm">
            <xsl:apply-templates/>
            <xsl:choose>
                <xsl:when test="@tmtype = 'service'">
                    <fo:inline xsl:use-attribute-sets="tm__content__service">SM</fo:inline>
                </xsl:when>
                <xsl:when test="@tmtype = 'tm'">
                    <fo:inline xsl:use-attribute-sets="tm__content__tm">&#8482;</fo:inline>
                </xsl:when>
                <xsl:when test="@tmtype = 'reg'">
                    <fo:inline xsl:use-attribute-sets="tm__content">&#174;</fo:inline>
                </xsl:when>
                <xsl:otherwise>
                    <fo:inline xsl:use-attribute-sets="tm__content">
                        <xsl:text>Error in tm type.</xsl:text>
                    </fo:inline>
                </xsl:otherwise>
            </xsl:choose>
        </fo:inline>
    </xsl:template>

    <!-- KL 2016-01-14 first-time use of trademarks-->
    <xsl:template match="*[contains(@class, ' topic/tm ')]" priority="2">
        <xsl:variable name="tmText" as="xs:string" select="normalize-space(.)"/>
        <xsl:variable name="isNotFirst" as="xs:boolean"
            select="boolean(preceding::*[not(ancestor::opentopic:map)][@class, ' topic/tm '][normalize-space(.) = ($tmText)])"/>

        <xsl:choose>
            <!-- output without the tm sign -->
            <xsl:when test="$isNotFirst">
                <!--   <xsl:number format="a "/> -->
                <xsl:value-of select="$tmText"/>
            </xsl:when>
            <!-- output with the tm sign -->
            <xsl:otherwise>
                <!--    <xsl:number format="1 "/> -->
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' concept/conbody ')]" priority="1">
        <xsl:variable name="level" as="xs:integer">
            <xsl:apply-templates select="." mode="get-topic-level"/>
        </xsl:variable>
        <!-- [SP] 2016-10-07: Before processing the body (but after any shortdesc), look for prereqs in reltable. -->
        <xsl:call-template name="check_reltable"/>
        <xsl:choose>
            <xsl:when test="not(node())"/>
            <xsl:when test="$level = 1">
                <fo:block xsl:use-attribute-sets="body__toplevel conbody">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:when test="$level = 2">
                <fo:block xsl:use-attribute-sets="body__secondLevel conbody">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:block xsl:use-attribute-sets="conbody">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- [SP] 2016-10-07 sfb: See if there are any reltable entries for this topic in which  
              importance="required". If so, insert a list of links.
    -->
    <xsl:template name="check_reltable">
        <xsl:variable name="this_id" select="concat('#', parent::*/@id)"/>
        <!-- Get the topicref elements -->
        <xsl:variable name="required"
            select="$map/reltable/relrow[relcell[1][topicref/@href = $this_id]]/relcell[2]/topicref[@importance = 'required']"/>

        <xsl:if test="count($required) &gt; 0">

            <!-- Create a node set consisting of each of the required topics. -->
            <xsl:variable name="nodeSet" as="element()*">
                <!-- [SP] 2016-07-29 sfb: For each topicref, make a copy of the corresponding topic. -->
                <xsl:for-each select="$required">
                    <xsl:copy-of select="key('id', substring(./@href, 2))"/>
                </xsl:for-each>
            </xsl:variable>

            <fo:block xsl:use-attribute-sets="prereq" keep-with-next="always">
                <fo:block xsl:use-attribute-sets="task.title" keep-with-next.within-page="always">
                    <fo:inline>
                        <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Task Prereq'"/>
                        </xsl:call-template>
                    </fo:inline>
                </fo:block>

                <fo:block xsl:use-attribute-sets="task__content"
                    keep-together.within-page="always">
                    <xsl:call-template name="createMapLinks">
                        <xsl:with-param name="nodeSet" select="$nodeSet"/>
                    </xsl:call-template>
                </fo:block>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/fig ')]">
        <fo:block xsl:use-attribute-sets="fig" keep-with-previous.within-page="auto">
            <xsl:call-template name="commonattributes"/>
            <xsl:if test="not(@id)">
                <xsl:attribute name="id">
                    <xsl:call-template name="get-id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <!-- Places title below images but above simpletables -->
                <xsl:when test="*[contains, (@class, ' topic/simpletable ')]">
                    <xsl:apply-templates select="*[contains(@class, ' topic/image ')]"/>
                    <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
                    <!--  KLL 2016-07-11 Inserts figure description under image title -->
                    <xsl:apply-templates select="*[contains(@class, ' topic/desc ')]"/>
                    <xsl:apply-templates select="*[contains(@class, ' topic/simpletable ')]"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Places title below images -->
                    <xsl:apply-templates select="*[not(contains(@class, ' topic/title '))]"/>
                    <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
                    <!--  KLL 2016-07-11 Inserts figure description under image title -->
                    <xsl:apply-templates select="*[contains(@class, ' topic/desc ')]"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
    </xsl:template>

    <xsl:template match="*" mode="placeImage">
        <xsl:param name="imageAlign"/>
        <xsl:param name="href"/>
        <xsl:param name="height" as="xs:string?"/>
        <xsl:param name="width" as="xs:string?"/>
        <!--Using align attribute set according to image @align attribute-->
        <xsl:call-template name="processAttrSetReflection">
            <xsl:with-param name="attrSet" select="concat('__align__', $imageAlign)"/>
            <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
        </xsl:call-template>
        <!--  2017-07-07 -->
        <!--  DITA for Print: Dynamically scale images to the page width -->
        <xsl:choose>
            <xsl:when test="@placement = 'break'">
                <fo:external-graphic src="url('{$href}')" xsl:use-attribute-sets="image__block">
                    <!--Setting image height if defined-->
                    <xsl:if test="$height">
                        <xsl:attribute name="content-height">
                            <!--The following test was commented out because most people found the behavior
                 surprising.  It used to force images with a number specified for the dimensions
                 *but no units* to act as a measure of pixels, *if* you were printing at 72 DPI.
                 Uncomment if you really want it. -->
                            <xsl:choose>
                                <!--xsl:when test="not(string(number($height)) = 'NaN')">
                        <xsl:value-of select="concat($height div 72,'in')"/>
                      </xsl:when-->
                                <xsl:when test="not(string(number($height)) = 'NaN')">
                                    <xsl:value-of select="concat($height, 'px')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$height"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:if>
                    <!--Setting image width if defined-->
                    <xsl:if test="$width">
                        <xsl:attribute name="content-width">
                            <xsl:choose>
                                <!--xsl:when test="not(string(number($width)) = 'NaN')">
                        <xsl:value-of select="concat($width div 72,'in')"/>
                      </xsl:when-->
                                <xsl:when test="not(string(number($width)) = 'NaN')">
                                    <xsl:value-of select="concat($width, 'px')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$width"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="not($width) and not($height) and @scale">
                        <xsl:attribute name="content-width">
                            <xsl:value-of select="concat(@scale, '%')"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if
                        test="@scalefit = 'yes' and not($width) and not($height) and not(@scale)">
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:attribute name="height">100%</xsl:attribute>
                        <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
                        <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
                        <xsl:attribute name="scaling">uniform</xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates
                        select="
                            node() except (text(),
                            *[contains(@class, ' topic/alt ') or
                            contains(@class, ' topic/longdescref ')])"
                    />
                </fo:external-graphic>
            </xsl:when>
            <xsl:otherwise>
                <fo:external-graphic src="url('{$href}')" xsl:use-attribute-sets="image__inline">
                    <!--Setting image height if defined-->
                    <xsl:if test="$height">
                        <xsl:attribute name="content-height">
                            <!--The following test was commented out because most people found the behavior
                 surprising.  It used to force images with a number specified for the dimensions
                 *but no units* to act as a measure of pixels, *if* you were printing at 72 DPI.
                 Uncomment if you really want it. -->
                            <xsl:choose>
                                <!--xsl:when test="not(string(number($height)) = 'NaN')">
                        <xsl:value-of select="concat($height div 72,'in')"/>
                      </xsl:when-->
                                <xsl:when test="not(string(number($height)) = 'NaN')">
                                    <xsl:value-of select="concat($height, 'px')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$height"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:if>
                    <!--Setting image width if defined-->
                    <xsl:if test="$width">
                        <xsl:attribute name="content-width">
                            <xsl:choose>
                                <!--xsl:when test="not(string(number($width)) = 'NaN')">
                        <xsl:value-of select="concat($width div 72,'in')"/>
                      </xsl:when-->
                                <xsl:when test="not(string(number($width)) = 'NaN')">
                                    <xsl:value-of select="concat($width, 'px')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$width"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="not($width) and not($height) and @scale">
                        <xsl:attribute name="content-width">
                            <xsl:value-of select="concat(@scale, '%')"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if
                        test="@scalefit = 'yes' and not($width) and not($height) and not(@scale)">
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:attribute name="height">100%</xsl:attribute>
                        <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
                        <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
                        <xsl:attribute name="scaling">uniform</xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates
                        select="
                            node() except (text(),
                            *[contains(@class, ' topic/alt ') or
                            contains(@class, ' topic/longdescref ')])"
                    />
                </fo:external-graphic>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  2017-05-26 -->
    <!--  DITA for Print: Remove mini-TOC from table -->
    <xsl:template match="*" mode="createMiniToc">
        <!--<fo:table xsl:use-attribute-sets="__toc__mini__table">
            <fo:table-column xsl:use-attribute-sets="__toc__mini__table__column_1"/>
            <fo:table-column xsl:use-attribute-sets="__toc__mini__table__column_2"/>
            <fo:table-body xsl:use-attribute-sets="__toc__mini__table__body">
                <fo:table-row>
                    <fo:table-cell>-->
        <fo:block>
            <xsl:apply-templates select="*[contains(@class, ' topic/titlealts ')]"/>
            <xsl:if
                test="
                    *[contains(@class, ' topic/shortdesc ')
                    or contains(@class, ' topic/abstract ')]/node()">
                <fo:block xsl:use-attribute-sets="p">
                    <xsl:apply-templates
                        select="
                            *[contains(@class, ' topic/shortdesc ')
                            or contains(@class, ' topic/abstract ')]/node()"
                    />
                </fo:block>
            </xsl:if>
            <xsl:apply-templates select="*[contains(@class, ' topic/body ')]/*"/>

            <xsl:if
                test="
                    *[contains(@class, ' topic/related-links ')]//
                    *[contains(@class, ' topic/link ')][not(@role) or @role != 'child']">
                <xsl:apply-templates select="*[contains(@class, ' topic/related-links ')]"/>
            </xsl:if>

        </fo:block>
        <fo:block xsl:use-attribute-sets="__toc__mini">
            <xsl:if test="*[contains(@class, ' topic/topic ')]">
                <fo:block xsl:use-attribute-sets="__toc__mini__header">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Mini Toc'"/>
                    </xsl:call-template>
                </fo:block>
                <fo:list-block xsl:use-attribute-sets="__toc__mini__list">
                    <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"
                        mode="in-this-chapter-list"/>
                </fo:list-block>
            </xsl:if>
        </fo:block>
        <!-- </fo:table-cell>
                    <fo:table-cell xsl:use-attribute-sets="__toc__mini__summary">-->
        <!--Really, it would be better to just apply-templates, but the attribute sets for shortdesc, body
                        and abstract might indent the text.  Here, the topic body is in a table cell, and should
                        not be indented, so each element is handled specially.-->

        <!--    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>-->
    </xsl:template>

    <xsl:template name="processTopicNotices">
        <xsl:variable name="atts" as="element()">
            <xsl:choose>
                <xsl:when
                    test="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)/ancestor::*[contains(@class, ' bookmap/backmatter ')]">
                    <dummy xsl:use-attribute-sets="page-sequence.backmatter.notice"/>
                </xsl:when>
                <xsl:otherwise>
                    <dummy xsl:use-attribute-sets="page-sequence.notice"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <fo:page-sequence master-reference="body-sequence">
            <xsl:copy-of select="$atts/@*"/>
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertPrefaceStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:if test="empty(ancestor::*[contains(@class, ' topic/topic ')])">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:variable name="topicref"
                                select="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)"/>
                            <xsl:for-each select="$topicref">
                                <xsl:apply-templates select="." mode="topicTitleNumber"/>
                            </xsl:for-each>
                        </fo:marker>
                        <xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'notices'"/>
                    </xsl:call-template>

                    <fo:block xsl:use-attribute-sets="topic.title">
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="*[contains(@class, ' topic/title ')]">
                            <xsl:apply-templates select="." mode="getTitle"/>
                        </xsl:for-each>
                    </fo:block>

                    <xsl:choose>
                        <xsl:when test="$noticesLayout = 'BASIC'">
                            <xsl:apply-templates
                                select="
                                    *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                            <!--xsl:apply-templates select="." mode="buildRelationships"/-->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"/>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <!--  Bookmap Chapter processing  -->
    <xsl:template name="processTopicChapter">
        <xsl:variable name="page-sequence-reference">
            <xsl:choose>
                <xsl:when test="@outputclass = 'landscape'">
                    <xsl:choose>
                        <xsl:when test="$mapType = 'bookmap'">
                            <xsl:value-of select="'landscape-sequence'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'landscape-sequence'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="$mapType = 'bookmap'">
                            <xsl:value-of select="'body-sequence'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'ditamap-body-sequence'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <fo:page-sequence master-reference="{$page-sequence-reference}"
            xsl:use-attribute-sets="__force__page__count">
            <xsl:call-template name="startPageNumbering"/>
            <!-- [SP] 2016-07-29 sfb: Indicate this is for a chapter. -->
            <xsl:call-template name="insertBodyStaticContents">
                <xsl:with-param name="type" select="'chapter'"/>
            </xsl:call-template>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:variable name="level" as="xs:integer">
                        <xsl:apply-templates select="." mode="get-topic-level"/>
                    </xsl:variable>
                    <xsl:if test="$level eq 1">
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

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'chapter'"/>
                    </xsl:call-template>

                    <xsl:choose>
                        <xsl:when test="$chapterLayout = 'BASIC'">
                            <xsl:apply-templates
                                select="
                                    *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                            <xsl:apply-templates select="." mode="buildRelationships"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"/>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>


    <!--  Bookmap Appendix processing  -->
    <xsl:template name="processTopicAppendix">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="__force__page__count">
            <!--DITA for Print-->
            <xsl:call-template name="startPageNumbering"/>
            <!-- [SP] 2016-07-29 sfb: Indicate this is for an appendix. -->
            <xsl:call-template name="insertBodyStaticContents">
                <xsl:with-param name="type" select="'appendix'"/>
            </xsl:call-template>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:variable name="level" as="xs:integer">
                        <xsl:apply-templates select="." mode="get-topic-level"/>
                    </xsl:variable>
                    <xsl:if test="$level eq 1">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:variable name="topicref"
                                select="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)"/>
                            <xsl:for-each select="$topicref">
                                <xsl:number count="*[contains(@class, ' bookmap/appendix ')]"
                                    format="1"/>
                            </xsl:for-each>
                        </fo:marker>
                        <fo:marker marker-class-name="current-header">
                            <xsl:for-each select="child::*[contains(@class, ' topic/title ')]">
                                <xsl:apply-templates select="." mode="getTitle"/>
                            </xsl:for-each>
                        </fo:marker>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'appendix'"/>
                    </xsl:call-template>

                    <xsl:choose>
                        <xsl:when test="$appendixLayout = 'BASIC'">
                            <xsl:apply-templates
                                select="
                                    *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                            <xsl:apply-templates select="." mode="buildRelationships"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"/>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <!--  Bookmap appendices processing  -->
    <xsl:template name="processTopicAppendices">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="__force__page__count">
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:if test="not(ancestor::*[contains(@class, ' topic/topic ')])">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:number format="I"/>
                        </fo:marker>
                        <fo:marker marker-class-name="current-header">
                            <xsl:for-each select="*[contains(@class, ' topic/title ')]">
                                <xsl:apply-templates select="." mode="getTitle"/>
                            </xsl:for-each>
                        </fo:marker>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'appendices'"/>
                    </xsl:call-template>

                    <fo:block xsl:use-attribute-sets="topic.title">
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="child::*[contains(@class, ' topic/title ')]">
                            <xsl:apply-templates select="." mode="getTitle"/>
                        </xsl:for-each>
                    </fo:block>

                    <xsl:choose>
                        <xsl:when test="$appendicesLayout = 'BASIC'">
                            <xsl:apply-templates
                                select="
                                    *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                            <xsl:apply-templates select="." mode="buildRelationships"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:for-each select="*[contains(@class, ' topic/topic ')]">
                        <xsl:variable name="topicType">
                            <xsl:call-template name="determineTopicType"/>
                        </xsl:variable>
                        <xsl:if test="$topicType = 'topicSimple'">
                            <xsl:apply-templates select="."/>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
        <xsl:for-each select="*[contains(@class, ' topic/topic ')]">
            <xsl:variable name="topicType">
                <xsl:call-template name="determineTopicType"/>
            </xsl:variable>
            <xsl:if test="not($topicType = 'topicSimple')">
                <xsl:apply-templates select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <!--  Bookmap Part processing  -->
    <xsl:template name="processTopicPart">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="__force__page__count">
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:if test="not(ancestor::*[contains(@class, ' topic/topic ')])">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:number format="I"/>
                        </fo:marker>
                        <fo:marker marker-class-name="current-header">
                            <xsl:for-each select="child::*[contains(@class, ' topic/title ')]">
                                <xsl:apply-templates select="." mode="getTitle"/>
                            </xsl:for-each>
                        </fo:marker>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'part'"/>
                    </xsl:call-template>

                    <!--DITA for Print-->
                    <fo:block xsl:use-attribute-sets="topic.title.hide">
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="child::*[contains(@class, ' topic/title ')]">
                            <xsl:apply-templates select="." mode="getTitle"/>
                        </xsl:for-each>
                    </fo:block>

                    <xsl:choose>
                        <xsl:when test="$partLayout = 'BASIC'">
                            <xsl:apply-templates
                                select="
                                    *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                            <xsl:apply-templates select="." mode="buildRelationships"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:for-each select="*[contains(@class, ' topic/topic ')]">
                        <xsl:variable name="topicType">
                            <xsl:call-template name="determineTopicType"/>
                        </xsl:variable>
                        <xsl:if test="$topicType = 'topicSimple'">
                            <xsl:apply-templates select="."/>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
        <xsl:for-each select="*[contains(@class, ' topic/topic ')]">
            <xsl:variable name="topicType">
                <xsl:call-template name="determineTopicType"/>
            </xsl:variable>
            <xsl:if test="not($topicType = 'topicSimple')">
                <xsl:apply-templates select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <!--  KLL 2017-06-08 -->
    <!--  For TOMV front matter notices section  -->
    <xsl:template
        match="*[contains(@class, ' topic/section ')]/*[contains(@class, ' topic/title ')]">
        <fo:block xsl:use-attribute-sets="section.title">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="reset_styles_if_notices_title"/>
            <xsl:apply-templates select="." mode="getTitle"/>
        </fo:block>
    </xsl:template>

    <!-- Process common attributes -->
    <!--  KLL 2017-06-08 -->
    <!--  For TOMV front matter notices section  -->
    <xsl:template name="commonattributes">
        <xsl:apply-templates select="@id"/>
        <xsl:choose>
            <xsl:when test="*[contains(@class, ' topic/body ')]">
                <xsl:call-template name="reset_styles_if_notices_body"/>
            </xsl:when>
            <xsl:when test="*[contains(@class, ' topic/title ')]">
                <xsl:call-template name="reset_styles_if_notices_title"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates
                    select="
                        *[contains(@class, ' ditaot-d/ditaval-startprop ')] |
                        *[contains(@class, ' ditaot-d/ditaval-endprop ')]"
                    mode="flag-attributes"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  KLL 2017-07-07 Formatted text for draft comment -->
    <xsl:template match="*[contains(@class, ' topic/draft-comment ')]">
        <xsl:if test="$publishRequiredCleanup = 'yes' or $DRAFT = 'yes'">
            <fo:block xsl:use-attribute-sets="draft-comment">
                <xsl:call-template name="commonattributes"/>
                <fo:block xsl:use-attribute-sets="draft-comment__label">
                    <xsl:value-of select="@author"/>
                    <xsl:text> </xsl:text>
                    <xsl:text>draft comment: </xsl:text>
                    <!-- <xsl:text>Disposition: </xsl:text>
                    <xsl:value-of select="@disposition"/>
                    <xsl:text> / </xsl:text>
                    <xsl:text>Status: </xsl:text>
                    <xsl:value-of select="@status"/>-->
                </fo:block>
                <xsl:apply-templates/>
            </fo:block>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
