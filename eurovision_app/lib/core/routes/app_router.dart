import 'package:eurovision_app/app/features/presentation/test/view/bottom_nav_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/cat_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/contest_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/home_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/test_view.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.cat:
        return MaterialPageRoute(builder: (_) => CatView());
      case RouteNames.test:
        return MaterialPageRoute(builder: (_) => const TestView());
      case RouteNames.contest:
        return MaterialPageRoute(builder: (_) => const ContestView());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case RouteNames.bottomnav:
        return MaterialPageRoute(builder: (_) => BottomNavigationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
