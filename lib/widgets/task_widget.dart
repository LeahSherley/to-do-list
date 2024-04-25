import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/widgets.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onDelete,
      required this.onChanged});

  final ToDoList todo;
  final dynamic onDelete;
  final dynamic onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: ListTile(
        onTap: () {
          onChanged(todo);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(mySnackBar("${todo.todoText} completed!"));
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.pink[100],
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.grey[700],
          size: 22,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: IconButton(
            onPressed: () {
              onDelete(todo.id);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context)
                  .showSnackBar(mySnackBar("${todo.todoText} deleted!"));
            },
            icon: const Icon(
              Icons.delete,
              size: 18,
              color: Colors.red,
            )),
      ),
    );
  }
}
