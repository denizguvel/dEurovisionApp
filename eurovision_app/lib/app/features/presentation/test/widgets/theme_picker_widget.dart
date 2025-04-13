import 'package:eurovision_app/app/features/presentation/test/provider/frame_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePickerBottomSheet extends StatelessWidget {
  const ThemePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<FrameThemeProvider>();

    return SizedBox(
      height: 200,
      child: Column(
        children: [
          ListTile(
            title: const Text("Light Theme"),
            onTap: () {
              themeProvider.setTheme(Colors.white, const TextStyle(fontSize: 18, color: Colors.black));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Dark Theme"),
            onTap: () {
              themeProvider.setTheme(Colors.black, const TextStyle(fontSize: 18, color: Colors.white));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Colorful Theme"),
            onTap: () {
              themeProvider.setTheme(Colors.deepPurple.shade100, const TextStyle(fontSize: 18, color: Colors.indigo));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}