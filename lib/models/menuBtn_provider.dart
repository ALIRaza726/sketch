import 'package:flutter/material.dart';

class MenuButtonProvider with ChangeNotifier {
  final List<String> _selectmenuvalue = [];

  List<String> get valuelist => _selectmenuvalue;

  void addvalue(String value ){
    _selectmenuvalue.add(value);
    notifyListeners();
  }

  void removevalue(String path) {
    _selectmenuvalue.remove(path);
    notifyListeners();
  }
}