import 'package:flutter/material.dart';
import 'package:todo_client/model/todo.dart';
import 'package:todo_client/state/app_state_manager.dart';
import 'package:todo_client/state/state_types.dart';
import 'package:todo_client/widgets/todo_list_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final AppStateManager<StateTypes> _appStateManager;
  late List<Todo> _todoList;

  _TodoListState() : _appStateManager = AppStateManager.instance() {
    _appStateManager.register(StateTypes.todos, this);
    _appStateManager.initState(StateTypes.todos);
  }

  /// https://dart.dev/language/callable-objects
  /// call() method turns an instance of a class defining it to callable object.
  call(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _todoList = _appStateManager.get(StateTypes.todos) ?? [];
    return ListView(
      children: _todoList.isEmpty ? [] : _sortedTodoList().map((element) => TodoListItem(element)).toList(growable: true),
    );
  }

  List<Todo> _sortedTodoList(){
    _todoList.sort((Todo first, Todo second) => first.id!.compareTo(second.id!));
    return _todoList;
  }

}