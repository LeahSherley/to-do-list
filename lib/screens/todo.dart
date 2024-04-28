import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';
//import 'package:todo_app/providers/todo.dart';
import 'package:todo_app/screens/additem.dart';
import 'package:todo_app/widgets/task_widget.dart';
import 'package:todo_app/widgets/widgets.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  late List<ToDoList> filteredtodo;
  List<ToDoList> todo = [];
  TaskStatus _selectedStatus = TaskStatus.all;
  bool isDarkMode = false;

  void updateTasks() {
    setState(() {
      switch (_selectedStatus) {
        case TaskStatus.all:
          filteredtodo = todo;
          break;
        case TaskStatus.completed:
          filteredtodo = todo.where((todo) => todo.isDone).toList();
          break;
        case TaskStatus.pending:
          filteredtodo = todo.where((todo) => !todo.isDone).toList();
          break;
      }
    });
  }

  void _handleToDoChange(ToDoList todo) {
    setState(() {
      todo.isDone = !todo.isDone;
      updateTasks();
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      filteredtodo.removeWhere((item) => item.id == id);
      updateTasks();
    });
  }

  void filtertodo(String query) {
    filteredtodo = todo
        .where((element) =>
            element.todoText!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _setSelectedCategory(TaskStatus status, BuildContext context) {
    setState(() {
      _selectedStatus = status;
      updateTasks();
    });

    Navigator.pop(context);
  }

  void _showHelpModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.pink[50],
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Help',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[500],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome to the Help section! Here, you can find useful information and tips to enhance your experience with the app.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'If you have any questions or encounter any issues, please feel free to contact our support team at randikileah@gmail.com.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[100],
                    // Set the text color
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: mytext('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    filteredtodo = todo;
    updateTasks();
  }

  @override
  Widget build(BuildContext context) {
    //final filteredtodo = ref.watch(toDoProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showModalBottomSheet(
              useSafeArea: true,
              isScrollControlled: true,
              backgroundColor: Colors.pink[50],
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              ),
              context: context,
              builder: (BuildContext context) {
                return const AddTask();
              });
          if (result != null) {
            setState(() {
              todo.add(result);
            });

            //ref.read(toDoProvider.notifier).addTask(result);
          }
        },
        label: mytext("Add task to list"),
        icon: Icon(
          Icons.add,
          color: Colors.grey[700],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: scaffoldtext("To Do List"),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.grey[700],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.pink[50],
        elevation: 0,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  child: Icon(
                Icons.account_circle_rounded,
                size: 50,
                color: Colors.grey[800],
              )),
              accountName: drawertext("Dorinda"),
              accountEmail: drawertext("doreen05@gmail.com"),
            ),
            ListTile(
              onTap: () => _setSelectedCategory(TaskStatus.all, context),
              title: mytext("All Tasks"),
              leading: Icon(
                Icons.assignment,
                color: Colors.grey[700],
                size: 20,
              ),
            ),
            ListTile(
              onTap: () => _setSelectedCategory(TaskStatus.pending, context),
              title: mytext("Pending Task"),
              leading: Icon(
                Icons.incomplete_circle,
                color: Colors.grey[700],
                size: 20,
              ),
            ),
            ListTile(
              onTap: () => _setSelectedCategory(TaskStatus.completed, context),
              title: mytext("Completed Task"),
              leading: Icon(
                Icons.check_box,
                color: Colors.grey[700],
                size: 20,
              ),
            ),
            ListTile(
              onTap: () => _showHelpModal(context),
              title: mytext("Help"),
              leading: Icon(
                Icons.help_center,
                color: Colors.grey[700],
                size: 20,
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  isDarkMode =! isDarkMode;
                });
              },
              title: mytext("Dark Mode"),
              leading: Icon(
                Icons.dark_mode_rounded,
                color: Colors.grey[700],
                size: 20,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    filtertodo(value);
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.pink[200]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.pink[200]!),
                  ),
                  contentPadding: const EdgeInsets.all(7),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[700],
                    size: 24,
                  ),
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            filteredtodo.isEmpty
                ? Center(
                    child: scaffoldtext("List is Empty"),
                  )
                : Expanded(
                    child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(
                          child: Text(
                            "Dorinda's To Do's",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.pink[500]),
                          ),
                        ),
                      ),
                      for (final todolist in filteredtodo)
                        ToDoItem(
                          todo: todolist,
                          onChanged: _handleToDoChange,
                          onDelete: _deleteToDoItem,
                        ),
                    ],
                  ))
          ],
        ),
      ),
      backgroundColor: Colors.pink[50],
    );
  }
}
