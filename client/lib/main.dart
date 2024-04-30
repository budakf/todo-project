import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_client/todo_app.dart';

final log = Logger('TodoApp');

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  runApp(TodoApp());
}