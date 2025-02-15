import 'package:flutter/material.dart';
import '../../presenters/home_presenter.dart';
import '../../data/models/user_model.dart';
import '../../core/locator_service.dart';
import '../widgets/common/user_datatable.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Use locator to get the presenter instance as alternative to implementing the presenter in the constructor
  final HomePresenter presenter = locator<HomePresenter>();

  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = presenter.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading users"));
          } else {
            return UserDataTable(users: snapshot.data!);
          }
        },
      ),
    );
  }
}
