import '../core/service/auth_service.dart';
import '../data/models/user_model.dart';

class HomePresenter {
  final AuthService authService;
  HomePresenter(this.authService);

  User getUser() {
    User user = authService.currentUser!;

    return user;
  }
}
