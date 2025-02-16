import 'package:flutter/material.dart';
import 'package:interface_app/data/models/user_model.dart';
import '../../presenters/home_presenter.dart';
import '../../core/service/locator_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomePresenter presenter = locator<HomePresenter>();
  late User user;

  @override
  void initState() {
    super.initState();
    user = presenter.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Hi ${user.name}', style: TextStyle(fontSize: 24.0)),
                SizedBox(height: 8.0),
                Text('Welcome to this Flutter app',
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
