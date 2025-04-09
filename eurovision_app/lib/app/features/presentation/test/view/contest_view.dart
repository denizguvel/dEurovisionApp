import 'package:eurovision_app/app/features/presentation/test/provider/contest_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContestView extends StatefulWidget {
  const ContestView({super.key});

  @override
  State<ContestView> createState() => _ContestViewState();
}

class _ContestViewState extends State<ContestView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
    Provider.of<ContestProvider>(context, listen: false).fetchContests());
  }

  @override
  Widget build(BuildContext context) {
    final contestProvider = Provider.of<ContestProvider>(context);
    return  Scaffold(
      appBar: AppBar(title: Text('Contests')),
      body: Column(
        children: [
          Container(
            height: 600,
            child: contestProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : contestProvider.errorMessage != null
            ? Center(child: Text(contestProvider.errorMessage!))
            : ListView.builder(
              itemCount: contestProvider.contests.length,
              itemBuilder: (context, index) {
                final contest = contestProvider.contests[index];
                return ListTile(
                  leading: Image.network(contest.logoUrl),
                  title: Text('${contest.year} - ${contest.city}'),
                  subtitle: Text(contest.arena),
                );
              },
            )
          ),
        ],
      )
    );
  }
}