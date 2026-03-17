import 'package:flutter/widgets.dart';

class FloatingVideoWidget extends StatefulWidget {
  final String videoUrl;

  const FloatingVideoWidget({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  State<FloatingVideoWidget> createState() => _FloatingVideoWidgetState();
}

class _FloatingVideoWidgetState extends State<FloatingVideoWidget> {
  Offset _position = Offset.zero;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() => _position += details.delta);
      },
      onTap: () => setState(() => _expanded = !_expanded),
      child: SizedBox(
        width: _expanded ? 300 : 150,
        height: _expanded ? 200 : 100,
        child: ColoredBox(
          color: const Color(0xFF000000),
        ),
      ),
    );
  }
}
