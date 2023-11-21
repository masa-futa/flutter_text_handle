import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter_text_handle/text_handle_custom_painter.dart';

class CustomTextSelectionControls extends TextSelectionControls {
  CustomTextSelectionControls({this.color = Colors.red});

  final Color color;

  @override
  Widget buildHandle(
      BuildContext context, TextSelectionHandleType type, double textLineHeight,
      [VoidCallback? onTap]) {
    Widget customPaint = CustomPaint(
      painter: TextHandleCustomPainter(color),
    );
    return SizedBox.fromSize(
      size: getHandleSize(textLineHeight),
      child: customPaint,
    );
  }

  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset selectionMidpoint,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ValueListenable<ClipboardStatus>? clipboardStatus,
      Offset? lastSecondaryTapDownPosition) {
    return Text('data');
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    final handleSize = getHandleSize(textLineHeight);
    return Offset(handleSize.width / 2, handleSize.height);
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return Size(
      _kSelectionHandleRadius * 2,
      textLineHeight + _kSelectionHandleRadius * 2 - _kSelectionHandleOverlap,
    );
  }
}

const double _kSelectionHandleOverlap = 1.5;
// Extracted from https://developer.apple.com/design/resources/.
const double _kSelectionHandleRadius = 6;