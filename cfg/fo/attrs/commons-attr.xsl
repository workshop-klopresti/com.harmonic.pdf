<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:rx="http://www.renderx.com/XSL/Extensions"
  version="2.0">
  <!--  KLL 2017-06-02 Changed attribute set from body to common.block to apply consistent spacing from topic titles.-->
  <xsl:attribute-set name="shortdesc" use-attribute-sets="common.block">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="topic__shortdesc" use-attribute-sets="common.block">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section" use-attribute-sets="base-font">
    <xsl:attribute name="line-height">
      <xsl:value-of select="$default-line-height"/>
    </xsl:attribute>
    <!--  KLL 2017-06-02 removed extra spacing that affected task prereq and context-->
    <!--    <xsl:attribute name="space-before">0.6em</xsl:attribute>
-->
  </xsl:attribute-set>

  <xsl:attribute-set name="section__content">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="line-height">
      <xsl:value-of select="$default-line-height"/>
    </xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
  </xsl:attribute-set>

  <!--  KLL 2016-09-07 Transform Change Request: Add "Example:" prefix and other formatting -->
  <xsl:attribute-set name="example">
    <xsl:attribute name="border-top-style">none</xsl:attribute>
    <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    <xsl:attribute name="border-left-style">none</xsl:attribute>
    <xsl:attribute name="border-right-style">none</xsl:attribute>
    <xsl:attribute name="space-before">6pt</xsl:attribute>
    <xsl:attribute name="font-size">10pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
    <xsl:attribute name="space-before">0.6em</xsl:attribute>
    <xsl:attribute name="start-indent">from-parent(start-indent)</xsl:attribute>
    <xsl:attribute name="end-indent">36pt</xsl:attribute>
  </xsl:attribute-set>

  <!--  KLL 2016-09-07 Transform Change Request: Add "Example:" prefix and other formatting -->
  <xsl:attribute-set name="example__content" use-attribute-sets="common.block">
    <xsl:attribute name="margin-right">0in</xsl:attribute>
    <xsl:attribute name="margin-left">0in</xsl:attribute>
    <xsl:attribute name="text-indent">0em</xsl:attribute>
    <xsl:attribute name="padding">0pt</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-06-01 -->
  <!--  DITA for Print: Format figure titles -->
  <xsl:attribute-set name="fig.title" use-attribute-sets="base-font common.title">
    <xsl:attribute name="font-family">sans-serif</xsl:attribute>
    <xsl:attribute name="font-weight">regular</xsl:attribute>
    <xsl:attribute name="space-before">5pt</xsl:attribute>
    <xsl:attribute name="space-after">10pt</xsl:attribute>
    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
  </xsl:attribute-set>

  <!-- Harmonic common attribute sets -->
  <xsl:attribute-set name="common.border__top">
    <xsl:attribute name="border-before-style">solid</xsl:attribute>
    <xsl:attribute name="border-before-width">1pt</xsl:attribute>
    <xsl:attribute name="border-before-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="common.border__bottom">
    <xsl:attribute name="border-after-style">solid</xsl:attribute>
    <xsl:attribute name="border-after-width">1pt</xsl:attribute>
    <xsl:attribute name="border-after-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="common.border__right">
    <xsl:attribute name="border-right-style">solid</xsl:attribute>
    <xsl:attribute name="border-right-width">1pt</xsl:attribute>
    <xsl:attribute name="border-right-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="common.border__left">
    <xsl:attribute name="border-left-style">solid</xsl:attribute>
    <xsl:attribute name="border-left-width">1pt</xsl:attribute>
    <xsl:attribute name="border-left-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-06-01 -->
  <!--  DITA for Print: Format table rules -->
  <xsl:attribute-set name="table.frame__top">
    <xsl:attribute name="border-before-style">solid</xsl:attribute>
    <xsl:attribute name="border-before-width">1pt</xsl:attribute>
    <xsl:attribute name="border-before-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.frame__bottom">
    <xsl:attribute name="border-after-style">solid</xsl:attribute>
    <xsl:attribute name="border-after-width">1pt</xsl:attribute>
    <xsl:attribute name="border-after-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.frame__right">
    <xsl:attribute name="border-right-style">solid</xsl:attribute>
    <xsl:attribute name="border-right-width">1pt</xsl:attribute>
    <xsl:attribute name="border-right-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.frame__left">
    <xsl:attribute name="border-left-style">solid</xsl:attribute>
    <xsl:attribute name="border-left-width">1pt</xsl:attribute>
    <xsl:attribute name="border-left-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.rule__top">
    <xsl:attribute name="border-before-style">solid</xsl:attribute>
    <xsl:attribute name="border-before-width">1pt</xsl:attribute>
    <xsl:attribute name="border-before-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.rule__bottom">
    <xsl:attribute name="border-after-style">solid</xsl:attribute>
    <xsl:attribute name="border-after-width">1pt</xsl:attribute>
    <xsl:attribute name="border-after-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.rule__right">
    <xsl:attribute name="border-right-style">solid</xsl:attribute>
    <xsl:attribute name="border-right-width">1pt</xsl:attribute>
    <xsl:attribute name="border-right-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.rule__left">
    <xsl:attribute name="border-left-style">solid</xsl:attribute>
    <xsl:attribute name="border-left-width">1pt</xsl:attribute>
    <xsl:attribute name="border-left-color">#797979</xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-05-31 -->
  <!--  DITA for Print: Set body font sizes -->
  <xsl:attribute-set name="note" use-attribute-sets="common.block">
    <xsl:attribute name="font-size">10pt</xsl:attribute>
    <xsl:attribute name="space-before">25pt</xsl:attribute>
    <xsl:attribute name="space-after">25pt</xsl:attribute>
    <xsl:attribute name="line-height">12pt</xsl:attribute>
    <xsl:attribute name="margin-right">0.3in</xsl:attribute>
    <xsl:attribute name="margin-left">0.0in</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="padding-left">5pt</xsl:attribute>
    <xsl:attribute name="padding-right">5pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="note__table" use-attribute-sets="common.block"> </xsl:attribute-set>

  <xsl:attribute-set name="note__image__column">
    <xsl:attribute name="column-number">1</xsl:attribute>
    <xsl:attribute name="column-width">.3in</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="note__text__column">
    <xsl:attribute name="column-number">2</xsl:attribute>
    <xsl:attribute name="column-width">6.0in</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="note__image__entry">
    <xsl:attribute name="padding-right">0pt</xsl:attribute>
    <xsl:attribute name="start-indent">.0in</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="note__text__entry">
    <xsl:attribute name="start-indent">0in</xsl:attribute>
  </xsl:attribute-set>

  <!--  KLL 2017-06-01 Format note labels (Note, Tip, Important) -->
  <xsl:attribute-set name="note__label">
    <xsl:attribute name="border-left-width">0pt</xsl:attribute>
    <xsl:attribute name="border-right-width">0pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="font-family">Arial</xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-05-31 -->
  <!--  DITA for Print: Specify numbering format for TOC pages -->
  <xsl:attribute-set name="page-sequence.toc"
    use-attribute-sets="__force__page__count page-sequence.frontmatter">
    <xsl:attribute name="format">1</xsl:attribute>
  </xsl:attribute-set>

  <!--  KLL 2017-07-11 Specify numbering format for frontmatter  -->
  <xsl:attribute-set name="page-sequence.frontmatter">
    <xsl:attribute name="format">1</xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-05-26 -->
  <!--  DITA for Print: Set the default line height -->
  <xsl:attribute-set name="base-font">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="line-height">
      <xsl:value-of select="$default-line-height"/>
    </xsl:attribute>
  </xsl:attribute-set>


  <!--  2017-05-26 -->
  <!--  DITA for Print: Format topic titles -->
  <!-- Formats Heading 1 in PDF-->
  <xsl:attribute-set name="topic.topic.title"
    use-attribute-sets="common.title common.border__bottom">
    <xsl:attribute name="space-before">0pt</xsl:attribute>
    <xsl:attribute name="space-after">0pt</xsl:attribute>
    <xsl:attribute name="font-size">17pt</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="line-height">19pt</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="border-after-style">none</xsl:attribute>
    <xsl:attribute name="border-after-width">0pt</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$text-color"/>
    </xsl:attribute>
    <xsl:attribute name="font-family">Futura, Arial</xsl:attribute>
  </xsl:attribute-set>
  <!-- Formats Heading 2 in PDF-->
  <xsl:attribute-set name="topic.topic.topic.title" use-attribute-sets="common.title">
    <xsl:attribute name="space-before">10pt</xsl:attribute>
    <xsl:attribute name="space-after">0pt</xsl:attribute>
    <xsl:attribute name="font-size">15pt</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="line-height">17pt</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$text-color"/>
    </xsl:attribute>
    <xsl:attribute name="font-family">Futura, Arial</xsl:attribute>
    <xsl:attribute name="start-indent">
      <xsl:value-of select="$side-col-width"/>
    </xsl:attribute>
  </xsl:attribute-set>
  <!-- Formats Heading 3 in PDF-->
  <xsl:attribute-set name="topic.topic.topic.topic.title"
    use-attribute-sets="base-font common.title">
    <xsl:attribute name="space-before">7pt</xsl:attribute>
    <xsl:attribute name="space-after">7pt</xsl:attribute>
    <xsl:attribute name="font-size">13pt</xsl:attribute>
    <xsl:attribute name="start-indent">
      <xsl:value-of select="$side-col-width"/>
    </xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="line-height">14pt</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$text-color"/>
    </xsl:attribute>
    <xsl:attribute name="font-family">Futura, Arial</xsl:attribute>
  </xsl:attribute-set>
  <!-- Formats Heading 4 in PDF-->
  <xsl:attribute-set name="topic.topic.topic.topic.topic.title"
    use-attribute-sets="base-font common.title">
    <xsl:attribute name="space-before">7pt</xsl:attribute>
    <xsl:attribute name="space-after">0pt</xsl:attribute>
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="start-indent">
      <xsl:value-of select="$side-col-width"/>
    </xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="line-height">13pt</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$text-color"/>
    </xsl:attribute>
    <xsl:attribute name="font-family">Futura, Arial</xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-05-26 -->
  <!--  DITA for Print: Format section titles -->
  <!--  KLL 2016-08-25 Transform Change Request: more space before section titles-->
  <xsl:attribute-set name="section.title" use-attribute-sets="common.title">
    <xsl:attribute name="font-weight">regular</xsl:attribute>
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="space-before">12pt</xsl:attribute>
    <xsl:attribute name="space-after">3pt</xsl:attribute>
    <xsl:attribute name="line-height">120%</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="font-family">Futura, Arial</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$text-color"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-05-26 -->
  <!--  DITA for Print: Format chapter, appendix or part titles -->
  <xsl:attribute-set name="topic.title" use-attribute-sets="common.title">
    <xsl:attribute name="padding-bottom">6pt</xsl:attribute>
    <xsl:attribute name="border-after-style">solid</xsl:attribute>
    <xsl:attribute name="border-after-width">1pt</xsl:attribute>
    <xsl:attribute name="border-after-color">
      <xsl:value-of select="$light-accent-color"/>
    </xsl:attribute>
    <xsl:attribute name="font-family">Futura, Arial</xsl:attribute>
    <xsl:attribute name="font-size">19pt</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$dark-accent-color"/>
    </xsl:attribute>
    <xsl:attribute name="text-align">end</xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-05-25 -->
  <!--  DITA for Print: Eliminate blank last pages -->
  <!--  DITA for Print: Use bookmap page sequence for maps -->
  <xsl:attribute-set name="__force__page__count">
    <xsl:attribute name="force-page-count">
      <xsl:choose>
        <xsl:when test="name(/*) = 'bookmap'">
          <!--  2017-05-31 -->
          <!--  DITA for Print: Eliminate blank last pages -->
          <xsl:value-of select="'auto'"/>
        </xsl:when>
        <xsl:otherwise>
          <!--  2017-05-31 -->
          <!--  DITA for Print: Use bookmap page sequence for maps -->
          <xsl:value-of select="'even'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-05-23 -->
  <!--  DITA for Print: Specify fonts to use -->
  <!--  KLL 2017-05-24 Used by 6 title levels as well as titles for section, example, figure, table, cover page, and TOC header -->
  <xsl:attribute-set name="common.title">
    <xsl:attribute name="font-family">Futura, Arial</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <!--  DITA for Print: Conditionalize an attribute set based on a build -->
    <!--  <xsl:attribute name="background-color">
      <xsl:choose>
        <xsl:when test="$DRAFT = 'yes'">#FF00FF</xsl:when>
        <xsl:otherwise>#ffffff</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>-->
  </xsl:attribute-set>

  <!--  KLL 2017-05-24 Applies fonts throughout the PDF unless there is a specific attribute set -->
  <xsl:attribute-set name="__fo__root" use-attribute-sets="base-font">
    <xsl:attribute name="font-family">Arial, Helvetica, KaiTi</xsl:attribute>
    <xsl:attribute name="background-color">#c99b9b</xsl:attribute>
    <xsl:attribute name="xml:lang" select="translate($locale, '_', '-')"/>
    <xsl:attribute name="writing-mode" select="$writing-mode"/>
  </xsl:attribute-set>
  <!--  KLL 2017-05-24 Used by codeblock and msgblock attribute sets -->
  <xsl:attribute-set name="pre" use-attribute-sets="base-font common.block">
    <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
    <xsl:attribute name="white-space-collapse">false</xsl:attribute>
    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
    <xsl:attribute name="wrap-option">wrap</xsl:attribute>
    <xsl:attribute name="background-color">#e6e6e6</xsl:attribute>
    <xsl:attribute name="font-family">Courier New, Courier</xsl:attribute>
    <xsl:attribute name="line-height">106%</xsl:attribute>
  </xsl:attribute-set>

  <!--DITA for Print: Format topic titles-->
  <xsl:attribute-set name="topic.title.hide" use-attribute-sets="common.title">
    <xsl:attribute name="border-bottom">0pt solid black</xsl:attribute>
    <xsl:attribute name="border-after-width">0pt</xsl:attribute>
    <xsl:attribute name="space-before">0pt</xsl:attribute>
    <xsl:attribute name="space-after">30pt</xsl:attribute>
    <xsl:attribute name="font-size">2pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="padding-top">0pt</xsl:attribute>
    <xsl:attribute name="color">#ffffff</xsl:attribute>
    <xsl:attribute name="line-height">4pt</xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-05-26 -->
  <!--  DITA for Print: Format trademark symbols -->
  <!--  KLL 2016-09-16 Updated trademark (TM) symbol for 2016 rebranding-->
  <xsl:attribute-set name="tm__content__tm">
    <xsl:attribute name="font-size">40%</xsl:attribute>
    <xsl:attribute name="baseline-shift">30%</xsl:attribute>
  </xsl:attribute-set>

  <!--  KLL 2016-09-16 Updated registered trademark (R) symbol for 2016 rebranding-->
  <xsl:attribute-set name="tm__content">
    <xsl:attribute name="font-size">40%</xsl:attribute>
    <xsl:attribute name="baseline-shift">30%</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="tm__content__service">
    <xsl:attribute name="font-size">100%</xsl:attribute>
    <xsl:attribute name="baseline-shift">0%</xsl:attribute>
  </xsl:attribute-set>

  <!--  2017-05-23 -->
  <!--  DITA for Print: Format mini-TOC links-->
  <xsl:attribute-set name="xref__mini__toc">
    <xsl:attribute name="color">
      <xsl:value-of select="$light-accent-color"/>
    </xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>

  <!--  KLL 2017-06-01 outputclass test -->
  <xsl:attribute-set name="ph">
    <!-- [SP] 2016-09-26 sfb: To change text color, you need to use the form shown after the comment below: -->
    <xsl:attribute name="color">
      <xsl:choose>
        <xsl:when test="contains(@outputclass, 'font-color-red')">
          <xsl:text>#ff0000</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>#000000</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <!--  KLL 2017-06-01 Dynamically scale images to page width -->
  <!-- Applies to oversize images with a width larger than the page -->
  <!--    Applies to images with "break" value for placement attribute-->
  <xsl:attribute-set name="image__block">
    <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
    <xsl:attribute name="content-height">100%</xsl:attribute>
    <xsl:attribute name="width">100%</xsl:attribute>
    <xsl:attribute name="scaling">uniform</xsl:attribute>
    <!-- [SP] 2016-09-26 sfb: Changed attribute name 'align' to text-align-->
    <!--<xsl:attribute name="text-align">center</xsl:attribute>-->
  </xsl:attribute-set>

  <xsl:attribute-set name="image__inline">
    <xsl:attribute name="content-width">auto</xsl:attribute>
    <xsl:attribute name="content-height">auto</xsl:attribute>
    <xsl:attribute name="width">auto</xsl:attribute>
    <xsl:attribute name="scaling">uniform</xsl:attribute>
  </xsl:attribute-set>

  <!--  KLL 2017-07-07 Format draft comment text and background -->
  <xsl:attribute-set name="draft-comment">
    <xsl:attribute name="color">#005700</xsl:attribute>
    <xsl:attribute name="background-color">#F0FFF0</xsl:attribute>
    <xsl:attribute name="padding">5pt</xsl:attribute>
    <xsl:attribute name="margin">3pt</xsl:attribute>
    <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
    <xsl:attribute name="border">none</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="draft-comment__label">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
