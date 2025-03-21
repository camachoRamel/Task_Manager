import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskDetailsPage extends StatelessWidget {
  final Task task;

  TaskDetailsPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${task.title}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Description: ${task.description}'),
            SizedBox(height: 8),
            Text('Due Date: ${task.dueDate}'), // Consider formatting this date
            // Add other properties as needed
          ],
        ),
      ),
    );
  }
}
