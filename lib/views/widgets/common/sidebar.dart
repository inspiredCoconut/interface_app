import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/routes.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/service/locator_service.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _selectedIndex = 0;
  final AuthService authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Set the background color to blue
      child: NavigationRail(
        backgroundColor: Colors.blue, // Set the background color to blue
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          _selectedIndex = index;
          switch (index) {
            case 0:
              context.go(RoutesApp.home);
              break;
            case 1:
              context.go(RoutesApp.userList);
              break;
            case 2:
              context.go(RoutesApp.settings);
              break;
            case 3:
              context.go(RoutesApp.admin);
              break;
          }
        },
        labelType: NavigationRailLabelType.all,
        selectedIconTheme: IconThemeData(
            color: Colors.white), // Set selected icon color to white
        unselectedIconTheme: IconThemeData(
            color: Colors.white70), // Set unselected icon color to white70
        selectedLabelTextStyle:
            TextStyle(color: Colors.white), // Set selected label color to white
        unselectedLabelTextStyle: TextStyle(
            color: Colors.white70), // Set unselected label color to white70
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          NavigationRailDestination(
              icon: Icon(Icons.supervised_user_circle), 
              label: Text("Users")
          ),
          NavigationRailDestination(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
          if(authService.isAdmin())
            NavigationRailDestination(
              icon: Icon(Icons.admin_panel_settings),
              label: Text('Admin'),
            ),
        ],
      ),
    );
  }
}
