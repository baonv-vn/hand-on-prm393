import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import '../models/item.dart';

class JsonStorageService {
  JsonStorageService({required this.fileName, this.seedAsset});

  final String fileName;

  final String? seedAsset;

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$fileName');
  }

  Future<String> filePath() async => (await _file()).path;

  List<Item> _parse(String raw) {
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Item>> readItems() async {
    final file = await _file();

    if (!await file.exists()) {
      if (seedAsset != null) {
        try {
          final raw = await rootBundle.loadString(seedAsset!);
          final items = _parse(raw);
          await writeItems(items);
          return items;
        } catch (_) {

        }
      }
      await file.writeAsString('[]');
      return [];
    }

    final raw = await file.readAsString();
    if (raw.trim().isEmpty) return [];
    try {
      return _parse(raw);
    } on FormatException {
      return [];
    } on TypeError {
      return [];
    }
  }

  Future<void> writeItems(List<Item> items) async {
    final file = await _file();
    final raw = jsonEncode(items.map((e) => e.toJson()).toList());
    await file.writeAsString(raw);
  }
}
