import 'package:flutter/material.dart';
import 'package:jsshop/productprovider.dart';

class CartProvider with ChangeNotifier {
  List<Product> _cartItems = [];
  List<Product> placedOrders = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    if (!_cartItems.any((item) => item.id == product.id)) {
      _cartItems.add(product);
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void placeOrder(List<Product> items) {
    placedOrders.addAll(items);
    cartItems.clear();
    notifyListeners();
  }
}
