import 'package:flutter/material.dart';
import 'package:m03/pertemuan3/ShoppingList.dart';

class ListProductProvider extends ChangeNotifier {
  List<ShoppingList> _shoppingList = [];
  List<ShoppingList> get getShoppingList => _shoppingList;
  set setShoppingList(value) {
    _shoppingList = value;
    notifyListeners();
  }

  void deletedById(ShoppingList) {
    _shoppingList.remove(ShoppingList);
    notifyListeners();
  }
}
