import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:essence/core/theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: AppTheme.glassBorder,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
