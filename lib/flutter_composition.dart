library flutter_composition;

import 'package:flutter/material.dart';

abstract class CompositionState<T extends StatefulWidget> extends State<T> {
  final _didChangeDependenciesCbList = Set<VoidCallback>();
  final _didUpdateWidgetCbList = Set<void Function(T oldWidget)>();
  final _deactivateCbList = Set<VoidCallback>();
  final _disposeCbList = Set<VoidCallback>();

  void onDidUpdateWidget([void Function(T oldWidget)? cb]) {
    if (cb != null) {
      _didUpdateWidgetCbList.add(cb);
    }
  }

  void onDispose([VoidCallback? cb]) {
    if (cb != null) {
      _disposeCbList.add(cb);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _didChangeDependenciesCbList.forEach((cb) {
      try {
        cb();
      } catch (e, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: e,
          stack: stack,
        ));
      }
    });
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);

    _didUpdateWidgetCbList.forEach((cb) {
      try {
        cb(oldWidget);
      } catch (e, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: e,
          stack: stack,
        ));
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();

    _deactivateCbList.forEach((cb) {
      try {
        cb();
      } catch (e, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: e,
          stack: stack,
        ));
      }
    });
  }

  @override
  void dispose() {
    _disposeCbList.forEach((cb) {
      cb();
    });

    super.dispose();
  }
}
