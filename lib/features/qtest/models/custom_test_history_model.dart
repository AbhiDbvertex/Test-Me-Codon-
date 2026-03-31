class CustomTestHistoryResponse {
  final bool success;
  final int count;
  final List<CustomTestHistoryItem> data;

  CustomTestHistoryResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  factory CustomTestHistoryResponse.fromJson(Map<String, dynamic> json) {
    return CustomTestHistoryResponse(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((i) => CustomTestHistoryItem.fromJson(i))
          .toList(),
    );
  }
}

class CustomTestHistoryItem {
  final String id;
  final String userId;
  final List<String> mcqIds;
  final String mode;
  final String status;
  final String startedAt;
  final String createdAt;
  final String updatedAt;
  final String? submittedAt;
  final HistoryResult? result;
  final List<HistoryAnswer>? answers;

  CustomTestHistoryItem({
    required this.id,
    required this.userId,
    required this.mcqIds,
    required this.mode,
    required this.status,
    required this.startedAt,
    required this.createdAt,
    required this.updatedAt,
    this.submittedAt,
    this.result,
    this.answers,
  });

  factory CustomTestHistoryItem.fromJson(Map<String, dynamic> json) {
    return CustomTestHistoryItem(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      mcqIds: List<String>.from(json['mcqIds'] ?? []),
      mode: json['mode'] ?? '',
      status: json['status'] ?? '',
      startedAt: json['startedAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      submittedAt: json['submittedAt'],
      result: json['result'] != null
          ? HistoryResult.fromJson(json['result'])
          : null,
      answers: (json['answers'] as List?)
          ?.map((a) => HistoryAnswer.fromJson(a))
          .toList(),
    );
  }
}

class HistoryResult {
  final int totalQuestions;
  final int correct;
  final int incorrect;
  final int notAttempted;
  final double scorePercentage;

  HistoryResult({
    required this.totalQuestions,
    required this.correct,
    required this.incorrect,
    required this.notAttempted,
    required this.scorePercentage,
  });

  factory HistoryResult.fromJson(Map<String, dynamic> json) {
    return HistoryResult(
      totalQuestions: json['totalQuestions'] ?? 0,
      correct: json['correct'] ?? 0,
      incorrect: json['incorrect'] ?? 0,
      notAttempted: json['notAttempted'] ?? 0,
      scorePercentage: (json['scorePercentage'] ?? 0).toDouble(),
    );
  }
}

class HistoryAnswer {
  final String mcqId;
  final int? selectedIndex;
  final String id;

  HistoryAnswer({required this.mcqId, this.selectedIndex, required this.id});

  factory HistoryAnswer.fromJson(Map<String, dynamic> json) {
    return HistoryAnswer(
      mcqId: json['mcqId'] ?? '',
      selectedIndex: json['selectedIndex'],
      id: json['_id'] ?? '',
    );
  }
}
