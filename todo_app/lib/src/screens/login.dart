import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/src/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/src/shared/loading.dart';

import 'home.dart';

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return (_loading)
        ? Loading()
        : Scaffold(
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
                      if (_usernameController.text.isNotEmpty && _usernameController.text.length>=6) {
                        if (_passwordController.text.isEmpty || _passwordController.text.length<6) {
                          setState(() {
                            _error = "Password not strong";
                          });
                        } else {
                          //here the request
                          setState(() {
                            _error = "";
                            _loading = true;
                          });
                          try {
                            String token = await Auth.login(
                                _usernameController.text,
                                _passwordController.text);
                            //succes (doing something)
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage(token: token,)),
                              (route) => false,
                            );
                            setState(() {
                              _loading = false;
                            });
                          } catch (error ) {
                            setState(() {
                              _error = error.toString();
                              _loading = false;
                            });
                          }
                        }
                      } else {
                        setState(() {
                          _error = "The field of username is empty or not good";
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
