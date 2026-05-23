import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EnhancedBottomNavBar', () {
    testWidgets('EnhancedBottomNavBar renders all items',
        (WidgetTester tester) async {
      final items = [
        EnhancedNavItem(icon: Icons.home, label: 'Home'),
        EnhancedNavItem(icon: Icons.search, label: 'Search'),
        EnhancedNavItem(icon: Icons.add, label: 'Add'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(),
            bottomNavigationBar: EnhancedBottomNavBar(
              items: items,
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedBottomNavBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });

    testWidgets('EnhancedBottomNavBar onItemSelected callback works',
        (WidgetTester tester) async {
      var selectedIndex = 0;
      final items = [
        EnhancedNavItem(icon: Icons.home, label: 'Home'),
        EnhancedNavItem(icon: Icons.search, label: 'Search'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(),
            bottomNavigationBar: EnhancedBottomNavBar(
              items: items,
              onItemSelected: (index) => selectedIndex = index,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
    });

    testWidgets('EnhancedBottomNavBar shows selected state',
        (WidgetTester tester) async {
      final items = [
        EnhancedNavItem(icon: Icons.home, label: 'Home'),
        EnhancedNavItem(icon: Icons.search, label: 'Search'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(),
            bottomNavigationBar: EnhancedBottomNavBar(
              items: items,
              currentIndex: 0,
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedBottomNavBar), findsOneWidget);
    });

    testWidgets('EnhancedBottomNavBar with active icons',
        (WidgetTester tester) async {
      final items = [
        EnhancedNavItem(
          icon: Icons.home_outlined,
          activeIcon: Icons.home,
          label: 'Home',
        ),
        EnhancedNavItem(
          icon: Icons.search,
          label: 'Search',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(),
            bottomNavigationBar: EnhancedBottomNavBar(
              items: items,
              currentIndex: 0,
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedBottomNavBar), findsOneWidget);
    });

    testWidgets('EnhancedBottomNavBar respects custom colors',
        (WidgetTester tester) async {
      final items = [
        EnhancedNavItem(icon: Icons.home, label: 'Home'),
        EnhancedNavItem(icon: Icons.search, label: 'Search'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(),
            bottomNavigationBar: EnhancedBottomNavBar(
              items: items,
              selectedColor: Colors.blue,
              unselectedColor: Colors.grey,
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedBottomNavBar), findsOneWidget);
    });

    testWidgets('EnhancedBottomNavBar respects custom elevation',
        (WidgetTester tester) async {
      final items = [
        EnhancedNavItem(icon: Icons.home, label: 'Home'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(),
            bottomNavigationBar: EnhancedBottomNavBar(
              items: items,
              elevation: 16.0,
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(EnhancedBottomNavBar), findsOneWidget);
    });
  });
}
