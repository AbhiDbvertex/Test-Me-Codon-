class ChapterDetailModel {
  final String id;
  final String subSubjectId;
  final String name;
  final String description;
  final String image;
  final int targetMcqs;
  final List<ChapterVideo> videos;
  final int totalVideos;

  ChapterDetailModel({
    required this.id,
    required this.subSubjectId,
    required this.name,
    required this.description,
    required this.image,
    required this.targetMcqs,
    required this.videos,
    required this.totalVideos,
  });

  factory ChapterDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final content = data['content'] ?? {};
    return ChapterDetailModel(
      id: data['_id'] ?? '',
      subSubjectId: data['subSubjectId'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      targetMcqs: data['targetMcqs'] ?? 0,
      videos: (content['videos'] as List? ?? [])
          .map((v) => ChapterVideo.fromJson(v))
          .toList(),
      totalVideos: content['totalVideos'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'subSubjectId': subSubjectId,
      'name': name,
      'description': description,
      'image': image,
      'targetMcqs': targetMcqs,
      'content': {
        'videos': videos.map((v) => v.toJson()).toList(),
        'totalVideos': totalVideos,
      },
    };
  }
}

class ChapterVideo {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final String notesUrl;

  ChapterVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.notesUrl,
  });

  factory ChapterVideo.fromJson(Map<String, dynamic> json) {
    return ChapterVideo(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      notesUrl: json['notesUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'notesUrl': notesUrl,
    };
  }
}
