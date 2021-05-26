library flutter_composition;

import 'package:flutter/material.dart';

abstract class CompositionState<T extends StatefulWidget> extends State<T> {
  final _initCbList = Set<VoidCallback>();
  final _disposeCbList = Set<VoidCallback>();

  void setUp() {}

  void onInit([VoidCallback? cb]) {
    if (cb != null) {
      _initCbList.add(cb);
    }
  }

  void onDispose([VoidCallback? cb]) {
    if (cb != null) {
      _disposeCbList.add(cb);
    }
  }

  @override
  void initState() {
    final Object? debugCheckForReturnedFuture = setUp() as dynamic;
    assert(
        debugCheckForReturnedFuture is! Future,
        'setUp() can\'t return a Future\n'
        'if need use `async` keyword, consider use a IIFE instead, or `Future.then` method');
    _initCbList.forEach((cb) {
      cb();
    });
    super.initState();
  }

  @override
  void dispose() {
    _disposeCbList.forEach((cb) {
      cb();
    });

    super.dispose();
  }
}
