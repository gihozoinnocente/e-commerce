import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.total;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(product: product),
      );
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void updateQuantity(int productId, int quantity) {
    if (_items.containsKey(productId)) {
      if (quantity > 0) {
        _items.update(
          productId,
          (existingItem) => CartItem(
            product: existingItem.product,
            quantity: quantity,
          ),
        );
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}