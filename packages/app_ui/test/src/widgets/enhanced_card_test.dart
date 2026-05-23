import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EnhancedCard', () {
    testWidgets('EnhancedCard renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedCard(
              child: const Text('Test Card'),
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedCard), findsOneWidget);
      expect(find.text('Test Card'), findsOneWidget);
    });

    testWidgets('EnhancedCard onTap callback works',
        (WidgetTester tester) async {
      var tapCount = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedCard(
              onTap: () => tapCount++,
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
    });

    testWidgets('EnhancedCard respects custom border radius',
        (WidgetTester tester) async {
      const customRadius = 20.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedCard(
              borderRadius: customRadius,
              child: const Text('Rounded Card'),
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedCard), findsOneWidget);
    });

    testWidgets('EnhancedCard respects custom padding',
        (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(24.0);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedCard(
              padding: customPadding,
              child: const Text('Padded Card'),
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedCard), findsOneWidget);
    });

    testWidgets('EnhancedCard hover effect works',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedCard(
              enableHover: true,
              child: const Text('Hoverable Card'),
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedCard), findsOneWidget);
    });

    testWidgets('EnhancedCard with border color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedCard(
              borderWidth: 2,
              borderColor: Colors.blue,
              child: const Text('Bordered Card'),
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedCard), findsOneWidget);
    });
  });
}
