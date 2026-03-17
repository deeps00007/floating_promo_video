import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floating_promo_video/src/widgets/expandable_video_card.dart';

void main() {
  testWidgets('ExpandableVideoCard expands and collapses',
      (WidgetTester tester) async {
    // Build the ExpandableVideoCard widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExpandableVideoCard(
            videoUrl: 'https://example.com/video.mp4',
            title: 'Test Video',
          ),
        ),
      ),
    );

    // Verify that the card is initially collapsed
    expect(find.text('Test Video'), findsOneWidget);
    expect(find.byType(Expanded), findsNothing);

    // Tap to expand the card
    await tester.tap(find.byType(ExpandableVideoCard));
    await tester.pumpAndSettle();

    // Verify that the card is expanded
    expect(find.byType(Expanded), findsOneWidget);

    // Tap to collapse the card
    await tester.tap(find.byType(ExpandableVideoCard));
    await tester.pumpAndSettle();

    // Verify that the card is collapsed again
    expect(find.byType(Expanded), findsNothing);
  });
}
