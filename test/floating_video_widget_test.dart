import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floating_promo_video/src/widgets/floating_video_widget.dart';

void main() {
  testWidgets('FloatingVideoWidget should display video',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        FloatingVideoWidget(videoUrl: 'https://example.com/video.mp4'));

    expect(find.byType(FloatingVideoWidget), findsOneWidget);
    // Additional checks for video playback can be added here
  });

  testWidgets('FloatingVideoWidget should be draggable',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        FloatingVideoWidget(videoUrl: 'https://example.com/video.mp4'));

    // Simulate dragging behavior
    await tester.drag(find.byType(FloatingVideoWidget), Offset(100, 0));
    await tester.pumpAndSettle();

    // Check if the widget's position has changed (you may need to implement a way to check this)
  });

  testWidgets('FloatingVideoWidget should expand and collapse',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        FloatingVideoWidget(videoUrl: 'https://example.com/video.mp4'));

    // Simulate tap to expand
    await tester.tap(find.byType(FloatingVideoWidget));
    await tester.pumpAndSettle();

    // Check if the widget is in expanded state (you may need to implement a way to check this)
  });
}
