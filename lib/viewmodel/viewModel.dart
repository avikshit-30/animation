import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:animation/models/model.dart';

class ItemsViewModel extends ChangeNotifier {
  final List<Item> _items = [
    //can use API also here
    Item(id: 1, name: "Item 1", price: 10.0),
    Item(id: 2, name: "Item 2", price: 20.0),
    Item(id: 3, name: "Item 3", price: 30.0),
    Item(id: 4, name: "Item 4", price: 40.0),
    Item(id: 5, name: "Item 5", price: 50.0),
    Item(id: 6, name: "Item 6", price: 60.0),
    Item(id: 7, name: "Item 7", price: 70.0),
    Item(id: 8, name: "Item 8", price: 80.0),
    Item(id: 9, name: "Item 9", price: 90.0),
    Item(id: 10, name: "Item 10", price: 100.0),
    Item(id: 11, name: "Item 11", price: 110.0),
    Item(id: 12, name: "Item 12", price: 120.0),
    Item(id: 13, name: "Item 13", price: 130.0),
  ];

  List<Item> get items => _items;

  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Item item) {
    final index =
        _cartItems.indexWhere((cartItem) => cartItem.item.id == item.id);
    if (index == -1) {
      _cartItems.add(CartItem(item: item));
    } else {
      _cartItems[index].quantity++;
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  double get totalPrice => _cartItems.fold(
      0.0,
      (previousValue, cartItem) =>
          previousValue + cartItem.item.price * cartItem.quantity);
}
