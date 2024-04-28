import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/edit_task.dart';
//import 'package:todo_app/providers/todo.dart';
import 'package:todo_app/widgets/widgets.dart';

class ToDoItem extends StatefulWidget {
  const ToDoItem({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onChanged,
  });

  final ToDoList todo;
  final dynamic onDelete;
  final dynamic onChanged;

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
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
          //widget.onChanged(widget.todo);
          setState(() {
            widget.todo.isDone = !widget.todo.isDone;
          });
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
              widget.todo.isDone
                  ? "${widget.todo.todoText} completed!"
                  : "${widget.todo.todoText} incomplete!"));
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.pink[100],
        leading: Icon(
          widget.todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.grey[700],
          size: 22,
        ),
        title: Text(
          widget.todo.todoText!,
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              decoration:
                  widget.todo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () async {
                  final result = await showModalBottomSheet(
                      useSafeArea: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.pink[50],
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.0)),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return EditTask(
                          todo: widget.todo,
                        );
                      });
                  if (result != null) {
                    setState(() {});
                  }
                },
                icon: Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.grey[700],
                )),
            IconButton(
                onPressed: () {
                  widget.onDelete(widget.todo.id);
                  //ref.read(toDoProvider.notifier).removeTask(widget.todo.id!);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                      mySnackBar("${widget.todo.todoText} deleted!"));
                },
                icon: const Icon(
                  Icons.delete,
                  size: 16,
                  color: Colors.pink,
                )),
          ],
        ),
      ),
    );
  }
}
