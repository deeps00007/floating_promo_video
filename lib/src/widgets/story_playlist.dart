import 'package:flutter/widgets.dart';

class StoryPlaylist extends StatefulWidget {
  final List playlist;

  const StoryPlaylist({Key? key, required this.playlist}) : super(key: key);

  @override
  State<StoryPlaylist> createState() => _StoryPlaylistState();
}

class _StoryPlaylistState extends State<StoryPlaylist> {
  int _currentIndex = 0;

  void _playNext() {
    if (_currentIndex < widget.playlist.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.playlist.isEmpty) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: _playNext,
      child: const SizedBox.expand(),
    );
  }
}
