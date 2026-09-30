import 'package:flutter/material.dart';
import 'package:lab4_flutter_ui/theme_notifier.dart';

class Exercise4 extends StatelessWidget {
  const Exercise4({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkNotifier,
      builder: (context, isDark, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Exercise 4 - App Structure & Theme'),
            actions: [
              const Text('Dark'),
              Switch(
                value: isDark,
                onChanged: (value) => isDarkNotifier.value = value,
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: const Center(
            child: Text('This is a simple screen with theme toggle.'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('FAB pressed'))),
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}