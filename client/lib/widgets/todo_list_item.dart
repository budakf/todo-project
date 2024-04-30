import 'package:flutter/material.dart';
import 'package:todo_client/http_client/todo_client.dart';
import 'package:todo_client/model/todo.dart';
import 'package:todo_client/constants.dart' as constants;
import 'package:todo_client/state/app_state_manager.dart';
import 'package:todo_client/state/state_types.dart';


class TodoListItem extends StatelessWidget {
  final AppStateManager _appStateManager = AppStateManager.instance();
  final Todo _todo;

  TodoListItem(this._todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      child: ListTile(
        leading: IconButton(
          icon: const Icon(Icons.star),
          color: _todo.important ? Colors.black: Colors.grey,
          onPressed: () {
            constants.log.fine('Pressed important button');
            List<Todo> todos = _appStateManager.get(StateTypes.todos);
            List<Todo?> newTodos = todos.map((element) {
              if(element.id == _todo.id){
                element.important = !_todo.important;
              }
              return element;
            }).toList(growable: true);
            _appStateManager.update(StateTypes.todos, newTodos);
            _updateStatus("important", _todo.important);
          },
        ),
        title: Text(
          _todo.message,
        ),
        trailing: Wrap(
          children: [
            IconButton(
              icon: const Icon(Icons.done),
              color: _todo.done ? Colors.black: Colors.grey,
              onPressed: () {
                constants.log.fine('Pressed done button');
                List<Todo> todos = _appStateManager.get(StateTypes.todos);
                List<Todo?> newTodos = todos.map((element) {
                  if(element.id == _todo.id){
                    element.done = !_todo.done;
                  }
                  return element;
                }).toList(growable: true);
                _appStateManager.update(StateTypes.todos, newTodos);
                _updateStatus("done", _todo.done);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                constants.log.fine('Pressed delete button');
                List<Todo> todos = _appStateManager.get(StateTypes.todos);
                todos.remove(_todo);
                _appStateManager.update(StateTypes.todos, todos);
                _delete();
              },
            ),
          ],
        )
      ),
    );
  }

  List<Map<String, dynamic>> _createPatch({required String path, required bool value}){
    return [{
      "op": "replace",
      "path": "/$path",
      "value": value,
    }];
  }

  void _updateStatus(String path, bool status){
    TodoClient todoClient = TodoClient(constants.host, constants.baseEndpoint);
    final patch =  _createPatch(path:path, value:status);

    () async {
      bool result = await todoClient.sendPatch(_todo.id!, patch, "todo/patch");
    }();
  }

  void _delete(){
    TodoClient _todoClient = TodoClient(constants.host, constants.baseEndpoint);
    () async {
      await _todoClient.deleteTodoById(_todo.id!, 'todo/delete');
    }();
  }

}
