import 'package:flutter/material.dart';

import 'screens/posts_screen.dart';
import 'services/api_service.dart';

void main() => runApp(MyApp(api: ApiService()));

class MyApp extends StatelessWidget {
  final ApiService api;
  const MyApp({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 8',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: PostsScreen(api: api),
    );
  }
}