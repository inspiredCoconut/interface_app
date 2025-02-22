import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/widgets/layout/main_layout.dart';
import '../views/home/home_view.dart';
import '../views/settings/settings_view.dart';
import '../views/users/user_add_view.dart';
import '../views/users/user_list_view.dart';
import '../views/admin/admin_dashboard_view.dart';
import '../views/auth/login_view.dart';
import 'constants/routes.dart';
import 'service/auth_service.dart';
import 'service/locator_service.dart';

final AuthService authService = locator<AuthService>();

final GoRouter router = GoRouter(
  initialLocation: RoutesApp.home,
  routes: [
    _standardRoute(RoutesApp.login, LoginView()),
    _protectedRouteNotrasition(RoutesApp.home, MainLayout(child: HomeView())),
    _protectedRouteNotrasition(RoutesApp.settings, MainLayout(child: SettingsView())),
    _protectedRouteNotrasition(RoutesApp.userList, MainLayout(child: UserListView())),
    _protectedRouteNotrasition(RoutesApp.userAdd, MainLayout(child: UserAddView())),
    _adminRouteNotrasition(RoutesApp.admin, MainLayout(child: AdminDashboardView())),
  ],
);

GoRoute _adminRouteNotrasition(String pathRoute, Widget widget) {
  return GoRoute(
    path: pathRoute,
    builder: (context, state) => widget,
    pageBuilder: (context, state) => NoTransitionPage(child: widget),
    redirect: (_, __) => authService.isAdmin() ? null : RoutesApp.home,
  );
}

GoRoute _standardRoute(String pathRoute, Widget widget) {
  return GoRoute(
    path: pathRoute,
    builder: (context, state) => widget,
  );
}

GoRoute _protectedRouteNotrasition(String pathRoute, Widget widget) {
  return GoRoute(
    path: pathRoute,
    builder: (context, state) =>  widget,
    pageBuilder: (context, state) =>NoTransitionPage(child: widget),
    redirect: (_, __) => authService.isAuthenticated() ? null : RoutesApp.login,
  );
}