import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final log = Logger('TodoApp');

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      child: Row (
        children: [
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.apps),
              onPressed: () { log.fine('Pressed all button'); },
            ),
          ),

          Expanded(
            child: IconButton(
              icon: const Icon(Icons.star),
              onPressed: () { log.fine('Pressed active button'); },
            ),
          ),

          Expanded(
            child: IconButton(
              icon: const Icon(Icons.done),
              onPressed: () { log.fine('Pressed done button'); },
            ),
          ),

        ],
      ),
    );
  }
}
