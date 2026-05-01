// import 'package:codon/features/settings/screens/rating_screen.dart';
// import 'package:codon/utills/app_theme.dart';
// import 'package:codon/utills/screen_size_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class TestResultScreen extends StatelessWidget {
//   final int totalMcqs;
//   final int correct;
//   final int wrong;
//   final int notAttempted;
//
//   const TestResultScreen({
//     super.key,
//     required this.totalMcqs,
//     required this.correct,
//     required this.wrong,
//     required this.notAttempted,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF8F8F8),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 0.06.toWidthPercent()),
//           child: Column(
//             children: [
//               _buildHeader(),
//               SizedBox(height: 0.04.toHeightPercent()),
//               _buildPerformanceSection(),
//               const Spacer(),
//               _buildReviewButton(),
//               SizedBox(height: 0.04.toHeightPercent()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(width: 48),
//             Text(
//               'Test Result',
//               style: TextStyle(
//                 fontSize: 0.05.toWidthPercent(),
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.close, color: Colors.black, size: 28),
//               onPressed: () => Get.back(),
//             ),
//           ],
//         ),
//         Text(
//           'Score: $correct/$totalMcqs',
//           style: TextStyle(
//             fontSize: 0.06.toWidthPercent(),
//             fontWeight: FontWeight.bold,
//             color: AppColors.primary,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPerformanceSection() {
//     return Container(
//       padding: EdgeInsets.all(0.06.toWidthPercent()),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           SizedBox(height: 0.04.toHeightPercent()),
//           _buildSegmentedBar(),
//           SizedBox(height: 0.06.toHeightPercent()),
//           _buildLegend(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSegmentedBar() {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(4),
//       child: SizedBox(
//         height: 24,
//         child: Row(
//           children: [
//             if (correct > 0)
//               Expanded(
//                 flex: correct,
//                 child: Container(color: const Color(0xFFA5F482)),
//               ),
//             if (wrong > 0)
//               Expanded(
//                 flex: wrong,
//                 child: Container(color: const Color(0xFFFFA07A)),
//               ),
//             if (notAttempted > 0)
//               Expanded(
//                 flex: notAttempted,
//                 child: Container(color: const Color(0xFFF0F0F0)),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLegend() {
//     return Column(
//       children: [
//         _buildLegendItem(const Color(0xFFA5F482), '$correct Correct'),
//         SizedBox(height: 0.02.toHeightPercent()),
//         _buildLegendItem(const Color(0xFFFFA07A), '$wrong Wrong'),
//         SizedBox(height: 0.02.toHeightPercent()),
//         _buildLegendItem(
//           const Color(0xFFF0F0F0),
//           '$notAttempted Not Attempted',
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLegendItem(Color color, String text) {
//     return Row(
//       children: [
//         SizedBox(width: 0.1.toWidthPercent()),
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//         ),
//         SizedBox(width: 0.04.toWidthPercent()),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 0.035.toWidthPercent(),
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildReviewButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () => Get.to(() => const RatingScreen()),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           foregroundColor: Colors.white,
//           padding: EdgeInsets.symmetric(vertical: 0.02.toHeightPercent()),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           elevation: 0,
//         ),
//         child: Text(
//           'Rate Test',
//           style: TextStyle(
//             fontSize: 0.05.toWidthPercent(),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:codon/features/test/domain/models/test_result_priview_model.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../settings/screens/rating_screen.dart';
import '../controllers/tests_controller.dart';
import '../domain/models/test_model.dart';

class TestResultScreen extends StatelessWidget {
  final String testId;

  const TestResultScreen({
    super.key,
    required this.testId,
  });

  @override
  Widget build(BuildContext context) {
    final TestsController controller = Get.find<TestsController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(height: 0.25.toHeightPercent(), color: Colors.white),
              Expanded(
                child: Container(
                  color: const Color(0xFFEFEDED),
                ),
              ),
            ],
          ),

          SafeArea(
            child: Obx(() {
              final result = controller.examSubmitResult.value;


              if (result == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildMainCard(result),
                    SizedBox(height: 0.05.toHeightPercent()),
                    _buildReviewSection(controller),
                    SizedBox(height: 0.05.toHeightPercent()),
                    _buildCloseButton(),
                    SizedBox(height: 0.05.toHeightPercent()),
                    _buildReviewButton(testId)

                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 0.04.toWidthPercent()),
      child: Row(
        children: [
          SizedBox(width: 0.1.toWidthPercent()),

          Expanded(
            child: Text(
              'Quiz Result',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 0.048.toWidthPercent(),
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ),

          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.close,
              color: Colors.black,
              size: 0.12.toWidthPercent(),
            ),
          ),
        ],
      ),
    );
  }

  // ================= MAIN PERFORMANCE CARD =================

  Widget _buildMainCard(ExamSubmitResponseModel result) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 0.05.toWidthPercent(),
        vertical: 0.001.toHeightPercent(),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "${result.percentage ?? "0"}%",
            style: TextStyle(
              fontSize: 0.055.toWidthPercent(),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF77EDF9),
            ),
          ),

          const SizedBox(height: 5),

          const Text("Score"),

          const SizedBox(height: 15),

          CustomPaint(
            size: const Size(220, 65),
            painter: GaussianCurvePainter(),
          ),

          const SizedBox(height: 40),

          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    flex: result.correctAnswer,
                    child: Container(color: const Color(0xFFACF485)),
                  ),
                  Expanded(
                    flex: result.wrongAnswer,
                    child: Container(color: const Color(0xFFFE9E74)),
                  ),
                  Expanded(
                    flex: result.notAttempt,
                    child: Container(color: const Color(0xFFEBEBEB)),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 45),

          _buildLegendRow(const Color(0xFFACF485),
              '${result.correctAnswer} Correct'),

          const SizedBox(height: 25),

          _buildLegendRow(const Color(0xFFFE9E74),
              '${result.wrongAnswer} Wrong'),

          const SizedBox(height: 25),

          _buildLegendRow(
            const Color(0xFFEBEBEB),
            '${result.notAttempt} Not Attempted',
          ),
        ],
      ),
    );
  }

  Widget _buildLegendRow(Color color, String label) {
    return Padding(
      padding: EdgeInsets.only(left: 0.15.toWidthPercent()),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration:
            BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 15),
          Text(
            label,
            style: TextStyle(
              fontSize: 0.04.toWidthPercent(),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ================= REVIEW QUESTIONS =================


  Widget _buildReviewSection(TestsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0.05.toWidthPercent()),
          child: Text(
            "Review Questions",
            style: TextStyle(
              fontSize: 0.05.toWidthPercent(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),

        FutureBuilder<TestResponseModel>(
          future: controller.fetchTestPreview(testId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (!snapshot.hasData || snapshot.data?.data?.mcqs == null) {
              return const SizedBox();
            }

            final mcqList = snapshot.data!.data!.mcqs!;
            final limit = snapshot.data!.data!.mcqLimit ?? mcqList.length;
            final displayCount = limit > mcqList.length ? mcqList.length : limit;

            // You need userAnswers map: { questionIndex: selectedOptionIndex }
            // Get this from your controller
            // final userAnswers = controller.; // Map<int, int>

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayCount,
              itemBuilder: (context, index) {
                return _buildQuestionReviewCard(
                  mcq: mcqList[index],
                  questionNumber: index + 1,
                  // selectedAnswer: correctAnswerName[index], // null if not answered
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuestionReviewCard({
    required Mcq mcq,
    required int questionNumber,
    int? selectedAnswer,
  }) {
    final correctIndex = (mcq.correctAnswer ?? 1) - 1; // convert 1-based to 0-based
    final isCorrect = selectedAnswer != null && selectedAnswer == correctIndex;
    final isIncorrect = selectedAnswer != null && selectedAnswer != correctIndex;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Row: Question N  +  Correct/Incorrect badge ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Question $questionNumber",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              if (selectedAnswer != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? const Color(0xFFE6F4EA)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isCorrect ? "Correct" : "Incorrect",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isCorrect
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFFC62828),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Question text ──
          if (mcq.question?.text != null && mcq.question!.text!.isNotEmpty)
            Text(
              mcq.question!.text!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),

          // ── Question images ──
          if (mcq.question?.images != null && mcq.question!.images!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  mcq.question!.images!.first,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),

          const SizedBox(height: 12),

          // ── Options ──
          if (mcq.options != null)
            ...List.generate(mcq.options!.length, (i) {
              final option = mcq.options![i];
              final label = String.fromCharCode(65 + i); // A, B, C, D
              final isSelected = selectedAnswer == i;
              final isThisCorrect = i == correctIndex;

              Color bgColor = const Color(0xFFF5F5F5);
              Color borderColor = const Color(0xFFE0E0E0);
              Color textColor = Colors.black87;
              Color labelBgColor = const Color(0xFFE0E0E0);
              Color labelTextColor = Colors.black54;
              Widget? trailingIcon;

              if (isThisCorrect) {
                bgColor = const Color(0xFFE8F5E9);
                borderColor = const Color(0xFF4CAF50);
                textColor = const Color(0xFF2E7D32);
                labelBgColor = const Color(0xFF4CAF50);
                labelTextColor = Colors.white;
                trailingIcon = const Icon(Icons.check_circle,
                    color: Color(0xFF4CAF50), size: 20);
              } else if (isSelected && !isThisCorrect) {
                bgColor = const Color(0xFFFFEBEE);
                borderColor = const Color(0xFFF44336);
                textColor = const Color(0xFFC62828);
                labelBgColor = const Color(0xFFF44336);
                labelTextColor = Colors.white;
                trailingIcon = const Icon(Icons.cancel,
                    color: Color(0xFFF44336), size: 20);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    // Label circle
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: labelBgColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        label,
                        style: TextStyle(
                          color: labelTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Option text / image
                    Expanded(
                      child: option.image != null && option.image!.isNotEmpty
                          ? Image.network(option.image!, height: 40,
                          errorBuilder: (_, __, ___) =>
                              Text(option.text ?? "", style: TextStyle(color: textColor)))
                          : Text(
                        option.text ?? "",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    if (trailingIcon != null) trailingIcon,
                  ],
                ),
              );
            }),

          // ── Explanation ──
          if (mcq.explanation?.text != null && mcq.explanation!.text!.isNotEmpty)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Explanation:",
                    style: TextStyle(
                      color: Color(0xFF1565C0),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mcq.explanation!.text!,
                    style: const TextStyle(
                      color: Color(0xFF1565C0),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }


  // Widget _buildReviewSection(TestsController controller) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(left: 0.05.toWidthPercent()),
  //         child: Text(
  //           "Review Questions",
  //           style: TextStyle(
  //             fontSize: 0.05.toWidthPercent(),
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 12),
  //
  //       FutureBuilder<TestResponseModel>(
  //         future: controller.fetchTestPreview(testId),
  //         builder: (context, snapshot) {
  //
  //           // 🔵 Loading
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return const Center(child: CircularProgressIndicator());
  //           }
  //
  //           // 🔴 Error
  //           if (snapshot.hasError) {
  //             return const Text("Something went wrong");
  //           }
  //
  //           // 🟡 No Data
  //           if (!snapshot.hasData ||
  //               snapshot.data?.data?.mcqs == null) {
  //             return const SizedBox();
  //           }
  //
  //           final mcqList = snapshot.data!.data!.mcqs!;
  //           final limit =
  //               snapshot.data!.data!.mcqLimit ?? mcqList.length;
  //
  //           return ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount:
  //             limit > mcqList.length ? mcqList.length : limit,
  //             itemBuilder: (context, index) {
  //
  //               final q = mcqList[index];
  //
  //               return Container(
  //                 margin: EdgeInsets.symmetric(
  //                   horizontal: 0.05.toWidthPercent(),
  //                   vertical: 6,
  //                 ),
  //                 padding: const EdgeInsets.all(14),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(15),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.black.withOpacity(0.05),
  //                       blurRadius: 10,
  //                     ),
  //                   ],
  //                 ),
  //                 child: Text(
  //                   q.question?.text ?? "",
  //                   style: const TextStyle(
  //                       fontWeight: FontWeight.w500),
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }
  Widget _buildCloseButton() {
    return Container(
      width: double.infinity,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 0.15.toWidthPercent()),
      child: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF77EDF9),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Close',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
Widget _buildReviewButton(String? testId) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(
                () => const RatingScreen(),
            arguments: {"targetId":  testId ?? "", "targetType": "test"},
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 0.02.toHeightPercent()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: Text(
          'Leave a Rating',
          style: TextStyle(
            fontSize: 0.05.toWidthPercent(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}



// class TestResultScreen extends StatelessWidget {
//   final int totalMcqs;
//   final int correct;
//   final int wrong;
//   final int notAttempted;
//   final String? percentage;
//   final int? score;
//   final String? testId;
//
//   const TestResultScreen({
//     super.key,
//     required this.totalMcqs,
//     required this.correct,
//     required this.wrong,
//     required this.notAttempted,
//     this.percentage,
//     this.score,
//     this.testId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     int solvedCount = totalMcqs - notAttempted;
//     double accuracy = (percentage != null)
//         ? double.tryParse(percentage!) ?? 0.0
//         : ((totalMcqs > 0) ? (correct / totalMcqs) * 100 : 0);
//
//     return Scaffold(
//
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Container(height: 0.25.toHeightPercent(), color: Colors.white),
//               Expanded(
//                 child: Container(
//                   color: const Color(
//                     0xFFEFEDED,
//                   ), // Exact Pinkish color from screenshot
//                 ),
//               ),
//             ],
//           ),
//
//           // Content Layer
//           SafeArea(
//             child: Column(
//               children: [
//                 _buildHeader(solvedCount),
//                 _buildMainCard(accuracy),
//                 // const Spacer(),
//                 SizedBox(height: 0.05.toHeightPercent()),
//                 _buildReviewButton(),
//
//                 _buildHeader(),
//
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader(int solved) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.symmetric(horizontal: 0.04.toWidthPercent()),
//       child: Row(
//         children: [
//           // Left Spacing to push text to center
//           SizedBox(width: 0.1.toWidthPercent()),
//
//           Expanded(
//             child: Text(
//               'You Solved $solved MCQs',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 0.048
//                     .toWidthPercent(), // Size thoda chota kiya (as per screenshot)
//                 fontWeight: FontWeight.w900, // Extra heavy bold
//                 color: Colors.black,
//                 letterSpacing: -0.5, // Thoda tight spacing
//               ),
//             ),
//           ),
//
//           // X Icon (Bold and Large)
//           GestureDetector(
//             onTap: () => Get.back(),
//             child: Icon(
//               Icons.close,
//               color: Colors.black,
//               size: 0.12.toWidthPercent(), // Icon size prominence di
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMainCard(double accuracy) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(
//         horizontal: 0.05.toWidthPercent(),
//         vertical: 0.001.toHeightPercent(),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             'You Performed',
//             style: TextStyle(
//               fontSize: 0.055.toWidthPercent(),
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF77EDF9),
//             ),
//           ),
//           const SizedBox(height: 15),
//
//           // Bell Curve Graph
//           Column(
//             children: [
//               CustomPaint(
//                 size: const Size(220, 65),
//                 painter: GaussianCurvePainter(),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 "${accuracy.toStringAsFixed(2)}%",
//                 style: const TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black54,
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 40),
//
//           // Horizontal Segmented Bar
//           ClipRRect(
//             borderRadius: BorderRadius.circular(2),
//             child: SizedBox(
//               height: 48,
//               child: Row(
//                 children: [
//                   if (correct > 0)
//                     Expanded(
//                       flex: correct,
//                       child: Container(color: const Color(0xFFACF485)),
//                     ),
//                   if (wrong > 0)
//                     Expanded(
//                       flex: wrong,
//                       child: Container(color: const Color(0xFFFE9E74)),
//                     ),
//                   Expanded(
//                     flex: notAttempted,
//                     child: Container(color: const Color(0xFFEBEBEB)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 45),
//
//           // Legend Section
//           _buildLegendRow(const Color(0xFFACF485), '$correct Correct'),
//           const SizedBox(height: 25),
//           _buildLegendRow(const Color(0xFFFE9E74), '$wrong Wrong'),
//           const SizedBox(height: 25),
//           _buildLegendRow(
//             const Color(0xFFEBEBEB),
//             '$notAttempted Not Attempemd',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLegendRow(Color color, String label) {
//     return Padding(
//       padding: EdgeInsets.only(left: 0.15.toWidthPercent()),
//       child: Row(
//         children: [
//           Container(
//             width: 14,
//             height: 14,
//             decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//           ),
//           const SizedBox(width: 15),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 0.04.toWidthPercent(),
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildReviewButton() {
//     return Container(
//       width: double.infinity,
//       height: 60,
//       margin: EdgeInsets.symmetric(horizontal: 0.15.toWidthPercent()),
//       child: ElevatedButton(
//         onPressed: () {
//           Get.to(
//             () => const RatingScreen(),
//             arguments: {"targetId": testId ?? "", "targetType": "test"},
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF77EDF9),
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//         child: Text(
//           'Review',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 0.055.toWidthPercent(),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const SizedBox(width: 48),
//         Text(
//           'Quiz Result',
//           style: TextStyle(
//             fontSize: 0.05.toWidthPercent(),
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         IconButton(
//           icon: const Icon(Icons.close, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//       ],
//     );
//   }
// // ================= PERFORMANCE =================
//
//   Widget _buildPerformanceSection(ExamSubmitResponseModel result) {
//     return Container(
//       padding: EdgeInsets.all(0.06.toWidthPercent()),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             "${result.percentage ?? "0"}%",
//             style: TextStyle(
//               fontSize: 0.12.toWidthPercent(),
//               fontWeight: FontWeight.bold,
//               color: AppColors.primary,
//             ),
//           ),
//
//           const Text("Score"),
//
//           SizedBox(height: 20),
//
//           /// Segmented Bar
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             child: SizedBox(
//               height: 24,
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: result.correctAnswer,
//                     child: Container(color: const Color(0xFFA5F482)),
//                   ),
//                   Expanded(
//                     flex: result.wrongAnswer,
//                     child: Container(color: const Color(0xFFFFA07A)),
//                   ),
//                   Expanded(
//                     flex: result.notAttempt,
//                     child: Container(color: const Color(0xFFF0F0F0)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ================= REVIEW QUESTIONS =================
//
//   Widget _buildReviewSection(TestsController controller) {
//     final result = controller.examSubmitResult.value;
//
//     if (result == null || result.questions == null) {
//       return const SizedBox();
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Review Questions",
//           style: TextStyle(
//             fontSize: 0.05.toWidthPercent(),
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//
//         SizedBox(height: 0.02.toHeightPercent()),
//
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: result.questions!.length,
//           itemBuilder: (context, index) {
//             final question = result.questions![index];
//
//             return Container(
//               margin: EdgeInsets.only(
//                 bottom: 0.03.toHeightPercent(),
//               ),
//               padding: EdgeInsets.all(0.04.toWidthPercent()),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Text(
//                 question.question?.text ?? "",
//                 style: const TextStyle(fontWeight: FontWeight.w500),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildReviewButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () => Get.back(),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           foregroundColor: Colors.white,
//         ),
//         child: const Text("Close"),
//       ),
//     );
//   }
// }







class GaussianCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFF77EDF9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    var path = Path();
    path.moveTo(0, size.height * 0.85);
    path.lineTo(size.width * 0.2, size.height * 0.85);
    path.cubicTo(
      size.width * 0.4,
      size.height * 0.85,
      size.width * 0.45,
      0,
      size.width * 0.5,
      0,
    );
    path.cubicTo(
      size.width * 0.55,
      0,
      size.width * 0.6,
      size.height * 0.85,
      size.width * 0.8,
      size.height * 0.85,
    );
    path.lineTo(size.width, size.height * 0.85);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
