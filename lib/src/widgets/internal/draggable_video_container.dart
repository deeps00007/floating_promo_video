import 'package:flutter/material.dart';

/// Handles the draggability, snapping to edge, and animated expanding
/// of the floating promo video widget.
class DraggableVideoContainer extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final bool isExpanded;
  final double initialLeft;
  final double initialBottom;
  final VoidCallback onToggleExpand;

  const DraggableVideoContainer({
    Key? key,
    required this.child,
    required this.isVisible,
    required this.isExpanded,
    required this.initialLeft,
    required this.initialBottom,
    required this.onToggleExpand,
  }) : super(key: key);

  @override
  State<DraggableVideoContainer> createState() =>
      _DraggableVideoContainerState();
}

class _DraggableVideoContainerState extends State<DraggableVideoContainer> {
  bool _isDragging = false;
  double? _left;
  double? _bottom;
  double? _savedLeft;
  double? _savedBottom;

  final double _frameWidth = 120.0;
  final double _frameHeight = 200.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _left = widget.initialLeft;
          _bottom = widget.initialBottom;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant DraggableVideoContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      if (widget.isExpanded) {
        _savedLeft = _left;
        _savedBottom = _bottom;
        _left = 0;
        _bottom = 0;
      } else {
        _left = _savedLeft ?? widget.initialLeft;
        _bottom = _savedBottom ?? widget.initialBottom;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_left == null || _bottom == null) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableSize = constraints.biggest;
        final double currentWidth =
            widget.isExpanded ? availableSize.width : _frameWidth;
        final double currentHeight =
            widget.isExpanded ? availableSize.height : _frameHeight;

        return Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: _isDragging ? 0 : 600),
              curve: Curves.easeInOutCubic,
              left: _left,
              bottom: _bottom,
              width: currentWidth,
              height: currentHeight,
              child: AnimatedScale(
                scale: widget.isVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutBack,
                child: AnimatedOpacity(
                  opacity: widget.isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: GestureDetector(
                    onPanStart: (details) {
                      if (widget.isExpanded) return;
                      setState(() => _isDragging = true);
                    },
                    onPanUpdate: (details) {
                      if (widget.isExpanded) return;
                      setState(() {
                        _left = (_left ?? 0) + details.delta.dx;
                        _bottom = (_bottom ?? 0) - details.delta.dy;

                        if (_left! < 16) _left = 16;
                        if (_bottom! < 16) _bottom = 16;
                        if (_left! + currentWidth > availableSize.width - 16) {
                          _left = availableSize.width - currentWidth - 16;
                        }
                        if (_bottom! + currentHeight >
                            availableSize.height - 16) {
                          _bottom = availableSize.height - currentHeight - 16;
                        }
                      });
                    },
                    onPanEnd: (_) {
                      if (widget.isExpanded) return;
                      setState(() {
                        _isDragging = false;
                        if ((_left ?? 0) + (currentWidth / 2) <
                            availableSize.width / 2) {
                          _left = 16.0;
                        } else {
                          _left = availableSize.width - currentWidth - 16.0;
                        }
                      });
                    },
                    onTap: widget.onToggleExpand,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.circular(widget.isExpanded ? 0 : 20),
                        boxShadow: widget.isExpanded
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                      ),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
