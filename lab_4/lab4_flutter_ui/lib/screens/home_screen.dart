import 'package:flutter/material.dart';
import 'package:lab4_flutter_ui/screens/Exercise1.dart';
import 'package:lab4_flutter_ui/screens/Exercise2.dart';
import 'package:lab4_flutter_ui/screens/Exercise3.dart';
import 'package:lab4_flutter_ui/screens/Exercise4.dart';
import 'package:lab4_flutter_ui/screens/Exercise5.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 - Flutter UI Fundamentals'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _ExerciseTile(
              title: 'Exercise 1 - Core Widgets Demo',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Exercise1(),
                ),
              ),
          ),
          const SizedBox(height: 12),
          _ExerciseTile(
              title: 'Exercise 2 - Input Controls Demo',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Exercise2(),
                ),
              ),
          ),
          const SizedBox(height: 12),
          _ExerciseTile(
              title: 'Exercise 3 - Layout Demo',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Exercise3(),
                ),
              ),
          ),
          const SizedBox(height: 12),
          _ExerciseTile(
              title: 'Exercise 4 - App Structure & Theme',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Exercise4(),
                ),
              ),
          ),
          const SizedBox(height: 12),
          _ExerciseTile(
              title: 'Exercise 5 - Common UI Fixes',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Exercise5(),
                ),
              ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ExerciseTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}