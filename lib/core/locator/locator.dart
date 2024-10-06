import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_infinity_app/data/providers/appwrite_provider.dart';
import 'package:todo_infinity_app/data/services/storage_service.dart';

final locator = GetIt.I;

void setUpLocator() {
 
  locator.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );
 locator.registerLazySingleton<AppwriteProvider>(
    () => AppwriteProvider(),
  );
  locator.registerLazySingleton<StorageService>(
    () => StorageService(),
  );
}
