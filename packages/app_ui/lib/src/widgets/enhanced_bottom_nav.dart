import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Enhanced bottom navigation bar with modern animations
class EnhancedBottomNavBar extends StatefulWidget {
  const EnhancedBottomNavBar({
    required this.items,
    required this.onItemSelected,
    super.key,
    this.currentIndex = 0,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.borderRadius = 24,
    this.elevation = 8,
  });

  final List<EnhancedNavItem> items;
  final ValueChanged<int> onItemSelected;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double borderRadius;
  final double elevation;

  @override
  State<EnhancedBottomNavBar> createState() => _EnhancedBottomNavBarState();
}

class EnhancedNavItem {
  EnhancedNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  final IconData icon;
  final String label;
  final IconData? activeIcon;
}

class _EnhancedBottomNavBarState extends State<EnhancedBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final selectedColor = widget.selectedColor ?? AppColors.blue;
    final unselectedColor = widget.unselectedColor ?? AppColors.grey;
    final backgroundColor = widget.backgroundColor ??
        context.customAdaptiveColor(
          light: AppColors.white,
          dark: AppColors.black,
        );

    return Material(
      elevation: widget.elevation,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(widget.borderRadius),
        topRight: Radius.circular(widget.borderRadius),
      ),
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.items.length,
            (index) => _NavBarItem(
              item: widget.items[index],
              isSelected: widget.currentIndex == index,
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
              onTap: () => widget.onItemSelected(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  final EnhancedNavItem item;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  @override
  State<_NavBarItem> createState() => __NavBarItemState();
}

class __NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(_NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.15).animate(
          CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.isSelected
                  ? (widget.item.activeIcon ?? widget.item.icon)
                  : widget.item.icon,
              color: widget.isSelected
                  ? widget.selectedColor
                  : widget.unselectedColor,
              size: 28,
            ),
            const Gap.v(AppSpacing.xs),
            Text(
              widget.item.label,
              style: TextStyle(
                color: widget.isSelected
                    ? widget.selectedColor
                    : widget.unselectedColor,
                fontSize: 12,
                fontWeight: widget.isSelected
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
