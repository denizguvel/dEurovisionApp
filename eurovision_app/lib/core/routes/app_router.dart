import 'package:eurovision_app/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:eurovision_app/app/features/presentation/feature/view/main_scaffold.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/view/my_top_ten_view.dart.dart';
import 'package:eurovision_app/app/features/presentation/home/view/home_view.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/view/winner_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const MainScaffold()
        );
      case RouteNames.winner:
        return MaterialPageRoute(
            builder: (_) => const WinnerView()
        );
      // case RouteNames.contestantDetail:
      //   return MaterialPageRoute(
      //       builder: (_) => const ContestantDetailView()
      //   );
      case RouteNames.contest:
        return MaterialPageRoute(
            builder: (_) => MyTop10View()
        );
      case RouteNames.home:
        return MaterialPageRoute(
            builder: (_) => const HomeView()
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Error: Route not found')),
          ),
        );
    }
  }
}