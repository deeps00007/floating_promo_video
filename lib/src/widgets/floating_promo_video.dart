import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../services/video_source_service.dart';
import 'internal/draggable_video_container.dart';
import 'internal/story_progress_bars.dart';
import 'internal/video_player_controls.dart';

/// A floating, draggable promotional video widget that fetches Instagram Reels
/// via a backend token API and falls back to [fallbackUrls] on failure.
class FloatingPromotionVideo extends StatefulWidget {
  final String tokenApiUrl;
  final List<String> fallbackUrls;
  final Color accentColor;
  final double initialLeft;
  final double initialBottom;

  const FloatingPromotionVideo({
    Key? key,
    required this.tokenApiUrl,
    this.fallbackUrls = const [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ],
    this.accentColor = const Color(0xFFF60000),
    this.initialLeft = 16.0,
    this.initialBottom = 16.0,
  }) : super(key: key);

  factory FloatingPromotionVideo.fromUrls({
    Key? key,
    required List<String> urls,
    Color accentColor = const Color(0xFFF60000),
    double initialLeft = 16.0,
    double initialBottom = 16.0,
  }) {
    return FloatingPromotionVideo(
      key: key,
      tokenApiUrl: '',
      fallbackUrls: urls,
      accentColor: accentColor,
      initialLeft: initialLeft,
      initialBottom: initialBottom,
    );
  }

  /// Global state is generally discouraged, but kept for backward compatibility.
  /// Set to `true` to hide the widget for the remainder of the app session.
  static bool isClosedForSession = false;

  @override
  State<FloatingPromotionVideo> createState() => _FloatingPromotionVideoState();
}

class _FloatingPromotionVideoState extends State<FloatingPromotionVideo> {
  late final VideoSourceService _videoService;

  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  bool _isMuted = true;
  bool _isExpanded = false;
  bool _isVisible = false;

  List<String> _playlist = [];
  int _currentIndex = 0;
  double _currentProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _videoService = VideoSourceService(
      tokenApiUrl: widget.tokenApiUrl,
      fallbackUrls: widget.fallbackUrls,
    );

    if (!FloatingPromotionVideo.isClosedForSession) {
      _fetchVideos();
    }
  }

  Future<void> _fetchVideos() async {
    final urls = await _videoService.fetchVideos();
    if (!mounted) return;

    _initializePlaylist(urls);

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && !FloatingPromotionVideo.isClosedForSession) {
        setState(() => _isVisible = true);
      }
    });
  }

  void _initializePlaylist(List<String> urls) {
    if (urls.isEmpty) return;
    setState(() {
      _playlist = urls;
      _currentIndex = 0;
    });
    _initializeVideoPlayer(_playlist[_currentIndex]);
  }

  Future<void> _initializeVideoPlayer(String videoUrl) async {
    final newController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    try {
      await newController.initialize();
      if (!mounted) {
        newController.dispose();
        return;
      }

      _videoController?.removeListener(_videoListener);
      _videoController?.dispose();
      _chewieController?.dispose();

      setState(() {
        _videoController = newController..addListener(_videoListener);

        _chewieController = ChewieController(
          videoPlayerController: _videoController!,
          autoPlay: true,
          looping: false,
          showControls: false,
        );

        _videoController!.setVolume(_isMuted ? 0.0 : 1.0);
      });
    } catch (e) {
      debugPrint('FloatingPromotionVideo init error: $e');
      newController.dispose();
    }
  }

  void _videoListener() {
    if (!mounted || _videoController == null) return;

    final position = _videoController!.value.position;
    final duration = _videoController!.value.duration;

    if (duration.inMilliseconds > 0) {
      setState(() {
        _currentProgress = position.inMilliseconds / duration.inMilliseconds;
      });
    }

    if (_videoController!.value.isInitialized &&
        position >= duration &&
        !_videoController!.value.isPlaying) {
      _videoController!.removeListener(_videoListener);
      Future.microtask(_playNextVideo);
    }
  }

  void _playNextVideo() {
    if (_playlist.isEmpty) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
      _currentProgress = 0.0;
    });
    _initializeVideoPlayer(_playlist[_currentIndex]);
  }

  @override
  void dispose() {
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _videoController?.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _closeVideo() async {
    setState(() {
      _isVisible = false;
      _isExpanded = false;
    });

    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    _videoController?.removeListener(_videoListener);
    _videoController?.pause();
    _playlist.clear();

    try {
      _chewieController?.dispose();
    } catch (e) {
      debugPrint('Chewie dispose error: $e');
    }
    try {
      _videoController?.dispose();
    } catch (e) {
      debugPrint('VideoPlayer dispose error: $e');
    }

    setState(() {
      _chewieController = null;
      _videoController = null;
      FloatingPromotionVideo.isClosedForSession = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (FloatingPromotionVideo.isClosedForSession) {
      return const SizedBox.shrink();
    }

    return DraggableVideoContainer(
      isVisible: _isVisible,
      isExpanded: _isExpanded,
      initialLeft: widget.initialLeft,
      initialBottom: widget.initialBottom,
      onToggleExpand: _toggleExpand,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video player
          if (_chewieController != null &&
              _videoController != null &&
              _videoController!.value.isInitialized)
            ClipRRect(
              key: ValueKey(_currentIndex),
              borderRadius: BorderRadius.circular(_isExpanded ? 0 : 8),
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController!.value.size.width,
                  height: _videoController!.value.size.height,
                  child: Chewie(controller: _chewieController!),
                ),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white24,
              ),
            ),

          // Controls
          Positioned.fill(
            child: VideoPlayerControlsContainer(
              isExpanded: _isExpanded,
              isMuted: _isMuted,
              onClose: _closeVideo,
              onToggleMute: _toggleMute,
            ),
          ),

          // Progress Bars
          Positioned(
            bottom:
                (_isExpanded ? MediaQuery.of(context).padding.bottom : 0) + 1,
            left: 2,
            right: 2,
            child: StoryProgressBars(
              totalCount: _playlist.length,
              currentIndex: _currentIndex,
              currentProgress: _currentProgress,
              accentColor: widget.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
