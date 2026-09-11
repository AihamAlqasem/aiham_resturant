import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../database/db_helper.dart';

class ItemProvider extends ChangeNotifier {
  List<ItemModel> _items = [];
  List<ItemModel>  items() => _items;

  final DBHelper _dbHelper = DBHelper();

  Future<void> getData() async {
    final db = await _dbHelper.database();
    final List<Map<String, dynamic>> maps = await db.query(DBHelper.tableName);
    _items = List.generate(maps.length, (i) => ItemModel.fromMap(maps[i]));
    
    notifyListeners(); 
  }

  Future<void> addItem(ItemModel item) async {
    await _dbHelper.insertItem(item);
    await getData();
  }

  Future<void> updateItem(ItemModel item) async {
    await _dbHelper.updateItem(item);
    await getData(); 
  }

  Future<void> deleteItem(int id) async {
    await _dbHelper.deleteItem(id);
    await getData(); 
  }
}