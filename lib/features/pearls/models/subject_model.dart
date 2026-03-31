class SubjectModel {
  final String id;
  final String name;
  final int order;
  final String? image;

  SubjectModel({
    required this.id,
    required this.name,
    required this.order,
    this.image,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      order: json['order'] ?? 0,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'order': order, 'image': image};
  }
}
