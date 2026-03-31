class QTestChapterModel {
  final String chapterId;
  final String chapterName;
  final String chapterImage;
  final int totalMcq;
  final int attemptedMcq;
  final String status;
  final int rating;
  final int order;

  QTestChapterModel({
    required this.chapterId,
    required this.chapterName,
    required this.chapterImage,
    required this.totalMcq,
    required this.attemptedMcq,
    required this.status,
    required this.rating,
    required this.order,
  });

  factory QTestChapterModel.fromJson(Map<String, dynamic> json) {
    return QTestChapterModel(
      chapterId: json['chapterId'] ?? '',
      chapterName: json['chapterName'] ?? '',
      chapterImage: json['chapterImage'] ?? '',
      totalMcq: json['totalMcq'] ?? 0,
      attemptedMcq: json['attemptedMcq'] ?? 0,
      status: json['status'] ?? 'NOT_STARTED',
      rating: (json['rating'] ?? 0).toInt(),
      order: json['order'] ?? 0,
    );
  }
}
