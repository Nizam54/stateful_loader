library stateful_loader;

import 'package:flutter/material.dart';

/// use as an extension mixin for stateful widget's State to directly call showLoading(context) and hideLoading()
mixin LoadingWidget {
  BuildContext _dialogContext;
  bool _loaderRendering = false;
  /// Can override to provide any widget as a loader
  Widget get loaderWidget => null;
  /// Decides whether to dismiss the loader on taping the barrier. Defaults to false.
  bool get barrierDismissible => false;
  /// Replace the boring black shade for the barrier
  Color get barrierColor => null;

  /// Call this to show a full screen loader
  showLoading(BuildContext context) async {
    if (_dialogContext != null) {
      Navigator.pop(_dialogContext);
      _dialogContext = null;
    }
    _loaderRendering = true;
    _dialogContext = await showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        builder: (BuildContext context) {
          _loaderRendering = false;
          _dialogContext = context;
          return Center(
            child: loaderWidget ?? CircularProgressIndicator(),
          );
        });
    _loaderRendering = false;
  }

  /// Hides a previously shown loader through this mixin. Do nothing otherwise.
  hideLoading() {
    if (_loaderRendering) {
      Future.delayed(Duration(milliseconds: 500), () {
        hideLoading();
      });
    }
    if (_dialogContext != null) {
      Navigator.pop(_dialogContext);
      _dialogContext = null;
    }
  }
}
