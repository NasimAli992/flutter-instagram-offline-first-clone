import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Demo screen showcasing all enhanced UI components
class EnhancedWidgetsDemoScreen extends StatefulWidget {
  /// Constructor
  const EnhancedWidgetsDemoScreen({super.key});

  @override
  State<EnhancedWidgetsDemoScreen> createState() =>
      _EnhancedWidgetsDemoScreenState();
}

class _EnhancedWidgetsDemoScreenState extends State<EnhancedWidgetsDemoScreen> {
  int _selectedNavIndex = 0;
  double _progressValue = 0.0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final items = [
      EnhancedNavItem(icon: Icons.home, label: 'Home'),
      EnhancedNavItem(icon: Icons.favorite, label: 'Likes'),
      EnhancedNavItem(icon: Icons.add_box, label: 'Add'),
      EnhancedNavItem(icon: Icons.person, label: 'Profile'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Widgets Demo'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhanced Card Demo
            Text(
              '🎴 Enhanced Card',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap.v(AppSpacing.md),
            EnhancedCard(
              borderWidth: 1,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Card tapped!')),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enhanced Card Widget',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Gap.v(AppSpacing.sm),
                  const Text(
                    'This card has hover effects and smooth animations. Tap to see the action!',
                  ),
                ],
              ),
            ),
            const Gap.v(AppSpacing.xl),

            // Enhanced Progress Bar Demo
            Text(
              '📊 Enhanced Progress Bar',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap.v(AppSpacing.md),
            EnhancedProgressBar(
              progress: _progressValue,
              showLabel: true,
              label: '${(_progressValue * 100).toStringAsFixed(0)}%',
            ),
            const Gap.v(AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => _progressValue = 0.25);
                  },
                  child: const Text('25%'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _progressValue = 0.5);
                  },
                  child: const Text('50%'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _progressValue = 0.75);
                  },
                  child: const Text('75%'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _progressValue = 1.0);
                  },
                  child: const Text('100%'),
                ),
              ],
            ),
            const Gap.v(AppSpacing.xl),

            // Enhanced Text Field Demo
            Text(
              '📝 Enhanced Text Field',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap.v(AppSpacing.md),
            EnhancedTextField(
              hint: 'Search something...',
              prefixIcon: Icons.search,
            ),
            const Gap.v(AppSpacing.md),
            EnhancedTextField(
              hint: 'Enter password',
              obscureText: true,
              prefixIcon: Icons.lock,
              suffixIcon: Icons.visibility,
            ),
            const Gap.v(AppSpacing.xl),

            // Enhanced Button Demo
            Text(
              '🔘 Enhanced Button',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap.v(AppSpacing.md),
            EnhancedAppButton(
              text: _isLoading ? 'Loading...' : 'Primary Button',
              isLoading: _isLoading,
              onPressed: () {
                setState(() => _isLoading = true);
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    setState(() => _isLoading = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Button pressed!')),
                    );
                  }
                });
              },
              variant: ButtonVariant.primary,
              size: ButtonSize.large,
            ),
            const Gap.v(AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: EnhancedAppButton(
                    text: 'Secondary',
                    onPressed: () {},
                    variant: ButtonVariant.secondary,
                  ),
                ),
                const Gap.h(AppSpacing.md),
                Expanded(
                  child: EnhancedAppButton(
                    text: 'Outlined',
                    onPressed: () {},
                    variant: ButtonVariant.outlined,
                  ),
                ),
              ],
            ),
            const Gap.v(AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: EnhancedAppButton(
                text: 'Delete',
                onPressed: () {},
                variant: ButtonVariant.danger,
              ),
            ),
            const Gap.v(AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: EnhancedAppButton(
                text: 'Save Document',
                icon: Icons.save,
                onPressed: () {},
                variant: ButtonVariant.primary,
              ),
            ),
            const Gap.v(AppSpacing.xl),

            // Spacing for bottom nav
            const Gap.v(AppSpacing.xl),
          ],
        ),
      ),
      bottomNavigationBar: EnhancedBottomNavBar(
        items: items,
        currentIndex: _selectedNavIndex,
        onItemSelected: (index) {
          setState(() => _selectedNavIndex = index);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${items[index].label}')),
          );
        },
      ),
    );
  }
}
