import 'package:change_notifier_demo/model/item_model.dart';
import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  final List<ItemModel> _items = [];

  int get itemCount => _items.length;

  List<ItemModel> get items => _items;

  void add(ItemModel item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(ItemModel item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
