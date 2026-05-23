import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Enhanced button with modern animations and styles
class EnhancedAppButton extends StatefulWidget {
  const EnhancedAppButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
    this.size = ButtonSize.medium,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.enableGradient = false,
    this.gradient,
    this.shadowColor,
    this.onLongPress,
  });

  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final ButtonSize size;
  final ButtonVariant variant;
  final bool isLoading;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool enableGradient;
  final Gradient? gradient;
  final Color? shadowColor;
  final VoidCallback? onLongPress;

  @override
  State<EnhancedAppButton> createState() => _EnhancedAppButtonState();
}

enum ButtonSize { small, medium, large }

enum ButtonVariant { primary, secondary, outlined, danger }

class _EnhancedAppButtonState extends State<EnhancedAppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    if (!widget.isLoading) {
      widget.onPressed();
    }
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  double _getWidth() {
    if (widget.width != null) return widget.width!;
    switch (widget.size) {
      case ButtonSize.small:
        return 80;
      case ButtonSize.medium:
        return 120;
      case ButtonSize.large:
        return double.infinity;
    }
  }

  double _getHeight() {
    if (widget.height != null) return widget.height!;
    switch (widget.size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 44;
      case ButtonSize.large:
        return 52;
    }
  }

  Color _getBackgroundColor() {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return AppColors.blue;
      case ButtonVariant.secondary:
        return AppColors.grey;
      case ButtonVariant.outlined:
        return Colors.transparent;
      case ButtonVariant.danger:
        return Colors.red;
    }
  }

  Color _getTextColor() {
    switch (widget.variant) {
      case ButtonVariant.primary:
      case ButtonVariant.danger:
        return AppColors.white;
      case ButtonVariant.secondary:
        return AppColors.black;
      case ButtonVariant.outlined:
        return AppColors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getBackgroundColor();
    final textColor = _getTextColor();

    return ScaleTransition(
      scale: _scaleAnimation,
      child: SizedBox(
        width: _getWidth(),
        height: _getHeight(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onLongPress: widget.onLongPress,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.enableGradient
                    ? widget.gradient
                    : null,
                color: widget.enableGradient ? null : backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: widget.variant == ButtonVariant.outlined
                    ? Border.all(color: AppColors.blue, width: 2)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: (widget.shadowColor ?? backgroundColor)
                        .withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: widget.isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            textColor,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.icon != null) ...[\n                            Icon(
                              widget.icon,
                              color: textColor,
                            ),
                            const Gap.h(AppSpacing.sm),
                          ],
                          Text(
                            widget.text,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
