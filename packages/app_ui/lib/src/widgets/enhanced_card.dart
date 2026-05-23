import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Enhanced card widget with modern design patterns
class EnhancedCard extends StatefulWidget {
  const EnhancedCard({
    required this.child,
    super.key,
    this.onTap,
    this.elevation = 0,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.enableShadow = true,
    this.enableHover = true,
    this.hoverElevation = 8,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final bool enableShadow;
  final bool enableHover;
  final double hoverElevation;

  @override
  State<EnhancedCard> createState() => _EnhancedCardState();
}

class _EnhancedCardState extends State<EnhancedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _elevationAnimation = Tween<double>(
      begin: widget.elevation,
      end: widget.hoverElevation,
    ).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onEnter(PointerEnterEvent event) {
    if (widget.enableHover) {
      _hoverController.forward();
    }
  }

  void _onExit(PointerExitEvent event) {
    if (widget.enableHover) {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor ??
        context.customAdaptiveColor(
          light: AppColors.white,
          dark: AppColors.black,
        );

    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedBuilder(
        animation: _elevationAnimation,
        builder: (context, child) => Material(
          elevation: _elevationAnimation.value,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          shadowColor: context.customAdaptiveColor(
            light: Colors.black.withOpacity(0.1),
            dark: Colors.white.withOpacity(0.1),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: widget.borderWidth > 0
                  ? Border.all(
                      color: widget.borderColor ?? AppColors.brightGrey,
                      width: widget.borderWidth,
                    )
                  : null,
            ),
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Padding(
                padding: widget.padding,
                child: child,
              ),
            ),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
