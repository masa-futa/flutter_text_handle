import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_handle/text_handle_custom_painter.dart';

const double _kHandleSize = 22.0;
const double _kSelectionHandleOverlap = 1.5;
// Extracted from https://developer.apple.com/design/resources/.
const double _kSelectionHandleRadius = 6;

class CupertinoHandleControls extends CupertinoTextSelectionControls {
  CupertinoHandleControls({
    required this.color,
    required this.radius,
  });

  final Color? color;
  final Radius radius;

  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    Widget customPaint = CustomPaint(
      painter: textHandleCustomPainter(
        color: color ?? CupertinoTheme.of(context).primaryColor,
        radius: radius,
      ),
    );
    switch (type) {
      case TextSelectionHandleType.left:
        final desiredSize = getHandleSize(textLineHeight);
        return SizedBox.fromSize(
          size: desiredSize,
          child: customPaint,
        );
      case TextSelectionHandleType.right:
        final desiredSize = getHandleSize(textLineHeight);
        final handle = SizedBox.fromSize(
          size: desiredSize,
          child: customPaint,
        );
        return Transform(
          transform: Matrix4.identity()
            ..translate(desiredSize.width / 2, desiredSize.height / 2)
            ..rotateZ(math.pi)
            ..translate(-desiredSize.width / 2, -desiredSize.height / 2),
          child: handle,
        );
      case TextSelectionHandleType.collapsed:
        return const SizedBox.shrink();
    }
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return Size(
      _kSelectionHandleRadius * 2,
      textLineHeight + _kSelectionHandleRadius * 2 - _kSelectionHandleOverlap,
    );
  }
}

class MaterialHandleControls extends MaterialTextSelectionControls {
  MaterialHandleControls({
    this.color,
    required this.radius,
  });

  final Color? color;
  final Radius radius;

  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textHeight, [
    VoidCallback? onTap,
  ]) {
    final ThemeData theme = Theme.of(context);

    final Widget handle = SizedBox(
      width: _kHandleSize,
      height: _kHandleSize,
      child: CustomPaint(
        painter: textHandleCustomPainter(
          color: color ??
              TextSelectionTheme.of(context).selectionHandleColor ??
              theme.colorScheme.primary,
          radius: radius,
        ),
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
        ),
      ),
    );

    switch (type) {
      case TextSelectionHandleType.left:
        return Transform.rotate(
          angle: math.pi / 2.0,
          child: handle,
        );
      case TextSelectionHandleType.right:
        return handle;
      case TextSelectionHandleType.collapsed:
        return Transform.rotate(
          angle: math.pi / 4.0,
          child: handle,
        );
    }
  }
}
