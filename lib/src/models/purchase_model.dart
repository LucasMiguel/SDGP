import 'package:flutter/material.dart';
import 'package:sdgp/src/models/iten_model.dart';

class PurchasesModel extends ChangeNotifier {
  int? id;
  String? description;
  double? totalPrice;
  String? dateCreation;
  int? type;
  List<ItensModel>? listItensModel;
  int? status;

  PurchasesModel(
      {this.id,
      this.description,
      this.totalPrice,
      this.dateCreation,
      this.type,
      this.listItensModel,
      this.status});

  factory PurchasesModel.fromJson(Map<String, dynamic> json) {
    return PurchasesModel(
      id: json['id'],
      description: json['description'],
      totalPrice: json['total_price'],
      dateCreation: json['date_creation'],
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'total_price': totalPrice,
      'date_creation': dateCreation,
      'type': type,
      'status': status,
    };
  }
}
