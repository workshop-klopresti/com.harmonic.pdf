<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

  <xsl:attribute-set name="simpletable">
    <xsl:attribute name="table-layout">fixed</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="dl">
    <xsl:attribute name="table-layout">fixed</xsl:attribute>
  </xsl:attribute-set>

  <!-- [Scriptorium] 2016-03-30 sfb: calculating keep-with-next/previous
   If a dlentry has fewer than 2 preceding/following siblings (and not zero), the row stays as is. 
   Otherwise, allow it is allowed to break anywhere ("auto").
  -->
  <xsl:attribute-set name="dlentry">
    <xsl:attribute name="keep-with-previous.within-page">
      <xsl:choose>
        <xsl:when test="count(preceding-sibling::dlentry) = 0">
          <xsl:text>auto</xsl:text>
        </xsl:when>
        <xsl:when test="count(preceding-sibling::dlentry) &lt; 2">
          <xsl:text>always</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>auto</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="keep-with-next.within-page">
      <xsl:choose>
        <xsl:when test="count(following-sibling::dlentry) = 0">
          <xsl:text>auto</xsl:text>
        </xsl:when>
        <xsl:when test="count(following-sibling::dlentry) &lt; 2">
          <xsl:text>always</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>auto</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="reltable">
    <xsl:attribute name="table-layout">fixed</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="properties">
    <xsl:attribute name="table-layout">fixed</xsl:attribute>
  </xsl:attribute-set>


  <xsl:attribute-set name="choicetable">
    <xsl:attribute name="table-layout">fixed</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.tgroup">
    <xsl:attribute name="table-layout">fixed</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
