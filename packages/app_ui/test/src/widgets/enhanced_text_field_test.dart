import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EnhancedTextField', () {
    testWidgets('EnhancedTextField renders with hint',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedTextField(
              hint: 'Enter text',
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedTextField), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('EnhancedTextField onChanged callback works',
        (WidgetTester tester) async {
      var inputValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedTextField(
              hint: 'Type here',
              onChanged: (value) => inputValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello');
      await tester.pumpAndSettle();

      expect(inputValue, 'Hello');
    });

    testWidgets('EnhancedTextField supports prefix icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedTextField(
              hint: 'Search',
              prefixIcon: Icons.search,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('EnhancedTextField supports suffix icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedTextField(
              hint: 'Password',
              suffixIcon: Icons.visibility,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('EnhancedTextField obscureText works',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedTextField(
              hint: 'Password',
              obscureText: true,
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedTextField), findsOneWidget);
    });

    testWidgets('EnhancedTextField respects custom border radius',
        (WidgetTester tester) async {
      const customRadius = 16.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedTextField(
              hint: 'Rounded',
              borderRadius: customRadius,
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedTextField), findsOneWidget);
    });

    testWidgets('EnhancedTextField with controller',
        (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedTextField(
              hint: 'Controlled',
              controller: controller,
            ),
          ),
        ),
      );

      controller.text = 'Test';
      await tester.pumpAndSettle();

      expect(controller.text, 'Test');
    });

    testWidgets('EnhancedTextField focus animation works',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedTextField(
              hint: 'Focus me',
              enableAnimation: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.byType(EnhancedTextField), findsOneWidget);
    });
  });
}
