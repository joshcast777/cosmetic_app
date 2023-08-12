// To parse this JSON data, do
//
//     final customerBill = customerBillFromJson(jsonString);

// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

// Bill customerBillFromJson(String str) => Bill.fromJson(json.decode(str));

// String customerBillToJson(Bill data) => json.encode(data.toJson());

class Bill {
  final String _id;
  final BillData _data;

  Bill({
    required String id,
    required BillData data,
  })  : _data = data,
        _id = id;

  String get id => _id;

  BillData get data => _data;

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        data: BillData.fromJson(json["data"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "id": _id,
  //       "data": _data.toJson(),
  //     };
}

class BillData {
  final DateTime _date;
  final double _total;
  final List<CartItem> _cartItems;

  BillData({
    required DateTime date,
    required double total,
    required List<CartItem> cartItems,
  })  : _cartItems = cartItems,
        _total = total,
        _date = date;

  DateTime get date => _date;

  double get total => _total;

  List<CartItem> get cartItems => _cartItems;

  factory BillData.fromJson(Map<String, dynamic> json) => BillData(
        date: DateTime.parse(json["date"]),
        total: json["total"]?.toDouble(),
        cartItems: List<CartItem>.from(json["cart_items"].map((cartItem) => CartItem.fromJson(cartItem))),
      );

  // Map<String, dynamic> toJson() => {
  //       "date": _date.toIso8601String(),
  //       "total": _total,
  //       "products": List<dynamic>.from(_cartItems.map((product) => product.toJson())),
  //     };
  // Map<String, dynamic> toJson() => {
  //       "date": Timestamp.fromDate(_date),
  //       "total": _total,
  //       "products": List<dynamic>.from(_cartItems.map((cartItem) => cartItem.toJson())),
  //     };
}
