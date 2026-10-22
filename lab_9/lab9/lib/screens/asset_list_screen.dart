import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/item.dart';

class AssetListScreen extends StatefulWidget {
  const AssetListScreen({super.key});

  @override
  State<AssetListScreen> createState() => _AssetListScreenState();
}

class _AssetListScreenState extends State<AssetListScreen> {
  List<Item> _items = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final raw = await rootBundle.loadString('assets/data/items.json');
      final decoded = jsonDecode(raw) as List<dynamic>;
      final items = decoded
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList();
      if (!mounted) return;
      setState(() {
        _items = items;
        _error = null;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Không đọc được dữ liệu: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(_error!, textAlign: TextAlign.center),
        ),
      );
    } else if (_items.isEmpty) {
      body = const Center(child: Text('Không có dữ liệu.'));
    } else {
      body = ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            leading: CircleAvatar(child: Text('${item.id}')),
            title: Text(item.name),
            subtitle: Text(item.description),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 9.1 - Đọc JSON từ Assets')),
      body: body,
    );
  }
}