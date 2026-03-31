class CustomTestTagModel {
  final String id;
  final String name;

  CustomTestTagModel({required this.id, required this.name});

  factory CustomTestTagModel.fromJson(Map<String, dynamic> json) {
    return CustomTestTagModel(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name};
  }
}
