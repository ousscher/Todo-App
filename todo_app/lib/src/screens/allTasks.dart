import 'package:flutter/material.dart';
import 'package:todo_app/src/services/tasks.dart';
import 'package:todo_app/src/shared/loading.dart';

class ShowAllTasksSection extends StatefulWidget {
  String token;
  ShowAllTasksSection({Key? key, required this.token}) : super(key: key);
  @override
  State<ShowAllTasksSection> createState() => _ShowAllTasksSectionState();
}

class _ShowAllTasksSectionState extends State<ShowAllTasksSection> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: Tasks(token: widget.token).getTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> tasks = snapshot.data ?? [];
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(8),
                elevation: 3,
                child: ListTile(
                  title: Text('Title: ${tasks[index]['title']}'),
                  subtitle: Text('Content: ${tasks[index]['content']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete Task'),
                          content: Text(
                              'Are you sure you want to delete this task?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                print(tasks[index]);
                                Tasks(token: widget.token).deleteTask(tasks[index]['id']);
                                setState(() async{
                                  // Reload the tasks after deletion
                                  tasks =  (Tasks(token: widget.token).getTasks()
                                          as List<Map<String, dynamic>>?) ??
                                      [];
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Add other fields as needed
                ),
              );
            },
          );
        }
      },
    );
  }
}
