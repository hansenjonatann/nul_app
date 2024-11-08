import 'package:flutter/material.dart';
import 'package:nul_app/screen/activity_screen.dart';
import 'package:nul_app/screen/auth/login_screen.dart';
import 'package:nul_app/screen/auth/register_screen.dart';
import 'package:nul_app/screen/favorite_screen.dart';
import 'package:nul_app/screen/home_screen.dart';
import 'package:nul_app/screen/profile_screen.dart';
import 'package:nul_app/screen/splash_screen.dart';

class NullAppNavigation {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // register routes
  static Map<String , WidgetBuilder> routes = {
    SplashScreen.routeName: (context) => const SplashScreen(),
    LoginScreen.routeName: (context) => const LoginScreen(),
    RegisterScreen.routeName: (context) => const RegisterScreen(),
    HomeScreen.routeName: (context) => HomeScreen(),
    FavoriteScreen.routeName: (context) => const FavoriteScreen(),
    ProfileScreen.routeName: (context) => const ProfileScreen(),
    ActivityScreen.routeName: (context) =>  ActivityScreen()

  };

  void pushNamed (String routeName , {Object? arguments}) {
    navigatorKey.currentState!.pushNamed(routeName , arguments: arguments);
  }

  void pushReplacementNamed ( String routeName , {Object? arguments}) {
    navigatorKey.currentState!.pushReplacementNamed(routeName , arguments: arguments);
  }

  void push (Widget widget) {
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => widget));
  }

   void pop() {
    navigatorKey.currentState!.pop();
  }

  void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }
}