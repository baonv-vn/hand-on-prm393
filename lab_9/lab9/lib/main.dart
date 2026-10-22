import 'package:flutter/material.dart';

import 'screens/asset_list_screen.dart';
import 'screens/crud_screen.dart';
import 'screens/storage_screen.dart';

void main() => runApp(const Lab9App());

class Lab9App extends StatelessWidget {
  const Lab9App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 9',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void open(Widget screen) => Navigator.push(
        context, MaterialPageRoute(builder: (_) => screen));

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 9 – Local JSON Storage')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Lab 9.1 – Đọc JSON từ Assets'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => open(const AssetListScreen()),
          ),
          ListTile(
            title: const Text('Lab 9.2 – Lưu & Đọc JSON'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => open(const StorageScreen()),
          ),
          ListTile(
            title: const Text('Lab 9.3 – JSON CRUD + Search'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => open(const CrudScreen()),
          ),
        ],
      ),
    );
  }
}