library flutter_text_handle;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_handle/custom_text_selection_controls.dart';
import 'package:flutter_text_handle/text_handle_custom_painter.dart';

class TextHandle extends SelectionArea {
  const TextHandle._({
    required super.child,
    super.selectionControls,
  });

  factory TextHandle({
    required Widget child,
    Color? color,
  }) =>
      TextHandle._(
        selectionControls: _controls(color: color, radius: Radius.normal),
        child: child,
      );

  factory TextHandle.small({
    required Widget child,
    Color? color,
  }) =>
      TextHandle._(
        selectionControls: _controls(color: color, radius: Radius.small),
        child: child,
      );

  factory TextHandle.medium({
    required Widget child,
    Color? color,
  }) =>
      TextHandle._(
        selectionControls: _controls(color: color, radius: Radius.medium),
        child: child,
      );

  factory TextHandle.large({
    required Widget child,
    Color? color,
  }) =>
      TextHandle._(
        selectionControls: _controls(color: color, radius: Radius.large),
        child: child,
      );

  static TextSelectionControls _controls({
    Color? color,
    required Radius radius,
  }) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return MaterialHandleControls(color: color, radius: radius);
    }
    if (Platform.isIOS) {
      return CupertinoHandleControls(color: color, radius: radius);
    }
    if (Platform.isLinux || Platform.isWindows) {
      return desktopTextSelectionHandleControls;
    }
    if (Platform.isMacOS) {
      return cupertinoDesktopTextSelectionHandleControls;
    }
    throw UnimplementedError();
  }
}
