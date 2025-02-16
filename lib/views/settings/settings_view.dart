import 'package:flutter/material.dart';

import 'package:interface_app/presenters/settings_presenter.dart';
import '../../core/service/locator_service.dart';
import '../../data/models/user_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsPresenter presenter = locator<SettingsPresenter>();
  late User user;
  String statusMessage = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = presenter.getUser();
    emailController.text = user.email;
    nameController.text = user.name;
    ageController.text = user.age.toString();
  }

  void updateSettings() async {
    bool status = await presenter.updateSettings(
      email: emailController.text,
      name: nameController.text,
      age: int.parse(ageController.text),
    );
    if (!status) {
      setState(() {
        statusMessage = 'Failed to update settings';
      });
    } else {
      setState(() {
        statusMessage = 'Settings updated successfully';
      });
    }
    showStatusMessage();
  }

  void showStatusMessage() {
    if (statusMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(statusMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Settings", style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: user.email,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: user.name,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: "Age",
                  hintText: user.age.toString(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  updateSettings();
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
