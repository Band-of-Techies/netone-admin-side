import 'package:netone_loanmanagement_admin/src/pages/loginsection/confirm/confirm_page.dart';
import 'package:netone_loanmanagement_admin/src/pages/loginsection/login/log_in_page.dart';
import 'package:netone_loanmanagement_admin/src/pages/loginsection/recover/recover_page.dart';
import 'package:netone_loanmanagement_admin/src/pages/routes/routes.dart';
import 'package:netone_loanmanagement_admin/src/pages/loginsection/signup/sign_up_page.dart';
import 'package:flutter/material.dart';

import 'fade_route.dart';

var routes = (RouteSettings settings) {
  switch (settings.name) {
    case PageRoutes.login:
      return FadeRoute(
        page: const LoginPage(),
      );

    case PageRoutes.signup:
      return FadeRoute(
        page: const SignupPage(),
      );

    case PageRoutes.recover:
      return FadeRoute(
        page: const RecoverPage(),
      );

    case PageRoutes.confirm:
      return FadeRoute(
        page: const ConfirmPage(),
      );

    default:
      return FadeRoute(
        page: const Scaffold(
          body: Center(
            child: Text("404: Page Not Found"),
          ),
        ),
      );
  }
};
