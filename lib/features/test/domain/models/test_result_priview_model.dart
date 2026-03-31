class TestResponseModel {
  bool? success;
  TestData? data;

  TestResponseModel({this.success, this.data});

  factory TestResponseModel.fromJson(Map<String, dynamic> json) {
    return TestResponseModel(
      success: json['success'],
      data:
      json['data'] != null ? TestData.fromJson(json['data']) : null,
    );
  }
}

class TestData {
  String? id;
  String? month;
  String? academicYear;
  String? testTitle;
  CourseId? courseId;
  SubjectId? subjectId;
  SubSubjectId? subSubjectId;
  ChapterId? chapterId;
  String? testMode;
  int? mcqLimit;
  List<Mcq>? mcqs;
  int? totalQuestions;
  String? description;

  TestData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    month = json['month'];
    academicYear = json['academicYear'];
    testTitle = json['testTitle'];
    courseId = json['courseId'] != null
        ? CourseId.fromJson(json['courseId'])
        : null;

    subjectId = json['subjectId'] != null
        ? SubjectId.fromJson(json['subjectId'])
        : null;

    subSubjectId = json['subSubjectId'] != null
        ? SubSubjectId.fromJson(json['subSubjectId'])
        : null;

    chapterId = json['chapterId'] != null
        ? ChapterId.fromJson(json['chapterId'])
        : null;

    testMode = json['testMode'];
    mcqLimit = json['mcqLimit'];
    totalQuestions = json['totalQuestions'];
    description = json['description'];

    if (json['mcqs'] != null) {
      mcqs = List<Mcq>.from(
          json['mcqs'].map((x) => Mcq.fromJson(x)));
    }
  }
}

class CourseId {
  String? id;
  String? name;
  bool? isPaid;

  CourseId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    isPaid = json['isPaid'];
  }
}

class SubjectId {
  String? id;
  String? name;

  SubjectId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }
}

class SubSubjectId {
  String? id;
  String? name;
  String? description;

  SubSubjectId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
  }
}

class ChapterId {
  String? id;
  String? name;
  String? chapterCode;

  ChapterId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    chapterCode = json['chapterCode'];
  }
}

class Mcq {
  Question? question;
  Explanation? explanation;
  List<Option>? options;
  int? correctAnswer;
  int? marks;
  int? negativeMarks;

  // 🔥 NEW FIELDS
  String? correctAnswerName;
  String? correctAnswerLabel;

  Mcq.fromJson(Map<String, dynamic> json) {
    question = json['question'] != null
        ? Question.fromJson(json['question'])
        : null;

    explanation = json['explanation'] != null
        ? Explanation.fromJson(json['explanation'])
        : null;

    if (json['options'] != null) {
      options =
      List<Option>.from(json['options'].map((x) => Option.fromJson(x)));
    }

    correctAnswer = json['correctAnswer'];
    marks = json['marks'];
    negativeMarks = json['negativeMarks'];

    // 🔥 NEW DATA PARSING
    correctAnswerName = json['correctAnswerName'];
    correctAnswerLabel = json['correctAnswerLabel'];
  }
}

class Question {
  String? text;
  List<String>? images;

  Question.fromJson(Map<String, dynamic> json) {
    text = json['text'];

    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }
  }
}

class Explanation {
  String? text;
  List<String>? images;

  Explanation.fromJson(Map<String, dynamic> json) {
    text = json['text'];

    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }
  }
}

class Option {
  String? text;
  String? image;

  Option.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    image = json['image'];
  }
}