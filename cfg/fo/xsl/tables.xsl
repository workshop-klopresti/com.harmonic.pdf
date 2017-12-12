<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    exclude-result-prefixes="opentopic-func xs dita2xslfo dita-ot" version="2.0">

    <!--  2017-06-02 -->
    <!--  DITA for Print: Number table cells (intended for diagrams) -->
    <xsl:template
        match="*[contains(@class, ' topic/strow ')]/*[contains(@class, ' topic/stentry ')]">
        <xsl:variable name="current-row-count"
            select="number(count(../preceding-sibling::*[contains(@class, ' topic/strow ')]) + 1)"/>
        <xsl:variable name="preceding-row-count"
            select="number(count(../preceding-sibling::*[contains(@class, ' topic/strow')]))"/>
        <xsl:variable name="preceding-entry">
            <xsl:value-of select="count(preceding-sibling::*[contains(@class, ' topic/stentry ')])"
            />
        </xsl:variable>
        <xsl:variable name="cell-count" select="$current-row-count"/>
        <fo:table-cell xsl:use-attribute-sets="strow.stentry">
            <xsl:call-template name="commonattributes"/>
            <xsl:variable name="entryCol"
                select="count(preceding-sibling::*[contains(@class, ' topic/stentry ')]) + 1"/>
            <xsl:variable name="frame" as="xs:string">
                <xsl:variable name="f"
                    select="ancestor::*[contains(@class, ' topic/simpletable ')][1]/@frame"/>
                <xsl:choose>
                    <xsl:when test="$f">
                        <xsl:value-of select="$f"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$table.frame-default"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:if test="../following-sibling::*[contains(@class, ' topic/strow ')]">
                <xsl:call-template name="generateSimpleTableHorizontalBorders">
                    <xsl:with-param name="frame" select="$frame"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="following-sibling::*[contains(@class, ' topic/stentry ')]">
                <xsl:call-template name="generateSimpleTableVerticalBorders">
                    <xsl:with-param name="frame" select="$frame"/>
                </xsl:call-template>
            </xsl:if>

            <xsl:choose>
                <xsl:when
                    test="number(ancestor::*[contains(@class, ' topic/simpletable ')][1]/@keycol) = $entryCol">
                    <fo:block xsl:use-attribute-sets="strow.stentry__keycol-content">
                        <xsl:apply-templates select="." mode="ancestor-start-flag"/>
                        <xsl:apply-templates/>
                        <xsl:apply-templates select="." mode="ancestor-end-flag"/>
                    </fo:block>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <!--KLL 02/07/2016 DITA for Print "Number Table Cells"-->
                        <xsl:when
                            test="$preceding-entry = 0 and ancestor::*[contains(@class, ' topic/simpletable ')]/@outputclass = 'auto-number'">
                            <fo:block xsl:use-attribute-sets="strow.stentry__content">
                                <xsl:value-of select="$cell-count"/>
                                <xsl:text>. </xsl:text>
                                <xsl:apply-templates/>
                            </fo:block>
                        </xsl:when>
                        <!-- Output cells without auto numbers -->
                        <xsl:otherwise>
                            <fo:block xsl:use-attribute-sets="strow.stentry__content">
                                <xsl:apply-templates/>
                            </fo:block>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </fo:table-cell>
    </xsl:template>


    <!--  KLL 2017-06-01 Set the default row and column rules-->
    <!-- XML Exchange Table Model Document Type Definition default is all -->
    <xsl:variable name="table.frame-default" select="'all'"/>
    <!-- XML Exchange Table Model Document Type Definition default is 1 -->
    <xsl:variable name="table.rowsep-default" select="'1'"/>
    <!-- XML Exchange Table Model Document Type Definition default is 1 -->
    <xsl:variable name="table.colsep-default" select="'1'"/>

    <!--Definition list-->
    <!--  the outputclass = 'dl-paragraph' breaks dt and dd into separate paragraphs -->
    <xsl:template match="*[contains(@class, ' topic/dl ')]">
        <xsl:choose>
            <xsl:when test="@outputclass = 'dl-paragraph'">
                <xsl:call-template name="dl-paragraph"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="dl-table"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- [SP] 2016-10-11 sfb: Here's the basic form of how to handle the dl in a block form.
                    Note that because the table-form is already using standard processing 
                    (without modes) for all dl elements, we need to consistently use
                    the horizontal mode. 
    -->
    <!--Definition list horizontal-->
    <xsl:template name="dl-paragraph">
        <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]" mode="paragraph"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/dlentry')]" mode="paragraph">
        <xsl:apply-templates select="*[contains(@class, ' topic/dt ')]" mode="paragraph"/>
        <xsl:apply-templates select="*[contains(@class, ' topic/dd ')]" mode="paragraph"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/dt ')]" mode="paragraph">
        <fo:block xsl:use-attribute-sets="dlentry.dt__content__para">
            <xsl:apply-templates/>
        </fo:block>

    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/dd ')]" mode="paragraph">
        <fo:block xsl:use-attribute-sets="dlentry.dd__content__para">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!--Definition list table-->
    <!--  KLL 2016-10-07 this is the default 2-column table format for definition lists -->
    <xsl:template name="dl-table">
        <fo:table xsl:use-attribute-sets="dl">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="*[contains(@class, ' topic/dlhead ')]"/>
            <fo:table-body xsl:use-attribute-sets="dl__body">
                <xsl:choose>
                    <xsl:when test="contains(@otherprops, 'sortable')">
                        <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]">
                            <xsl:sort
                                select="opentopic-func:getSortString(normalize-space(opentopic-func:fetchValueableText(*[contains(@class, ' topic/dt ')])))"
                                lang="{$locale}"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <!--  2017-06-01 -->
    <!--  DITA for Print: Add chapter, appendix, or part numbers to table titles -->
    <xsl:template match="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]">
        <fo:block xsl:use-attribute-sets="table.title">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Table.title'"/>
                <xsl:with-param name="params">
                    <number>
                        <xsl:call-template name="getChapterPrefix"/>
                        <xsl:text>-</xsl:text>
                        <xsl:choose>
                            <xsl:when
                                test="count(ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = last()][count(preceding-sibling::*[contains(@class, ' topic/topic ')]) > 0])">
                                <xsl:value-of
                                    select="count(./preceding::*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]][ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = last()]]) - count(ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = last()]/preceding-sibling::*[contains(@class, ' topic/topic ')]//*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]]) + 1"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of
                                    select="count(./preceding::*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]][ancestor-or-self::*[contains(@class, ' topic/topic')][position() = last()]]) + 1"
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


    <!--<xsl:template match="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]">
        <fo:block xsl:use-attribute-sets="table.title">
            <xsl:call-template name="commonattributes"/>
            <!-\-Add chapter to table titles -\->
            <!-\- [SP] 2016-09-06 sfb: Scriptorium changes: -\->
            <!-\- Can't use @id, because there are some figures without ids.  -\->
            <xsl:variable name="this_table_id" select="generate-id(parent::*)"/>

            <!-\- Find the current chapter -\->
            <xsl:variable name="this_topic_id"
                select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id"/>
            <xsl:variable name="topicref" select="key('map-id', $this_topic_id)[1]"/>
            <xsl:variable name="chap_app_id"
                select="$topicref/ancestor-or-self::*[contains(@class, ' bookmap/chapter') or contains(@class, ' bookmap/appendix ')]/@id"/>

            <!-\- Get all the tables (with titles) in the current chapter -\->
            <xsl:variable name="chap_app_topic" select="key('id', $chap_app_id)"/>

            <xsl:variable name="chap_app_tables"
                select="$chap_app_topic/descendant::*[contains(@class, ' topic/table ') and child::*[contains(@class, ' topic/title ')]]"/>

            <!-\- Find the position of the figure of interest in the list. -\->
            <xsl:variable name="table_num">
                <xsl:for-each select="$chap_app_tables">
                    <xsl:if test="generate-id(.) = $this_table_id">
                        <xsl:value-of select="position()"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <!-\-            <xsl:message>table_num is <xsl:value-of select="$table_num"/>.</xsl:message>-\->

            <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Table'"/>
                <xsl:with-param name="params">
                    <number>
                        <xsl:call-template name="getChapterPrefix"/>
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="$table_num"/>
                        <!-\- [SP] 2016-09-07 sfb: This doesn't work for chapters in parts. -\->
                        <!-\-                        <xsl:choose>
                            <xsl:when
                                test="count(ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = last()][count(preceding-sibling::*[contains(@class, ' topic/topic ')]) > 0])">
                                <xsl:value-of
                                    select="count(./preceding::*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]][ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = last()]]) - count(ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = last()]/preceding-sibling::*[contains(@class, ' topic/topic ')]//*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]]) + 1"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of
                                    select="count(./preceding::*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]][ancestor-or-self::*[contains(@class, ' topic/topic')][position() = last()]]) + 1"
                                />
                            </xsl:otherwise>
                        </xsl:choose>-\->
                    </number>
                    <title>
                        <xsl:apply-templates/>
                    </title>
                </xsl:with-param>
            </xsl:call-template>
        </fo:block>
    </xsl:template>-->

</xsl:stylesheet>
