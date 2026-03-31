class Faculty {
  final String id;
  final String name;
  final String degree;
  final String description;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Faculty({
    required this.id,
    required this.name,
    required this.degree,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  /// JSON → Dart
  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      id: json['_id'],
      name: json['name'],
      degree: json['degree'],
      description: json['description'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  /// Dart → JSON (for POST / PUT)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'degree': degree,
      'description': description,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
