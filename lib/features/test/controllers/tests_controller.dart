//
// import 'dart:async';
//
// import 'package:codon/features/test/domain/models/test_model.dart';
// import 'package:codon/features/test/domain/services/test_service.dart';
// import 'package:codon/features/test/screens/test_result_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../domain/models/test_result_priview_model.dart';
// import '../screens/test_mcq_screen.dart';
//
// class TestsController extends GetxController {
//   final TestService _testService = Get.find<TestService>();
//   static String? courseId;
//   var examSubmitResult = Rxn<ExamSubmitResponseModel>();
//   Rx<TestResponseModel?> TestResult = Rx<TestResponseModel?>(null);
//
//   // --- List Screen State (Unchanged) ---
//   final testCourse = <TestModel>[].obs;
//   final examTests = <ExamTestModel>[].obs;
//   final groupedTestsByYear = <String, Map<String, List<TestModel>>>{}.obs;
//   var isTestCourseLoading = false.obs;
//   var isExamTestsLoading = false.obs;
//   var startLoadingId = ''.obs;
//   // var currentAttemptId = ''.obs;
//
//   // --- MCQ & Timer State (Updated for New Response) ---
//   final questionsList = <Map<String, dynamic>>[].obs; // Static JSON format list
//   final currentQuestionIndex = 0.obs;
//   final PageController pageController = PageController();
//   final userSelections = <String, String?>{}.obs;
//
//   Timer? timer;
//   var timeDisplay = "15:00".obs;
//   int _totalSeconds = 15 * 60; // Total 15 mins
//   int _remainingSeconds = 0;
//   String currentAttemptId = "6975a6badfef0250a8b78104";
//   String currentTestId = "";
//
//   ////////////////////////////
//
//   ////////////////////////////
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     final testId = Get.arguments;
//
//     if (testId != null) {
//       fetchTestPreview(testId);
//     }
//
//     fetchExamTests();
//   }
//
//   // @override
//   // void onClose() {
//   //   _timer?.cancel();
//   //   pageController.dispose();
//   //   super.onClose();
//   // }
//
//   @override
//   void onClose() {
//     timer?.cancel();
//     timer = null;               // ← extra safety
//     pageController.dispose();
//     super.onClose();
//   }
//
//   // Static Data Loading according to your requirement
//   void _loadStaticQuestions() {
//     if (questionsList.isNotEmpty) return;
//     questionsList.assignAll([
//       {
//         "id": "Q101",
//         "questionText": "What is the primary function of Mitochondria?",
//         "questionImageUrl":
//             "https://images.unsplash.com/photo-1530026405186-ed1f139313f8?q=80&w=400&h=200&auto=format&fit=crop",
//         "imageTag": "#Cell_Structure_01",
//         "correctAnswerId": "opt_2",
//         "options": [
//           {"id": "opt_1", "text": "Protein Synthesis", "optionImageUrl": null},
//           {
//             "id": "opt_2",
//             "text": "ATP Production (Energy)",
//             "optionImageUrl": null,
//           },
//           {"id": "opt_3", "text": "DNA Replication", "optionImageUrl": null},
//           {"id": "opt_4", "text": "Waste Removal", "optionImageUrl": null},
//         ],
//       },
//       {
//         "id": "Q102",
//         "questionText": "Identify the element 'K' in the periodic table.",
//         "questionImageUrl": null,
//         "imageTag": "#Periodic_Table_K",
//         "correctAnswerId": "opt_7",
//         "options": [
//           {
//             "id": "opt_5",
//             "text": "Sodium",
//             "optionImageUrl":
//                 "https://images.unsplash.com/photo-1541167760496-1628856ab772?q=80&w=100&h=100&fit=crop",
//           },
//           {"id": "opt_6", "text": "Magnesium", "optionImageUrl": null},
//           {"id": "opt_7", "text": "Potassium", "optionImageUrl": null},
//           {"id": "opt_8", "text": "Calcium", "optionImageUrl": null},
//         ],
//       },
//     ]);
//     for (var q in questionsList) {
//       userSelections.putIfAbsent(q['id'], () => null);
//     }
//   }
//
//   void startTest({required String testId, required String testTitle}) {
//     currentTestId = testId;
//     // 1. Index ko 0 karo taaki dots pehle question se shuru hon
//     currentQuestionIndex.value = 0;
//
//     // 2. Agar PageController attach hai, toh usey bhi jump karao (Safety ke liye)
//     if (pageController.hasClients) {
//       pageController.jumpToPage(0);
//     }
//
//     _loadStaticQuestions();
//     _remainingSeconds = _totalSeconds;
//     _startTimer();
//     Get.to(() => const TestMCQScreen(), arguments: {'testName': testTitle});
//   }
//
//   void startExamTest({required String testId, required String testTitle}) {
//     currentTestId = testId;
//     startLoadingId.value = testId;
//
//     _apiHandler(
//       loader: RxBool(false),
//       call: _testService.startExamTest(testId: testId),
//       onData: (response) {
//         final data = ExamStartResponseModel.fromJson(response);
//
//         currentAttemptId = data.attemptId;
//         _remainingSeconds = data.remainingTimeSeconds;
//
//         // Map ExamMcqModel to the format expected by TestMCQScreen
//         final mappedQuestions = data.mcqs
//             .map(
//               (m) => {
//                 "id": m.mcqId,
//                 "questionText": m.text,
//                 "questionImageUrl": m.images.isNotEmpty ? m.images[0] : null,
//                 "imageTag": m.tag,
//                 "options": m.options
//                     .map(
//                       (o) => {
//                         "id": o.optionId.toString(),
//                         "text": o.name,
//                         "optionImageUrl": o.image,
//                       },
//                     )
//                     .toList(),
//               },
//             )
//             .toList();
//
//         questionsList.assignAll(mappedQuestions);
//
//         // Initialize userSelections
//         userSelections.clear();
//         for (var q in mappedQuestions) {
//           userSelections[q['id'] as String] = null;
//         }
//
//         currentQuestionIndex.value = 0;
//         if (pageController.hasClients) {
//           pageController.jumpToPage(0);
//         }
//
//         _startTimer();
//         Get.to(
//           () => const TestMCQScreen(),
//           arguments: {'testName': data.testTitle},
//         );
//       },
//     ).then((_) {
//       startLoadingId.value = '';
//     });
//   }
//
//
//
// //   Future<TestResponseModel>fetchTestPreview(String testId)async {
// // print("xvfxdvxcc");
// //   final response= await _testService.getTestPriviewById(testId: testId);
// //     // _apiHandler(
// //     //   loader: isTestCourseLoading,
// //     //   // call: _testService.getTestPriviewById(testId: testId),
// //
// //     //   onData: (response) {
// //     //     final model = TestResponseModel.fromJson(response);
// //     //     TestResult.value = model;
// //     //
// //     //   },
// //
// //
// //     // );
// //     final model = TestResponseModel.fromJson(response);
// //   return TestResult.value = model;
// //
// //   }
//
//   Future<TestResponseModel> fetchTestPreview(String testId) async {
//     final response =
//     await _testService.getTestPriviewById(testId: testId);
//     Map<int, int> userAnswers = {};
//     return TestResponseModel.fromJson(response);
//   }
//   void _startTimer() {
//     timer?.cancel();
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingSeconds > 0) {
//         _remainingSeconds--;
//         int mins = _remainingSeconds ~/ 60;
//         int secs = _remainingSeconds % 60;
//         timeDisplay.value =
//             "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
//       } else {
//         submitTest();
//       }
//     });
//   }
//
//   void selectOption(String qId, String optId) {
//     userSelections[qId] = optId;
//     userSelections.refresh();
//
//     // If an attempt ID is present, sync the answer to the server
//     if (currentAttemptId.isNotEmpty) {
//       final int? optionId = int.tryParse(optId);
//       if (optionId != null) {
//         _testService
//             .submitExamAnswer(
//               attemptId: currentAttemptId,
//               mcqId: qId,
//               optionId: optionId,
//             )
//             .then((response) {
//               debugPrint("Answer submitted successfully: $response");
//             })
//             .catchError((error) {
//               debugPrint("Error submitting answer: $error");
//             });
//       }
//     }
//   }
//
//   void onPageChanged(int index) {
//     currentQuestionIndex.value = index;
//   }
//
//   void nextQuestion() {
//     if (currentQuestionIndex.value < questionsList.length - 1) {
//       pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       submitTest();
//     }
//   }
//
//   void previousQuestion() {
//     if (currentQuestionIndex.value > 0) {
//       pageController.previousPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
//
//   void stopTimer() {
//     timer?.cancel();
//     timer = null;
//     print("Timer forcefully stopped"); // ← debug ke liye add karo
//   }
//
//   void submitTest() {
//     timer?.cancel();
//
//     if (currentAttemptId.isNotEmpty) {
//       Get.dialog(
//         const Center(child: CircularProgressIndicator()),
//         barrierDismissible: false,
//       );
//
//       _testService
//           .submitExamTest(attemptId: currentAttemptId)
//           .then((response) {
//             Get.back(); // Close loading dialog
//             final data = ExamSubmitResponseModel.fromJson(response);
//
//             if (data.success) {
//               examSubmitResult.value = data;
//               Get.off(
//
//                 () => TestResultScreen(
//                   // totalMcqs: data.solvedMcq + data.notAttempt,
//                   // correct: data.correctAnswer,
//                   // wrong: data.wrongAnswer,
//                   // notAttempted: data.notAttempt,
//                   // percentage: data.percentage,
//                   // score: data.score,
//                   testId: currentTestId,
//                 ),
//               );
//             } else {
//               Get.snackbar("Error", "Submission failed");
//             }
//           })
//           .catchError((error) {
//             Get.back(); // Close loading dialog
//             Get.snackbar("Error", error.toString());
//           });
//     } else {
//       // Fallback for course tests if needed, or static calculation
//       _calculateAndNavigateStatically();
//     }
//   }
//
//   void _calculateAndNavigateStatically() {
//     int correctCount = 0;
//     int wrongCount = 0;
//     int unattemptedCount = 0;
//
//     for (var q in questionsList) {
//       String? selected = userSelections[q['id']];
//       if (selected == null) {
//         unattemptedCount++;
//       } else if (selected == q['correctAnswerId']) {
//         correctCount++;
//       } else {
//         wrongCount++;
//       }
//     }
//
//     Get.off(
//       () => TestResultScreen(
//         // totalMcqs: questionsList.length,
//         // correct: correctCount,
//         // wrong: wrongCount,
//         // notAttempted: unattemptedCount,
//         testId: currentTestId,
//       ),
//     );
//   }
//
//   // --- API & Grouping Logic (Bina chede) ---
//   // void fetchTestCourse({required String courseId}) {
//   //   _apiHandler(
//   //     loader: isTestCourseLoading,
//   //     call: _testService.getTestCourse(courseId: courseId),
//   //     onData: (response) {
//   //       final rawList = response['tests'] as List? ?? [];
//   //       final List<TestModel> allTests = rawList
//   //           .map((e) => TestModel.fromJson(e))
//   //           .toList();
//
//   //       testCourse.assignAll(allTests);
//   //       _groupTestsByYearAndMonth(allTests);
//   //     },
//   //   );
//   // }
//
//   void fetchExamTests() {
//     _apiHandler(
//       loader: isExamTestsLoading,
//       call: _testService.getExamTests(),
//       onData: (response) {
//         final rawList = response['data'] as List? ?? [];
//         final List<ExamTestModel> allExamTests = rawList
//             .map((e) => ExamTestModel.fromJson(e))
//             .toList();
//         examTests.assignAll(allExamTests);
//       },
//     );
//   }
//
//   void _groupTestsByYearAndMonth(List<TestModel> tests) {
//     Map<String, Map<String, List<TestModel>>> yearGroups = {};
//     List<String> months = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec",
//     ];
//
//     tests.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//
//     for (var test in tests) {
//       try {
//         DateTime date = DateTime.parse(test.createdAt);
//         String year = date.year.toString();
//         String monthName = months[date.month - 1];
//
//         if (!yearGroups.containsKey(year)) {
//           yearGroups[year] = {};
//         }
//         if (!yearGroups[year]!.containsKey(monthName)) {
//           yearGroups[year]![monthName] = [];
//         }
//
//         yearGroups[year]![monthName]!.add(test);
//       } catch (e) {
//         print("Grouping Error: $e");
//       }
//     }
//     groupedTestsByYear.assignAll(yearGroups);
//   }
// }
//
// Future<void> _apiHandler({
//   required RxBool loader,
//   required Future<Map<String, dynamic>> call,
//   required Function(Map<String, dynamic> response) onData,
// }) async
// {
//   try {
//     loader(true);
//     final res = await call;
//     if (res['success'] == true) {
//       onData(res);
//     } else {
//       // Get.snackbar("Alert", res['message'] ?? "Error");
//     }
//   } catch (e) {
//     print("API Error: $e");
//     // Get.snackbar("Error", "Check your connection");
//   } finally {
//     loader(false);
//   }
// }

import 'dart:async';

import 'package:codon/features/test/domain/models/test_model.dart';
import 'package:codon/features/test/domain/services/test_service.dart';
import 'package:codon/features/test/screens/test_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/models/test_result_priview_model.dart';
import '../screens/test_mcq_screen.dart';

class TestsController extends GetxController {
  final TestService _testService = Get.find<TestService>();
  static String? courseId;
  var examSubmitResult = Rxn<ExamSubmitResponseModel>();
  Rx<TestResponseModel?> TestResult = Rx<TestResponseModel?>(null);

  // --- List Screen State ---
  final testCourse = <TestModel>[].obs;
  final examTests = <ExamTestModel>[].obs;
  final groupedTestsByYear = <String, Map<String, List<TestModel>>>{}.obs;
  var isTestCourseLoading = false.obs;
  var isExamTestsLoading = false.obs;
  var startLoadingId = ''.obs;

  // --- MCQ & Timer State ---
  final questionsList = <Map<String, dynamic>>[].obs;
  final currentQuestionIndex = 0.obs;
  final PageController pageController = PageController();
  final userSelections = <String, String?>{}.obs;

  Timer? timer;
  var timeDisplay = "15:00".obs;
  int _totalSeconds = 15 * 60;
  int _remainingSeconds = 0;
  String currentAttemptId = "";
  String currentTestId = "";

  // Flag to stop timer when test is no longer active
  var isTestActive = true.obs;

  @override
  void onInit() {
    super.onInit();
    final testId = Get.arguments;
    if (testId != null) {
      fetchTestPreview(testId);
    }
    fetchExamTests();
  }

  @override
  void onClose() {
    stopTimer();
    isTestActive.value = false;
    pageController.dispose();
    super.onClose();
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
    print("Timer stopped");
  }

  void _loadStaticQuestions() {
    if (questionsList.isNotEmpty) return;
    questionsList.assignAll([
      // your static questions here (same as before)
      {
        "id": "Q101",
        "questionText": "What is the primary function of Mitochondria?",
        "questionImageUrl": "https://images.unsplash.com/photo-1530026405186-ed1f139313f8?q=80&w=400&h=200&auto=format&fit=crop",
        "imageTag": "#Cell_Structure_01",
        "correctAnswerId": "opt_2",
        "options": [
          {"id": "opt_1", "text": "Protein Synthesis", "optionImageUrl": null},
          {"id": "opt_2", "text": "ATP Production (Energy)", "optionImageUrl": null},
          {"id": "opt_3", "text": "DNA Replication", "optionImageUrl": null},
          {"id": "opt_4", "text": "Waste Removal", "optionImageUrl": null},
        ],
      },
      // ... other questions
    ]);
    for (var q in questionsList) {
      userSelections.putIfAbsent(q['id'], () => null);
    }
  }

  void startTest({required String testId, required String testTitle}) {
    currentTestId = testId;
    currentQuestionIndex.value = 0;
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
    _loadStaticQuestions();
    _remainingSeconds = _totalSeconds;
    isTestActive.value = true;
    _startTimer();

    Get.to(() => const TestMCQScreen(), arguments: {'testName': testTitle})?.then((_) {
      stopTimer();
      isTestActive.value = false;
      print("Test screen closed (static test)");
    });
  }

  void startExamTest({required String testId, required String testTitle}) {
    currentTestId = testId;
    startLoadingId.value = testId;

    _apiHandler(
      loader: RxBool(false),
      call: _testService.startExamTest(testId: testId),
      onData: (response) {
        final data = ExamStartResponseModel.fromJson(response);

        currentAttemptId = data.attemptId;
        _remainingSeconds = data.remainingTimeSeconds;

        final mappedQuestions = data.mcqs
            .map(
              (m) => {
            "id": m.mcqId,
            "questionText": m.text,
            "questionImageUrl": m.images.isNotEmpty ? m.images[0] : null,
            "imageTag": m.tag,
            "options": m.options
                .map(
                  (o) => {
                "id": o.optionId.toString(),
                "text": o.name,
                "optionImageUrl": o.image,
              },
            )
                .toList(),
          },
        )
            .toList();

        questionsList.assignAll(mappedQuestions);
        userSelections.clear();
        for (var q in mappedQuestions) {
          userSelections[q['id'] as String] = null;
        }

        currentQuestionIndex.value = 0;
        if (pageController.hasClients) {
          pageController.jumpToPage(0);
        }

        isTestActive.value = true;
        _startTimer();

        Get.to(
              () => const TestMCQScreen(),
          arguments: {'testName': data.testTitle},
        )?.then((_) {
          stopTimer();
          isTestActive.value = false;
          print("Test screen closed (exam test)");
        });
      },
    ).then((_) {
      startLoadingId.value = '';
    });
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!isTestActive.value) {
        t.cancel();
        return;
      }

      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        int mins = _remainingSeconds ~/ 60;
        int secs = _remainingSeconds % 60;
        timeDisplay.value =
        "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
      } else {
        submitTest();
      }
    });
  }

  void selectOption(String qId, String optId) {
    userSelections[qId] = optId;
    userSelections.refresh();
    // in getx put call then
    if (currentAttemptId.isNotEmpty) {
      final int? optionId = int.tryParse(optId);
      if (optionId != null) {
        _testService
            .submitExamAnswer(
          attemptId: currentAttemptId,
          mcqId: qId,
          optionId: optionId,
        )
            .then((response) {
          debugPrint("Answer submitted : ${response}");
        })
            .catchError((error) {
          debugPrint("Error submitting answer: $error");
        });
      }
    }
  }

  void onPageChanged(int index) {
    currentQuestionIndex.value = index;
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questionsList.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      submitTest();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void submitTest() {
    stopTimer();

    if (currentAttemptId.isNotEmpty) {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      _testService
          .submitExamTest(attemptId: currentAttemptId)
          .then((response) {
        Get.back();
        final data = ExamSubmitResponseModel.fromJson(response);

        if (data.success) {
          examSubmitResult.value = data;
          Get.off(
                () => TestResultScreen(
              testId: currentTestId,
            ),
          );
        } else {
          Get.snackbar("Error", "Submission failed");
        }
      })
          .catchError((error) {
        Get.back();
        Get.snackbar("Error", error.toString());
      });
    } else {
      _calculateAndNavigateStatically();
    }
  }

  void _calculateAndNavigateStatically() {
    // your static calculation logic (same as before)
    int correctCount = 0;
    int wrongCount = 0;
    int unattemptedCount = 0;

    for (var q in questionsList) {
      String? selected = userSelections[q['id']];
      if (selected == null) {
        unattemptedCount++;
      } else if (selected == q['correctAnswerId']) {
        correctCount++;
      } else {
        wrongCount++;
      }
    }

    Get.off(
          () => TestResultScreen(
        testId: currentTestId,
      ),
    );
  }

  Future<TestResponseModel> fetchTestPreview(String testId) async {
    final response = await _testService.getTestPriviewById(testId: testId);
    return TestResponseModel.fromJson(response);
  }

  void fetchExamTests() {
    _apiHandler(
      loader: isExamTestsLoading,
      call: _testService.getExamTests(),
      onData: (response) {
        final rawList = response['data'] as List? ?? [];
        final List<ExamTestModel> allExamTests =
        rawList.map((e) => ExamTestModel.fromJson(e)).toList();
        examTests.assignAll(allExamTests);
      },
    );
  }

  Future<void> _apiHandler({
    required RxBool loader,
    required Future<Map<String, dynamic>> call,
    required Function(Map<String, dynamic> response) onData,
  }) async {
    try {
      loader(true);
      final res = await call;
      if (res['success'] == true) {
        onData(res);
      }
    } catch (e) {
      print("API Error: $e");
    } finally {
      loader(false);
    }
  }
}