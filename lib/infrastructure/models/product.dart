// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

// import 'dart:convert';

// Product productFromJson(String str) => Product.fromJson(json.decode(str));

// String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final String _id;
  final ProductData _data;

  Product({
    required String id,
    required ProductData data,
  })  : _data = data,
        _id = id;

  String get id => _id;

  ProductData get data => _data;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        data: ProductData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": _id,
        "data": _data.toJson(),
      };
}

class ProductData {
  final String _imageUrl;
  final String _name;
  final String _summary;
  final String _description;
  final double _price;

  ProductData({
    required String imageUrl,
    required String name,
    required String summary,
    required String description,
    required double price,
  })  : _imageUrl = imageUrl,
        _name = name,
        _summary = summary,
        _description = description,
        _price = price;

  String get imageUrl => _imageUrl;

  String get name => _name;

  String get summary => _summary;

  String get description => _description;

  double get price => _price;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        imageUrl: json["imageUrl"],
        name: json["name"],
        summary: json["summary"],
        description: json["description"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": _imageUrl,
        "name": _name,
        "summary": _summary,
        "description": _description,
        "price": _price,
      };
}
