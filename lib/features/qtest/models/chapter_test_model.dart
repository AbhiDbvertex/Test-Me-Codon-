class ChapterTestModel {
  final String id;
  final String month;
  final String academicYear;
  final String testTitle;
  final int mcqLimit;
  final int totalQuestions;
  final String status;

  ChapterTestModel({
    required this.id,
    required this.month,
    required this.academicYear,
    required this.testTitle,
    required this.mcqLimit,
    required this.totalQuestions,
    required this.status,
  });

  factory ChapterTestModel.fromJson(Map<String, dynamic> json) {
    return ChapterTestModel(
      id: json['_id'] ?? '',
      month: json['month'] ?? '',
      academicYear: json['academicYear'] ?? '',
      testTitle: json['testTitle'] ?? '',
      mcqLimit: json['mcqLimit'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      status: json['status'] ?? 'NOT_STARTED',
    );
  }
}
