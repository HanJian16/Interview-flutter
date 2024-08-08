import 'package:flutter/material.dart';

class ListProvider with ChangeNotifier {
  List<Map> list = [];
  
  void addItem(Map item) {
    list.add(item);
    notifyListeners();
  }
}