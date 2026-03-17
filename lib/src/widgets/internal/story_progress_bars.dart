import 'package:flutter/material.dart';

/// Renders story-style progress bars with ticks at the bottom of the video.
class StoryProgressBars extends StatelessWidget {
  final int totalCount;
  final int currentIndex;
  final double currentProgress;
  final Color accentColor;

  const StoryProgressBars({
    Key? key,
    required this.totalCount,
    required this.currentIndex,
    required this.currentProgress,
    required this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) return const SizedBox.shrink();

    return Row(
      children: List.generate(totalCount, (index) {
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
              widthFactor: index < currentIndex
                  ? 1.0
                  : (index == currentIndex ? currentProgress : 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
