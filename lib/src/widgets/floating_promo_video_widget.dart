import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

/// A floating, draggable promotional video widget that fetches Instagram Reels
/// via a backend token API and falls back to [fallbackUrls] on failure.
///
/// **Easiest usage** — wrap your screen body with [FloatingPromoVideoOverlay]:
/// ```dart
/// FloatingPromoVideoOverlay(
///   tokenApiUrl: 'https://yourbackend.com/api/instagram-token',
///   child: YourScaffoldBody(),
/// )
/// ```
///
/// **Play local / CDN URLs directly** (no backend needed):
/// ```dart
/// FloatingPromoVideoOverlay.fromUrls(
///   urls: ['https://example.com/promo.mp4'],
///   child: YourScaffoldBody(),
/// )
/// ```
///
/// **Manual placement** inside your own Stack:
/// ```dart
/// Stack(
///   children: [
///     YourMainContent(),
///     FloatingPromotionVideo(
///       tokenApiUrl: 'https://yourbackend.com/api/instagram-token',
///     ),
///   ],
/// )
/// ```
class FloatingPromotionVideo extends StatefulWidget {
  /// URL of your backend endpoint that returns:
  /// `{ "status": true, "data": [{ "api_key": "<instagram_token>" }] }`
  ///
  /// Leave empty when using [FloatingPromotionVideo.fromUrls].
  final String tokenApiUrl;

  /// Videos to play when the backend or Instagram API is unavailable.
  final List<String> fallbackUrls;

  /// Accent color used for the progress bar. Defaults to red (YouTube-style).
  final Color accentColor;

  /// Initial horizontal position from the left edge. Defaults to 16.
  final double initialLeft;

  /// Initial vertical position from the bottom edge. Defaults to 16.
  final double initialBottom;

  const FloatingPromotionVideo({
    Key? key,
    required this.tokenApiUrl,
    this.fallbackUrls = const [
      'https://ik.imagekit.io/projectss/Follow%20for%20more_.mp4',
      'https://ik.imagekit.io/projectss/Featuring%20Soon__interior%20_interiordesign%20_reel%20_design.mp4',
    ],
    this.accentColor = const Color(0xFFF60000),
    this.initialLeft = 16.0,
    this.initialBottom = 16.0,
  }) : super(key: key);

  /// Creates a [FloatingPromotionVideo] that plays [urls] directly,
  /// without needing a backend token API.
  ///
  /// ```dart
  /// FloatingPromotionVideo.fromUrls(
  ///   urls: ['https://example.com/promo1.mp4', 'https://example.com/promo2.mp4'],
  /// )
  /// ```
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

  /// Set to `true` to hide the widget for the remainder of the app session.
  static bool isClosedForSession = false;

  @override
  State<FloatingPromotionVideo> createState() => _FloatingPromotionVideoState();
}

