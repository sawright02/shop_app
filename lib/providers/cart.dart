import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId].quantity > 1) {
      _items.update(productId, (existingCartItem) {
        return CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        );
      });
      notifyListeners();
    } else {
      removeItem(productId);
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void addItem({String productId, double price, String title}) {
    // if (_items.containsKey(productId)) {
    // change quantity
    _items.update(
      productId,
      (existingCartItem) => CartItem(
        id: existingCartItem.id,
        title: existingCartItem.title,
        price: existingCartItem.price,
        quantity: existingCartItem.quantity + 1,
      ),
      ifAbsent: () => CartItem(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        quantity: 1,
      ),
    );

    notifyListeners();
    // } else {
    //   _items.putIfAbsent(
    //     productId,
    //     () => CartItem(
    //       id: DateTime.now().toString(),
    //       title: title,
    //       price: price,
    //       quantity: 1,
    //     ),
    //   );
    // }
  }
}
