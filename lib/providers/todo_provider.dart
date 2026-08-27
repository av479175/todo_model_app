import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoProvider = NotifierProvider<TodoNotifier, List<Todo>>(TodoNotifier.new);

class TodoNotifier extends Notifier<List<Todo>> {

  final _uuid = const Uuid();

  @override
  List<Todo> build() => []; // initial state — replaces the constructor


  void addTodo(String title) {
    state = [...state , Todo(id: _uuid.v4(), title: title)];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(isDone: !todo.isDone) else todo,
    ];
  }

  void editTodo(String id, String newTitle) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(title: newTitle) else todo,
    ];
  }

  void deleteTodo(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  Todo? getById(String id) {
    try {
      return state.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}