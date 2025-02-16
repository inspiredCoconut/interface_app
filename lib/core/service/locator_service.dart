import 'package:get_it/get_it.dart';

import '../../data/repositories/user_repository.dart';
import '../../data/repositories/auth_repository.dart';

import '../../presenters/home_presenter.dart';
import '../../presenters/settings_presenter.dart';
import '../../presenters/user_presenter.dart';
import '../../presenters/auth_presenter.dart';

import 'auth_service.dart';

// Create a locator instance
final GetIt locator = GetIt.instance;

// Register the services and presenters with the locator service
void setupLocator() {
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<UserRepository>(() => UserRepository());
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository());
  locator.registerFactory(() => HomePresenter(locator<AuthService>()));
  locator.registerFactory(() => AuthPresenter(locator<AuthService>()));
  locator.registerFactory(() => SettingsPresenter(locator<AuthService>()));
  locator.registerFactory(() => UserPresenter(locator<UserRepository>()));
}
