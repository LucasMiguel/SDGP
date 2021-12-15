import 'package:flutter/material.dart';
import 'package:sdgp/src/models/m_item.dart';

class PurchasesModel extends ChangeNotifier {
  int? id;
  String? description;
  double? totalPrice;
  String? dateCreation;
  int? type;
  List<ItemsModel>? listItensModel;
  int? status;
  bool save = false;

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

  void refreshPrice() {
    totalPrice = 0.00;
    for (var item in listItensModel!) {
      if (item.status == 1) {
        totalPrice = totalPrice! + (item.price! * item.amount!);
      }
    }
    notifyListeners();
  }

  ///Fuction if add new item
  void addNewItem({required ItemsModel itemModel}) {
    listItensModel!.add(itemModel);
    refreshPrice();
  }

  void changeStatusItem(bool value, int index) {
    if (value) {
      listItensModel![index].status = 1;
      totalPrice = totalPrice! +
          (listItensModel![index].price! * listItensModel![index].amount!);
    } else {
      listItensModel![index].status = 0;
      totalPrice = totalPrice! -
          (listItensModel![index].price! * listItensModel![index].amount!);
    }
    refreshPrice();
  }

  void refreshWindow() {
    //Change controller
    save = false;
    notifyListeners();
  }
}
