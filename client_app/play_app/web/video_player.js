// hls.jsプレーヤーの制御
let hls;
let video;

function initializePlayer() {
  if (!video) {
    video = document.getElementById('video-player');
    hls = new Hls({
      enableWorker: true,
      lowLatencyMode: true,
    });

    hls.loadSource('http://localhost:8080/hls/test.m3u8');
    hls.attachMedia(video);

    hls.on(Hls.Events.MANIFEST_PARSED, function() {
      video.play().catch(function(error) {
        console.error('Play failed:', error);
      });
    });

    hls.on(Hls.Events.ERROR, function(event, data) {
      if (data.fatal) {
        switch(data.type) {
          case Hls.ErrorTypes.NETWORK_ERROR:
            console.error('Network error:', data);
            hls.startLoad();
            break;
          case Hls.ErrorTypes.MEDIA_ERROR:
            console.error('Media error:', data);
            hls.recoverMediaError();
            break;
          default:
            console.error('Fatal error:', data);
            hls.destroy();
            break;
        }
      }
    });
  }
}

function showPlayer() {
  document.getElementById('video-container').style.display = 'block';
  initializePlayer();
}

function hidePlayer() {
  document.getElementById('video-container').style.display = 'none';
  if (video) {
    video.pause();
  }
  if (hls) {
    hls.destroy();
    hls = null;
  }
}

function playVideo() {
  const player = initializePlayer();
  player.play().catch(function(error) {
    console.error('Play failed:', error);
  });
}

function pauseVideo() {
  const player = initializePlayer();
  player.pause();
}

function checkPlayerStatus() {
  const player = initializePlayer();
  return {
    isPlaying: !player.paused(),
    hasError: player.error() !== null,
    errorMessage: player.error() ? player.error().message : null
  };
}

// Flutterからアクセスできるようにグローバルオブジェクトとして公開
window.videoPlayerInterface = {
  showPlayer: showPlayer,
  hidePlayer: hidePlayer,
  playVideo: playVideo,
  pauseVideo: pauseVideo,
  checkStatus: checkPlayerStatus,
}; 