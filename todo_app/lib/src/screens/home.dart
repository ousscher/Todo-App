import 'package:flutter/material.dart';
import 'allTasks.dart';
import 'newTask.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showAddTask = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showAddTask ? 'Add Task' : 'Show All Tasks'),
      ),
      body: showAddTask ? AddTaskSection() : ShowAllTasksSection(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    showAddTask = true;
                  });
                },
                color: showAddTask ? Theme.of(context).primaryColor : Colors.grey,
              ),
              IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    showAddTask = false;
                  });
                },
                color: !showAddTask ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

