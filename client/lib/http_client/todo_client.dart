import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:todo_client/model/todo.dart';

final log = Logger('TodoApp');

class TodoClient{
  final String _host;
  final String _baseEndpoint;

  TodoClient(String host, String baseEndpoint)
    : _host = host, _baseEndpoint = baseEndpoint;

  Future<Todo?> fetchById(String path, int id) async {
    Todo? todo;
    var url = Uri.http(_host, '$_baseEndpoint/$path/$id');
    var response = await http.get(url, 
      headers: <String,String> {
        'Content-Type': 'application/json; charset=UTF-8',
      });
    if(response.statusCode == 200){
      todo = Todo.todoFromJson(response.body);
      log.info('Response body: $todo');
    }
    return todo;
  }

  Future<List<Todo>?> fetchAll(String path) async {
    List<Todo>? todoList;
    var url = Uri.http(_host, '$_baseEndpoint/$path');
    var response = await http.get(url, 
      headers: <String,String> {
        'Content-Type': 'application/json; charset=UTF-8',
      });
    if(response.statusCode == 200){
      todoList = Todo.todoListFromJson(response.body);
      log.info('Response body: $todoList');
    }
    return todoList;
  }

  Future<Todo> postNewTodo(Todo newTodo, String path) async {
    var url = Uri.http(_host, '$_baseEndpoint/$path');
    var response = await http.post(url, 
      headers: <String,String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: Todo.todoToJson(newTodo)
    );
    return Todo.todoFromJson(response.body);
  }

  Future<bool> deleteTodoById(int id, String path) async {
    var url = Uri.http(_host, '$_baseEndpoint/$path/$id');
    var response = await http.delete(url, 
      headers: <String,String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> sendPatch(int id, List<Map<String, dynamic>> patch, String path) async {
    var url = Uri.http(_host, '$_baseEndpoint/$path/$id');
    var response = await http.patch(url,
      headers: <String,String> {
        'Content-Type': 'application/json-patch+json',
      },
      body: json.encode(patch)
    );
    return response.statusCode == 200;
  }

}