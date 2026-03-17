import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floating_promo_video/src/widgets/progress_bar.dart';

void main() {
  group('ProgressBar', () {
    testWidgets('should display correct progress', (WidgetTester tester) async {
      // Arrange
      const double progress = 0.5; // 50% progress
      final progressBar = ProgressBar(progress: progress);

      // Act
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: progressBar)));

      // Assert
      final progressFinder = find.byType(LinearProgressIndicator);
      expect(progressFinder, findsOneWidget);
      expect((tester.widget<LinearProgressIndicator>(progressFinder).value),
          progress);
    });

    testWidgets('should display 0 progress when progress is negative',
        (WidgetTester tester) async {
      // Arrange
      const double progress = -0.1; // Invalid progress
      final progressBar = ProgressBar(progress: progress);

      // Act
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: progressBar)));

      // Assert
      final progressFinder = find.byType(LinearProgressIndicator);
      expect(progressFinder, findsOneWidget);
      expect(
          (tester.widget<LinearProgressIndicator>(progressFinder).value), 0.0);
    });

    testWidgets('should display 1 progress when progress is greater than 1',
        (WidgetTester tester) async {
      // Arrange
      const double progress = 1.5; // Invalid progress
      final progressBar = ProgressBar(progress: progress);

      // Act
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: progressBar)));

      // Assert
      final progressFinder = find.byType(LinearProgressIndicator);
      expect(progressFinder, findsOneWidget);
      expect(
          (tester.widget<LinearProgressIndicator>(progressFinder).value), 1.0);
    });
  });
}
