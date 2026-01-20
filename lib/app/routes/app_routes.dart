import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_man/app/modules/home/view/home_view.dart';
import 'package:vehicle_man/app/modules/auth/login/view/login_view.dart';
import 'package:vehicle_man/app/modules/auth/register/view/register_view.dart';
import 'package:vehicle_man/app/modules/splash/view/splash_view.dart';
import 'package:vehicle_man/app/modules/weather/view/weather_view.dart';

class AppRoutes {
  static const String homeView = '/home_view';
  static const String loginView = '/login_view';
  static const String registerView = '/register_view';
  static const String splashView = '/splash_view';
  static const String weatherView = '/weather_view';
}

class AppPages {
  static GetPage<T> createPage<T>({
    required String name,
    required Widget page,
    // Bindings? binding,
  }) {
    return GetPage<T>(
      name: name,
      page: () => page,
      // binding: binding,
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  static List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    createPage(name: AppRoutes.homeView, page: HomeView()),
    createPage(name: AppRoutes.loginView, page: LoginView()),
    createPage(name: AppRoutes.registerView, page: RegisterView()),
    createPage(name: AppRoutes.splashView, page: SplashView()),
    createPage(name: AppRoutes.weatherView, page: WeatherView()),
  ];
}
