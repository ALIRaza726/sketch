import 'package:flutter/material.dart';

class ListProvider with ChangeNotifier {
   Map<String, String?> _selectedItems = {};


  Map<String, String?> get selectedItems => _selectedItems;

  void addvalue(String key, String? value) {
    _selectedItems[key] = value;
    notifyListeners();
  }

  void removevalue(String key) {
    _selectedItems.remove(key);
    notifyListeners();
  }
}