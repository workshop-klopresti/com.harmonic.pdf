<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">
    <!--	The order of xsl:include statements affects processing; the lower in the list, the higher its priority (processed later in the build)-->

    <xsl:import href="commons.xsl"/>
    <xsl:import href="../layout-masters.xsl"/>
    <xsl:import href="front-matter.xsl"/>
    <xsl:import href="front-matter-notices.xsl"/>
    <xsl:import href="back-matter.xsl"/>
    <xsl:import href="hi-domain.xsl"/>
    <xsl:import href="links.xsl"/>
    <xsl:import href="lists.xsl"/>
    <xsl:import href="root-processing.xsl"/>
    <xsl:import href="root-processing_fop.xsl"/>
    <xsl:import href="static-content.xsl"/>
    <xsl:import href="tables.xsl"/>
    <xsl:import href="task-elements.xsl"/>
    <xsl:import href="toc.xsl"/>


    <!--  2017-05-23 -->
    <!--  DITA for Print: getChapterPrefix template -->

    <!-- This template donated by Kyle Schwamkrug, from the dita-users Yahoo group.-->
    <xsl:template name="getChapterPrefix">
        <xsl:variable name="topicType">
            <xsl:call-template name="determineTopicType"/>
        </xsl:variable>
        <!-- Looks back up the document tree to find which top-level topic I'm nested in. -->
        <xsl:variable name="containingChapter"
            select="ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = last()]"/>
        <!-- And get the id of that chapter. I'll need it later. -->
        <xsl:variable name="id" select="$containingChapter/@id"/>
        <!-- Get the chapters and appendixes from the merged map because, at this point, I don't
    know whether the topic I'm in is inside a chapter or an appendix or a part. -->
        <xsl:variable name="topicChapters">
            <xsl:copy-of select="$map//*[contains(@class, ' bookmap/chapter')]"/>
        </xsl:variable>
        <xsl:variable name="topicAppendices">
            <xsl:copy-of select="$map//*[contains(@class, ' bookmap/appendix')]"/>
        </xsl:variable>
        <xsl:variable name="topicParts">
            <xsl:copy-of select="$map//*[contains(@class, ' bookmap/part')]"/>
        </xsl:variable>
        <!-- Figure out the chapter number. -->
        <xsl:variable name="chapterNumber">
            <xsl:choose>
                <!-- If there's something in $topicChapters with an id that matches the id of the
        context node, then I'm inside a chapter. -->
                <xsl:when test="$topicChapters/*[@id = $id]">
                    <xsl:number format="1"
                        value="count($topicChapters/*[@id = $id]/preceding-sibling::*) + 1"/>
                </xsl:when>
                <!-- If there's something in $topicAppendices with an id that matches the id of 
            the context node, then I'm inside an appendix. -->
                <xsl:when test="$topicAppendices/*[@id = $id]">
                    <xsl:number format="A"
                        value="count($topicAppendices/*[@id = $id]/preceding-sibling::*) + 1"/>
                </xsl:when>
                <!-- If there's something in $topicParts with an id that matches the id of the context node,
            then I'm inside a part. -->
                <xsl:when test="$topicParts/*[@id = $id]">
                    <!-- [SP] 2016-08-31 sfb: When in a part, restart the calculation, based on the penultimate topic-->
                    <xsl:variable name="penultimateTopic"
                        select="ancestor-or-self::*[contains(@class, ' topic/topic ')][position() = (last() - 1)]"/>
                    <!-- And get the id of that chapter. I'll need it later. -->
                    <xsl:variable name="pen_id" select="$penultimateTopic/@id"/>
                    <xsl:choose>
                        <xsl:when test="$topicChapters/*[@id = $pen_id]">
                            <xsl:number format="1"
                                value="count($topicChapters/*[@id = $pen_id]/preceding-sibling::*) + 1"
                            />
                        </xsl:when>
                        <!-- If there's something in $topicAppendices with an id that matches the id of 
            the context node, then I'm inside an appendix. -->
                        <xsl:when test="$topicAppendices/*[@id = $pen_id]">
                            <xsl:number format="A"
                                value="count($topicAppendices/*[@id = $pen_id]/preceding-sibling::*) + 1"
                            />
                        </xsl:when>
                    </xsl:choose>
                    <!-- [SP] 2016-08-31 sfb: we don't need this...-->
                    <!--                <xsl:number format="I" value="count($topicParts/*[@id =$id]/preceding-sibling::*) + 1"/>-->
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:variable>
        <!-- If $chapterNumber is defined, return it.-->
        <xsl:choose>
            <xsl:when test="$chapterNumber != ''">
                <xsl:value-of select="$chapterNumber"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
