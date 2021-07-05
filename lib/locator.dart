import 'package:get_it/get_it.dart';
import 'package:q8uc/core/api/auth_api.dart';
import 'package:q8uc/core/api/get_serial.dart';
import 'package:q8uc/core/api/items_api.dart';
import 'package:q8uc/core/view_models/items_vm.dart';
import 'package:q8uc/core/view_models/serial_vm.dart';
import 'package:q8uc/core/view_models/startup_vm.dart';
import 'package:q8uc/utils/dialog_service.dart';
import 'package:q8uc/utils/navigator.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/view_models/auth_vm.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());

  locator.registerFactory(() => StartUpViewModel());

  locator.registerLazySingleton(() => AuthApi());
  locator.registerFactory(() => AuthViewModel());

  // locator.registerLazySingleton(() => ChatApi());
  // locator.registerFactory(() => ChatViewModel());

  locator.registerLazySingleton(() => ItemsApi());
  locator.registerFactory(() => ItemsViewModel());

  locator.registerLazySingleton(() => SerialApi());
  locator.registerFactory(() => SerialViewModel());
}

final List<SingleChildWidget> allProviders = <SingleChildWidget>[
  ChangeNotifierProvider<ItemsViewModel>(create: (_) => ItemsViewModel())
];
