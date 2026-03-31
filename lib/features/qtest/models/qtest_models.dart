class Subject {
  final String name;
  final String modulesCount;
  Subject({required this.name, required this.modulesCount});
}

class SubSubject {
  final String name;
  final String modulesCount;
  SubSubject({required this.name, required this.modulesCount});
}

class Topic {
  final String name;
  final String modulesCount;
  Topic({required this.name, required this.modulesCount});
}

class Module {
  final String name;
  final String mcqsCount;
  final double rating;
  final String status; // 'All', 'Paused', 'Completed', 'Unattempted'
  Module({
    required this.name,
    required this.mcqsCount,
    required this.rating,
    required this.status,
  });
}

class McqModel {
  final McqContent question;
  final McqContent explanation;
  final String id;
  final String courseId;
  final String subjectId;
  final String subSubjectId;
  final String topicId;
  final String chapterId;
  final String tagId;
  final String mode;
  final List<McqOption> options;
  final List<String> tags;
  final int correctAnswer;
  final String difficulty;
  final int marks;
  final int negativeMarks;
  final bool previousYearTag;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String codonId;

  McqModel({
    required this.question,
    required this.explanation,
    required this.id,
    required this.courseId,
    required this.subjectId,
    required this.subSubjectId,
    required this.topicId,
    required this.chapterId,
    required this.tagId,
    required this.mode,
    required this.options,
    required this.tags,
    required this.correctAnswer,
    required this.difficulty,
    required this.marks,
    required this.negativeMarks,
    required this.previousYearTag,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.codonId
  });

  factory McqModel.fromJson(Map<String, dynamic> json) {
    return McqModel(
      question: McqContent.fromJson(json['question']),
      explanation: McqContent.fromJson(json['explanation']),
      id: json['_id'] ?? '',
      courseId: json['courseId'] ?? '',
      subjectId: json['subjectId'] ?? '',
      subSubjectId: json['subSubjectId'] ?? '',
      topicId: json['topicId'] ?? '',
      chapterId: json['chapterId'] ?? '',
      tagId: json['tagId'] is Map
          ? json['tagId']['_id']
          : (json['tagId'] ?? ''),
      mode: json['mode'] ?? '',
      options:
          (json['options'] as List?)
              ?.map((e) => McqOption.fromJson(e))
              .toList() ??
          [],
      tags: List<String>.from(json['tags'] ?? []),
      correctAnswer: json['correctAnswer'] ?? 0,
      difficulty: json['difficulty'] ?? '',
      marks: json['marks'] ?? 0,
      negativeMarks: json['negativeMarks'] ?? 0,
      previousYearTag: json['previousYearTag'] ?? false,
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      codonId: json['codonId'] ?? '',

    );
  }
}

// class McqContent {
//   final String text;
//   final List<String> images;
//
//   McqContent({required this.text, required this.images});
//
//   factory McqContent.fromJson(Map<String, dynamic> json) {
//     return McqContent(
//       text: json['text'] ?? '',
//       images: List<String>.from(json['images'] ?? []),
//     );
//   }
// }

class McqContent {
  final String mcqId;
  final String text;
  final List<String> images;

  McqContent({
    required this.mcqId,
    required this.text,
    required this.images,
  });

  factory McqContent.fromJson(Map<String, dynamic> json) {
    return McqContent(
      mcqId: json['mcqId'] ?? '',
      text: json['text'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }
}

class McqOption {
  final String text;
  final String? image;
  final String id;

  McqOption({required this.text, this.image, required this.id});

  factory McqOption.fromJson(Map<String, dynamic> json) {
    return McqOption(
      text: json['text'] ?? '',
      image: json['image'],
      id: json['_id'] ?? '',
    );
  }
}
