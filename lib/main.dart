import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/navigation/navigation_service.dart';
import 'src/pages/loginsection/login/log_in_page.dart';
import 'src/pages/dashboard/dashboard.dart';
import 'src/pages/routes/routes.dart';
import 'src/res/font_family.dart';
import 'src/di/service_locator.dart';

void main() async {
  await ServiceLocator().setUp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wons',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: FontFamily.dmSans),
      navigatorKey: GetIt.I.get<NavigationService>().navigatorKey,
      home: FutureBuilder<bool>(
        future: checkUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return DashboardScreen();
            } else {
              return DashboardScreen();
            }
          } else {
            // You can return a loading indicator if needed
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<bool> checkUserLoggedIn() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final email = sharedPreferences.getString('email');

    // Check if both token and email exist
    return (token != null && email != null);
  }
}
