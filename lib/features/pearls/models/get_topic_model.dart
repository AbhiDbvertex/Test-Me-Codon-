import 'package:get/get.dart';

class GetTopicModel {
  final String id;
  final String name;
  final String description;
  final String codonId;
  final RxBool isBookMarked;
  final RxString bookMarkedCategory;

  GetTopicModel({
    required this.id,
    required this.name,
    required this.description,
    required this.codonId,
    required this.isBookMarked,
    required this.bookMarkedCategory,
  });

  factory GetTopicModel.fromJson(Map<String, dynamic> json) {
    return GetTopicModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      codonId: json['codonId']?.toString() ?? '',
      isBookMarked: (json['isBookmarked'] == true).obs,
      bookMarkedCategory: (json['bookmarkCategory']?.toString() ?? '').obs,
    );
  }
}
