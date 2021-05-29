import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_composition/flutter_composition.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends CompositionState<MyApp> {
  int _count = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _count += 5;
              });
            },
            child: Text('change count'),
          ),
          ChildWidget(
            count: _count,
          ),
        ],
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  const ChildWidget({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  _ChildWidgetState createState() => _ChildWidgetState();
}

class _ChildWidgetState extends CompositionState<ChildWidget> {
  Future<int>? _future;

  @override
  void initState() {
    onDidUpdateWidget((_) {
      _future =
          Future<int>.delayed(Duration(seconds: 1), () => widget.count * 10);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('count ${widget.count}'),
        FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            } else {
              return Text('async count${snapshot.data}');
            }
          },
        ),
      ],
    );
  }
}
