import 'package:flutter/material.dart';

import '../models/item.dart';
import '../services/json_storage_service.dart';
import '../widgets/item_tile.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final _storage = JsonStorageService(
    fileName: 'crud_items.json',
    seedAsset: 'assets/data/items.json',
  );
  List<Item> _items = [];
  String _query = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
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

  Future<void> _persist(String successMessage) async {
    String message;
    try {
      await _storage.writeItems(_items);
      message = successMessage;
    } catch (e) {
      message = 'Lưu thất bại: $e';
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showItemDialog({Item? existing}) async {
    String name = existing?.name ?? '';
    String desc = existing?.description ?? '';

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing == null ? 'Thêm mục' : 'Sửa mục'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: name,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Tên'),
              onChanged: (v) => name = v,
            ),
            TextFormField(
              initialValue: desc,
              decoration: const InputDecoration(labelText: 'Mô tả'),
              onChanged: (v) => desc = v,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Hủy')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Lưu')),
        ],
      ),
    );

    if (!mounted) return;
    if (ok != true || name.trim().isEmpty) return;

    final isAdd = existing == null;
    setState(() {
      if (isAdd) {
        _items.add(Item(
            id: nextId(_items),
            name: name.trim(),
            description: desc.trim()));
      } else {
        final idx = _items.indexWhere((i) => i.id == existing.id);
        if (idx != -1) {
          _items[idx] =
              existing.copyWith(name: name.trim(), description: desc.trim());
        }
      }
    });
    await _persist(isAdd ? 'Đã thêm mục' : 'Đã cập nhật mục');
  }

  Future<void> _delete(Item item) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa mục?'),
        content: Text('Bạn có chắc muốn xóa "${item.name}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Hủy')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Xóa')),
        ],
      ),
    );
    if (!mounted) return;
    if (ok != true) return;

    setState(() => _items.removeWhere((i) => i.id == item.id));
    await _persist('Đã xóa "${item.name}"');
  }

  @override
  Widget build(BuildContext context) {
    final visible = filterItems(_items, _query);

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 9.3 – JSON CRUD')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemDialog(),
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Tìm theo tên hoặc mô tả',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _load,
                  child: visible.isEmpty
                      ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 120),
                      Center(
                        child: Text(_items.isEmpty
                            ? 'Chưa có dữ liệu. Bấm + để thêm.'
                            : 'Không tìm thấy kết quả.'),
                      ),
                    ],
                  )
                      : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: visible.length,
                    itemBuilder: (context, i) {
                      final item = visible[i];
                      return ItemTile(
                        item: item,
                        onEdit: () => _showItemDialog(existing: item),
                        onDelete: () => _delete(item),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
