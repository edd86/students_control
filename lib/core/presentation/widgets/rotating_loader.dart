import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatingLoader extends StatefulWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final Duration duration;

  const RotatingLoader({
    super.key,
    this.icon = Icons.refresh,
    this.size = 24.0,
    this.color,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<RotatingLoader> createState() => _RotatingLoaderState();
}

class _RotatingLoaderState extends State<RotatingLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Icon(
        widget.icon,
        size: widget.size,
        color: widget.color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
