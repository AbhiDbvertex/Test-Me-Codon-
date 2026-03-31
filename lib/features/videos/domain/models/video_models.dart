class VideoSubject {
  final String id;
  final String name;
  final num order;

  VideoSubject({required this.id, required this.name, required this.order});

  factory VideoSubject.fromJson(Map<String, dynamic> json) {
    return VideoSubject(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      order: json['order'] ?? 0,
    );
  }
}

class VideoSubSubject {
  final String id;
  final String name;
  final int videoCount;
  final num order;

  VideoSubSubject({
    required this.id,
    required this.name,
    required this.videoCount,
    required this.order,
  });

  factory VideoSubSubject.fromJson(Map<String, dynamic> json) {
    return VideoSubSubject(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      videoCount: json['videoCount'] ?? 0,
      order: json['order'] ?? 0,
    );
  }
}

class VideoChapter {
  final String id;
  final String topicId;
  final String name;
  final num order;

  VideoChapter({
    required this.id,
    required this.topicId,
    required this.name,
    required this.order,
  });

  factory VideoChapter.fromJson(Map<String, dynamic> json) {
    return VideoChapter(
      id: json['_id'] ?? '',
      topicId: json['topicId'] ?? '',
      name: json['name'] ?? '',
      order: json['order'] ?? 0,
    );
  }
}

class VideoTopic {
  final String id;
  final String name;
  final String description;
  final num order;
  final int videoCount;
  final List<VideoChapter> chapters;

  VideoTopic({
    required this.id,
    required this.name,
    required this.description,
    required this.order,
    required this.videoCount,
    required this.chapters,
  });

  factory VideoTopic.fromJson(Map<String, dynamic> json) {
    return VideoTopic(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      order: json['order'] ?? 0,
      videoCount: json['videoCount'] ?? 0,
      chapters: (json['chapters'] as List? ?? [])
          .map((chapter) => VideoChapter.fromJson(chapter))
          .toList(),
    );
  }
}

enum VideoStatus { none, paused, completed, unattended }

class VideoTopicModuleResponse {
  final bool success;
  final String topicName;
  final List<VideoTopicChapter> chapters;

  VideoTopicModuleResponse({
    required this.success,
    required this.topicName,
    required this.chapters,
  });

  factory VideoTopicModuleResponse.fromJson(Map<String, dynamic> json) {
    return VideoTopicModuleResponse(
      success: json['success'] ?? false,
      topicName: json['topicName'] ?? '',
      chapters: (json['data'] as List? ?? [])
          .map((item) => VideoTopicChapter.fromJson(item))
          .toList(),
    );
  }
}

class VideoTopicChapter {
  final String chapterId;
  final String chapterName;
  final List<VideoModule> videos;

  VideoTopicChapter({
    required this.chapterId,
    required this.chapterName,
    required this.videos,
  });

  factory VideoTopicChapter.fromJson(Map<String, dynamic> json) {
    return VideoTopicChapter(
      chapterId: json['chapterId'] ?? '',
      chapterName: json['chapterName'] ?? '',

      videos: (json['videos'] as List? ?? [])
          .map((v) => VideoModule.fromJson(v))
          .toList(),
    );
  }
}

class VideoModule {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final String? notesUrl;
  final String courseId;
  final String subjectId;
  final String subSubjectId;
  final String topicId;
  final String chapterId;
  final num order;
  final String status;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;
  final String statusTag;
  final num watchPercentage;
  final num lastWatchTime;
  final double? avgRating;
  final int totalReviews;

  VideoModule({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    this.notesUrl,
    required this.courseId,
    required this.subjectId,
    required this.subSubjectId,
    required this.topicId,
    required this.chapterId,
    required this.order,
    required this.status,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.statusTag,
    required this.watchPercentage,
    required this.lastWatchTime,
    this.avgRating,
    required this.totalReviews,
  });

  factory VideoModule.fromJson(Map<String, dynamic> json) {
    return VideoModule(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      notesUrl: json['notesUrl'],
      courseId: json['courseId'] is Map
          ? json['courseId']['_id']
          : json['courseId'] ?? '',
      subjectId: json['subjectId'] is Map
          ? json['subjectId']['_id']
          : json['subjectId'] ?? '',
      subSubjectId: json['subSubjectId'] is Map
          ? json['subSubjectId']['_id']
          : json['subSubjectId'] ?? '',
      topicId: json['topicId'] is Map
          ? json['topicId']['_id']
          : json['topicId'] ?? '',
      chapterId: json['chapterId'] is Map
          ? json['chapterId']['_id']
          : json['chapterId'] ?? '',
      order: json['order'] ?? 0,
      status: json['status'] ?? '',
      createdBy: json['createdBy'] ?? '',
      updatedBy: json['updatedBy'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      statusTag: json['statusTag'] ?? 'unattended',
      watchPercentage: json['watchPercentage'] ?? 0,
      lastWatchTime: json['lastWatchTime'] ?? 0,
      avgRating: json['avgRating'] != null
          ? (json['avgRating'] as num).toDouble()
          : null,
      totalReviews: json['totalReviews'] ?? 0,
    );
  }

  VideoStatus get uiStatus {
    switch (statusTag) {
      case 'watching':
        return VideoStatus.paused;
      case 'completed':
        return VideoStatus.completed;
      default:
        return VideoStatus.unattended;
    }
  }

  VideoModule copyWith({
    String? statusTag,
    num? watchPercentage,
    num? lastWatchTime,
  }) {
    return VideoModule(
      id: id,
      title: title,
      description: description,
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
      notesUrl: notesUrl,
      courseId: courseId,
      subjectId: subjectId,
      subSubjectId: subSubjectId,
      topicId: topicId,
      chapterId: chapterId,
      order: order,
      status: status,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      statusTag: statusTag ?? this.statusTag,
      watchPercentage: watchPercentage ?? this.watchPercentage,
      lastWatchTime: lastWatchTime ?? this.lastWatchTime,
      avgRating: avgRating,
      totalReviews: totalReviews,
    );
  }
}

class VideoProgressModel {
  final String id;
  final String userId;
  final String videoId;
  final String topicId;
  final int watchTime;
  final int totalDuration;
  final int percentage;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VideoProgressModel({
    required this.id,
    required this.userId,
    required this.videoId,
    required this.topicId,
    required this.watchTime,
    required this.totalDuration,
    required this.percentage,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory VideoProgressModel.fromJson(Map<String, dynamic> json) {
    return VideoProgressModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      videoId: json['videoId'] ?? '',
      topicId: json['topicId'] ?? '',
      watchTime: json['watchTime'] ?? 0,
      totalDuration: json['totalDuration'] ?? 0,
      percentage: json['percentage'] ?? 0,
      status: json['status'] ?? 'watching',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  static Map<String, dynamic> toRequestJson({
    required String videoId,
    required String topicId,
    required int watchTime,
    required int totalDuration,
  }) {
    return {
      "videoId": videoId,
      "topicId": topicId,
      "watchTime": watchTime,
      "totalDuration": totalDuration,
    };
  }
}
