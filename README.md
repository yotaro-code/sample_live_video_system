# OBS Live Streaming App

このプロジェクトは、OBSを使用したライブストリーミングシステムのサンプルアプリケーションです。

## 機能

- OBSからのRTMPストリーミング受信
- HLS形式でのライブ配信
- メディアサーバー（Nginx-RTMP）によるストリーミング処理

## セットアップ

### 必要条件

- Docker
- Docker Compose
- OBS Studio

### インストール手順

1. リポジトリをクローン:
```bash
git clone git@github.com:yotaro-code/sample_live_video_system.git
cd sample_live_video_system
```

2. メディアサーバーの起動:
```bash
cd media_server
docker-compose up -d
```

3. OBSの設定:
- 出力設定でRTMPサーバーを `rtmp://localhost:1935/live` に設定
- ストリームキーを任意の値に設定

## 使用方法

1. メディアサーバーを起動後、OBSで配信を開始
2. ブラウザで `http://localhost:8080/hls/stream.m3u8` にアクセスして配信を視聴

## 技術スタック

- Nginx-RTMP
- Docker
- HLS (HTTP Live Streaming)
- RTMP (Real-Time Messaging Protocol) 