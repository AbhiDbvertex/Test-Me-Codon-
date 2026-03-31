// // import 'package:codon/features/qtest/controllers/qtest_controller.dart';
// // import 'package:codon/features/qtest/models/chapter_test_model.dart';
// // import 'package:codon/features/qtest/models/qtest_models.dart';
// // import 'package:codon/utills/api_urls.dart';
// // import 'package:codon/utills/app_theme.dart';
// // import 'package:codon/utills/screen_size_utils.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// // import 'package:get/get.dart';
// //
// // class BookmarkMCQdetailScreen extends StatefulWidget {
// //   final ChapterTestModel? qTest;
// //   final id;
// //   final title;
// //   final otpions;
// //   // final
// //   const BookmarkMCQdetailScreen({super.key, this.qTest, this.id, this.title, this.otpions});
// //
// //   @override
// //   State<BookmarkMCQdetailScreen> createState() => _BookmarkMCQdetailScreenState();
// // }
// //
// // class _BookmarkMCQdetailScreenState extends State<BookmarkMCQdetailScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     final QTestController controller = Get.find<QTestController>();
// //
// //
// //     // Reset quiz state when entering the screen
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       controller.fetchQTest(widget.id ?? "0");
// //     });
// //
// //     return PopScope(
// //       // canPop: false,
// //       // onPopInvoked: (didPop) async {
// //       //   if (didPop) return;
// //       //   final shouldPop = await _showQuitConfirmationDialog(context);
// //       //   if (shouldPop == true) {
// //       //     Get.back();
// //       //   }
// //       // },
// //       child: SafeArea(
// //         top: false,
// //         child: Scaffold(
// //           backgroundColor: Color(0xFFF8F8F8),
// //           appBar: AppBar(
// //             title: Text(
// //               widget.title ?? "",
// //               style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.black,
// //               ),
// //             ),
// //             centerTitle: true,
// //             backgroundColor: Colors.white,
// //             surfaceTintColor: Colors.white,
// //             elevation: 0,
// //             automaticallyImplyLeading: false,
// //             actions: [
// //               // Obx(
// //               //       () => Container(
// //               //     margin: const EdgeInsets.only(right: 1),
// //               //     padding: const EdgeInsets.symmetric(
// //               //       horizontal: 10,
// //               //       vertical: 5,
// //               //     ),
// //               //     decoration: BoxDecoration(
// //               //       color: AppColors.primary.withOpacity(0.1),
// //               //       borderRadius: BorderRadius.circular(20),
// //               //     ),
// //               //     child: Row(
// //               //       mainAxisSize: MainAxisSize.min,
// //               //       children: [
// //               //         const Icon(
// //               //           Icons.timer_outlined,
// //               //           size: 20,
// //               //           color: AppColors.primary,
// //               //         ),
// //               //         const SizedBox(width: 5),
// //               //         Text(
// //               //           '${controller.remainingSeconds.value}s',
// //               //           style: const TextStyle(
// //               //             fontWeight: FontWeight.bold,
// //               //             color: AppColors.primary,
// //               //           ),
// //               //         ),
// //               //       ],
// //               //     ),
// //               //   ),
// //               // ),
// //               // IconButton(
// //               //   icon: const Icon(Icons.close, color: Colors.black, size: 28),
// //               //   onPressed: () =>
// //               //       _showQuitConfirmationDialog(context).then((value) {
// //               //         if (value == true) Get.back();
// //               //       }),
// //               // ),
// //             ],
// //           ),
// //           body: Obx(() {
// //             if (controller.isLoading.value) {
// //               return const Center(child: CircularProgressIndicator());
// //             }
// //             if (controller.questions.isEmpty) {
// //               return const Center(child: Text('No questions available'));
// //             }
// //             return Column(
// //               children: [
// //                 // Progress indicator: Dots
// //                 // Padding(
// //                 //   padding: EdgeInsets.symmetric(
// //                 //     vertical: 0.02.toHeightPercent(),
// //                 //   ),
// //                 //   child: Obx(
// //                 //         () => Row(
// //                 //       mainAxisAlignment: MainAxisAlignment.center,
// //                 //       children: List.generate(
// //                 //         controller.questions.length,
// //                 //             (index) => Container(
// //                 //           margin: const EdgeInsets.symmetric(horizontal: 3),
// //                 //           width: 8,
// //                 //           height: 8,
// //                 //           decoration: BoxDecoration(
// //                 //             shape: BoxShape.circle,
// //                 //             color: index == controller.currentQuestionIndex.value
// //                 //                 ? AppColors.primary
// //                 //                 : Colors.grey[300],
// //                 //           ),
// //                 //         ),
// //                 //       ),
// //                 //     ),
// //                 //   ),
// //                 // ),
// //                 Expanded(
// //                   child: PageView.builder(
// //                     controller: controller.pageController,
// //                     onPageChanged: controller.onPageChanged,
// //                     itemCount: controller.questions.length,
// //                     itemBuilder: (context, index) {
// //                       final currentQuestion = controller.questions[index];
// //                       return Obx(() {
// //                         return SingleChildScrollView(
// //                           padding: EdgeInsets.symmetric(
// //                             horizontal: 0.04.toWidthPercent(),
// //                           ),
// //                           child: Column(
// //                             //crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               SizedBox(height: 0.02.toHeightPercent()),
// //                               // White card for question and options
// //                               Container(
// //                                 padding: EdgeInsets.all(0.04.toWidthPercent()),
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.white,
// //                                   borderRadius: BorderRadius.circular(20),
// //                                   boxShadow: [
// //                                     BoxShadow(
// //                                       color: Colors.black.withOpacity(0.05),
// //                                       blurRadius: 15,
// //                                       offset: const Offset(0, 5),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 child: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Text(
// //                                       (index + 1).toString() +
// //                                           ". " +
// //                                           currentQuestion.question.text,
// //                                       style: TextStyle(
// //                                         fontSize: 0.042.toWidthPercent(),
// //                                         fontWeight: FontWeight.w500,
// //                                         color: AppColors.primary,
// //                                       ),
// //                                     ),
// //                                     if (currentQuestion
// //                                         .question
// //                                         .images
// //                                         .isNotEmpty) ...[
// //                                       SizedBox(height: 0.02.toHeightPercent()),
// //                                       ...currentQuestion.question.images.map(
// //                                             (img) =>
// //                                             _buildQuestionImage(baseUrl + img),
// //                                         // (img) => ClipRRect(
// //                                         //   borderRadius: BorderRadius.circular(12),
// //                                         //   child: Container(
// //                                         //     constraints: BoxConstraints(
// //                                         //       maxHeight: 0.2.toHeightPercent(),
// //                                         //     ),
// //                                         //     width: double.infinity,
// //                                         //     child: Image.network(
// //                                         //       baseUrl + img,
// //                                         //       fit: BoxFit.contain,
// //                                         //       errorBuilder:
// //                                         //           (context, error, stackTrace) =>
// //                                         //               const SizedBox(),
// //                                         //     ),
// //                                         //   ),
// //                                         // ),
// //                                       ),
// //                                     ],
// //                                     SizedBox(height: 0.03.toHeightPercent()),
// //                                     Divider(color: AppColors.primary),
// //                                     SizedBox(height: 0.03.toHeightPercent()),
// //                                     ...List.generate(
// //                                       currentQuestion.options.length,
// //                                           (idx) => _buildOption(
// //                                         currentQuestion.options[idx],
// //                                         idx,
// //                                         controller,
// //                                         index,
// //                                       ),
// //                                     ),
// //                                     SizedBox(height: 0.02.toHeightPercent()),
// //                                     // MCQ ID Section
// //                                     Center(
// //                                       child: Container(
// //                                         padding: const EdgeInsets.symmetric(
// //                                           horizontal: 12,
// //                                           vertical: 6,
// //                                         ),
// //                                         decoration: BoxDecoration(
// //                                           color: Colors.white,
// //                                           borderRadius: BorderRadius.circular(
// //                                             8,
// //                                           ),
// //                                           boxShadow: [
// //                                             BoxShadow(
// //                                               color: Colors.black.withOpacity(
// //                                                 0.05,),
// //                                               blurRadius: 5,
// //                                             ),
// //                                           ],
// //                                         ),
// //                                         child: Row(
// //                                           mainAxisSize: MainAxisSize.min,
// //                                           children: [
// //                                             Expanded(
// //                                               child: Text(
// //                                                 'MCQ ID: ${currentQuestion.id}',
// //                                                 overflow: TextOverflow.ellipsis,
// //                                                 style: TextStyle(
// //                                                   color: Colors.grey[600],
// //                                                   fontSize: 0.035
// //                                                       .toWidthPercent(),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                             const SizedBox(width: 8),
// //                                             Icon(
// //                                               Icons.copy_rounded,
// //                                               size: 18,
// //                                               color: Colors.grey[400],
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                               SizedBox(height: 0.02.toHeightPercent()),
// //                               // Tags and Pearl ID Row (outside card)
// //                               if (currentQuestion.tags.isNotEmpty ||
// //                                   currentQuestion.tagId.isNotEmpty)
// //                                 Wrap(
// //                                   alignment: WrapAlignment.end,
// //                                   spacing: 8,
// //                                   runSpacing: 8,
// //                                   children: [
// //                                     if (currentQuestion.tags.isNotEmpty)
// //                                       ...currentQuestion.tags.map(
// //                                             (tag) => Container(
// //                                           padding: const EdgeInsets.symmetric(
// //                                             horizontal: 10,
// //                                             vertical: 5,
// //                                           ),
// //                                           decoration: BoxDecoration(
// //                                             color: AppColors.primary,
// //                                             borderRadius: BorderRadius.circular(
// //                                               12,
// //                                             ),
// //                                           ),
// //                                           child: Text(
// //                                             tag.startsWith('#') ? tag : "#$tag",
// //                                             style: TextStyle(
// //                                               color: Colors.grey[700],
// //                                               fontSize: 0.03.toWidthPercent(),
// //                                               fontWeight: FontWeight.w500,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       )
// //                                     else if (currentQuestion.tagId.isNotEmpty)
// //                                       Container(
// //                                         padding: const EdgeInsets.symmetric(
// //                                           horizontal: 10,
// //                                           vertical: 5,
// //                                         ),
// //                                         decoration: BoxDecoration(
// //                                           color: AppColors.primary,
// //                                           borderRadius: BorderRadius.circular(
// //                                             12,
// //                                           ),
// //                                         ),
// //                                         child: Text(
// //                                           currentQuestion.tagId.startsWith('#')
// //                                               ? currentQuestion.tagId
// //                                               : "#${currentQuestion.tagId}",
// //                                           style: TextStyle(
// //                                             color: Colors.grey[700],
// //                                             fontSize: 0.03.toWidthPercent(),
// //                                             fontWeight: FontWeight.w500,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                   ],
// //                                 ),
// //                               SizedBox(height: 0.02.toHeightPercent()),
// //                               Align(
// //                                 alignment: Alignment.centerLeft,
// //                                 child: InkWell(
// //                                   onTap: () {
// //                                     Clipboard.setData(
// //                                       ClipboardData(
// //                                         text: currentQuestion.codonId,
// //                                       ),
// //                                     );
// //                                     Get.snackbar(
// //                                       'Copied',
// //                                       'Codon ID copied to clipboard',
// //                                       snackPosition: SnackPosition.BOTTOM,
// //                                       backgroundColor: Colors.black87,
// //                                       colorText: Colors.white,
// //                                       duration: const Duration(seconds: 1),
// //                                       margin: const EdgeInsets.all(10),
// //                                     );
// //                                   },
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   child: Container(
// //                                     padding: const EdgeInsets.symmetric(
// //                                       horizontal: 10,
// //                                       vertical: 5,
// //                                     ),
// //                                     decoration: BoxDecoration(
// //                                       color: Colors.grey[200],
// //                                       borderRadius: BorderRadius.circular(5),
// //                                     ),
// //                                     child: Row(
// //                                       mainAxisSize: MainAxisSize.min,
// //                                       children: [
// //                                         Text(
// //                                           'Codon ID: ${currentQuestion.codonId}',
// //                                           style: TextStyle(
// //                                             color: Colors.grey[700],
// //                                             fontSize: 0.03.toWidthPercent(),
// //                                             fontWeight: FontWeight.w500,
// //                                           ),
// //                                         ),
// //                                         const SizedBox(width: 5),
// //                                         Icon(
// //                                           Icons.copy_rounded,
// //                                           size: 0.035.toWidthPercent(),
// //                                           color: Colors.grey[600],
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(height: 0.02.toHeightPercent()),
// //                               // View Explanation Button (outside card)
// //                               controller.userAnswers.containsKey(
// //                                 currentQuestion.id,
// //                               )
// //                                   ? Container(
// //                                 decoration: BoxDecoration(
// //                                   color: AppColors.primary,
// //                                   borderRadius: BorderRadius.circular(22),
// //                                 ),
// //                                 width: 0.6.toWidthPercent(),
// //                                 height: 0.06.toHeightPercent(),
// //                                 // child: ElevatedButton(
// //                                 //   onPressed: controller.togglePearl,
// //                                 //   style: ElevatedButton.styleFrom(
// //                                 //     backgroundColor: AppColors.primary,
// //                                 //     foregroundColor: Colors.grey[700],
// //                                 //     padding: EdgeInsets.symmetric(
// //                                 //       vertical: 0.012.toHeightPercent(),
// //                                 //     ),
// //                                 //     shape: RoundedRectangleBorder(
// //                                 //       borderRadius: BorderRadius.circular(
// //                                 //         10,
// //                                 //       ),
// //                                 //     ),
// //                                 //     elevation: 0,
// //                                 //   ),
// //                                 //   child: Text(
// //                                 //     'View Explanation',
// //                                 //     style: TextStyle(
// //                                 //       fontSize: 0.025.toWidthPercent(),
// //                                 //       fontWeight: FontWeight.bold,
// //                                 //     ),
// //                                 //   ),
// //                                 // ),
// //
// //                                 child: ElevatedButton(
// //                                   onPressed: controller.togglePearl,
// //                                   style: ElevatedButton.styleFrom(
// //                                     backgroundColor:
// //                                     AppColors.primary,
// //                                     foregroundColor: Colors.white,
// //                                     padding: EdgeInsets.symmetric(
// //                                       vertical: 0.012
// //                                           .toHeightPercent(),
// //                                     ),
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius:
// //                                       BorderRadius.circular(
// //                                         0.02.toWidthPercent(),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   child: Row(
// //                                     mainAxisAlignment:
// //                                     MainAxisAlignment.center,
// //                                     children: [
// //                                       Icon(
// //                                         controller.showPearl.value
// //                                             ? Icons.visibility_off
// //                                             : Icons.visibility,
// //                                         size: 0.045.toWidthPercent(),
// //                                       ),
// //                                       SizedBox(
// //                                         width: 0.02.toWidthPercent(),
// //                                       ),
// //                                       Text(
// //                                         controller.showPearl.value
// //                                             ? 'Hide Explanation'
// //                                             : 'View Explanation',
// //                                         style: TextStyle(
// //                                           fontSize: 0.04
// //                                               .toWidthPercent(),
// //                                           fontWeight: FontWeight.bold,
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               )
// //                                   : SizedBox(),
// //                               SizedBox(height: 0.03.toHeightPercent()),
// //                               if (controller.showPearl.value) ...[
// //                                 SizedBox(height: 0.02.toHeightPercent()),
// //                                 // Explanation Content
// //                                 Container(
// //                                   width: double.infinity,
// //                                   padding: const EdgeInsets.all(16),
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(15),
// //                                     boxShadow: [
// //                                       BoxShadow(
// //                                         color: Colors.black.withOpacity(0.05),
// //                                         blurRadius: 10,
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                     CrossAxisAlignment.start,
// //                                     children: [
// //                                       HtmlWidget(
// //                                         currentQuestion.explanation.text,
// //                                       ),
// //                                       if (currentQuestion
// //                                           .explanation
// //                                           .images
// //                                           .isNotEmpty) ...[
// //                                         SizedBox(height: 10),
// //                                         ...currentQuestion.explanation.images
// //                                             .map(
// //                                               (img) => Image.network(
// //                                             img,
// //                                             errorBuilder:
// //                                                 (
// //                                                 context,
// //                                                 error,
// //                                                 stackTrace,
// //                                                 ) => const SizedBox(),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ],
// //                           ),
// //                         );
// //                       });
// //                     },
// //                   ),
// //                 ),
// //                 // Bottom Nav
// //                 // Padding(
// //                 //   padding: EdgeInsets.all(0.04.toWidthPercent()),
// //                 //   child: Row(
// //                 //     children: [
// //                 //       Expanded(
// //                 //         child: Obx(
// //                 //               () => OutlinedButton(
// //                 //             onPressed: controller.currentQuestionIndex.value > 0
// //                 //                 ? controller.previousQuestion
// //                 //                 : null,
// //                 //             style: OutlinedButton.styleFrom(
// //                 //               side: const BorderSide(color: AppColors.primary),
// //                 //               shape: RoundedRectangleBorder(
// //                 //                 borderRadius: BorderRadius.circular(12),
// //                 //               ),
// //                 //             ),
// //                 //             child: const Text(
// //                 //               'Previous',
// //                 //               style: TextStyle(color: AppColors.primary),
// //                 //             ),
// //                 //           ),
// //                 //         ),
// //                 //       ),
// //                 //       SizedBox(width: 0.04.toWidthPercent()),
// //                 //       Expanded(
// //                 //         child: Obx(() {
// //                 //           bool isLast =
// //                 //               controller.currentQuestionIndex.value ==
// //                 //                   controller.questions.length - 1;
// //                 //           return ElevatedButton(
// //                 //             onPressed: () {
// //                 //               if (isLast) {
// //                 //                 _showSubmitConfirmationDialog(
// //                 //                   context,
// //                 //                   controller,
// //                 //                 ); // Call Dialog
// //                 //               } else {
// //                 //                 controller.nextQuestion();
// //                 //               }
// //                 //             },
// //                 //             style: ElevatedButton.styleFrom(
// //                 //               backgroundColor: AppColors.primary,
// //                 //               foregroundColor: Colors.white,
// //                 //               shape: RoundedRectangleBorder(
// //                 //                 borderRadius: BorderRadius.circular(12),
// //                 //               ),
// //                 //               elevation: 0,
// //                 //             ),
// //                 //             child: Text(isLast ? 'Submit' : 'Next'),
// //                 //           );
// //                 //         }),
// //                 //       ),
// //                 //     ],
// //                 //   ),
// //                 // ),
// //               ],
// //             );
// //           }),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildOption(
// //       McqOption option,
// //       int index,
// //       QTestController controller,
// //       int questionIndex,
// //       ) {
// //     final currentQuestion = controller.questions[questionIndex];
// //     bool isAnswered = controller.userAnswers.containsKey(currentQuestion.id);
// //     bool isCorrectAnswer = index == currentQuestion.correctAnswer;
// //     bool isSelectedByUser = controller.selectedAnswerIndex.value == index;
// //
// //     Color bgColor = const Color(0xFFF0FEFF);
// //     Color textColor = Colors.black87;
// //
// //     if (isAnswered) {
// //       if (isCorrectAnswer) {
// //         bgColor = const Color(0xFFA5F482); // Green for correct answer
// //         textColor = Colors.white;
// //       } else if (isSelectedByUser) {
// //         bgColor = const Color(
// //           0xFFFFA07A,
// //         ); // Red/Orange for selected wrong answer
// //         textColor = Colors.white;
// //       } else {
// //         bgColor = const Color(
// //           0xFFF0FEFF,
// //         ); // Default for unselected wrong options
// //         textColor = Colors.black87;
// //       }
// //     } else if (isSelectedByUser) {
// //       // This case might not be reached if we disable selection after answer,
// //       // but keeping it for immediate feedback logic if needed before persisting 'isAnswered' state fully?
// //       // Actually with the controller change, isSelectedByUser will be true and isAnswered will be true immediately.
// //       // So the logic above covers it.
// //     }
// //
// //     return Container(
// //       width: double.infinity,
// //       margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
// //       decoration: BoxDecoration(
// //         color: bgColor,
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Material(
// //         color: Colors.transparent,
// //         borderRadius: BorderRadius.circular(10),
// //         child: InkWell(
// //           onTap: isAnswered ? null : () => controller.selectAnswer(index),
// //           borderRadius: BorderRadius.circular(10),
// //           child: Padding(
// //             padding: EdgeInsets.all(0.04.toWidthPercent()),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 if (option.image != null && option.image!.isNotEmpty) ...[
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.circular(8),
// //                     child: Image.network(
// //                       baseUrl + option.image!,
// //                       scale: 8,
// //                       // height: 100,
// //                       // width: double.infinity,
// //                       fit: BoxFit.cover,
// //                       errorBuilder: (context, error, stackTrace) =>
// //                       const SizedBox(),
// //                     ),
// //                   ),
// //                   SizedBox(height: 0.01.toHeightPercent()),
// //                 ],
// //                 Row(
// //                   children: [
// //                     Container(
// //                       padding: EdgeInsets.all(0.015.toWidthPercent()),
// //                       decoration: BoxDecoration(
// //                         color: isAnswered
// //                             ? (isCorrectAnswer
// //                             ? Colors.white.withOpacity(0.3)
// //                             : (isSelectedByUser
// //                             ? Colors.white.withOpacity(0.3)
// //                             : AppColors.primary))
// //                             : AppColors.primary,
// //                         borderRadius: BorderRadius.circular(5),
// //                       ),
// //                       child: Text(
// //                         String.fromCharCode(65 + index), // A, B, C, D
// //                         style: TextStyle(
// //                           fontSize: 0.035.toWidthPercent(),
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                     ),
// //                     SizedBox(width: 0.03.toWidthPercent()),
// //                     Expanded(
// //                       child: Text(
// //                         option.text,
// //                         style: TextStyle(
// //                           fontSize: 0.038.toWidthPercent(),
// //                           fontWeight: FontWeight.w600,
// //                           color: textColor,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildQuestionImage(String? url) {
// //     // 1. URL empty hai toh gap bhi mat dikhao
// //     if (url == null || url.isEmpty) return const SizedBox.shrink();
// //
// //     return Container(
// //       margin: const EdgeInsets.symmetric(vertical: 15),
// //       width: double.infinity,
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(15),
// //         border: Border.all(color: const Color(0xFF77EDF9).withOpacity(0.2)),
// //       ),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(15),
// //         child: Image.network(
// //           url,
// //           fit: BoxFit.cover,
// //           // Loading State
// //           loadingBuilder: (context, child, loadingProgress) {
// //             if (loadingProgress == null) return child;
// //             return Container(
// //               height: 150,
// //               color: Colors.grey[50],
// //               child: const Center(
// //                 child: CircularProgressIndicator(strokeWidth: 2),
// //               ),
// //             );
// //           },
// //           // Error State: Agar internet band ho ya URL expire ho jaye toh box gayab
// //           errorBuilder: (context, error, stackTrace) {
// //             debugPrint("Image Error: $error");
// //             return const SizedBox.shrink(); // Box gayab ho jayega
// //           },
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Future<bool?> _showQuitConfirmationDialog(BuildContext context) {
// //     return showDialog<bool>(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
// //         contentPadding: EdgeInsets.zero,
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             // Red Alert Header
// //             Container(
// //               height: 0.07.toHeightPercent(),
// //               width: double.infinity,
// //               decoration: const BoxDecoration(
// //                 color: Colors.redAccent,
// //                 borderRadius: BorderRadius.only(
// //                   topLeft: Radius.circular(24),
// //                   topRight: Radius.circular(24),
// //                 ),
// //               ),
// //               child: const Icon(
// //                 Icons.warning_amber_rounded,
// //                 size: 35,
// //                 color: Colors.white,
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.all(0.06.toWidthPercent()),
// //               child: Column(
// //                 children: [
// //                   Text(
// //                     "Quit Assessment?",
// //                     style: TextStyle(
// //                       fontSize: 0.05.toWidthPercent(),
// //                       fontWeight: FontWeight.w900,
// //                     ),
// //                   ),
// //                   SizedBox(height: 0.015.toHeightPercent()),
// //                   Text(
// //                     "Are you sure you want to leave? Your current progress in this session might not be saved.",
// //                     textAlign: TextAlign.center,
// //                     style: TextStyle(
// //                       fontSize: 0.035.toWidthPercent(),
// //                       color: Colors.black54,
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                   SizedBox(height: 0.03.toHeightPercent()),
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: TextButton(
// //                           onPressed: () => Navigator.pop(context, false),
// //                           child: const Text(
// //                             "CONTINUE TEST",
// //                             style: TextStyle(
// //                               color: Colors.black45,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       Expanded(
// //                         child: ElevatedButton(
// //                           onPressed: () => Navigator.pop(context, true),
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: Colors.redAccent,
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(12),
// //                             ),
// //                             elevation: 0,
// //                           ),
// //                           child: const Text(
// //                             "QUIT",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.w900,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Future<void> _showSubmitConfirmationDialog(
// //       BuildContext context,
// //       QTestController controller,
// //       ) {
// //     return showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
// //         contentPadding: EdgeInsets.zero,
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             // Cyan Success Header
// //             Container(
// //               height: 0.07.toHeightPercent(),
// //               width: double.infinity,
// //               decoration: const BoxDecoration(
// //                 color: AppColors.primary,
// //                 borderRadius: BorderRadius.only(
// //                   topLeft: Radius.circular(24),
// //                   topRight: Radius.circular(24),
// //                 ),
// //               ),
// //               child: const Icon(
// //                 Icons.check_circle_outline,
// //                 size: 35,
// //                 color: Colors.white,
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.all(0.06.toWidthPercent()),
// //               child: Column(
// //                 children: [
// //                   Text(
// //                     "Final Submission",
// //                     style: TextStyle(
// //                       fontSize: 0.05.toWidthPercent(),
// //                       fontWeight: FontWeight.w900,
// //                     ),
// //                   ),
// //                   SizedBox(height: 0.015.toHeightPercent()),
// //                   Text(
// //                     "You have reached the end of the test. Would you like to submit your answers and view the result?",
// //                     textAlign: TextAlign.center,
// //                     style: TextStyle(
// //                       fontSize: 0.035.toWidthPercent(),
// //                       color: Colors.black54,
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                   SizedBox(height: 0.03.toHeightPercent()),
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: TextButton(
// //                           onPressed: () => Navigator.pop(context),
// //                           child: const Text(
// //                             "REVIEW",
// //                             style: TextStyle(
// //                               color: Colors.black45,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       Expanded(
// //                         child: ElevatedButton(
// //                           onPressed: () {
// //                             Navigator.pop(context);
// //                             controller.nextQuestion(); // Final Submit Logic
// //                           },
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: AppColors.primary,
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(12),
// //                             ),
// //                             elevation: 0,
// //                           ),
// //                           child: const Text(
// //                             "SUBMIT",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.w900,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:codon/features/qtest/controllers/qtest_controller.dart';
// import 'package:codon/features/qtest/models/chapter_test_model.dart';
// import 'package:codon/features/qtest/models/qtest_models.dart';
// import 'package:codon/utills/api_urls.dart';
// import 'package:codon/utills/app_theme.dart';
// import 'package:codon/utills/screen_size_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:get/get.dart';
//
// class BookmarkMCQdetailScreen extends StatefulWidget {
//   final ChapterTestModel? qTest;
//   final String? id;       // ← ye bookmark ka MCQ ID hoga
//   final String? title;
//   final dynamic otpions;  // agar use nahi ho raha to remove kar sakte ho
//
//   const BookmarkMCQdetailScreen({
//     super.key,
//     this.qTest,
//     this.id,
//     this.title,
//     this.otpions,
//   });
//
//   @override
//   State<BookmarkMCQdetailScreen> createState() => _BookmarkMCQdetailScreenState();
// }
//
// class _BookmarkMCQdetailScreenState extends State<BookmarkMCQdetailScreen> {
//   @override
//   void initState() {
//     super.initState();
//
//     final controller = Get.find<QTestController>();
//
//     // Important: reset states
//     controller.questions.clear();
//     controller.userAnswers.clear();
//     controller.currentQuestionIndex.value = 0;
//     controller.showPearl.value = false;
//     controller.selectedAnswerIndex.value = -1;
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.id == null || widget.id!.isEmpty) {
//         Get.snackbar("Error", "No MCQ ID provided for bookmark");
//         Get.back();
//         return;
//       }
//
//       // Poora test fetch kar rahe hain (jaise pehle tha)
//       controller.fetchQTest(widget.id ?? "0");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final QTestController controller = Get.find<QTestController>();
//     final String? targetMcqId = widget.id;
//
//     return PopScope(
//       canPop: true, // ya false rakh sakte ho agar confirmation chahiye
//       child: SafeArea(
//         top: false,
//         child: Scaffold(
//           backgroundColor: const Color(0xFFF8F8F8),
//           appBar: AppBar(
//             title: Text(
//               widget.title ?? "Bookmarked Question",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.white,
//             elevation: 0,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.black),
//               onPressed: () => Get.back(),
//             ),
//           ),
//           body: Obx(() {
//             if (controller.isLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (controller.questions.isEmpty) {
//               return const Center(child: Text('No questions loaded'));
//             }
//
//             // ------------------ FILTER: sirf bookmark wala question ------------------
//             final filtered = controller.questions
//                 .where((q) => q.id == targetMcqId)
//                 .toList();
//
//             if (filtered.isEmpty) {
//               return const Center(
//                 child: Text(
//                   'Bookmarked question not found',
//                   style: TextStyle(fontSize: 18, color: Colors.grey),
//                   textAlign: TextAlign.center,
//                 ),
//               );
//             }
//
//             // Sirf ek question hoga (normally)
//             final question = filtered.first;
//             final questionIndex = controller.questions.indexOf(question);
//
//             return SingleChildScrollView(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 0.04.toWidthPercent(),
//                 vertical: 16,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 8),
//
//                   // White card → question + options
//                   Container(
//                     padding: EdgeInsets.all(0.04.toWidthPercent()),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 15,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${questionIndex + 1}. ${question.question.text}",
//                           style: TextStyle(
//                             fontSize: 0.042.toWidthPercent(),
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.primary,
//                           ),
//                         ),
//
//                         if (question.question.images.isNotEmpty) ...[
//                           const SizedBox(height: 16),
//                           ...question.question.images.map(
//                                 (img) => _buildQuestionImage(baseUrl + img),
//                           ),
//                         ],
//
//                         const SizedBox(height: 24),
//                         const Divider(color: AppColors.primary),
//                         const SizedBox(height: 24),
//
//                         ...List.generate(
//                           question.options.length,
//                               (idx) => _buildOption(
//                             question.options[idx],
//                             idx,
//                             controller,
//                             questionIndex,
//                           ),
//                         ),
//
//                         const SizedBox(height: 16),
//
//                         // MCQ ID section
//                         Center(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 6,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(8),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.05),
//                                   blurRadius: 5,
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'MCQ ID: ${question.id}',
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.grey[600],
//                                       fontSize: 0.035.toWidthPercent(),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Icon(
//                                   Icons.copy_rounded,
//                                   size: 18,
//                                   color: Colors.grey[400],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   // Tags
//                   if (question.tags.isNotEmpty || question.tagId.isNotEmpty)
//                     Wrap(
//                       alignment: WrapAlignment.end,
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: [
//                         if (question.tags.isNotEmpty)
//                           ...question.tags.map(
//                                 (tag) => _buildTag(tag),
//                           )
//                         else if (question.tagId.isNotEmpty)
//                           _buildTag(question.tagId),
//                       ],
//                     ),
//
//                   const SizedBox(height: 16),
//
//                   // Codon ID copy
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: InkWell(
//                       onTap: () {
//                         Clipboard.setData(ClipboardData(text: question.codonId));
//                         Get.snackbar(
//                           'Copied',
//                           'Codon ID copied to clipboard',
//                           snackPosition: SnackPosition.BOTTOM,
//                           backgroundColor: Colors.black87,
//                           colorText: Colors.white,
//                           duration: const Duration(seconds: 1),
//                         );
//                       },
//                       borderRadius: BorderRadius.circular(5),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 5,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'Codon ID: ${question.codonId}',
//                               style: TextStyle(
//                                 color: Colors.grey[700],
//                                 fontSize: 0.03.toWidthPercent(),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             Icon(
//                               Icons.copy_rounded,
//                               size: 0.035.toWidthPercent(),
//                               color: Colors.grey[600],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   // View / Hide Explanation button
//                   if (controller.userAnswers.containsKey(question.id))
//                     Container(
//                       width: double.infinity,
//                       height: 0.06.toHeightPercent(),
//                       decoration: BoxDecoration(
//                         color: AppColors.primary,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: ElevatedButton(
//                         onPressed: controller.togglePearl,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primary,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               controller.showPearl.value
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               size: 0.045.toWidthPercent(),
//                             ),
//                             const SizedBox(width: 12),
//                             Text(
//                               controller.showPearl.value
//                                   ? 'Hide Explanation'
//                                   : 'View Explanation',
//                               style: TextStyle(
//                                 fontSize: 0.04.toWidthPercent(),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   const SizedBox(height: 24),
//
//                   // Explanation (agar visible)
//                   if (controller.showPearl.value) ...[
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 10,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           HtmlWidget(question.explanation.text),
//                           if (question.explanation.images.isNotEmpty) ...[
//                             const SizedBox(height: 16),
//                             ...question.explanation.images.map(
//                                   (img) => Padding(
//                                 padding: const EdgeInsets.only(bottom: 12),
//                                 child: Image.network(
//                                   img,
//                                   errorBuilder: (_, __, ___) => const SizedBox(),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                   ],
//
//                   const SizedBox(height: 80), // bottom padding
//                 ],
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTag(String tag) {
//     final displayTag = tag.startsWith('#') ? tag : '#$tag';
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: AppColors.primary,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         displayTag,
//         style: TextStyle(
//           color: Colors.grey[700],
//           fontSize: 0.03.toWidthPercent(),
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
//
//   // Baaki helper functions same rakh rahe hain (copy-paste kar lena)
//
//   Widget _buildOption(
//       McqOption option,
//       int index,
//       QTestController controller,
//       int questionIndex,
//       ) {
//     final currentQuestion = controller.questions[questionIndex];
//     final isAnswered = controller.userAnswers.containsKey(currentQuestion.id);
//     final isCorrect = index == currentQuestion.correctAnswer;
//     final isSelected = controller.selectedAnswerIndex.value == index;
//
//     Color bgColor = const Color(0xFFF0FEFF);
//     Color textColor = Colors.black87;
//
//     if (isAnswered) {
//       if (isCorrect) {
//         bgColor = const Color(0xFFA5F482); // green
//         textColor = Colors.white;
//       } else if (isSelected) {
//         bgColor = const Color(0xFFFFA07A); // red/orange
//         textColor = Colors.white;
//       }
//     }
//
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(10),
//         child: InkWell(
//           onTap: isAnswered ? null : () => controller.selectAnswer(index),
//           borderRadius: BorderRadius.circular(10),
//           child: Padding(
//             padding: EdgeInsets.all(0.04.toWidthPercent()),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (option.image != null && option.image!.isNotEmpty) ...[
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       baseUrl + option.image!,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => const SizedBox(),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                 ],
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(0.015.toWidthPercent()),
//                       decoration: BoxDecoration(
//                         color: isAnswered
//                             ? (isCorrect
//                             ? Colors.white.withOpacity(0.3)
//                             : (isSelected
//                             ? Colors.white.withOpacity(0.3)
//                             : AppColors.primary))
//                             : AppColors.primary,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         String.fromCharCode(65 + index),
//                         style: TextStyle(
//                           fontSize: 0.035.toWidthPercent(),
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Text(
//                         option.text,
//                         style: TextStyle(
//                           fontSize: 0.038.toWidthPercent(),
//                           fontWeight: FontWeight.w600,
//                           color: textColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuestionImage(String url) {
//     if (url.isEmpty) return const SizedBox.shrink();
//
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 12),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: const Color(0xFF77EDF9).withOpacity(0.2)),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Image.network(
//           url,
//           fit: BoxFit.contain,
//           loadingBuilder: (context, child, loadingProgress) {
//             if (loadingProgress == null) return child;
//             return const SizedBox(
//               height: 180,
//               child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
//             );
//           },
//           errorBuilder: (_, __, ___) => const SizedBox.shrink(),
//         ),
//       ),
//     );
//   }
// }

import 'package:codon/features/qtest/controllers/qtest_controller.dart';
import 'package:codon/features/qtest/models/chapter_test_model.dart';
import 'package:codon/features/qtest/models/qtest_models.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class BookmarkMCQdetailScreen extends StatefulWidget {
  final ChapterTestModel? qTest;
  final String? id;       // ← ye bookmark ka MCQ ID hoga
  final String? title;
  final dynamic otpions;

  const BookmarkMCQdetailScreen({
    super.key,
    this.qTest,
    this.id,
    this.title,
    this.otpions,
  });

  @override
  State<BookmarkMCQdetailScreen> createState() => _BookmarkMCQdetailScreenState();
}

class _BookmarkMCQdetailScreenState extends State<BookmarkMCQdetailScreen> {
  @override
  void initState() {
    super.initState();

    final controller = Get.find<QTestController>();

    // Reset states for clean bookmark view
    controller.questions.clear();
    controller.userAnswers.clear();
    controller.currentQuestionIndex.value = 0;
    controller.showPearl.value = false;
    controller.selectedAnswerIndex.value = -1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id == null || widget.id!.isEmpty) {
        Get.snackbar("Error", "No MCQ ID provided", backgroundColor: Colors.red);
        Get.back();
        return;
      }

      controller.fetchQTest(widget.id ?? "0"); // test fetch (jaise pehle tha)
    });
  }

  @override
  Widget build(BuildContext context) {
    final QTestController controller = Get.find<QTestController>();
    final String? targetMcqId = widget.id;

    return PopScope(
      canPop: true,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          appBar: AppBar(
            title: Text(
              widget.title ?? "Bookmarked MCQ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.questions.isEmpty) {
              return const Center(child: Text('No questions loaded'));
            }

            // Filter → sirf bookmark wala MCQ
            final filtered = controller.questions
                .where((q) => q.id == targetMcqId)
                .toList();

            if (filtered.isEmpty) {
              return const Center(
                child: Text(
                  'Bookmarked question not found in this set',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              );
            }

            final question = filtered.first;
            final questionIndex = controller.questions.indexOf(question);

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 0.04.toWidthPercent(),
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Question Card
                  Container(
                    padding: EdgeInsets.all(0.04.toWidthPercent()),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${questionIndex + 1}. ${question.question.text}",
                          style: TextStyle(
                            fontSize: 0.042.toWidthPercent(),
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),

                        if (question.question.images.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          ...question.question.images.map(
                                (img) => _buildQuestionImage(baseUrl + img),
                          ),
                        ],

                        const SizedBox(height: 24),
                        const Divider(color: AppColors.primary),
                        const SizedBox(height: 24),

                        // Options – selectable
                        // ...List.generate(
                        //   question.options.length,
                        //       (idx) => _buildOption(
                        //     question.options[idx],
                        //     idx,
                        //     controller,
                        //         question,
                        //   ),
                        // ),
                        ...List.generate(
                          question.options.length,
                              (idx) => _buildOption(
                            question.options[idx],
                            idx,
                            controller,
                            questionIndex,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // MCQ ID box
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Text(
                                    'MCQ ID: ${question.id}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 0.035.toWidthPercent(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.copy_rounded, size: 18, color: Colors.grey[400]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tags
                  if (question.tags.isNotEmpty || question.tagId.isNotEmpty)
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (question.tags.isNotEmpty)
                          ...question.tags.map((tag) => _buildTag(tag))
                        else if (question.tagId.isNotEmpty)
                          _buildTag(question.tagId),
                      ],
                    ),

                  const SizedBox(height: 20),

                  // Codon ID
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: question.codonId));
                        Get.snackbar('Copied', 'Codon ID copied', duration: const Duration(seconds: 1));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Codon ID: ${question.codonId}',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 0.035.toWidthPercent(),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.copy, size: 18, color: Colors.grey[600]),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Explanation Button – HAMESHA visible
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: controller.togglePearl,
                      icon: Icon(
                        controller.showPearl.value ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      label: Text(
                        controller.showPearl.value ? 'Hide Explanation' : 'View Explanation',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Explanation Content
                  if (controller.showPearl.value)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Explanation",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          HtmlWidget(
                            question.explanation.text,
                            textStyle: const TextStyle(fontSize: 15, height: 1.5),
                          ),
                          if (question.explanation.images.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            ...question.explanation.images.map(
                                  (img) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    img,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => const SizedBox(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                  const SizedBox(height: 100), // bottom space
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    final display = tag.startsWith('#') ? tag : '#$tag';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        display,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 0.035.toWidthPercent(),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Widget _buildOption(
  //     McqOption option,
  //     int optIndex,
  //     QTestController controller,
  //     QuestionModel question, // changed to pass question directly
  //     ) {
  //   final isAnswered = controller.userAnswers.containsKey(question.id);
  //   final isCorrect = optIndex == question.correctAnswer;
  //   final isSelected = controller.selectedAnswerIndex.value == optIndex;

  // Widget _buildOption(
  //     McqOption option,
  //     int index,
  //     QTestController controller,
  //     int questionIndex,
  //     ) {
  //   final currentQuestion = controller.questions[questionIndex];
  //   final isAnswered = controller.userAnswers.containsKey(currentQuestion.id);
  //   final isCorrect = index == currentQuestion.correctAnswer;
  //   final isSelected = controller.selectedAnswerIndex.value == index;
  //
  //   Color bgColor = const Color(0xFFF0FEFF);
  //   Color textColor = Colors.black87;
  //   Color letterBg = AppColors.primary;
  //
  //   if (isSelected || (isAnswered && isCorrect)) {
  //     if (isCorrect) {
  //       bgColor = const Color(0xFFA5F482); // green
  //       textColor = Colors.white;
  //       letterBg = Colors.white.withOpacity(0.4);
  //     } else if (isSelected) {
  //       bgColor = const Color(0xFFFFA07A); // red/orange
  //       textColor = Colors.white;
  //       letterBg = Colors.white.withOpacity(0.4);
  //     }
  //   }
  //
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
  //     decoration: BoxDecoration(
  //       color: bgColor,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Material(
  //       color: Colors.transparent,
  //       borderRadius: BorderRadius.circular(12),
  //       child: InkWell(
  //         onTap: () {
  //           controller.selectAnswer(index); // ← select hone do har baar
  //         },
  //         borderRadius: BorderRadius.circular(12),
  //         child: Padding(
  //           padding: EdgeInsets.all(0.04.toWidthPercent()),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               if (option.image != null && option.image!.isNotEmpty) ...[
  //                 ClipRRect(
  //                   borderRadius: BorderRadius.circular(10),
  //                   child: Image.network(
  //                     baseUrl + option.image!,
  //                     fit: BoxFit.cover,
  //                     errorBuilder: (_, __, ___) => const SizedBox(),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 12),
  //               ],
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //                     decoration: BoxDecoration(
  //                       color: letterBg,
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: Text(
  //                       String.fromCharCode(65 + index),
  //                       style: TextStyle(
  //                         fontSize: 0.038.toWidthPercent(),
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 16),
  //                   Expanded(
  //                     child: Text(
  //                       option.text,
  //                       style: TextStyle(
  //                         fontSize: 0.038.toWidthPercent(),
  //                         fontWeight: FontWeight.w600,
  //                         color: textColor,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildOption(
      McqOption option,
      int index,
      QTestController controller,
      int questionIndex,
      ) {
    final currentQuestion = controller.questions[questionIndex];
    final isAnswered = controller.userAnswers.containsKey(currentQuestion.id);
    final isCorrect = index == currentQuestion.correctAnswer;
    final isSelected = controller.selectedAnswerIndex.value == index;

    Color bgColor = const Color(0xFFF0FEFF);
    Color textColor = Colors.black87;

    if (isAnswered) {
      if (isCorrect) {
        bgColor = const Color(0xFFA5F482); // green
        textColor = Colors.white;
      } else if (isSelected) {
        bgColor = const Color(0xFFFFA07A); // red/orange
        textColor = Colors.white;
      }
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: isAnswered ? null : () => controller.selectAnswer(index),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.all(0.04.toWidthPercent()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (option.image != null && option.image!.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      baseUrl + option.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(0.015.toWidthPercent()),
                      decoration: BoxDecoration(
                        color: isAnswered
                            ? (isCorrect
                            ? Colors.white.withOpacity(0.3)
                            : (isSelected
                            ? Colors.white.withOpacity(0.3)
                            : AppColors.primary))
                            : AppColors.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        String.fromCharCode(65 + index),
                        style: TextStyle(
                          fontSize: 0.035.toWidthPercent(),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        option.text,
                        style: TextStyle(
                          fontSize: 0.038.toWidthPercent(),
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionImage(String url) {
    if (url.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          url,
          fit: BoxFit.contain,
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;
            return const SizedBox(height: 180, child: Center(child: CircularProgressIndicator()));
          },
          errorBuilder: (_, __, ___) => const SizedBox(),
        ),
      ),
    );
  }
}