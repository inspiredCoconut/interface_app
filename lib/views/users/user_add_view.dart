import 'package:flutter/material.dart';
import '../../core/service/locator_service.dart';
import '../../presenters/user_presenter.dart';

class UserAddView extends StatefulWidget {
  const UserAddView({super.key});

  @override
  _UserAddViewState createState() => _UserAddViewState();
}

class _UserAddViewState extends State<UserAddView> {
  final UserPresenter presenter = locator<UserPresenter>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void submit() async {
    await presenter.addUser(nameController.text, emailController.text);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add User")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: submit, child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
