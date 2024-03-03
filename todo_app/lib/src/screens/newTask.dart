import 'package:flutter/material.dart';
import 'package:todo_app/src/services/tasks.dart';

class AddTaskSection extends StatefulWidget {
  String token;
  AddTaskSection({required this.token});
  @override
  State<AddTaskSection> createState() => _AddTaskSectionState();
}

class _AddTaskSectionState extends State<AddTaskSection> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isError = false;
  String _error = '';
  bool _isSuccess = false;
  String _success = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        TextField(
          controller: _titleController,
          maxLines: 2,
          decoration: InputDecoration(
            labelText: 'Title *',
            hintText: 'Enter the title of the task',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.all(12.0),
          ),
        ),
        const SizedBox(height: 30),
        TextField(
          controller: _descriptionController,
          maxLines: 8,
          decoration: InputDecoration(
            labelText: 'Description *',
            hintText: 'Enter the description of the task',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.all(12.0),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(18.0),
          ),
          onPressed: () async {
            if (_titleController.text.isEmpty ||
                _descriptionController.text.isEmpty) {
              setState(() {
                _isError = true;
                _error = 'Please fill all the fields';
              });
              return;
            } else
              setState(() {
                _isError = false;
              });
            try {
              print(widget.token);
              await Tasks(token: widget.token).addTask(_titleController.text, _descriptionController.text);
              setState(() {
                _isSuccess = true;
                _success = 'Task added successfully';
              });
            } catch (e) {
              setState(() {
                _isError = true;
                _error = "Failed to add task";
              });
              return;
            }
          },
          child: const Text(
            'Add Task',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Text(_isError ? _error : '',
            style: const TextStyle(color: Colors.red, fontSize: 16.0)),
        Text(_isSuccess ? _success : '',
            style: const TextStyle(color: Colors.green, fontSize: 16.0)),
      ],
    );
  }
}
