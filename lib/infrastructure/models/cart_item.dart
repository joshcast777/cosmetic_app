import 'package:cosmetic_app/infrastructure/models/index.dart';

/// Modelo de lo artículos del carrito de compras
class CartItem {
  int amount;

  final Product product;

  CartItem({
    required this.amount,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        amount: json["amount"],
        product: Product.fromJson(json["product"]),
      );
}
