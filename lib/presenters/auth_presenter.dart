import '../core/service/auth_service.dart';

class AuthPresenter {
  final AuthService authService;

  AuthPresenter(this.authService);

  Future<bool> login(String email, String password) => authService.login(email, password);
  
  void logout() => authService.logout();
}
