import 'package:get/get.dart';

class GetChaptersChapterModel {
  final String id;
  final String name;
  final int totalTopicsCount;
  final RxBool isBookMarked;
  final Rx<String?> bookMarkedCategory;

  GetChaptersChapterModel({
    required this.id,
    required this.name,
    required this.totalTopicsCount,
    bool isBookMarked = false,
    String? bookMarkedCategory,
  }) : isBookMarked = isBookMarked.obs,
       bookMarkedCategory = Rx<String?>(bookMarkedCategory);

  factory GetChaptersChapterModel.fromJson(Map<String, dynamic> json) {
    return GetChaptersChapterModel(
      id: json['chapterId']?.toString() ?? '',
      name: json['chapterName']?.toString() ?? '',
      totalTopicsCount: json['totalTopicsCount']?.toInt() ?? 0,
      isBookMarked: json['isBookmarked'] == true,
      bookMarkedCategory: json['bookmarkCategory']?.toString(),
    );
  }
}
