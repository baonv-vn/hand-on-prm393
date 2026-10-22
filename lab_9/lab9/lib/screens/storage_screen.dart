import 'package:flutter/material.dart';

import '../models/item.dart';
import '../services/json_storage_service.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final _storage = JsonStorageService(fileName: 'saved_items.json');
  final _controller = TextEditingController();
  List<Item> _items = [];
  bool _loading = true;
  bool _dirty = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final items = await _storage.readItems();
      if (!mounted) return;
      setState(() {
        _items = items;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  void _add() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _items.add(Item(id: nextId(_items), name: text, description: ''));
      _controller.clear();
      _dirty = true;
    });
  }

  Future<void> _save() async {
    String message;
    try {
      await _storage.writeItems(_items);
      message = 'Đã lưu ${_items.length} mục';
      _dirty = false;
    } catch (e) {
      message = 'Lưu thất bại: $e';
    }
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9.2 – Lưu & Đọc JSON'),
        actions: [
          IconButton(
            icon: Icon(_dirty ? Icons.save : Icons.save_outlined),
            tooltip: 'Lưu',
            onPressed: _save,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Tên mục mới',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _add, child: const Text('Thêm')),
              ],
            ),
          ),
          if (_dirty)
            const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text('Có thay đổi chưa lưu – bấm biểu tượng Lưu',
                  style: TextStyle(color: Colors.orange)),
            ),
          Expanded(
            child: _items.isEmpty
                ? const Center(child: Text('Chưa có mục nào'))
                : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, i) => ListTile(
                leading:
                CircleAvatar(child: Text('${_items[i].id}')),
                title: Text(_items[i].name),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
