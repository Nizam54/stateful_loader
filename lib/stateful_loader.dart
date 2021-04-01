library stateful_loader;

import 'package:flutter/material.dart';

/// use as an extension mixin for stateful widget's State to directly call showLoading(context) and hideLoading()
mixin LoadingWidget { 
  BuildContext _dialogContext;
  bool _loaderRendering = false;
  Widget get loaderWidget => null;
  bool get barrierDismissible => false;

  showLoading(BuildContext context) async {
    if (_dialogContext != null) {
      Navigator.pop(_dialogContext);
      _dialogContext = null;
    }
    _loaderRendering = true;
    _dialogContext = await showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          _loaderRendering = false;
          _dialogContext = context;
          return Center(
            child: loaderWidget ?? CircularProgressIndicator(),
          );
        });
    _loaderRendering = false;
  }

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