import 'package:flutter/material.dart';
import '../../core/locator_service.dart';
import '../../presenters/user_presenter.dart';
import '../../data/models/user_model.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final UserPresenter presenter = locator<UserPresenter>();
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = presenter.getUsers();
  }

  void refreshUsers() {
    setState(() {
      users = presenter.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addUser').then((_) => refreshUsers());
        },
      ),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading users"));
          } else {
            return ListView(
              children: snapshot.data!
                  .map(
                    (user) => ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushNamed(context, '/editUser',
                                      arguments: user)
                                  .then((_) => refreshUsers());
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await presenter.removeUser(user.id);
                              refreshUsers();
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
