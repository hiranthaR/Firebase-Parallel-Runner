import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class FirebaseParallelRunner {
  final _testGroups = "testGroups";
  final _channel =
  const MethodChannel('xyz.hirantha/firebase_parallel_runner_channel');

  final _testGroupsCompleter = Completer<List<String>>();

  Future<List<String>> get testGroups => _testGroupsCompleter.future;

  FirebaseParallelRunner() {
    _channel.setMethodCallHandler(_callHandler);
  }

  Future<dynamic> _callHandler(MethodCall call) async {
    if (call.method == _testGroups) {
      final json = jsonDecode(call.arguments);
      final groups = (json as List).map((group) => group.toString()).toList();
      _testGroupsCompleter.complete(groups);
    }
    return null;
  }
}