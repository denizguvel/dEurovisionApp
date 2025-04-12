import 'package:eurovision_app/app/features/presentation/test/view/contestant_detail_view.dart';
import 'package:eurovision_app/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:eurovision_app/app/features/presentation/test/view/main_scaffold.dart';
import 'package:eurovision_app/app/features/presentation/test/view/cat_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/contest_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/home_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/winner_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const MainScaffold()
        );
      case RouteNames.cat:
        return MaterialPageRoute(
            builder: (_) => CatView()
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
            builder: (_) => const ContestView()
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