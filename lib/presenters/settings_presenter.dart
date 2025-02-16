import '../core/service/auth_service.dart';
import '../data/models/user_model.dart';

class SettingsPresenter {
  final AuthService authService;

  SettingsPresenter(this.authService);

  User getUser() {
    User user = authService.currentUser!;

    return user;
  }

  Future<bool> updateSettings(
      {required String email, required String name, required int age}) async {
    // Handle settings update logic
    bool status = await authService.fakeUpdateProfile(email, name, age);
    return status;
  }
}
