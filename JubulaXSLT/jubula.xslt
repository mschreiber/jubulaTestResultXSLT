<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:strip-space elements="*" />
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="/">
    <testsuite>
      <xsl:attribute name="name">
      <xsl:value-of select="report/project/name"></xsl:value-of>.<xsl:value-of
        select="report/project/testsuite/name"></xsl:value-of>
      </xsl:attribute>
      <xsl:attribute name="failures">
        <xsl:value-of select="count(/report/project/testsuite/test-run/testcase[count(step/error)>0])"></xsl:value-of>
      </xsl:attribute>
      <xsl:attribute name="errors">0</xsl:attribute>
      <xsl:attribute name="skipped">
        <xsl:value-of select="count(report/project/testsuite/test-run/testcase[status=0])"></xsl:value-of>
      </xsl:attribute>
      <xsl:attribute name="tests">
        <xsl:value-of select="count(report/project/testsuite/test-run/testcase)"></xsl:value-of>
      </xsl:attribute>
      <xsl:for-each select="/report/project/testsuite/test-run/testcase">
      <testcase>
      <xsl:attribute name="classname"><xsl:value-of select="../../name"></xsl:value-of></xsl:attribute>
      <xsl:attribute name="name"><xsl:value-of select="name"></xsl:value-of></xsl:attribute>
      <xsl:choose>
         <xsl:when test="@duration">
            <xsl:attribute name="time"><xsl:value-of select="substring(@duration, 1,1) * 60 * 60 + substring(@duration, 3,2) * 60 + substring(@duration, 7,5)"></xsl:value-of></xsl:attribute> 
         </xsl:when>
      </xsl:choose>
      <xsl:choose>
      <xsl:when test="step/error">
      <failure>
      <xsl:attribute name="type"><xsl:value-of select="step/error/../action-type"></xsl:value-of>: <xsl:value-of select="step/error/description"></xsl:value-of></xsl:attribute>
      Step: <xsl:value-of select="step/error/../name"></xsl:value-of>
      Action-Type: <xsl:value-of select="step/error/../action-type"></xsl:value-of>
      Description: <xsl:value-of select="step/error/description"></xsl:value-of>
      <xsl:for-each select="step/error/../parameter">
      Name: <xsl:value-of select="parameter-name"></xsl:value-of>
      Type: <xsl:value-of select="parameter-type"></xsl:value-of>
      Value: <xsl:value-of select="parameter-value"></xsl:value-of>
      </xsl:for-each>
      </failure>
      </xsl:when>
      </xsl:choose>
      <xsl:choose>
      <xsl:when test="status=0">
      <skipped/>
      </xsl:when>
      </xsl:choose>
      </testcase>
      </xsl:for-each>
    </testsuite>
  </xsl:template>
</xsl:stylesheet>