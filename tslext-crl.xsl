<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="yes" encoding="utf-8"/>
<xsl:template match="/">
  <xsl:for-each select="/АккредитованныеУдостоверяющиеЦентры/УдостоверяющийЦентр/ПрограммноАппаратныеКомплексы/ПрограммноАппаратныйКомплекс/КлючиУполномоченныхЛиц/Ключ">
    <xsl:variable name="keyid" select="ИдентификаторКлюча"/>
    <xsl:for-each select="АдресаСписковОтзыва/Адрес">
      <xsl:variable name="address" select="."/>
      <xsl:value-of select="concat($keyid, ' ', $address)"/>
    <xsl:text>
</xsl:text>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
