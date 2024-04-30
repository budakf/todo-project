import 'package:flutter/material.dart';
import 'package:todo_client/http_client/todo_client.dart';
import 'package:todo_client/model/todo.dart';
import 'package:todo_client/constants.dart' as constants;
import 'package:todo_client/state/app_state_manager.dart';
import 'package:todo_client/state/state_types.dart';


class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final AppStateManager _appStateManager = AppStateManager.instance();

  void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'UNDO', onPressed: (){ 

        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          constants.log.fine('Pressed add button');
          String todoMessage = _appStateManager.get(StateTypes.newTodo);
          List<Todo> todos = _appStateManager.get(StateTypes.todos);
          TodoClient todoClient = TodoClient(constants.host, constants.baseEndpoint);
          Todo newTodo = Todo(message: todoMessage, important: false, done: false);
          () async {
            Todo newTodoWithId = await todoClient.postNewTodo(newTodo, 'todo/add');
            todos.add(newTodoWithId);
            _appStateManager.update(StateTypes.todos, todos);
          }();
          showToast(context, "Added New Todo Item: $todoMessage");
        },
      ),
    );
  }

}