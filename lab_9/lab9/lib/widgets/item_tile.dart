import 'package:flutter/material.dart';

import '../models/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ItemTile({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text('${item.id}')),
      title: Text(item.name),
      subtitle: item.description.isEmpty ? null : Text(item.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Sửa',
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Xóa',
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}