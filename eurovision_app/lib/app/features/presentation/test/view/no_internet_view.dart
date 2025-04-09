import 'package:eurovision_app/app/features/presentation/test/provider/network_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cat Gallery')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.signal_wifi_connected_no_internet_4_rounded, size: 40, color: Colors.grey,),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<NetworkProvider>().checkConnectionManually();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
        // child: Text(
        //   'No Internet Connection',
        //   style: TextStyle(fontSize: 20, color: Colors.red),
        // ),
        
      ),
    );
  }
}