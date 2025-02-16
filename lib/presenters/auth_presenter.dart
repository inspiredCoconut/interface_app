import '../core/service/auth_service.dart';

class AuthPresenter {
  final AuthService authService;

  AuthPresenter(this.authService);

  // Real login
  // Future<bool> login(String email, String password) => authService.login(email, password);
  // Fake login
  Future<bool> login(String email, String password) => authService.fakeLogin(email, password);

  bool isAuthenticated() => authService.isAuthenticated();
  
  void logout() => authService.logout();
}
