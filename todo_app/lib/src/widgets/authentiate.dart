import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo_app/src/screens/login.dart';
import 'package:todo_app/src/screens/register.dart';

class Authenticate extends StatefulWidget {
  bool showRegister;
  Authenticate({super.key, required this.showRegister});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  void toogleView() {
    setState(() {
      widget.showRegister = !widget.showRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.showRegister ? Register(toogleView: toogleView):Login(toogleView: toogleView));
  }
}
