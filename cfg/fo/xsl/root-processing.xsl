<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  exclude-result-prefixes="opentopic-index opentopic opentopic-i18n opentopic-func dita-ot xs ot-placeholder"
  version="2.0">

  <xsl:variable name="productRelease"
    select="(/*/opentopic:map//*[contains(@class, ' topic/vrmlist ')]/*[contains(@class, ' topic/vrm ')]/@release)[1]"/>

  <xsl:variable name="productVersion"
    select="(/*/opentopic:map//*[contains(@class, ' topic/vrmlist ')]/*[contains(@class, ' topic/vrm ')]/@version)[1]"/>

  <xsl:variable name="productComponent"
    select="(/*/opentopic:map//*[contains(@class, ' topic/component ')])[1]"/>

  <xsl:variable name="documentCategory"
    select="(/*/opentopic:map//*[contains(@class, ' topic/category ')])[1]"/>

  <xsl:variable name="documentRevision"
    select="//*[contains(@class, ' bookmap/bookchangehistory ')]//*[contains(@class, ' bookmap/revisionid ')]"/>

  <!--  2017-05-25 -->
  <!--  DITA for Print: Create metadata variables for headers and footers -->
  <xsl:variable name="bc.productName">
    <xsl:variable name="mapProdname"
      select="(/*/opentopic:map//*[contains(@class, ' topic/prodname ')])[1]"/>
    <xsl:choose>
      <xsl:when test="$mapProdname">
        <xsl:value-of select="$mapProdname"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'Product Name'"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="map" select="//opentopic:map"/>
  <xsl:variable name="topicNumbers">
    <xsl:for-each select="//*[contains(@class, ' topic/topic ')]">
      <topic guid="{generate-id()}">
        <xsl:call-template name="commonattributes"/>
      </topic>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="bc.productVersion"
    select="(/*/opentopic:map//*[contains(@class, ' topic/vrm ')]/@version)[1]"/>

  <xsl:variable name="bc.pubDate"
    select="(/*/opentopic:map//*[contains(@class, ' topic/revised ')]/@golive)[1]"/>

  <xsl:variable name="bc.bookTitle">
    <xsl:choose>
      <xsl:when
        test="exists($map/*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class, ' bookmap/mainbooktitle ')])">
        <xsl:value-of>
          <xsl:apply-templates
            select="$map/*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class, ' bookmap/mainbooktitle ')][1]"
            mode="dita-ot:text-only"/>
        </xsl:value-of>
      </xsl:when>
      <xsl:when test="exists($map/*[contains(@class, ' topic/title ')])">
        <xsl:value-of>
          <xsl:apply-templates select="$map/*[contains(@class, ' topic/title ')][1]"
            mode="dita-ot:text-only"/>
        </xsl:value-of>
      </xsl:when>
      <xsl:when test="exists(//*[contains(@class, ' map/map ')]/@title)">
        <xsl:value-of select="//*[contains(@class, ' map/map ')]/@title"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of>
          <xsl:apply-templates
            select="descendant::*[contains(@class, ' topic/topic ')][1]/*[contains(@class, ' topic/title')]"
            mode="dita-ot:text-only"> </xsl:apply-templates>
        </xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="bc.copyYear">
    <xsl:choose>
      <xsl:when
        test="$map//*[contains(@class, ' topic/data bookmap/copyrfirst ')]//*[contains(@class, ' topic/ph bookmap/year ')]">
        <xsl:apply-templates
          select="$map//*[contains(@class, ' topic/data bookmap/copyrfirst ')]//*[contains(@class, ' topic/ph bookmap/year ')]"
        />
      </xsl:when>
      <xsl:when test="$map//*[contains(@class, ' topic/copyryear ')]/@year">
        <xsl:apply-templates select="$map//*[contains(@class, ' topic/copyryear ')]/@year"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'Copy Year'"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="partNumber"
    select="//*[contains(@class, ' bookmap/bookid ')]//*[contains(@class, ' bookmap/bookpartno ')]"/>

  <xsl:variable name="currentDate"
    select="format-dateTime(current-dateTime(), '[MNn] [D], [Y0001]')"/>
  <!-- TOMV (2014-11) Notices section require this info from bookmap -->
  <xsl:variable name="productReleaseYear"
    select="(//*[contains(@class, ' bookmap/completed ')]/*[contains(@class, ' bookmap/year ')])[1]"/>
  <xsl:variable name="productReleaseMonth"
    select="(//*[contains(@class, ' bookmap/completed ')]/*[contains(@class, ' bookmap/month ')])[1]"/>
  <xsl:variable name="productCreatedDate"
    select="(//*[contains(@class, ' bookmap/copyrfirst ')]/*[contains(@class, ' bookmap/year ')])[1]"/>
  <xsl:variable name="productRevisedDate"
    select="(//*[contains(@class, ' bookmap/copyrlast ')]/*[contains(@class, ' bookmap/year ')])[1]"/>

</xsl:stylesheet>
