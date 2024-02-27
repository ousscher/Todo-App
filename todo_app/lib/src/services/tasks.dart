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
      // If the server returns a 200 OK response, parse the tasks
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

  Future<void> addTask(String task) async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> deleteTask(String task) async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> updateTask(String task) async {
    await Future.delayed(Duration(seconds: 2));
  }
}
