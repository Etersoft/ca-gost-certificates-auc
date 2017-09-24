<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="yes" encoding="utf-8"/>
<xsl:template match="/">
  <xsl:for-each select="/АккредитованныеУдостоверяющиеЦентры/УдостоверяющийЦентр/ПрограммноАппаратныеКомплексы/ПрограммноАппаратныйКомплекс/КлючиУполномоченныхЛиц/Ключ/Сертификаты/ДанныеСертификата">
    <xsl:value-of select="Отпечаток"/><xsl:text> </xsl:text><xsl:value-of select="Данные"/>
    <xsl:text>
</xsl:text>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
