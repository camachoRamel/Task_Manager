import 'package:flutter/material.dart';
import 'package:task_manager/bloc/task_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/task_bloc.dart';
import 'services/api_service.dart';
import 'views/task_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(ApiService())..add(LoadTasks()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Task Manager",
        theme: ThemeData(primarySwatch: Colors.teal),
        home: TaskList(),
      ),
    );
  }
}
