import 'package:flutter/material.dart';

class MenuButtonProvider with ChangeNotifier {
   String _selectmenuvalue='';

  String get valuelist => _selectmenuvalue;

  void addvalue(String value ){
    _selectmenuvalue= value;
    notifyListeners();
  }

  void removevalue(String path) {
    _selectmenuvalue=path;
    notifyListeners();
  }
}