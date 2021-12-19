import 'package:flutter/material.dart';

class ItemsModel extends ChangeNotifier {
  int? id;
  int? purchaseId;
  String? description;
  double? price;
  double? amount;
  int? typeItemId;
  String? nameTypeItem;
  int? typeAmount;
  int? status;

  ///Contrutor
  ItemsModel({
    this.id,
    this.purchaseId,
    this.description,
    this.price,
    this.amount,
    this.typeItemId,
    this.nameTypeItem,
    this.typeAmount,
    this.status,
  });

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      id: json['id'],
      purchaseId: json['purchase_id'],
      description: json['description'],
      price: json['price'],
      amount: json['amount'],
      typeItemId: json['type_id'],
      typeAmount: json['type_amount'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'purchase_id': purchaseId,
      'type_id': typeItemId,
      'description': description,
      'price': price,
      'amount': amount,
      'type_amount': typeAmount,
      'status': status,
    };
  }
}
