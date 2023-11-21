library flutter_text_handle;

import 'package:flutter/material.dart';
import 'package:flutter_text_handle/custom_text_selection_controls.dart';

class TextHandle extends SelectionArea {
  const TextHandle._({
    required super.child,
    super.selectionControls,
  });

  factory TextHandle({
    required Widget child,
    Color color = Colors.red,
  }) =>
      TextHandle._(
        selectionControls: CustomTextSelectionControls(color: color),
        child: child,
      );
}
