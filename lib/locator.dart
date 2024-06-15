import 'package:get_it/get_it.dart';
import 'package:reminder_app/form_data.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FormData());
}
