class PurchasesModel {
  int? id;
  String? description;
  double? totalPrice;
  String? dateCreation;
  int? type;
  int? status;

  PurchasesModel(
      {this.id,
      this.description,
      this.totalPrice,
      this.dateCreation,
      this.type,
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
