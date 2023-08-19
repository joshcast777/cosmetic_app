import 'package:cosmetic_app/constants/models/model_constants.dart';
import 'package:flutter/material.dart';

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = cartItemsConstant;
  bool _isLoading = false;
  String _message = "";
  double _total = 0.0;

  final BillsFirestore _firestoreFirebase = BillsFirestore();

  List<CartItem> get cartItems => _cartItems;

  bool get isLoading => _isLoading;

  String get message => _message;

  set message(String newMessage) {
    _message = newMessage;

    notifyListeners();
  }

  double get total => _total;

  void addToCart(Product product) {
    _cartItems.add(CartItem(
      amount: 1,
      product: product,
    ));

    _calculateTotal();
    notifyListeners();
  }

  void addBillToUser() async {
    _isLoading = true;

    notifyListeners();

    final BillData billData = BillData(
      date: DateTime.now(),
      total: _total,
      cartItems: _cartItems,
    );

    ApiResponse<void> response = await _firestoreFirebase.firebaseAddBillToUser("ESqSO8PyAAWgmLCYSZUzNzzbM8L2", billData);

    if (!response.isSuccess && response.message.startsWith("Error")) {
      _message = response.message.split("/")[1];
      _isLoading = false;

      notifyListeners();
      return;
    }

    _message = response.message.split("/")[1];
    _total = 0.0;
    _cartItems = cartItemsConstant;
    _isLoading = false;

    notifyListeners();
  }

  void decreaseAmount(CartItem cartItem) {
    final int index = _cartItems.indexOf(cartItem);

    _cartItems[index].amount--;

    _calculateTotal();
    notifyListeners();
  }

  void increaseAmount(CartItem cartItem) {
    final int index = _cartItems.indexOf(cartItem);

    _cartItems[index].amount++;

    _calculateTotal();
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);

    _calculateTotal();
    notifyListeners();
  }

  void removeProductFromCart(Product product) => removeFromCart(_cartItems.firstWhere((CartItem cartItem) => cartItem.product == product));

  void _calculateTotal() => _total = _cartItems.isEmpty ? 0.0 : _cartItems.map((CartItem cartItem) => cartItem.amount * cartItem.product.data.price).reduce((double totalAcumulator, double subTotal) => totalAcumulator + subTotal);

  void clearAll() {
    _cartItems = cartItemsConstant;
    _isLoading = false;
    _message = "";
    _total = 0.0;
  }
}
