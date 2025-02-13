import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Set the background color to blue
      child: NavigationRail(
        backgroundColor: Colors.blue, // Set the background color to blue
        selectedIndex: GoRouterState.of(context).uri.toString() == "/settings" ? 1 : 0,
        onDestinationSelected: (index) {
          if (index == 0) {
            context.go('/');
          } else {
            context.go('/settings');
          }
        },
        labelType: NavigationRailLabelType.all,
        selectedIconTheme: IconThemeData(color: Colors.white), // Set selected icon color to white
        unselectedIconTheme: IconThemeData(color: Colors.white70), // Set unselected icon color to white70
        selectedLabelTextStyle: TextStyle(color: Colors.white), // Set selected label color to white
        unselectedLabelTextStyle: TextStyle(color: Colors.white70), // Set unselected label color to white70
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
