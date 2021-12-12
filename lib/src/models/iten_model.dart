import 'package:flutter/material.dart';

class ItensModel extends ChangeNotifier {
  int? id;
  int? purchaseId;
  String? description;
  double? price;
  double? amount;
  int? typeItemId;
  int? status;

  ///Contrutor
  ItensModel({
    this.id,
    this.purchaseId,
    this.description,
    this.price,
    this.amount,
    this.typeItemId,
    this.status,
  });

  factory ItensModel.fromJson(Map<String, dynamic> json) {
    return ItensModel(
      id: json['id'],
      purchaseId: json['purchase_id'],
      description: json['description'],
      price: json['price'],
      amount: json['amount'],
      typeItemId: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'purchase_id': purchaseId,
      'description': description,
      'price': price,
      'amount': amount,
      'type': typeItemId,
      'status': status,
    };
  }
}
