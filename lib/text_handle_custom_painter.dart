
import 'package:flutter/cupertino.dart';

class TextHandleCustomPainter extends CustomPainter {
  const TextHandleCustomPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const double halfStrokeWidth = 1.0;
    final Paint paint = Paint()..color = color;
    final Rect circle = Rect.fromCircle(
      center: const Offset(6, 6),
      radius: 6,
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
    // Draw line so it slightly overlaps the circle.
      ..addRect(line);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TextHandleCustomPainter oldDelegate) => color != oldDelegate.color;
}