import 'package:chargeover/screens/widgets/splash_screen.dart';
import 'package:get/get.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import 'app_pages.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: AppPages.loginScreen, page: () => const LoginScreen()),
    GetPage(name: AppPages.signupScreen, page: () => const SignupScreen()),
    GetPage(name: AppPages.home, page: () => const HomeScreen()),
    GetPage(name: AppPages.splashScreen, page: () => const SplashScreen()),
  ];
}
