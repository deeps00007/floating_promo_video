import 'package:flutter/material.dart';

/// Renders the mute and close buttons over the video player.
class VideoPlayerControlsContainer extends StatelessWidget {
  final bool isMuted;
  final VoidCallback onToggleMute;
  final VoidCallback onClose;
  final bool isExpanded;

  const VideoPlayerControlsContainer({
    Key? key,
    required this.isMuted,
    required this.onToggleMute,
    required this.onClose,
    required this.isExpanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        // Mute button
        Positioned(
          top: isExpanded ? topInset : 0,
          left: 0,
          child: IconButton(
            icon: Icon(
              isMuted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
              size: 24,
            ),
            onPressed: onToggleMute,
            padding: EdgeInsets.zero,
            tooltip: isMuted ? 'Unmute' : 'Mute',
          ),
        ),

        // Close button
        Positioned(
          top: isExpanded ? topInset : 0,
          right: 0,
          child: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 24,
            ),
            onPressed: onClose,
            padding: EdgeInsets.zero,
            tooltip: 'Close',
          ),
        ),
      ],
    );
  }
}
