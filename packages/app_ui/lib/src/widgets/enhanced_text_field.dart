import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Enhanced text field with modern design
class EnhancedTextField extends StatefulWidget {
  const EnhancedTextField({
    required this.hint,
    super.key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.borderRadius = 12,
    this.enableAnimation = true,
    this.focusColor,
    this.fillColor,
    this.errorText,
  });

  final String hint;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final double borderRadius;
  final bool enableAnimation;
  final Color? focusColor;
  final Color? fillColor;
  final String? errorText;

  @override
  State<EnhancedTextField> createState() => _EnhancedTextFieldState();
}

class _EnhancedTextFieldState extends State<EnhancedTextField>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = widget.fillColor ??
        context.customAdaptiveColor(
          light: AppColors.brightGrey.withOpacity(0.3),
          dark: AppColors.emphasizeDarkGrey.withOpacity(0.5),
        );

    final focusColor = widget.focusColor ?? AppColors.blue;

    return ScaleTransition(
      scale: widget.enableAnimation ? _scaleAnimation : const AlwaysStoppedAnimation(1.0),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hint,
          filled: true,
          fillColor: fillColor,
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: focusColor)
              : null,
          suffixIcon: widget.suffixIcon != null
              ? Icon(widget.suffixIcon, color: focusColor)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: focusColor,
              width: 2,
            ),
          ),
          errorText: widget.errorText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
        ),
      ),
    );
  }
}
