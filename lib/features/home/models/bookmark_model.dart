// class BookmarkResponse {
//   final bool success;
//   final int count;
//   final List<BookmarkModel> data;
//
//   BookmarkResponse({
//     required this.success,
//     required this.count,
//     required this.data,
//   });
//
//   factory BookmarkResponse.fromJson(Map<String, dynamic> json) {
//     return BookmarkResponse(
//       success: json['success'] ?? false,
//       count: json['count'] ?? 0,
//       data:
//           (json['data'] as List?)
//               ?.map((e) => BookmarkModel.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }
// }
//
// class BookmarkModel {
//   final String id;
//   final String userId;
//   final String type;
//   final String category;
//
//   final BaseIdModel? chapter;
//   final BaseIdModel? topic;
//   final BaseIdModel? subSubject;
//   final BaseIdModel? mcq;
//
//   final String createdAt;
//   final String updatedAt;
//
//   BookmarkModel({
//     required this.id,
//     required this.userId,
//     required this.type,
//     required this.category,
//     this.chapter,
//     this.topic,
//     this.subSubject,
//     this.mcq,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory BookmarkModel.fromJson(Map<String, dynamic> json) {
//     final type = json['type'] ?? '';
//     final itemData = json['itemData'];
//
//     return BookmarkModel(
//       id: json['_id'] ?? '',
//       userId: json['userId'] ?? '',
//       type: type,
//       category: json['category'] ?? '',
//       chapter: type == 'chapter' && itemData != null
//           ? BaseIdModel.fromJson(itemData)
//           : null,
//       topic: type == 'topic' && itemData != null
//           ? BaseIdModel.fromJson(itemData)
//           : null,
//       subSubject: type == 'subSubject' && itemData != null
//           ? BaseIdModel.fromJson(itemData)
//           : null,
//       mcq: type == 'mcq' && itemData != null
//           ? BaseIdModel.fromJson(itemData)
//           : null,
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//     );
//   }
// }
//
// class BaseIdModel {
//   final String id;
//   final String? name;
//
//   BaseIdModel({required this.id, this.name});
//
//   factory BaseIdModel.fromJson(dynamic json) {
//     if (json == null) return BaseIdModel(id: '');
//
//     if (json is String) {
//       return BaseIdModel(id: json);
//     }
//
//     return BaseIdModel(id: json['_id'] ?? '', name: json['name']);
//   }
// }

class BookmarkResponse {
  final bool success;
  final int count;
  final List<BookmarkModel> data;

  BookmarkResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  factory BookmarkResponse.fromJson(Map<String, dynamic> json) {
    return BookmarkResponse(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List?)
          ?.map((e) => BookmarkModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class BookmarkModel {
  final String id;
  final String userId;
  final String itemId;
  final String chapterId;
  final String type;
  final String category;

  final BaseIdModel? chapter;
  final BaseIdModel? topic;
  final BaseIdModel? subSubject;
  final McqModel? mcq;

  final String createdAt;
  final String updatedAt;

  BookmarkModel({
    required this.id,
    required this.userId,
    required this.itemId,
    required this.chapterId,
    required this.type,
    required this.category,
    this.chapter,
    this.topic,
    this.subSubject,
    this.mcq,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    final itemData = json['itemData'];

    return BookmarkModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      chapterId: json['chapterId'] ?? '',
      type: type ?? '',
      category: json['category'] ?? '',
      chapter: type == 'chapter' && itemData != null
          ? BaseIdModel.fromJson(itemData)
          : null,
      topic: type == 'topic' && itemData != null
          ? BaseIdModel.fromJson(itemData)
          : null,
      subSubject: type == 'subSubject' && itemData != null
          ? BaseIdModel.fromJson(itemData)
          : null,
      mcq: type == 'mcq' && itemData != null
          ? McqModel.fromJson(itemData)
          : null,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      itemId: json['itemId'] ?? '',
    );
  }
}

class BaseIdModel {
  final String id;
  final String? name;
  final String? description;
  final String? image;

  BaseIdModel({
    required this.id,
    this.name,
    this.description,
    this.image,
  });

  factory BaseIdModel.fromJson(Map<String, dynamic> json) {
    return BaseIdModel(
      id: json['_id'] ?? '',
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}

class McqModel {
  final String id;
  final String name;
  final List<OptionModel> options;
  final List images;
  final String difficulty;

  McqModel({
    required this.id,
    required this.name,
    required this.options,
    required this.images,
    required this.difficulty,
  });

  factory McqModel.fromJson(Map<String, dynamic> json) {
    return McqModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      images: json['images'] ?? [],
      difficulty: json['difficulty'] ?? '',
      options: (json['options'] as List?)
          ?.map((e) => OptionModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class OptionModel {
  final String id;
  final String text;
  final String? image;

  OptionModel({
    required this.id,
    required this.text,
    this.image,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['_id'] ?? '',
      text: json['text'] ?? '',
      image: json['image'],
    );
  }
}