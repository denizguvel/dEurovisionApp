import 'package:eurovision_app/app/features/presentation/test/provider/test_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/view/test_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<TestProvider>(context, listen: false).getAllTests();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const TestView()),
        (_) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder(),
    );
  }
}


