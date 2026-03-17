import 'package:flutter/material.dart';

class ExpandableVideoCard extends StatefulWidget {
  final String videoUrl;
  final String title;

  const ExpandableVideoCard({
    Key? key,
    required this.videoUrl,
    required this.title,
  }) : super(key: key);

  @override
  State<ExpandableVideoCard> createState() => _ExpandableVideoCardState();
}

class _ExpandableVideoCardState extends State<ExpandableVideoCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          if (_expanded)
            Expanded(
              child: Container(
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}
