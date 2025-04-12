<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
    <html>
        <head>
            <title>RTMP Statistics</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 20px; }
                table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
                th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
                th { background-color: #f5f5f5; }
                h1, h2 { color: #333; }
                .stream { background-color: #f9f9f9; margin: 10px 0; padding: 10px; }
            </style>
        </head>
        <body>
            <h1>RTMP Server Statistics</h1>
            
            <xsl:apply-templates select="rtmp"/>
            
            <div class="footer">
                <p>Generated at <xsl:value-of select="$date"/> by nginx-rtmp-module</p>
            </div>
        </body>
    </html>
</xsl:template>

<xsl:template match="rtmp">
    <h2>RTMP Server</h2>
    <table>
        <tr>
            <th>Uptime</th>
            <td><xsl:value-of select="uptime"/> seconds</td>
        </tr>
        <tr>
            <th>Accepted Connections</th>
            <td><xsl:value-of select="naccepted"/></td>
        </tr>
    </table>
    
    <xsl:apply-templates select="server"/>
</xsl:template>

<xsl:template match="server">
    <h2>Applications</h2>
    <xsl:apply-templates select="application"/>
</xsl:template>

<xsl:template match="application">
    <div class="stream">
        <h3>Application: <xsl:value-of select="name"/></h3>
        <table>
            <tr>
                <th>Live Streams</th>
                <td><xsl:value-of select="live/nclients"/> clients</td>
            </tr>
        </table>
        
        <xsl:apply-templates select="live/stream"/>
    </div>
</xsl:template>

<xsl:template match="stream">
    <h4>Stream <xsl:value-of select="name"/></h4>
    <table>
        <tr>
            <th>Time</th>
            <td><xsl:value-of select="time"/></td>
        </tr>
        <tr>
            <th>Clients</th>
            <td><xsl:value-of select="nclients"/></td>
        </tr>
        <tr>
            <th>Video</th>
            <td>
                <xsl:value-of select="meta/video/width"/>x<xsl:value-of select="meta/video/height"/>
                <xsl:value-of select="meta/video/frame_rate"/> fps
                <xsl:value-of select="meta/video/codec"/>
            </td>
        </tr>
        <tr>
            <th>Audio</th>
            <td>
                <xsl:value-of select="meta/audio/codec"/>
                <xsl:value-of select="meta/audio/channels"/> channels
                <xsl:value-of select="meta/audio/sample_rate"/> Hz
            </td>
        </tr>
    </table>
</xsl:template>

</xsl:stylesheet> 