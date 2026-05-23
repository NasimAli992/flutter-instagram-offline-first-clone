import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Animated progress bar with linear gradient
class EnhancedProgressBar extends StatefulWidget {
  const EnhancedProgressBar({
    required this.progress,
    super.key,
    this.height = 6,
    this.backgroundColor,
    this.gradient,
    this.borderRadius = 3,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeInOutCubic,
    this.showLabel = false,
    this.label,
  });

  final double progress; // 0.0 to 1.0
  final double height;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double borderRadius;
  final Duration duration;
  final Curve curve;
  final bool showLabel;
  final String? label;

  @override
  State<EnhancedProgressBar> createState() => _EnhancedProgressBarState();
}

class _EnhancedProgressBarState extends State<EnhancedProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(EnhancedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(begin: oldWidget.progress, end: widget.progress)
          .animate(
        CurvedAnimation(parent: _controller, curve: widget.curve),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showLabel && widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              widget.label!,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: LinearProgressIndicator(
              value: _animation.value,
              minHeight: widget.height,
              backgroundColor: widget.backgroundColor ??
                  context.customAdaptiveColor(
                    light: AppColors.brightGrey,
                    dark: AppColors.emphasizeDarkGrey,
                  ),
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.gradient != null
                    ? Colors.blue
                    : AppColors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
