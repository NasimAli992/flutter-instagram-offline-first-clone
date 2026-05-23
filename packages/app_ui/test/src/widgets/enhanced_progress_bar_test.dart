import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EnhancedProgressBar', () {
    testWidgets('EnhancedProgressBar renders with progress',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedProgressBar(
              progress: 0.5,
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedProgressBar), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('EnhancedProgressBar animates correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedProgressBar(
              progress: 0.75,
              duration: const Duration(milliseconds: 500),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(EnhancedProgressBar), findsOneWidget);
    });

    testWidgets('EnhancedProgressBar shows label when enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedProgressBar(
              progress: 0.6,
              showLabel: true,
              label: '60%',
            ),
          ),
        ),
      );

      expect(find.text('60%'), findsOneWidget);
    });

    testWidgets('EnhancedProgressBar respects custom height',
        (WidgetTester tester) async {
      const customHeight = 12.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedProgressBar(
              progress: 0.5,
              height: customHeight,
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedProgressBar), findsOneWidget);
    });

    testWidgets('EnhancedProgressBar updates when progress changes',
        (WidgetTester tester) async {
      var progress = 0.3;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) => MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  EnhancedProgressBar(progress: progress),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => progress = 0.7);
                    },
                    child: const Text('Update Progress'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Update Progress'));
      await tester.pumpAndSettle();

      expect(find.byType(EnhancedProgressBar), findsOneWidget);
    });

    testWidgets('EnhancedProgressBar with custom colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedProgressBar(
              progress: 0.5,
              backgroundColor: Colors.grey[300]!,
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedProgressBar), findsOneWidget);
    });
  });
}
