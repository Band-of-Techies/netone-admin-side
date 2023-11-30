import 'dart:async';

import 'package:netone_loanmanagement_admin/src/navigation/navigation_service.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  Future<void> setUp() async {
    GetIt.I.registerSingleton<NavigationService>(NavigationService()); //
  }
}
