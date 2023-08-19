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
  String description;
  String fullPath;
  String imageUrl;
  String name;
  double price;
  String summary;

  ProductData({
    required this.description,
    required this.fullPath,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.summary,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        description: json["description"],
        fullPath: json["fullPath"],
        imageUrl: json["imageUrl"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "fullPath": fullPath,
        "imageUrl": imageUrl,
        "name": name,
        "price": price,
        "summary": summary,
      };
}
