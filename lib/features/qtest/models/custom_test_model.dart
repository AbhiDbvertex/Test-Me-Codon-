import 'package:codon/features/qtest/models/tag_model.dart';

class CustomTestModel {
  final bool success;
  final String? attemptId;
  final bool isResume;
  final int count;
  final String requestedMode;
  final bool isTimerRequired;
  final int timerMinutes;
  final List<TestQuestion> data;

  CustomTestModel({
    required this.success,
    this.attemptId,
    required this.isResume,
    required this.count,
    required this.requestedMode,
    required this.isTimerRequired,
    required this.timerMinutes,
    required this.data,
  });

  factory CustomTestModel.fromJson(Map<String, dynamic> json) {
    return CustomTestModel(
      success: json['success'] ?? false,
      attemptId: json['attemptId'],
      isResume: json['isResume'] ?? false,
      count: json['count'] ?? 0,
      requestedMode: json['requestedMode'] ?? '',
      isTimerRequired: json['isTimerRequired'] ?? false,
      timerMinutes: json['timerMinutes'] ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => TestQuestion.fromJson(e))
          .toList(),
    );
  }

  factory CustomTestModel.fromHistoryJson(Map<String, dynamic> json) {
    final data = json['data'];
    final mcqs = data['mcqIds'] as List<dynamic>? ?? [];
    return CustomTestModel(
      success: json['success'] ?? false,
      attemptId: data['_id'],
      isResume: data['status'] == 'in_progress',
      count: mcqs.length,
      requestedMode: data['mode'] ?? '',
      isTimerRequired: false,
      timerMinutes: 0,
      data: mcqs.map((e) => TestQuestion.fromJson(e)).toList(),
    );
  }
}

class TestQuestion {
  final String id;
  final QuestionContent question;
  final List<OptionModel> options;
  final int correctAnswer;
  final Explanation explanation;
  final String difficulty;
  final int marks;
  final int negativeMarks;
  final String mode;
  final CustomTestTagModel? tag;

  TestQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.difficulty,
    required this.marks,
    required this.negativeMarks,
    required this.mode,
    this.tag,
  });

  factory TestQuestion.fromJson(Map<String, dynamic> json) {
    return TestQuestion(
      id: json['_id'] ?? '',
      question: QuestionContent.fromJson(json['question']),
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionModel.fromJson(e))
          .toList(),
      correctAnswer: json['correctAnswer'] ?? 0,
      explanation: Explanation.fromJson(json['explanation']),
      difficulty: json['difficulty'] ?? '',
      marks: json['marks'] ?? 0,
      negativeMarks: json['negativeMarks'] ?? 0,
      mode: json['mode'] ?? '',
      tag: json['tag'] != null
          ? CustomTestTagModel.fromJson(json['tag'])
          : null,
    );
  }
}

class QuestionContent {
  final String text;
  final List<String> images;

  QuestionContent({required this.text, required this.images});

  factory QuestionContent.fromJson(Map<String, dynamic> json) {
    return QuestionContent(
      text: json['text'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }
}

class OptionModel {
  final String id;
  final String text;
  final String? image;

  OptionModel({required this.id, required this.text, this.image});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['_id'] ?? '',
      text: json['text'] ?? '',
      image: json['image'],
    );
  }
}

class Explanation {
  final String text;
  final List<String> images;

  Explanation({required this.text, required this.images});

  factory Explanation.fromJson(Map<String, dynamic> json) {
    return Explanation(
      text: json['text'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }
}
