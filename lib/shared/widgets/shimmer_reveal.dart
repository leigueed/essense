import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerReveal extends StatefulWidget {
  final Widget child;
  const ShimmerReveal({super.key, required this.child});

  @override
  State<ShimmerReveal> createState() => _ShimmerRevealState();
}

class _ShimmerRevealState extends State<ShimmerReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _fadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _fadeAnimation,
          builder: (context, child) {
            if (_fadeAnimation.value <= 0) return const SizedBox.shrink();
            return IgnorePointer(
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Shimmer.fromColors(
                  baseColor: Colors.white.withValues(alpha: 0.1),
                  highlightColor: Colors.white.withValues(alpha: 0.3),
                  child: Container(color: Colors.white.withValues(alpha: 0.05)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
