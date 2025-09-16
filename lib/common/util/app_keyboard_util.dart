import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppKeyboardUtil {
  static void hide(BuildContext context) {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static void show(BuildContext context, FocusNode node) {
    FocusScope.of(context).unfocus();
    Timer(const Duration(milliseconds: 1), () {
      FocusScope.of(context).requestFocus(node);
    });
  }
}

mixin KeyboardDetector<T extends StatefulWidget> on State<T> {
  bool isKeyboardOn = false;
  final bool useDefaultKeyboardDetectorInit = true;

  @override
  void initState() {
    if (useDefaultKeyboardDetectorInit) {
      initKeyboardDetector();
    }
    super.initState();
  }

  @override
  void dispose() {
    disposeKeyboardDetector();
    super.dispose();
  }

  initKeyboardDetector({
    final Function(double)? willShowKeyboard,
    final Function()? willHideKeyboard,
  }) {
    // Use MediaQuery to detect keyboard visibility
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkKeyboardStatus(willShowKeyboard, willHideKeyboard);
    });
  }

  void _checkKeyboardStatus(
    Function(double)? willShowKeyboard,
    Function()? willHideKeyboard,
  ) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardHeight = mediaQuery.viewInsets.bottom;
    final newKeyboardOn = keyboardHeight > 0;

    if (newKeyboardOn != isKeyboardOn) {
      setState(() {
        isKeyboardOn = newKeyboardOn;
      });

      if (newKeyboardOn) {
        willShowKeyboard?.call(keyboardHeight);
      } else {
        willHideKeyboard?.call();
      }
    }
  }

  disposeKeyboardDetector() {
    // No cleanup needed for MediaQuery-based detection
  }
}
