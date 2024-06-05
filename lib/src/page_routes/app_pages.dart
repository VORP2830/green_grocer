import 'package:get/get.dart';
import 'package:green_grocer/src/pages/auth/sign_in_page.dart';
import 'package:green_grocer/src/pages/auth/sign_up_page.dart';
import 'package:green_grocer/src/pages/base/base_page.dart';
import 'package:green_grocer/src/pages/splash/splash_page.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => const SplashPage(),
      name: PagesRoutes.splashRoute,

    ),
    GetPage(
      page: () => SignInPage(),
      name: PagesRoutes.signInRoute,
    ),
    GetPage(
      page: () => SignUpPage(),
      name: PagesRoutes.signUpRoute,
    ),
    GetPage(
      page: () => const BasePage(),
      name: PagesRoutes.baseRoute,
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = '/splash';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String baseRoute = '/';
}