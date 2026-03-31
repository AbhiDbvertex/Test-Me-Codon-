class DailyMcqModel {
  final String id;
  final TextImageModel question;
  final TextImageModel explanation;

  final IdNameModel course;
  final IdNameModel subject;
  final IdNameModel subSubject;
  final IdNameModel tag;

  final String topicId;
  final IdNameModel? chapter;

  final String mode;
  final List<McqOptionModel> options;
  final int correctAnswer;

  final String difficulty;
  final int marks;
  final int negativeMarks;

  final bool previousYearTag;
  final String status;

  final String createdBy;
  final String updatedBy;

  final DateTime createdAt;
  final DateTime updatedAt;

  DailyMcqModel({
    required this.id,
    required this.question,
    required this.explanation,
    required this.course,
    required this.subject,
    required this.subSubject,
    required this.tag,
    required this.topicId,
    this.chapter,
    required this.mode,
    required this.options,
    required this.correctAnswer,
    required this.difficulty,
    required this.marks,
    required this.negativeMarks,
    required this.previousYearTag,
    required this.status,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  // factory DailyMcqModel.fromJson(Map<String, dynamic> json) {
  //   return DailyMcqModel(
  //     id: json['_id'],
  //     question: TextImageModel.fromJson(json['question']),
  //     explanation: TextImageModel.fromJson(json['explanation']),
  //     course: IdNameModel.fromJson(json['courseId']),
  //     subject: IdNameModel.fromJson(json['subjectId']),
  //     subSubject: IdNameModel.fromJson(json['subSubjectId']),
  //     tag: (json['tagId'] != null && json['tagId'] is Map)
  //         ? IdNameModel.fromJson(json['tagId'])
  //         : IdNameModel(id: '', name: 'No Tag'),      topicId: json['topicId'],
  //     chapter: (json['chapterId'] != null && json['chapterId'] is Map)
  //         ? IdNameModel.fromJson(json['chapterId'])
  //         : null,
  //     mode: json['mode']?.toString() ?? 'standard',      options: (json['options'] as List)
  //         .map((e) => McqOptionModel.fromJson(e))
  //         .toList(),
  //     correctAnswer: json['correctAnswer'],
  //     difficulty: json['difficulty'],
  //     marks: json['marks'],
  //     negativeMarks: json['negativeMarks'],
  //     previousYearTag: json['previousYearTag'],
  //     status: json['status'],
  //     createdBy: json['createdBy'],
  //     updatedBy: json['updatedBy'],
  //     createdAt: DateTime.parse(json['createdAt']),
  //     updatedAt: DateTime.parse(json['updatedAt']),
  //   );
  // }
  factory DailyMcqModel.fromJson(Map<String, dynamic> json) {
    // Helper function to handle Map fields safely
    IdNameModel parseIdName(dynamic data, String fallbackName) {
      if (data != null && data is Map<String, dynamic>) {
        return IdNameModel.fromJson(data);
      }
      return IdNameModel(id: '', name: fallbackName);
    }

    return DailyMcqModel(
      id: json['_id']?.toString() ?? '',
      question: TextImageModel.fromJson(json['question'] ?? {}),
      explanation: TextImageModel.fromJson(json['explanation'] ?? {}),
      course: parseIdName(json['courseId'], 'N/A'),
      subject: parseIdName(json['subjectId'], 'N/A'),
      subSubject: parseIdName(json['subSubjectId'], 'N/A'),
      tag: parseIdName(json['tagId'], 'No Tag'),
      topicId: json['topicId']?.toString() ?? '',
      chapter: (json['chapterId'] != null && json['chapterId'] is Map<String, dynamic>)
          ? IdNameModel.fromJson(json['chapterId'])
          : null,
      mode: json['mode']?.toString() ?? 'standard',
      options: (json['options'] as List? ?? [])
          .map((e) => McqOptionModel.fromJson(e is Map<String, dynamic> ? e : {}))
          .toList(),
      correctAnswer: int.tryParse(json['correctAnswer']?.toString() ?? '0') ?? 0,
      difficulty: json['difficulty']?.toString() ?? 'easy',
      marks: int.tryParse(json['marks']?.toString() ?? '0') ?? 0,
      negativeMarks: int.tryParse(json['negativeMarks']?.toString() ?? '0') ?? 0,
      previousYearTag: json['previousYearTag'] ?? false,
      status: json['status']?.toString() ?? 'active',
      createdBy: json['createdBy']?.toString() ?? '',
      updatedBy: json['updatedBy']?.toString() ?? '',
      // Safe Date Parsing
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now() : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) ?? DateTime.now() : DateTime.now(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'question': question.toJson(),
      'explanation': explanation.toJson(),
      'courseId': course.toJson(),
      'subjectId': subject.toJson(),
      'subSubjectId': subSubject.toJson(),
      'tagId': tag.toJson(),
      'topicId': topicId,
      'chapterId': chapter?.toJson(),
      'mode': mode,
      'options': options.map((e) => e.toJson()).toList(),
      'correctAnswer': correctAnswer,
      'difficulty': difficulty,
      'marks': marks,
      'negativeMarks': negativeMarks,
      'previousYearTag': previousYearTag,
      'status': status,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class McqOptionModel {
  final String id;
  final String text;
  final String? image;

  McqOptionModel({required this.id, required this.text, this.image});

  factory McqOptionModel.fromJson(Map<String, dynamic> json) {
    return McqOptionModel(
      id: json['_id'],
      text: json['text'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'text': text, 'image': image};
  }
}

// class IdNameModel {
//   final String id;
//   final String name;
//
//   IdNameModel({required this.id, required this.name});
//
//   factory IdNameModel.fromJson(Map<String, dynamic> json) {
//     return IdNameModel(id: json['_id'], name: json['name']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'_id': id, 'name': name};
//   }
// }
class IdNameModel {
  final String id;
  final String name;

  IdNameModel({required this.id, required this.name});

  factory IdNameModel.fromJson(Map<String, dynamic> json) {
    return IdNameModel(
      id: json['_id']?.toString() ?? '', // Safe conversion
      name: json['name']?.toString() ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name};
}

class TextImageModel {
  final String text;
  final List<String> images;

  TextImageModel({required this.text, required this.images});

  factory TextImageModel.fromJson(Map<String, dynamic> json) {
    return TextImageModel(
      text: json['text'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'images': images};
  }
}
