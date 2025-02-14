import '../data/repositories/user_repository.dart';
import '../data/models/user_model.dart';

class UserPresenter {
  final UserRepository userRepository;

  UserPresenter(this.userRepository);

  Future<List<User>> getUsers() => userRepository.loadJsonUsers();

  Future<User> addUser(String name, String email) =>
      userRepository.createUser(name, email);

  Future<User> editUser(int id, String name, String email) =>
      userRepository.updateUser(id, name, email);

  Future<void> removeUser(int id) => userRepository.deleteUser(id);
}
