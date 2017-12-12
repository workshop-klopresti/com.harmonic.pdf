<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    exclude-result-prefixes="opentopic opentopic-index dita2xslfo" version="2.0">

    <!-- Task Labels -->
    <xsl:template match="*" mode="dita2xslfo:task-heading">
        <xsl:param name="use-label"/>
        <xsl:if test="$GENERATE-TASK-LABELS = 'YES'">
            <fo:block xsl:use-attribute-sets="task.title">
                <fo:inline>
                    <xsl:copy-of select="$use-label"/>
                </fo:inline>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <!--  KLL 2017-06-02 Generate list of prerequisite links based on topicref=required (similar to help output behavior)-->
    <xsl:template match="*[contains(@class, ' task/taskbody ')]">
        <fo:block xsl:use-attribute-sets="taskbody">
            <xsl:call-template name="commonattributes"/>
            <!-- [SP] 2016-08-03 sfb: If there isn't a task/prereq, call it-->
            <xsl:if test="not(*[contains(@class, ' task/prereq ')])">
                <!-- [SP] 2016-07-29 sfb: Get ID of containing topic (or self). -->
                <xsl:variable name="topic_id"
                    select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id"/>
                <!-- [SP] 2016-07-29 sfb: Find topicref in map. -->
                <xsl:variable name="mapTopic" select="key('map-id', $topic_id)"/>

                <!-- [SP] 2016-07-29 sfb: Gather all preceding siblings (topicrefs) that are required. -->
                <xsl:variable name="required_siblings"
                    select="$mapTopic/preceding-sibling::*[contains(@class, ' map/topicref ') and @importance = 'required']"/>

                <xsl:if test="count($required_siblings) &gt; 0">
                    <xsl:call-template name="task_prereq"/>
                </xsl:if>

            </xsl:if>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template name="task_prereq">
        <fo:block xsl:use-attribute-sets="prereq" keep-with-next="always">
            <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                <xsl:with-param name="use-label">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Task Prereq'"/>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:apply-templates>
            <fo:block xsl:use-attribute-sets="prereq__content">
                <!-- Add xrefs to any preceding siblings for which @importance="required".  -->
                <xsl:call-template name="add_required_siblings"/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/prereq ')]">
        <fo:block xsl:use-attribute-sets="prereq">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                <xsl:with-param name="use-label">
                    <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                        <!--  KLL 2017-06 pdf2-string points to values in cfg/common/vars/en.xml-->
                        <xsl:with-param name="pdf2-string">Task Prereq</xsl:with-param>
                        <!--  KLL 2017-06-02 common-string points to values in xsl/common/strings-en-us.xml -->
                        <xsl:with-param name="common-string">task_prereq</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:with-param>
            </xsl:apply-templates>
            <fo:block xsl:use-attribute-sets="prereq__content">
                <xsl:apply-templates/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <!-- [SP] 2016-07-27 sfb: look for preceding sibling in which @importance="required". -->
    <xsl:template name="add_required_siblings">
        <!-- [SP] 2016-07-29 sfb: Get ID of containing topic (or self). -->
        <xsl:variable name="topic_id"
            select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id"/>
        <!-- [SP] 2016-07-29 sfb: Find topicref in map. -->
        <xsl:variable name="mapTopic" select="key('map-id', $topic_id)"/>

        <!-- [SP] 2016-07-29 sfb: Gather all preceding siblings (topicrefs) that are required. -->
        <xsl:variable name="required_siblings"
            select="$mapTopic/preceding-sibling::*[contains(@class, ' map/topicref ') and @importance = 'required']"/>

        <!-- [SP] 2016-07-29 sfb: Create a node set consisting of each of the required topics. -->
        <xsl:variable name="nodeSet" as="element()*">
            <!-- [SP] 2016-07-29 sfb: For each topicref, make a copy of the corresponding topic. -->
            <xsl:for-each select="$required_siblings">
                <xsl:copy-of select="key('id', substring(./@href, 2))"/>
            </xsl:for-each>
        </xsl:variable>

        <!-- Create list with createMapLinks (from links.xsl). -->
        <xsl:call-template name="createMapLinks">
            <xsl:with-param name="nodeSet" select="$nodeSet"/>
            <!--            <xsl:with-param name="title" select="$linksTitle"/>-->

        </xsl:call-template>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/context ')]">
        <!--  KLL 2016-10-24 Uncomment to use title for Task Context, otherwise the content has extra spacing after <shortdesc> -->
        <fo:block xsl:use-attribute-sets="context">
            <xsl:call-template name="commonattributes"/>
            <!--    <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                <xsl:with-param name="use-label">
                    <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                        <!-\-  KLL 2017-06 pdf2-string points to values in cfg/common/vars/en.xml-\->
                        <xsl:with-param name="pdf2-string">Task Context</xsl:with-param>
                        <!-\-  KLL 2017-06-02 common-string points to values in xsl/common/strings-en-us.xml -\->
                        <xsl:with-param name="common-string">task_context</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:with-param>
            </xsl:apply-templates>-->
            <fo:block xsl:use-attribute-sets="context__content">
                <xsl:apply-templates/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <!--  KLL 2017-12-04 Adjusted formatting to be distinct from prereq  -->
    <!-- If example has a title, process it first; otherwise, create default title (if needed) -->
    <xsl:template
        match="*[contains(@class, ' task/taskbody ')]/*[contains(@class, ' topic/example ')]">
        <fo:block xsl:use-attribute-sets="example">
            <xsl:call-template name="commonattributes"/>
            <xsl:choose>
                <xsl:when test="*[contains(@class, ' topic/title ')]">
                    <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Task Example'"/>
                    </xsl:call-template>
                    <fo:inline xsl:use-attribute-sets="example__content">
                        <xsl:apply-templates/>
                    </fo:inline>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
    </xsl:template>

    <!--  KLL 2016-11-14 transform change request: added formatting for result and result title -->
    <!-- If result has a title, process it first; otherwise, print result content only -->
    <xsl:template match="*[contains(@class, ' task/result ')]">
        <!--        <fo:block xsl:use-attribute-sets="result">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                <xsl:with-param name="use-label">
                    <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                        <xsl:with-param name="pdf2-string">Task Result</xsl:with-param>
                        <xsl:with-param name="common-string">task_results</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:with-param>
            </xsl:apply-templates>
            <fo:block xsl:use-attribute-sets="result__content">
                <xsl:apply-templates/>
            </fo:block>
        </fo:block>-->
        <fo:block xsl:use-attribute-sets="result">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Task Result'"/>
            </xsl:call-template>
            <fo:inline xsl:use-attribute-sets="result__content">
                <xsl:apply-templates/>
            </fo:inline>
        </fo:block>
    </xsl:template>

    <!--Steps-->
    <xsl:template match="*[contains(@class, ' task/steps ')]">
        <xsl:choose>
            <xsl:when test="$GENERATE-TASK-LABELS = 'YES'">
                <fo:block>
                    <!--  KLL 2016-10-24 Uncomment to use title for Task Steps (Procedure), otherwise the content has extra spacing after <shortdesc> -->
                    <!-- <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                        <xsl:with-param name="use-label">
                            <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                                <!-\-  KLL 2017-06 pdf2-string points to values in cfg/common/vars/en.xml-\->
                                <xsl:with-param name="pdf2-string">Task Steps</xsl:with-param>
                                <!-\-  KLL 2017-06-02 common-string points to values in xsl/common/strings-en-us.xml -\->
                                <xsl:with-param name="common-string">task_procedure</xsl:with-param>
                            </xsl:apply-templates>
                        </xsl:with-param>
                    </xsl:apply-templates>-->
                    <fo:list-block xsl:use-attribute-sets="steps">
                        <xsl:call-template name="commonattributes"/>
                        <xsl:apply-templates/>
                    </fo:list-block>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-block xsl:use-attribute-sets="steps">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:list-block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/steps-unordered ')]">
        <xsl:choose>
            <xsl:when test="$GENERATE-TASK-LABELS = 'YES'">
                <fo:block>
                    <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                        <xsl:with-param name="use-label">
                            <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                                <xsl:with-param name="pdf2-string"
                                    >#steps-unordered-label</xsl:with-param>
                                <!--  KLL 2017-06-02 Uncomment to use values in xsl/common/strings-en-us.xml -->
                                <!--   <xsl:with-param name="common-string"
                                    >task_procedure_unordered</xsl:with-param>-->
                            </xsl:apply-templates>
                        </xsl:with-param>
                    </xsl:apply-templates>
                    <fo:list-block xsl:use-attribute-sets="steps-unordered">
                        <xsl:call-template name="commonattributes"/>
                        <xsl:apply-templates/>
                    </fo:list-block>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-block xsl:use-attribute-sets="steps-unordered">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:list-block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  KLL 2016-07-22 transform change request: added formatting for step example -->
    <xsl:template match="*[contains(@class, ' task/stepxmp ')]">
        <fo:block xsl:use-attribute-sets="stepxmp">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Step Example'"/>
            </xsl:call-template>
            <fo:inline xsl:use-attribute-sets="stepxmp__content">
                <xsl:apply-templates/>
            </fo:inline>
        </fo:block>
    </xsl:template>


    <!--  KLL 2016-11-15  transform change request: added formatting for result and result title -->
    <xsl:template match="*[contains(@class, ' task/stepresult ')]">
        <fo:block xsl:use-attribute-sets="stepresult">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Step Result'"/>
            </xsl:call-template>
            <fo:inline xsl:use-attribute-sets="stepxmp__content">
                <xsl:apply-templates/>
            </fo:inline>
        </fo:block>
    </xsl:template>

    <!--Substeps-->
    <!--  KLL 2017-06-02 Changed formatting of substeps from a) to a. -->
    <xsl:template
        match="*[contains(@class, ' task/substeps ')]/*[contains(@class, ' task/substep ')]">
        <fo:list-item xsl:use-attribute-sets="substeps.substep">
            <fo:list-item-label xsl:use-attribute-sets="substeps.substep__label">
                <fo:block xsl:use-attribute-sets="substeps.substep__label__content">
                    <fo:inline>
                        <xsl:call-template name="commonattributes"/>
                    </fo:inline>
                    <xsl:number format="a. "/>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body xsl:use-attribute-sets="substeps.substep__body">
                <fo:block xsl:use-attribute-sets="substeps.substep__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <!-- Choice tables -->
    <xsl:template match="*[contains(@class, ' task/choicetable ')]">
        <fo:table xsl:use-attribute-sets="choicetable">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="univAttrs"/>
            <xsl:call-template name="globalAtts"/>

            <xsl:if test="@relcolwidth">
                <xsl:variable name="fix-relcolwidth">
                    <xsl:apply-templates select="." mode="fix-relcolwidth">
                        <xsl:with-param name="number-cells" select="2"/>
                    </xsl:apply-templates>
                </xsl:variable>
                <xsl:call-template name="createSimpleTableColumns">
                    <xsl:with-param name="theColumnWidthes" select="$fix-relcolwidth"/>
                </xsl:call-template>
            </xsl:if>

            <xsl:choose>
                <xsl:when test="*[contains(@class, ' task/chhead ')]">
                    <xsl:apply-templates select="*[contains(@class, ' task/chhead ')]"/>
                </xsl:when>
                <xsl:otherwise>
                    <fo:table-header xsl:use-attribute-sets="chhead">
                        <fo:table-row xsl:use-attribute-sets="chhead__row">
                            <fo:table-cell xsl:use-attribute-sets="chhead.choptionhd">
                                <fo:block xsl:use-attribute-sets="chhead.choptionhd__content">
                                    <xsl:call-template name="getVariable">
                                        <xsl:with-param name="id" select="'Option'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="chhead.chdeschd">
                                <fo:block xsl:use-attribute-sets="chhead.chdeschd__content">
                                    <xsl:call-template name="getVariable">
                                        <xsl:with-param name="id" select="'Description'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                </xsl:otherwise>
            </xsl:choose>

            <fo:table-body xsl:use-attribute-sets="choicetable__body">
                <xsl:apply-templates select="*[contains(@class, ' task/chrow ')]"/>
            </fo:table-body>

        </fo:table>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/chhead ')]">
        <fo:table-header xsl:use-attribute-sets="chhead">
            <xsl:call-template name="commonattributes"/>
            <fo:table-row xsl:use-attribute-sets="chhead__row">
                <xsl:apply-templates/>
            </fo:table-row>
        </fo:table-header>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/chrow ')]">
        <fo:table-row xsl:use-attribute-sets="chrow">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:table-row>
    </xsl:template>

    <xsl:template
        match="*[contains(@class, ' task/chhead ')]/*[contains(@class, ' task/choptionhd ')]">
        <fo:table-cell xsl:use-attribute-sets="chhead.choptionhd">
            <xsl:call-template name="commonattributes"/>
            <fo:block xsl:use-attribute-sets="chhead.choptionhd__content">
                <xsl:apply-templates/>
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template
        match="*[contains(@class, ' task/chhead ')]/*[contains(@class, ' task/chdeschd ')]">
        <fo:table-cell xsl:use-attribute-sets="chhead.chdeschd">
            <xsl:call-template name="commonattributes"/>
            <fo:block xsl:use-attribute-sets="chhead.chdeschd__content">
                <xsl:apply-templates/>
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/chrow ')]/*[contains(@class, ' task/choption ')]">
        <xsl:variable name="keyCol"
            select="ancestor::*[contains(@class, ' task/choicetable ')][1]/@keycol"/>
        <fo:table-cell xsl:use-attribute-sets="chrow.choption">
            <xsl:call-template name="commonattributes"/>
            <xsl:choose>
                <xsl:when test="$keyCol = 1">
                    <fo:block xsl:use-attribute-sets="chrow.choption__keycol-content">
                        <xsl:apply-templates/>
                    </fo:block>
                </xsl:when>
                <xsl:otherwise>
                    <fo:block xsl:use-attribute-sets="chrow.choption__content">
                        <xsl:apply-templates/>
                    </fo:block>
                </xsl:otherwise>
            </xsl:choose>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' task/chrow ')]/*[contains(@class, ' task/chdesc ')]">
        <xsl:variable name="keyCol"
            select="number(ancestor::*[contains(@class, ' task/choicetable ')][1]/@keycol)"/>
        <fo:table-cell xsl:use-attribute-sets="chrow.chdesc">
            <xsl:call-template name="commonattributes"/>
            <xsl:choose>
                <xsl:when test="$keyCol = 2">
                    <fo:block xsl:use-attribute-sets="chrow.chdesc__keycol-content">
                        <xsl:apply-templates/>
                    </fo:block>
                </xsl:when>
                <xsl:otherwise>
                    <fo:block xsl:use-attribute-sets="chrow.chdesc__content">
                        <xsl:apply-templates/>
                    </fo:block>
                </xsl:otherwise>
            </xsl:choose>
        </fo:table-cell>
    </xsl:template>

</xsl:stylesheet>
