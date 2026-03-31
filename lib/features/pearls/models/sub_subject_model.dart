class SubSubjectModel {
  final String id;
  final String name;
  final int order;
  final String? image;
  final int videoCount;

  SubSubjectModel({
    required this.id,
    required this.name,
    required this.order,
    this.image,
    required this.videoCount,
  });

  factory SubSubjectModel.fromJson(Map<String, dynamic> json) {
    return SubSubjectModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      order: json['order'] as int,
      image: json['image'],
      videoCount: json['videoCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'order': order,
      'image': image,
      'VideoCount': videoCount,
    };
  }
}
