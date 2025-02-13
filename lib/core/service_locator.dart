import 'package:get_it/get_it.dart';
import '../data/repositories/user_repository.dart';
import '../presenters/home_presenter.dart';
import '../presenters/settings_presenter.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<UserRepository>(() => UserRepository());
  locator.registerFactory(() => HomePresenter(locator<UserRepository>()));
  locator.registerFactory(() => SettingsPresenter());
}