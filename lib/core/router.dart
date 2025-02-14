import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/home_view.dart';
import '../views/settings_view.dart';
import '../views/widgets/sidebar.dart';
import '../views/users/user_add_view.dart';
import '../views/users/user_list_view.dart';
import '../views/admin/admin_dashboard_view.dart';
import '../views/auth/login_view.dart';
import 'constants/routes.dart';
import 'auth_service.dart';
import 'locator_service.dart';

final AuthService authService = locator<AuthService>();

final GoRouter router = GoRouter(
  initialLocation: RoutesApp.home,
  routes: [
    GoRoute(path: RoutesApp.login, builder: (context, state) => LoginView()),
    GoRoute(
      path: RoutesApp.home,
      builder: (context, state) => MainLayout(child: HomeView()),
      pageBuilder: (context, state) =>
          NoTransitionPage(child: MainLayout(child: HomeView())),
    ),
    GoRoute(
      path: RoutesApp.settings,
      builder: (context, state) => MainLayout(child: SettingsView()),
      pageBuilder: (context, state) =>
          NoTransitionPage(child: MainLayout(child: SettingsView())),
    ),
    GoRoute(
      path: RoutesApp.userList,
      builder: (context, state) => MainLayout(child: UserListView()),
      pageBuilder: (context, state) =>
          NoTransitionPage(child: MainLayout(child: UserListView())),
    ),
    GoRoute(
      path: RoutesApp.userAdd,
      builder: (context, state) => MainLayout(child: UserAddView()),
      pageBuilder: (context, state) =>
          NoTransitionPage(child: MainLayout(child: UserAddView())),
    ),
    GoRoute(
      path: RoutesApp.admin,
      builder: (context, state) => authService.isAdmin()
          ? MainLayout(child: AdminDashboardView())
          : LoginView(),
      pageBuilder: (context, state) => authService.isAdmin()
          ? NoTransitionPage(child: MainLayout(child: AdminDashboardView()))
          : NoTransitionPage(child: LoginView()),
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
