import 'package:http/http.dart' as http;
import 'dart:convert';

class Tasks {
  String token;
  String ipAdress = "192.168.176.89";
  Tasks({required this.token});
  Future<List<Map<String, dynamic>>?> getTasks() async {
    final response = await http.get(
      Uri.parse('http://$ipAdress:3000/api/tasks/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> tasksJson = jsonDecode(response.body)['tasks'];
      final List<Map<String, dynamic>> tasks = tasksJson.map((taskJson) {
        return {
          'id': taskJson['_id'],
          'userId': taskJson['userId'],
          'title': taskJson['title'],
          'content': taskJson['content'],
          '__v': taskJson['__v'].toString(),
        };
      }).toList();
      return tasks;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> addTask(String title, String discription) async {
    print(title+"    "+ discription);
    final response = await http.post(
      Uri.parse('http://$ipAdress:3000/api/tasks/add'),
      headers: {
        'Authorization': 'Bearer  $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'content': discription,
      }),
    );
    if (response.statusCode == 200) {
      print('Task added');
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<void> deleteTask(String taskId) async {
    final response = await http.delete(
      Uri.parse('http://$ipAdress:3000/api/tasks/$taskId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('Task deleted');
    } else {
      throw Exception('Failed to delete task');
    }
  }

  Future<void> updateTask(
      String taskId, String newTitle, String newContent) async {
    final response = await http.put(
      Uri.parse('http://$ipAdress:3000/api/tasks/$taskId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': newTitle,
        'content': newContent,
      }),
    );
    if (response.statusCode == 200) {
      print('Task updated');
    } else {
      throw Exception('Failed to update task');
    }
  }
}
