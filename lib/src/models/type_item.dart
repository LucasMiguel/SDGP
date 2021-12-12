class TypeItem {
  int? id;
  String? description;
  int? status;

  TypeItem({this.id, this.description, this.status});

  factory TypeItem.fromJson(Map<String, dynamic> json) {
    return TypeItem(
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
