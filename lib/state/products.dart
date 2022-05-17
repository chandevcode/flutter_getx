import 'package:get/get.dart';

import 'dart:math';
import '../models/items.dart';

class Products extends GetxController {
  // all products
  // in production, these thins usually be loaded them from API or database or somethisng like that

  final RxList<Item> _items = List.generate(
      100,
      (index) => Item(
          id: index,
          name: 'Product $index',
          price: Random().nextDouble() * 100,
          inWishList: false.obs)).obs;

  //use this to retrieve all products
  List<Item> get items {
    return [..._items];
  }

  // this will return the products that were added to wish list
  List<Item> get wishListItems {
    return _items.where((item) => item.inWishList.value == true).toList();
  }

  // add an item to the wish list
  void addItem(int id) {
    final int index = _items.indexWhere((e) => e.id == id);
    _items[index].inWishList.value = true;
  }

  //Remove an item from wish list
  void removeItem(int id) {
    final int index = _items.indexWhere((e) => e.id == id);
    _items[index].inWishList.value = false;
  }

  //this will return the products that were added to wish list
}
