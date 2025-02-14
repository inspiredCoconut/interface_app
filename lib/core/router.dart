import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/home_view.dart';
import '../views/settings_view.dart';
import '../views/widgets/sidebar.dart';
import 'constants/routes.dart';

final GoRouter router = GoRouter(
  initialLocation: RoutesApp.home,
  routes: [
    GoRoute(
      path: RoutesApp.home,
      builder: (context, state) => MainLayout(child: HomeView()),
      pageBuilder: (context, state) => NoTransitionPage(child: MainLayout( child: HomeView())),
    ),
    GoRoute(
      path: RoutesApp.settings,
      builder: (context, state) => MainLayout(child: SettingsView()),
      pageBuilder: (context, state) => NoTransitionPage(child: MainLayout( child: SettingsView())),
    ),
  ],
);

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
