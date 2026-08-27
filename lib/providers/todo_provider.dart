import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/todo.dart';


class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];
  final _uuid = const Uuid();

  List<Todo> get todo {
    return List.unmodifiable(_todos);
  }
  //list.unmodifiable prevents a screen form changing list just .add , it return a immutable list

  void addTodo(String title) {
    _todos.add(Todo(id: _uuid.v4(), title: title));
    notifyListeners();
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _todos[index] = _todos[index].copyWith(isDone: !_todos[index].isDone);
    notifyListeners();
  }

  void editTodo(String id, String newTitle) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _todos[index] = _todos[index].copyWith(title: newTitle);
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  Todo? getById(String id) {
    try {
      return _todos.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}