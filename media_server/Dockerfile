FROM alpine:3.14

# 必要なパッケージのインストール
RUN apk add --no-cache \
    nginx \
    nginx-mod-rtmp \
    ffmpeg

# nginx設定ファイルのコピー
COPY nginx.conf /etc/nginx/nginx.conf

# stat.xslファイルのコピー
COPY stat.xsl /var/www/stat.xsl

# rtmpモジュールの設定ファイルをコピー
RUN mkdir -p /etc/nginx/modules && \
    ln -s /usr/lib/nginx/modules/ngx_rtmp_module.so /etc/nginx/modules/

# ポートの公開
EXPOSE 1935
EXPOSE 8080

# HLS用のディレクトリを作成
RUN mkdir -p /var/www/hls && \
    chown -R nginx:nginx /var/www/hls && \
    chown nginx:nginx /var/www/stat.xsl

# nginx実行
CMD ["nginx", "-g", "daemon off;"] 
