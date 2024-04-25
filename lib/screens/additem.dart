import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/widgets.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController taskController = TextEditingController();
  TaskStatus _selectedStatus = TaskStatus.all;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
            backgroundColor: Colors.pink[50],
            automaticallyImplyLeading: false,
            title: scaffoldtext(
              'Add Task',
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
                    final task = taskController.text;
                    if (taskController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBar("Please add task!"),
                      );
                    } else {
                      Navigator.pop(
                          context,
                          ToDoList(
                            todoText: task,
                            isDone: false,
                          ));
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBar("${taskController.text} Added to List!"),
                      );
                      taskController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.assignment,
                    color: Colors.grey,
                    size: 20,
                  ),
                  label: mytext("Add Task"),
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
