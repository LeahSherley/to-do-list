import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/widgets.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.todo});
  final ToDoList todo;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController taskController;

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController(
      text: widget.todo.todoText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
            backgroundColor: Colors.pink[50],
            automaticallyImplyLeading: false,
            title: scaffoldtext(
              'Edit Task',
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.pink,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mytext(
                'Task:',
              ),
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  hintText: 'Enter Task',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: 40,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final editedtask = taskController.text;
                    if (taskController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBar("Please add task!"),
                      );
                    } else {
                      /*Navigator.pop(
                        context,
                        ToDoList(
                          todoText: editedtask,
                          isDone: false,
                        ),
                        
                      );*/
                      Navigator.pop(
                        context,
                        widget.todo..todoText = editedtask,
                      );
                      /**or widget.todo.todoText = editedtask;
Navigator.pop(context, widget.todo);
 */

                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBar("Task edited to ${widget.todo.todoText}!"),
                      );
                      taskController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.grey,
                    size: 20,
                  ),
                  label: mytext("Edit Task"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.pink[100],
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
