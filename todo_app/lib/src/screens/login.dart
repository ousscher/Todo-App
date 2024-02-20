import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/src/services/auth.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  Function toogleView;
  Login({super.key, required this.toogleView});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = false; //to use later
  String _error = "";
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    print(username + "   "+password); 

    // Your login API URL
    final String apiUrl = 'http://192.168.103.89:3000/api/auth/login';

    try {
      final response = await http.post(
        headers: {
          'Content-Type': 'application/json',
        },
        Uri.parse(apiUrl),
        body: jsonEncode(
          {
          'username': username,
          'password': password,
        },
        )
      );

      if (response.statusCode == 200) {
        print('Login successful');
        print(jsonDecode(response.body)['token']);
      } else {
        print(response);
        // Login failed, handle the response accordingly
        print('Login failed. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // An error occurred during the request
      print('Error during login request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to the TODO-APP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username field
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
              ),
            ),
            const SizedBox(height: 20),
            // Password field
            TextField(
              controller: _passwordController,
              obscureText: true, // For password fields
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_usernameController.text.isNotEmpty) {
                  if (_passwordController.text.isEmpty) {
                    setState(() {
                      _error = "Empty password";
                    });
                  } else {
                    //here the request
                    setState(() {
                      _error = "";
                    });
                    _login();
                  }
                } else {
                  setState(() {
                    _error = "The field of username is empty";
                  });
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                _error.isNotEmpty ? _error : "",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            Center(
              child: InkWell(
                onTap: () => widget.toogleView(),
                child: const Text(
                  "You don't have account? Register here",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
