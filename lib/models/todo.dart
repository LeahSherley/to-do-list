import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum TaskStatus {
  all,
  completed,
  pending,
}

class ToDoList {
  String? id;
  String? todoText;
  bool isDone;
  
  ToDoList({
    required this.todoText,
    this.isDone = false,
  }) : id = uuid.v4();
}
