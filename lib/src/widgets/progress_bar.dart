import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress.clamp(0.0, 1.0),
    );
  }
}
