import 'package:flutter/material.dart';
import 'allTasks.dart';
import 'newTask.dart';


class HomePage extends StatefulWidget {
  String token;
  HomePage({super.key , required this.token});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showAddTask = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showAddTask ? 'Add Task' : 'Show All Tasks'),
      ),
      body: showAddTask ? AddTaskSection() : ShowAllTasksSection(token: widget.token,),
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

