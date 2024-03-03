import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/home.dart';
import 'package:todo_app/src/services/auth.dart';
import 'package:todo_app/src/shared/loading.dart';

class Register extends StatefulWidget {
  Function toogleView;
  Register({super.key, required this.toogleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _loading = false;
  String _error = "";
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return (_loading)
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Register to the TODO-APP'),
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
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true, // For password fields
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_usernameController.text.isNotEmpty && _usernameController.text.length>=6 ) {
                        if (_passwordController.text.length < 6) {
                          setState(() {
                            _error = "Week password";
                          });
                        } else {
                          if (_passwordController.text ==
                              _confirmPasswordController.text) {
                            setState(() {
                              _error = "";
                              _loading = true;  
                            });
                            try {
                              String token = await Auth.signupAndLogin(
                                  _usernameController.text,
                                  _passwordController.text);
                              Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage(token: token,)),
                              (route) => false,
                            );
                              print(token);
                            } catch (e) {
                              setState(() {
                                _error = e.toString();
                                _loading = false;
                              });
                            }
                          } else {
                            setState(() {
                              _error = "Passwords do not match";
                            });
                          }
                        }
                      } else {
                        setState(() {
                          _error = "The field of username is empty";
                        });
                      }
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 20),
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
                        "You already have account? Login here",
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
