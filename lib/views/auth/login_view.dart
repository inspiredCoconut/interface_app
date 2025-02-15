import 'package:flutter/material.dart';
import '../../core/service/locator_service.dart';
import '../../presenters/auth_presenter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthPresenter presenter = locator<AuthPresenter>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  void login() async {
    bool success = await presenter.login(emailController.text, passwordController.text);
    if (success) {
      Navigator.pushReplacementNamed(context, '/users');
    } else {
      setState(() => errorMessage = "Invalid credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            Text(errorMessage, style: TextStyle(color: Colors.red)),
            ElevatedButton(onPressed: login, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
