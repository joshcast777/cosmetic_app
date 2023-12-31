import 'package:cosmetic_app/constants/models/model_constants.dart';
import 'package:cosmetic_app/preferences/preferences.dart';
import 'package:flutter/material.dart';

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

/// Clase que gestiona un estado global para el carrito de compras
class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = List.from(cartItemsConstant);
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

  /// Agrega un elemento al carrito
  void addToCart(Product product) {
    _cartItems.add(CartItem(
      amount: 1,
      product: product,
    ));

    _calculateTotal();
    notifyListeners();
  }

  /// Agrega una factura al cliente
  Future<void> addBillToUser() async {
    _isLoading = true;

    notifyListeners();

    final BillData billData = BillData(
      date: DateTime.now(),
      total: _total,
      cartItems: _cartItems,
    );

    final String? uid = Preferences.getItem<String>("uid");

    if (uid == null) return;

    ApiResponse<void> response = await _firestoreFirebase.firebaseAddBillToUser(uid, billData);

    if (!response.isSuccess && response.message.startsWith("Error")) {
      _message = response.message.split("/")[1];
      _isLoading = false;

      notifyListeners();
      return;
    }

    _message = response.message;
    _total = 0.0;
    _cartItems = List.from(cartItemsConstant);
    _isLoading = false;

    notifyListeners();
  }

  /// Disminuye la cantidad de un elemento del carrito de compras
  void decreaseAmount(CartItem cartItem) {
    final int index = _cartItems.indexOf(cartItem);

    _cartItems[index].amount--;

    _calculateTotal();
    notifyListeners();
  }

  /// Aumenta la cantidad de un elemento del carrito de compras
  void increaseAmount(CartItem cartItem) {
    final int index = _cartItems.indexOf(cartItem);

    _cartItems[index].amount++;

    _calculateTotal();
    notifyListeners();
  }

  /// Quita un elemento del carrito de compras
  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);

    _calculateTotal();
    notifyListeners();
  }

  /// Quita un elemento del carrito de compras basado en el producto
  void removeProductFromCart(Product product) => removeFromCart(_cartItems.firstWhere((CartItem cartItem) => cartItem.product == product));

  void _calculateTotal() => _total = _cartItems.isEmpty ? 0.0 : _cartItems.map((CartItem cartItem) => cartItem.amount * cartItem.product.data.price).reduce((double totalAcumulator, double subTotal) => totalAcumulator + subTotal);

  /// Limpia todo el estado global
  void clearAll() {
    _cartItems = List.from(cartItemsConstant);
    _isLoading = false;
    _message = "";
    _total = 0.0;

    notifyListeners();
  }
}
