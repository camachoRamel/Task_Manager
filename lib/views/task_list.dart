import 'package:intl/intl.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
// import 'package:date_field/date_field.dart';
// import 'package:intl/intl.dart';
import 'task_details_page.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading)
            return Center(child: CircularProgressIndicator());
          if (state is TaskError) return Center(child: Text(state.message));
          if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.dueDate),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // IconButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => TaskDetailsPage(task: task),
                      //       ),
                      //     );
                      //   },
                      //   icon: Icon(Icons.arrow_forward, color: Colors.green),
                      // ),
                      IconButton(
                        onPressed: () {
                          _showEditTaskDialog(context, task);
                        },
                        icon: Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<TaskBloc>().add(DeleteTask(task.id));
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsPage(task: task),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text("Press a button to load tasks"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void _showAddTaskDialog(BuildContext context) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String dueDateController =
      DateFormat("MM-dd-yyyy").format(DateTime.now()).toString();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text("Add Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                InputDatePickerFormField(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  onDateSubmitted: (value) {
                    setState(() {
                      dueDateController =
                          DateFormat("MM-dd-yyyy").format(value).toString();
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<TaskBloc>().add(
                    AddTask(
                      titleController.text,
                      descriptionController.text,
                      dueDateController,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          );
        },
      );
    },
  );
}

void _showEditTaskDialog(BuildContext context, Task task) {
  final TextEditingController titleController = TextEditingController(
    text: task.title,
  );
  final TextEditingController descriptionController = TextEditingController(
    text: task.description,
  );
  String dueDateController = task.dueDate;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Edit Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            InputDatePickerFormField(
              initialDate: DateFormat("MM-dd-yyyy").parse(dueDateController),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onDateSubmitted:
                  (value) => {
                    print(value),
                    dueDateController = DateFormat("MM-dd-yyyy").format(value),
                  },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TaskBloc>().add(
                UpdateTask(
                  task.id,
                  titleController.text,
                  descriptionController.text,
                  dueDateController,
                ),
              );
              Navigator.pop(context);
            },
            child: Text("Update"),
          ),
        ],
      );
    },
  );
}
