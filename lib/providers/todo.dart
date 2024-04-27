import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';

class ToDoNotifier extends StateNotifier<List<ToDoList>> {
  ToDoNotifier() : super([]);

  void addTask(ToDoList todo) {
    state = [...state, todo];
  }

  void removeTask(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }
}

final toDoProvider = StateNotifierProvider<ToDoNotifier, List<ToDoList>>(
  (ref) => ToDoNotifier(),
);
