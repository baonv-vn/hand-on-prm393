import 'dart:math';

class Item {
  final int id;
  final String name;
  final String description;

  const Item({
    required this.id,
    required this.name,
    required this.description,
});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: (json['id'] as num).toInt(),
    name: (json['name'] as String?) ?? '',
    description: (json['description'] as String?) ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };

  Item copyWith({String? name, String? description}) => Item(
    id: id,
    name: name ?? this.name,
    description: description ?? this.description,
  );
}

int nextId(List<Item> items) =>
    items.isEmpty ? 1 : items.map((e) => e.id).reduce(max) + 1;

List<Item> filterItems(List<Item> items, String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return items;
  return items
      .where((i) =>
          i.name.toLowerCase().contains(q) ||
          i.description.toLowerCase().contains(q))
      .toList();
}