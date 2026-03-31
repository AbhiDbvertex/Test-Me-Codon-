import 'package:get/get_rx/src/rx_types/rx_types.dart';

class TopicModel {
  final String id;
  final String name;
  final String description;
  final int order;

  // final int videoCount;
  final List<ChapterModel> chapters;

  TopicModel({
    required this.id,
    required this.name,
    required this.description,
    required this.order,
    // required this.videoCount,
    required this.chapters,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      // Safe casting for int
      order: int.tryParse(json['order']?.toString() ?? '0') ?? 0,
      chapters: (json['chapters'] as List<dynamic>? ?? [])
          .map((e) => ChapterModel.fromJson(e))
          .toList(),
    );
  }
}

class ChapterModel {
  final String id;
  final String topicId;
  final String name;
  final int order;
  RxBool isBookMarked;
  Rx<String?> bookMarkedCategory;

  ChapterModel({
    required this.id,
    required this.topicId,
    required this.name,
    required this.order,
    bool isBookMarked = false,
    String? bookMarkedCategory,
  }) : isBookMarked = isBookMarked.obs,
       bookMarkedCategory = Rx<String?>(bookMarkedCategory);

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['_id']?.toString() ?? '',
      topicId: json['topicId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      order: int.tryParse(json['order']?.toString() ?? '0') ?? 0,
      isBookMarked: json['isBookMarked'] == true,
      bookMarkedCategory: json['bookMarkedCategory']?.toString(),
    );
  }
}
