import '../data/repositories/user_repository.dart';
import '../data/models/user_model.dart';

class HomePresenter {
  final UserRepository userRepository;

  HomePresenter(this.userRepository);

  Future<List<User>> getUsers() async {
    return await userRepository.loadJsonUsers();
  }
}
