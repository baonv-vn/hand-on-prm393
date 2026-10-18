import 'package:flutter/material.dart';
import '../logic/advice.dart';

class AdviceCard extends StatelessWidget {
  final IconData icon;
  final Advice advice;
  const AdviceCard({super.key, required this.icon, required this.advice});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(advice.title),
        subtitle: Text(advice.detail),
      ),
    );
  }
}
