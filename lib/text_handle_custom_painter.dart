import 'package:flutter/cupertino.dart';

enum Radius {
  small(4),
  normal(6),
  medium(8),
  large(10);

  const Radius(this.radius);

  final double radius;

  double get offsetWithY => switch (this) {
        Radius.small => 8,
        Radius.normal => 6,
        Radius.medium => 4,
        Radius.large => 2,
      };
}

CustomPainter textHandleCustomPainter({
  required Color color,
  required Radius radius,
}) =>
    _TextHandleCustomPainter(color: color, radius: radius);

class _TextHandleCustomPainter extends CustomPainter {
  const _TextHandleCustomPainter({
    required this.color,
    required this.radius,
  });

  final Color color;
  final Radius radius;

  @override
  void paint(Canvas canvas, Size size) {
    const double halfStrokeWidth = 1.0;
    final Paint paint = Paint()..color = color;
    final Rect circle = Rect.fromCircle(
      center: Offset(6, radius.offsetWithY),
      radius: radius.radius,
    );
    final Rect line = Rect.fromPoints(
      const Offset(
        6 - 1,
        2 * 6 - 1.5,
      ),
      Offset(6 + halfStrokeWidth, size.height),
    );
    final Path path = Path()
      ..addOval(circle)
      ..addRect(line);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TextHandleCustomPainter oldDelegate) =>
      color != oldDelegate.color;
}
