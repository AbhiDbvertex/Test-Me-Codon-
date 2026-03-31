class TopicDetailModel {
  final TopicInfo topic;
  final TopicHierarchy hierarchy;
  final TopicStats stats;

  TopicDetailModel({
    required this.topic,
    required this.hierarchy,
    required this.stats,
  });

  factory TopicDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return TopicDetailModel(
      topic: TopicInfo.fromJson(data['topic'] ?? {}),
      hierarchy: TopicHierarchy.fromJson(data['hierarchy'] ?? {}),
      stats: TopicStats.fromJson(data['stats'] ?? {}),
    );
  }
}

class TopicInfo {
  final String id;
  final String codonId;
  final String name;
  final String description;

  TopicInfo({
    required this.id,
    required this.codonId,
    required this.name,
    required this.description,
  });

  factory TopicInfo.fromJson(Map<String, dynamic> json) {
    return TopicInfo(
      id: json['id']?.toString() ?? '',
      codonId: json['codonId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }
}

class TopicHierarchy {
  final String subject;
  final String subjectId;
  final String subSubject;
  final String subSubjectId;
  final String chapter;
  final String chapterId;

  TopicHierarchy({
    required this.subject,
    required this.subjectId,
    required this.subSubject,
    required this.subSubjectId,
    required this.chapter,
    required this.chapterId,
  });

  factory TopicHierarchy.fromJson(Map<String, dynamic> json) {
    final subjectObj = json['subject'] as Map<String, dynamic>? ?? {};
    final subSubjectObj = json['subSubject'] as Map<String, dynamic>? ?? {};
    final chapterObj = json['chapter'] as Map<String, dynamic>? ?? {};

    return TopicHierarchy(
      subject: subjectObj['name']?.toString() ?? '',
      subjectId: subjectObj['_id']?.toString() ?? '',
      subSubject: subSubjectObj['name']?.toString() ?? '',
      subSubjectId: subSubjectObj['_id']?.toString() ?? '',
      chapter: chapterObj['name']?.toString() ?? '',
      chapterId: chapterObj['_id']?.toString() ?? '',
    );
  }
}

class TopicStats {
  final int chapters;
  final int videos;
  final int mcqs;
  final int notes;
  final int rating;
  final int reviews;

  TopicStats({
    required this.chapters,
    required this.videos,
    required this.mcqs,
    required this.notes,
    required this.rating,
    required this.reviews,
  });

  factory TopicStats.fromJson(Map<String, dynamic> json) {
    return TopicStats(
      chapters: json['chapters']?.toInt() ?? 0,
      videos: json['videos']?.toInt() ?? 0,
      mcqs: json['mcqs']?.toInt() ?? 0,
      notes: json['notes']?.toInt() ?? 0,
      rating: json['rating']?.toInt() ?? 0,
      reviews: json['reviews']?.toInt() ?? 0,
    );
  }
}
