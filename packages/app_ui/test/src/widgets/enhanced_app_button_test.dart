import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EnhancedAppButton', () {
    testWidgets('EnhancedAppButton renders with text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAppButton(
              text: 'Click Me',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedAppButton), findsOneWidget);
      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('EnhancedAppButton onPressed callback works',
        (WidgetTester tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAppButton(
              text: 'Press',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Press'));
      await tester.pumpAndSettle();

      expect(pressed, true);
    });

    testWidgets('EnhancedAppButton primary variant',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAppButton(
              text: 'Primary',
              variant: ButtonVariant.primary,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedAppButton), findsOneWidget);
    });

    testWidgets('EnhancedAppButton secondary variant',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAppButton(
              text: 'Secondary',
              variant: ButtonVariant.secondary,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedAppButton), findsOneWidget);
    });

    testWidgets('EnhancedAppButton outlined variant',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAppButton(
              text: 'Outlined',
              variant: ButtonVariant.outlined,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedAppButton), findsOneWidget);
    });

    testWidgets('EnhancedAppButton danger variant',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAppButton(
              text: 'Delete',
              variant: ButtonVariant.danger,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedAppButton), findsOneWidget);
    });

    testWidgets('EnhancedAppButton shows loading state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAppButton(
              text: 'Loading',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('EnhancedAppButton with icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAppButton(
              text: 'Save',
              icon: Icons.save,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.save), findsOneWidget);
    });

    testWidgets('EnhancedAppButton different sizes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                EnhancedAppButton(
                  text: 'Small',
                  size: ButtonSize.small,
                  onPressed: () {},
                ),
                EnhancedAppButton(
                  text: 'Medium',
                  size: ButtonSize.medium,
                  onPressed: () {},
                ),
                EnhancedAppButton(
                  text: 'Large',
                  size: ButtonSize.large,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedAppButton), findsNWidgets(3));
    });
  });
}
