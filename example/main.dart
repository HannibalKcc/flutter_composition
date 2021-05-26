import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_composition/flutter_composition.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends CompositionState<MyApp> {
  late int count;

  @override
  void setUp() {
    onInit(() {
      count = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('count ${count}'),
        ],
      ),
    );
  }
}
