class TypeItemModel {
  int? id;
  String? description;
  int? status;

  TypeItemModel({this.id, this.description, this.status});

  factory TypeItemModel.fromJson(Map<String, dynamic> json) {
    return TypeItemModel(
      id: json['id'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'status': status,
    };
  }
}
