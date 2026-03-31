class TestModel {
  final String id;
  final String testTitle;
  final String category;
  final String testMode;
  final num mcqLimit;
  final num timeLimit;
  final String createdAt;
  final String updatedAt;

  TestModel({
    required this.id,
    required this.testTitle,
    required this.category,
    required this.testMode,
    required this.mcqLimit,
    required this.timeLimit,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['_id']?.toString() ?? '',
      testTitle: json['testTitle']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      testMode: json['testMode']?.toString() ?? '',
      mcqLimit: json['mcqLimit'] ?? 0,
      timeLimit: json['timeLimit'] ?? 0,
      createdAt:
          json['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
      updatedAt:
          json['updatedAt']?.toString() ?? DateTime.now().toIso8601String(),
    );
  }
}

//////////////////////////
// 1. Full Response Wrapper (Test duration aur total count ke liye)
class TestQuestionResponse {
  final bool success;
  final int testDurationInMinutes;
  final String endTime;
  final int totalQuestions;
  final List<TestQuestionModel> questions;

  TestQuestionResponse({
    required this.success,
    required this.testDurationInMinutes,
    required this.endTime,
    required this.totalQuestions,
    required this.questions,
  });

  factory TestQuestionResponse.fromJson(Map<String, dynamic> json) {
    return TestQuestionResponse(
      success: json['success'] ?? false,
      testDurationInMinutes: json['testDurationInMinutes'] ?? 0,
      endTime: json['endTime'] ?? '',
      totalQuestions: json['totalQuestions'] ?? 0,
      questions: (json['questions'] as List? ?? [])
          .map((i) => TestQuestionModel.fromJson(i))
          .toList(),
    );
  }
}

// 2. Question Model (Requirement #3 match)
class TestQuestionModel {
  final String id;
  final String questionText;
  final String image; // JSON mein 'image' hai
  final String correctAnswerId;
  final List<TestOptionModel> options;
  String? selectedOptionId; // Local state maintain karne ke liye

  TestQuestionModel({
    required this.id,
    required this.questionText,
    required this.image,
    required this.correctAnswerId,
    required this.options,
    this.selectedOptionId,
  });

  factory TestQuestionModel.fromJson(Map<String, dynamic> json) {
    return TestQuestionModel(
      id: json['id']?.toString() ?? '',
      questionText: json['questionText']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      correctAnswerId: json['correctAnswerId']?.toString() ?? '',
      options: (json['options'] as List? ?? [])
          .map((o) => TestOptionModel.fromJson(o))
          .toList(),
    );
  }
}

// 3. Option Model
class TestOptionModel {
  final String id;
  final String text;
  final String image;

  TestOptionModel({required this.id, required this.text, required this.image});

  factory TestOptionModel.fromJson(Map<String, dynamic> json) {
    return TestOptionModel(
      id: json['id']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }
}

class TestSummaryModel {
  final int totalAttempted;
  final double performedPercent;
  final int correct;
  final int wrong;
  final int notAttempted;

  TestSummaryModel({
    required this.totalAttempted,
    required this.performedPercent,
    required this.correct,
    required this.wrong,
    required this.notAttempted,
  });

  factory TestSummaryModel.fromJson(Map<String, dynamic> json) {
    return TestSummaryModel(
      totalAttempted: json['totalAttempted'] ?? 0,
      performedPercent: (json['performedPercent'] ?? 0).toDouble(),
      correct: json['correct'] ?? 0,
      wrong: json['wrong'] ?? 0,
      notAttempted: json['notAttempted'] ?? 0,
    );
  }
}

class ExamTestModel {
  final String testId;
  final String testTitle;
  final int totalMcqCount;
  final int totalTime;
  final int remainingTimeSeconds;
  final String? startTestTime;
  final String? endTestTime;
  final String status;
  final String? submittedBy;

  ExamTestModel({
    required this.testId,
    required this.testTitle,
    required this.totalMcqCount,
    required this.totalTime,
    required this.remainingTimeSeconds,
    this.startTestTime,
    this.endTestTime,
    required this.status,
    this.submittedBy,
  });

  factory ExamTestModel.fromJson(Map<String, dynamic> json) {
    return ExamTestModel(
      testId: json['testId']?.toString() ?? '',
      testTitle: json['testTitle']?.toString() ?? '',
      totalMcqCount: json['totalMcqCount'] ?? 0,
      totalTime: json['totalTime'] ?? 0,
      remainingTimeSeconds: json['remainingTimeSeconds'] ?? 0,
      startTestTime: json['startTestTime']?.toString(),
      endTestTime: json['endTestTime']?.toString(),
      status: json['status']?.toString() ?? 'NOT_STARTED',
      submittedBy: json['submittedBy']?.toString(),
    );
  }
}

class ExamOptionModel {
  final int optionId;
  final String name;
  final String? image;

  ExamOptionModel({required this.optionId, required this.name, this.image});

  factory ExamOptionModel.fromJson(Map<String, dynamic> json) {
    return ExamOptionModel(
      optionId: json['optionId'] ?? 0,
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString(),
    );
  }
}

class ExamMcqModel {
  final String mcqId;
  final String text;
  final List<String> images;
  final List<ExamOptionModel> options;
  final String tag;
  int? selectedOption;

  ExamMcqModel({
    required this.mcqId,
    required this.text,
    required this.images,
    required this.options,
    required this.tag,
    this.selectedOption,
  });

  factory ExamMcqModel.fromJson(Map<String, dynamic> json) {
    return ExamMcqModel(
      mcqId: json['mcqId']?.toString() ?? '',
      text: json['mcqName']?['text']?.toString() ?? '',
      images: List<String>.from(json['mcqName']?['images'] ?? []),
      options: (json['options'] as List? ?? [])
          .map((o) => ExamOptionModel.fromJson(o))
          .toList(),
      tag: json['tag']?.toString() ?? '',
      selectedOption: json['selectedOption'],
    );
  }
}

class ExamStartResponseModel {
  final bool success;
  final String attemptId;
  final String testTitle;
  final int totalMcqCount;
  final int totalTestTime;
  final int remainingTimeSeconds;
  final List<ExamMcqModel> mcqs;

  ExamStartResponseModel({
    required this.success,
    required this.attemptId,
    required this.testTitle,
    required this.totalMcqCount,
    required this.totalTestTime,
    required this.remainingTimeSeconds,
    required this.mcqs,
  });

  factory ExamStartResponseModel.fromJson(Map<String, dynamic> json) {
    return ExamStartResponseModel(
      success: json['success'] ?? false,
      attemptId: json['attemptId']?.toString() ?? '',
      testTitle: json['testTitle']?.toString() ?? '',
      totalMcqCount: json['totalMcqCount'] ?? 0,
      totalTestTime: json['totalTestTime'] ?? 0,
      remainingTimeSeconds: json['remainingTimeSeconds'] ?? 0,
      mcqs: (json['mcqs'] as List? ?? [])
          .map((m) => ExamMcqModel.fromJson(m))
          .toList(),
    );
  }
}

class ExamSubmitResponseModel {
  final bool success;
  final int solvedMcq;
  final int correctAnswer;
  final int wrongAnswer;
  final int notAttempt;
  final String percentage;
  final int score;

  ExamSubmitResponseModel({
    required this.success,
    required this.solvedMcq,
    required this.correctAnswer,
    required this.wrongAnswer,
    required this.notAttempt,
    required this.percentage,
    required this.score,
  });

  factory ExamSubmitResponseModel.fromJson(Map<String, dynamic> json) {
    return ExamSubmitResponseModel(
      success: json['success'] ?? false,
      solvedMcq: json['solvedMcq'] ?? 0,
      correctAnswer: json['correctAnswer'] ?? 0,
      wrongAnswer: json['wrongAnswer'] ?? 0,
      notAttempt: json['notAttempt'] ?? 0,
      percentage: json['percentage']?.toString() ?? '0.00',
      score: json['score'] ?? 0,
    );
  }
}