class _FloatingPromotionVideoState extends State<FloatingPromotionVideo> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isMuted = false;
  bool _isExpanded = false;

  final double _frameWidth = 120.0;
  final double _frameHeight = 200.0;
  final double _expandedWidth = 210.0;
  final double _expandedHeight = 350.0;
  String? _instagramToken;

  // Story-style playlist
  List<String> _playlist = [];
  int _currentIndex = 0;
  double _currentProgress = 0.0;

  // Draggable position
  double? _left;
  double? _bottom;

  @override
  void initState() {
    super.initState();
    if (!FloatingPromotionVideo.isClosedForSession) {
      _fetchInstagramToken();
    }
  }

  // ---------------------------------------------------------------------------
  // Token & video fetching
  // ---------------------------------------------------------------------------

  Future<void> _fetchInstagramToken() async {
    // If no backend URL provided, play fallback URLs directly.
    if (widget.tokenApiUrl.isEmpty) {
      _initializePlaylist(List<String>.from(widget.fallbackUrls));
      return;
    }
    try {
      final response = await http.get(Uri.parse(widget.tokenApiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true &&
            data['data'] != null &&
            (data['data'] as List).isNotEmpty) {
          _instagramToken = data['data'][0]['api_key'] as String?;
          await _fetchInstagramVideoUrl();
          return;
        }
      }
      _initializeVideoPlayer(widget.fallbackUrls.first);
    } catch (_) {
      _initializePlaylist(List<String>.from(widget.fallbackUrls));
    }
  }

  Future<void> _fetchInstagramVideoUrl() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://graph.instagram.com/me/media'
          '?fields=media_url,media_type'
          '&access_token=$_instagramToken'
          '&limit=5',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && (data['data'] as List).isNotEmpty) {
          final videoUrls = <String>[
            for (final item in data['data'] as List)
              if (item['media_type'] == 'VIDEO' && item['media_url'] != null)
                item['media_url'] as String,
          ];

          if (videoUrls.isNotEmpty) {
            if (videoUrls.length == 1) videoUrls.add(videoUrls[0]);
            _initializePlaylist(videoUrls);
            return;
          }
        }
      }
      _initializePlaylist(List<String>.from(widget.fallbackUrls));
    } catch (_) {
      _initializePlaylist(List<String>.from(widget.fallbackUrls));
    }
  }

  // ---------------------------------------------------------------------------
  // Playlist helpers
  // ---------------------------------------------------------------------------

  void _initializePlaylist(List<String> urls) {
    setState(() {
      _playlist = urls;
      _currentIndex = 0;
    });
    if (_playlist.isNotEmpty) {
      _initializeVideoPlayer(_playlist[_currentIndex]);
    }
  }

  void _initializeVideoPlayer(String videoUrl) {
    final newController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    newController.initialize().then((_) {
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
          aspectRatio: _frameWidth / _frameHeight,
        );

        _videoController!.setVolume(_isMuted ? 0.0 : 1.0);
      });
    }).catchError((Object e) {
      debugPrint('FloatingPromotionVideo init error: $e');
      newController.dispose();
    });
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

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void dispose() {
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  bool _defaultMuteApplied = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_defaultMuteApplied) {
      _defaultMuteApplied = true;
      _applyDefaultMute();
    }
  }

  Future<void> _applyDefaultMute() async {
    _isMuted = true;

    if (_left == null && _bottom == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _left = widget.initialLeft;
          _bottom = widget.initialBottom;
        });
      });
    }

    while (mounted) {
      if (_chewieController != null &&
          _videoController != null &&
          _videoController!.value.isInitialized) {
        await _videoController!.setVolume(0.0);
        break;
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  // ---------------------------------------------------------------------------
  // Controls
  // ---------------------------------------------------------------------------

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _videoController?.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;

      final double nextWidth = _isExpanded ? _expandedWidth : _frameWidth;
      final double nextHeight = _isExpanded ? _expandedHeight : _frameHeight;

      if (_left != null && _bottom != null) {
        final size = MediaQuery.of(context).size;

        if (_left! + nextWidth > size.width - 16) {
          _left = size.width - nextWidth - 16;
        }
        if (_left! < 16) _left = 16;

        if (_bottom! + nextHeight > size.height - 16) {
          _bottom = size.height - nextHeight - 16;
        }
        if (_bottom! < 16) _bottom = 16;
      }
    });
  }

  void _closeVideo() {
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

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    if (FloatingPromotionVideo.isClosedForSession ||
        _left == null ||
        _bottom == null) {
      return const SizedBox.shrink();
    }

    final double currentWidth = _isExpanded ? _expandedWidth : _frameWidth;
    final double currentHeight = _isExpanded ? _expandedHeight : _frameHeight;

    return Positioned(
      left: _left,
      bottom: _bottom,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _left = (_left ?? 0) + details.delta.dx;
            _bottom = (_bottom ?? 0) - details.delta.dy;

            final size = MediaQuery.of(context).size;
            if (_left! < 16) _left = 16;
            if (_bottom! < 16) _bottom = 16;
            if (_left! + currentWidth > size.width - 16) {
              _left = size.width - currentWidth - 16;
            }
            if (_bottom! + currentHeight > size.height - 16) {
              _bottom = size.height - currentHeight - 16;
            }
          });
        },
        onPanEnd: (_) {
          final screenWidth = MediaQuery.of(context).size.width;
          setState(() {
            if ((_left ?? 0) + (currentWidth / 2) < screenWidth / 2) {
              _left = 16.0;
            } else {
              _left = screenWidth - currentWidth - 16.0;
            }
          });
        },
        onTap: _toggleExpand,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: currentWidth,
          height: currentHeight,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Video player
              if (_chewieController != null &&
                  _videoController != null &&
                  _videoController!.value.isInitialized)
                ClipRRect(
                  key: ValueKey(_currentIndex),
                  borderRadius: BorderRadius.circular(8),
                  child: Chewie(controller: _chewieController!),
                )
              else
                const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white24,
                  ),
                ),

              // Mute button
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  icon: Icon(
                    _isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: _toggleMute,
                  padding: EdgeInsets.zero,
                  tooltip: _isMuted ? 'Unmute' : 'Mute',
                ),
              ),

              // Close button
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: _closeVideo,
                  padding: EdgeInsets.zero,
                  tooltip: 'Close',
                ),
              ),

              // Story-style progress bars
              Positioned(
                bottom: 1,
                left: 2,
                right: 2,
                child: Row(
                  children: List.generate(_playlist.length, (index) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: index < _currentIndex
                              ? 1.0
                              : (index == _currentIndex
                                  ? _currentProgress
                                  : 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.accentColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── FloatingPromoVideoOverlay ─────────────────────────────────────────────────

/// The easiest way to add a floating promo video to any screen.
///
/// Wraps [child] in a [Stack] and places [FloatingPromotionVideo] on top
/// automatically — no manual Stack or Positioned needed.
///
/// **With Instagram backend:**
/// ```dart
/// FloatingPromoVideoOverlay(
///   tokenApiUrl: 'https://yourbackend.com/api/instagram-token',
///   child: Scaffold(body: YourContent()),
/// )
/// ```
///
/// **With direct video URLs (no backend):**
/// ```dart
/// FloatingPromoVideoOverlay.fromUrls(
///   urls: ['https://example.com/promo.mp4'],
///   child: Scaffold(body: YourContent()),
/// )
/// ```
class FloatingPromoVideoOverlay extends StatelessWidget {
  final Widget child;
  final String tokenApiUrl;
  final List<String> fallbackUrls;
  final Color accentColor;
  final double initialLeft;
  final double initialBottom;

  const FloatingPromoVideoOverlay({
    Key? key,
    required this.child,
    required this.tokenApiUrl,
    this.fallbackUrls = const [
      'https://ik.imagekit.io/projectss/Follow%20for%20more_.mp4',
      'https://ik.imagekit.io/projectss/Featuring%20Soon__interior%20_interiordesign%20_reel%20_design.mp4',
    ],
    this.accentColor = const Color(0xFFF60000),
    this.initialLeft = 16.0,
    this.initialBottom = 16.0,
  }) : super(key: key);

  /// Creates an overlay that plays [urls] directly — no backend needed.
  factory FloatingPromoVideoOverlay.fromUrls({
    Key? key,
    required Widget child,
    required List<String> urls,
    Color accentColor = const Color(0xFFF60000),
    double initialLeft = 16.0,
    double initialBottom = 16.0,
  }) {
    return FloatingPromoVideoOverlay(
      key: key,
      child: child,
      tokenApiUrl: '',
      fallbackUrls: urls,
      accentColor: accentColor,
      initialLeft: initialLeft,
      initialBottom: initialBottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        FloatingPromotionVideo(
          tokenApiUrl: tokenApiUrl,
          fallbackUrls: fallbackUrls,
          accentColor: accentColor,
          initialLeft: initialLeft,
          initialBottom: initialBottom,
        ),
      ],
    );
  }
}
