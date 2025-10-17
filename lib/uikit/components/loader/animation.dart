import 'dart:math';
import 'package:flutter/material.dart';

class AppLoader extends StatefulWidget {
  final double size;
  final double maxRadius;
  final double minRadius;
  final Color color;
  final Duration duration;
  final int circleCount;

  const AppLoader({
    super.key,
    this.size = 80,
    this.maxRadius = 10,
    this.minRadius = 5,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 1200),
    this.circleCount = 8,
  });

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          painter: _CircleOrbitPainter(
            progress: _controller.value,
            color: widget.color,
            count: widget.circleCount,
            maxRadius: widget.maxRadius,
            minRadius: widget.minRadius,
          ),
        ),
      ),
    );
  }
}

class _CircleOrbitPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int count;
  final double maxRadius;
  final double minRadius;

  _CircleOrbitPainter({
    required this.progress,
    required this.color,
    required this.count,
    required this.maxRadius,
    required this.minRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.4;
    final paint = Paint()..color = color;

    final double step = (maxRadius - minRadius) / (count - 1);

    for (int i = 0; i < count; i++) {
      final angle = 2 * pi * (i / count) + (progress * 2 * pi);
      final dx = center.dx + radius * cos(angle);
      final dy = center.dy + radius * sin(angle);

      final circleRadius = maxRadius - (step * (count - 1 - i));

      canvas.drawCircle(Offset(dx, dy), circleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CircleOrbitPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
