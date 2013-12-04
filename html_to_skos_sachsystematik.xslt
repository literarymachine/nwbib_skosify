<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="html"
>

    <xsl:output method="xml" />

    <xsl:template match="html:body">
      <skos:ConceptScheme rdf:about="#">
        <xsl:for-each select="html:div[@id='navigation']/html:ul/html:li[@id='sachsystematik']/html:ul[@id='ul_sachsystematik']/html:li[@id]">
          <skos:hasTopConcept>
            <xsl:apply-templates select="." />
          </skos:hasTopConcept>
        </xsl:for-each>
      </skos:ConceptScheme>
    </xsl:template>

    <xsl:template match="html:li">
      <skos:Concept rdf:about="#{substring-before(normalize-space(html:a), ' ')}">
        <skos:notation><xsl:value-of select="substring-before(normalize-space(html:a), ' ')" /></skos:notation>
        <skos:prefLabel xml:lang="de"><xsl:value-of select="substring-after(normalize-space(html:a), ' ')" /></skos:prefLabel>
        <xsl:for-each select="html:ul[@class='opened']/html:li[@class='caption']">
          <skos:narrower>
            <xsl:apply-templates select="." />
          </skos:narrower>
        </xsl:for-each>
        <xsl:apply-templates select="following-sibling::html:li[1][@style='list-style: none; display: inline']" />
      </skos:Concept>
    </xsl:template>

    <xsl:template match="html:li[@style='list-style: none; display: inline']">
        <xsl:for-each select="html:ul/html:li[@class='caption']">
          <skos:narrower>
            <xsl:apply-templates select="." />
          </skos:narrower>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="text()|@*"></xsl:template>

</xsl:stylesheet>
