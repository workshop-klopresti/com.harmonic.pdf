<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:opentopic="http://www.idiominc.com/opentopic"
	exclude-result-prefixes="opentopic" version="2.0">

	<!--  2017-05-26 -->
	<!--  DITA for Print: Add content to the back cover -->
	<xsl:template name="createBackCover">
		<xsl:if test="$generate-back-cover">
			<fo:page-sequence master-reference="back-cover" xsl:use-attribute-sets="back-cover">
				<xsl:call-template name="insertBackCoverStaticContents"/>
				<fo:flow flow-name="xsl-region-body">
					<fo:block-container xsl:use-attribute-sets="__back-cover">
						<xsl:call-template name="createBackCoverContents"/>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>
		</xsl:if>
	</xsl:template>

	<xsl:template name="createBackCoverContents">
		<fo:block-container xsl:use-attribute-sets="__backmatter__container">
			<fo:block xsl:use-attribute-sets="__backmatter__website">
				<xsl:text>www.harmonicinc.com</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="__backmatter__publish">
				<xsl:text>Copyright &#169; </xsl:text>
				<xsl:choose>
					<xsl:when test="$productRevisedDate">
						<xsl:value-of select="$productRevisedDate"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]')"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> </xsl:text>
				<xsl:text>Harmonic Inc. All rights reserved.</xsl:text>
			</fo:block>
		</fo:block-container>
	</xsl:template>
</xsl:stylesheet>
