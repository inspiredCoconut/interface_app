import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/service/locator_service.dart';
import '../../presenters/auth_presenter.dart';
import '../../core/constants/routes.dart';

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

  @override
  void initState() {
    // If user is already logged in, redirect to home page
    if (presenter.isAuthenticated()) {
      changePage();
    }
    super.initState();
  }

  void login() async {
    bool success =
        await presenter.login(emailController.text, passwordController.text);
    if (success) {
      print("Login successful");
      changePage();
    } else {
      setState(() => errorMessage = "Invalid credentials");
    }
  }

  void changePage() {
    GoRouter.of(context).pushReplacement(RoutesApp.home);
  }

  void checkController() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      login();
      print("Check successful");
    } else {
      setState(() => errorMessage = "Please enter email and password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => checkController(),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
