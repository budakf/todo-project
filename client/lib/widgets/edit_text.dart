import 'package:flutter/material.dart';
import 'package:todo_client/http_client/todo_client.dart';
import 'package:todo_client/model/todo.dart';
import 'package:todo_client/state/app_state_manager.dart';
import 'package:todo_client/state/state_types.dart';
import 'package:todo_client/constants.dart' as constants;

class EditText extends StatefulWidget {
  const EditText({super.key});

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  final AppStateManager _appStateManager = AppStateManager.instance();
  final TextEditingController _controller = TextEditingController(text: '');

  _EditTextState(){
    _appStateManager.register(StateTypes.newTodo, this);
    _appStateManager.set(StateTypes.newTodo, "");
  }

  call(){
    setState(() {});
  }

  void _reset(){
    _appStateManager.set(StateTypes.newTodo, "");
    _controller.clear();
  }

  void _changedHandler(String value) {
    _appStateManager.set(StateTypes.newTodo, value);
  }

  void _submitHandler(String value) {
    _postNewTodo(value);
    _reset();
  }

  void _postNewTodo(String value){
    List<Todo> todos = _appStateManager.get(StateTypes.todos);
    TodoClient todoClient = TodoClient(constants.host, constants.baseEndpoint);
    Todo newTodo = Todo(message: value, important: false, done: false);
    () async {
      Todo newTodoWithId = await todoClient.postNewTodo(newTodo, 'todo/add');
      todos.add(newTodoWithId);
      _appStateManager.update(StateTypes.todos, todos);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Type to add new todo'
        ),
        controller: _controller,
        enabled: true,
        cursorColor: Colors.black,
        focusNode: FocusNode(),
        // autofocus: true,
        onChanged: _changedHandler,
        onSubmitted: _submitHandler,
      ),
    );
  }

}

