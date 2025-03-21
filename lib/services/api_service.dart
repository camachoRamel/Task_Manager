import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task_model.dart';

class ApiService {
  final String baseUrl =
      "https://67dd4672e00db03c406aeaf0.mockapi.io/api/tasks/tasks";

  // GET ALL TASKS
  Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse(baseUrl));
    // print("adspj)");
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // print(data.length);
      return data.map((json) => Task.fromJson(json)).toList();
    } else
      throw Exception("Failed to load tasks");
  }

  Future<Task> createTask(
    String title,
    String description,
    String dueDate,
  ) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode({
        'title': title,
        'description': description,
        'dueDate': dueDate,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return Task.fromJson(json.decode(response.body));
    } else
      throw Exception("Failed to create task");
  }

  Future<Task> updateTask(
    String id,
    String title,
    String description,
    String dueDate,
  ) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      body: json.encode({
        'title': title,
        'description': description,
        'dueDate': dueDate,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    } else
      throw Exception("Failed to update task");
  }

  Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception(response.statusCode);
    }
  }
}
