import 'dart:convert';

import 'package:http/http.dart' as http;

import '../entities/todo/todo.dart';

abstract class TodosRemoteDatasource {
  Future<List<Todo>> fetchTodos();
}

class TodosRemoteDatasourceImpl implements TodosRemoteDatasource {
  @override
  Future<List<Todo>> fetchTodos() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://jsonplaceholder.typicode.com/todos",
        ),
      );
      // print(response.body);

      return List<Todo>.from(
          json.decode(response.body).map((x) => Todo.fromJson(x)));
    } catch (e) {
      rethrow;
    }
  }
}
