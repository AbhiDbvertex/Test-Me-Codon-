// import 'package:codon/features/test/controllers/tests_controller.dart';
// import 'package:codon/utills/api_urls.dart';
// import 'package:codon/utills/screen_size_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:codon/utills/app_theme.dart';
// import 'package:get/get.dart';
//
// import '../../home/controllers/bookmark_controller.dart';
// import '../../home/models/bookmark_model.dart';
//
// class TestMCQScreen extends StatelessWidget {
//   const TestMCQScreen({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     final TestsController controller = Get.find<TestsController>();
//     final Map<String, dynamic> args = Get.arguments ?? {};
//     final String testName = args['testName'] ?? "Test";
//     // return PopScope(
//     //   canPop: false,
//     //   onPopInvoked: (didPop) async {
//     //     if (didPop) return;
//     //     final shouldPop = await _showQuitConfirmationDialog(context);
//     //     if (shouldPop == true) {
//     //       Get.back();
//     //     }
//     //   },
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) async {
//         if (didPop) return;
//
//         final shouldQuit = await _showQuitConfirmationDialog(context);
//         if (shouldQuit == true) {
//           // ────────────────────────────────────────
//           // Sabse zaroori line yahan
//           controller.timer?.cancel();
//           controller.timer = null;
//           // ────────────────────────────────────────
//
//           Get.back();           // ya Get.offAll() agar home jana hai
//         }
//       },
//       child: SafeArea(
//         top: false,
//         child: Scaffold(
//           backgroundColor: const Color(0xFFF8F8F8),
//           appBar: AppBar(
//             title: Text(
//               testName,
//               // "asdf asdfsdf",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.white,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//             actions: [
//               Center(
//                 child: Obx(
//                   () => Text(
//                     controller.timeDisplay.value,
//                     style: const TextStyle(
//                       color: Colors.redAccent,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               IconButton(
//                 icon: const Icon(Icons.close, color: Colors.black, size: 28),
//                 onPressed: () =>
//                     _showQuitConfirmationDialog(context).then((value) {
//                       if (value == true) Get.back();
//                     }),
//               ),
//             ],
//           ),
//           body: Obx(() {
//             if (controller.isTestCourseLoading.value ||
//                 controller.isExamTestsLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (controller.questionsList.isEmpty) {
//               return const Center(child: Text('No questions available'));
//             }
//             return Column(
//               children: [
//                 _buildDotsIndicator(controller),
//                 Expanded(
//                   child: PageView.builder(
//                     controller: controller.pageController,
//                     onPageChanged: controller.onPageChanged,
//                     itemCount: controller.questionsList.length,
//                     itemBuilder: (context, index) {
//                       final currentQuestion = controller.questionsList[index];
//                       final String qId = currentQuestion['id'];
//
//                       return Obx(() {
//                         return SingleChildScrollView(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 0.04.toWidthPercent(),
//                           ),
//                           child: Column(
//                             children: [
//                               SizedBox(height: 0.02.toHeightPercent()),
//                               // White card for question and options
//                               Container(
//                                 padding: EdgeInsets.all(0.04.toWidthPercent()),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.05),
//                                       blurRadius: 15,
//                                       offset: const Offset(0, 5),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             "${index + 1}. ${currentQuestion['questionText']}",
//                                             style: TextStyle(
//                                               fontSize: 0.042.toWidthPercent(),
//                                               fontWeight: FontWeight.w500,
//                                               color: AppColors.primary,
//                                             ),
//                                           ),
//                                         ),
//                                         // TextButton(onPressed: (){
//                                         //   print("Abhi:- mcqsId : ${qId}");
//                                         // }, child: Text("print")),
//                                         // Obx(() {
//                                         //   // final bookmarkCtrl = Get.put(BookmarkController());
//                                         //   // print("Abhi:- mcqId: ${qId}");
//                                         //   // final isBookmarked = bookmarkCtrl.isBookmarked(qId);
//                                         //   // final category = bookmarkCtrl.getCategory(qId);
//                                         //
//                                         //   final bookmarkCtrl = Get.find<BookmarkController>();
//                                         //
//                                         //   // Bookmark list se check karo jiska mcq.id match karta ho
//                                         //   final matchingBookmark = bookmarkCtrl.mostImportantBookmarks.firstWhere(
//                                         //         (b) => b.mcq?.id == qId,
//                                         //     orElse: () => bookmarkCtrl.veryImportantBookmarks.firstWhere(
//                                         //           (b) => b.mcq?.id == qId,
//                                         //       orElse: () => bookmarkCtrl.importantBookmarks.firstWhere(
//                                         //             (b) => b.mcq?.id == qId,
//                                         //         orElse: () => BookmarkModel(id: '', userId: '', type: '', category: '', createdAt: '', updatedAt: ''),
//                                         //       ),
//                                         //     ),
//                                         //   );
//                                         //
//                                         //   final isBookmarked = matchingBookmark.mcq?.id == qId;
//                                         //   final category = isBookmarked ? matchingBookmark.category : '';
//                                         //
//                                         //   Color iconColor;
//                                         //
//                                         //   if (!isBookmarked) {
//                                         //     iconColor = AppColors.primary.withOpacity(0.5);
//                                         //   } else {
//                                         //     switch (category) {
//                                         //       case 'mostimportant':
//                                         //         iconColor = Colors.red;
//                                         //         break;
//                                         //       case 'veryimportant':
//                                         //         iconColor = Colors.orange;
//                                         //         break;
//                                         //       case 'important':
//                                         //         iconColor = Colors.blue;
//                                         //         break;
//                                         //       default:
//                                         //         iconColor = AppColors.primary;
//                                         //     }
//                                         //   }
//                                         //
//                                         //   return PopupMenuButton<String>(
//                                         //     icon: Container(
//                                         //       // color: Colors.red,
//                                         //       child: Icon(
//                                         //         isBookmarked ? Icons.bookmark : Icons.bookmark_border,
//                                         //         color: iconColor,
//                                         //         size: 0.08.toWidthPercent(),
//                                         //       ),
//                                         //     ),
//                                         //     onSelected: (value) {
//                                         //       bookmarkCtrl.toggleBookmark(
//                                         //         type: "mcq",
//                                         //         itemId: qId,
//                                         //         category: value,
//                                         //       );
//                                         //     },
//                                         //     itemBuilder: (context) => [
//                                         //       _buildPopupItem('mostimportant', 'Most Important', Colors.red),
//                                         //       _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
//                                         //       _buildPopupItem('important', 'Important', Colors.blue),
//                                         //     ],
//                                         //   );
//                                         // })
//
//                                       /*  Obx(() {
//                                           final bookmarkCtrl = Get.find<BookmarkController>();
//
//                                           BookmarkModel? bookmark;
//
//                                           bookmark = bookmarkCtrl.mostImportantBookmarks
//                                               .where((b) => b.mcq?.id == qId)
//                                               .cast<BookmarkModel?>()
//                                               .firstOrNull ??
//                                               bookmarkCtrl.veryImportantBookmarks
//                                                   .where((b) => b.mcq?.id == qId)
//                                                   .cast<BookmarkModel?>()
//                                                   .firstOrNull ??
//                                               bookmarkCtrl.importantBookmarks
//                                                   .where((b) => b.mcq?.id == qId)
//                                                   .cast<BookmarkModel?>()
//                                                   .firstOrNull;
//
//                                           final isBookmarked = bookmark != null;
//                                           final category = bookmark?.category ?? '';
//
//                                           Color iconColor = AppColors.primary.withOpacity(0.5);
//
//                                           if (isBookmarked) {
//                                             switch (category) {
//                                               case 'mostimportant':
//                                                 iconColor = Colors.red;
//                                                 break;
//                                               case 'veryimportant':
//                                                 iconColor = Colors.orange;
//                                                 break;
//                                               case 'important':
//                                                 iconColor = Colors.blue;
//                                                 break;
//                                             }
//                                           }
//
//                                           return PopupMenuButton<String>(
//                                             icon: Icon(
//                                               isBookmarked ? Icons.bookmark : Icons.bookmark_border,
//                                               color: iconColor,
//                                               size: 0.08.toWidthPercent(),
//                                             ),
//                                             onSelected: (value) async {
//
//                                               await bookmarkCtrl.toggleBookmark(
//                                                 type: "mcq",
//                                                 itemId: qId,
//                                                 category: value,
//                                               );
//
//                                               // important
//                                               // await bookmarkCtrl.getBookmarks();
//                                             },
//                                             itemBuilder: (context) => [
//                                               _buildPopupItem('mostimportant', 'Most Important', Colors.red),
//                                               _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
//                                               _buildPopupItem('important', 'Important', Colors.blue),
//                                             ],
//                                           );
//                                         })*/
//
//                                         Obx(() {
//
//                                           final bookmarkCtrl = Get.find<BookmarkController>();
//
//                                           bool isMost = bookmarkCtrl.mostImportantBookmarks.any((b) => b.mcq?.id == qId);
//                                           bool isVery = bookmarkCtrl.veryImportantBookmarks.any((b) => b.mcq?.id == qId);
//                                           bool isImp = bookmarkCtrl.importantBookmarks.any((b) => b.mcq?.id == qId);
//
//                                           bool isBookmarked = isMost || isVery || isImp;
//
//                                           String category = "";
//
//                                           if (isMost) {
//                                             category = "mostimportant";
//                                           } else if (isVery) {
//                                             category = "veryimportant";
//                                           } else if (isImp) {
//                                             category = "important";
//                                           }
//
//                                           Color iconColor = AppColors.primary.withOpacity(0.5);
//
//                                           if (category == "mostimportant") {
//                                             iconColor = Colors.red;
//                                           }
//                                           else if (category == "veryimportant") {
//                                             iconColor = Colors.orange;
//                                           }
//                                           else if (category == "important") {
//                                             iconColor = Colors.blue;
//                                           }
//
//                                           return PopupMenuButton<String>(
//                                             icon: Icon(
//                                               isBookmarked ? Icons.bookmark : Icons.bookmark_border,
//                                               color: iconColor,
//                                               size: 0.08.toWidthPercent(),
//                                             ),
//
//                                               onSelected: (value) async {
//
//                                                 await bookmarkCtrl.toggleBookmark(
//                                                   type: "mcq",
//                                                   itemId: qId,
//                                                   category: value,
//                                                 );
//
//                                                 // force refresh
//                                                 bookmarkCtrl.mostImportantBookmarks.refresh();
//                                                 bookmarkCtrl.veryImportantBookmarks.refresh();
//                                                 bookmarkCtrl.importantBookmarks.refresh();
//                                               },
//
//                                             itemBuilder: (context) => [
//                                               _buildPopupItem('mostimportant', 'Most Important', Colors.red),
//                                               _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
//                                               _buildPopupItem('important', 'Important', Colors.blue),
//                                             ],
//                                           );
//                                         })
//
//
//                                       ],
//                                     ),
//                                     if (currentQuestion['questionImageUrl'] !=
//                                         null)
//                                       _buildQuestionImage(
//                                         currentQuestion['questionImageUrl'],
//                                       ),
//                                     SizedBox(height: 0.03.toHeightPercent()),
//                                     Divider(color: AppColors.primary),
//                                     SizedBox(height: 0.03.toHeightPercent()),
//                                     ...List.generate(
//                                       currentQuestion['options'].length,
//                                       (idx) {
//                                         final option =
//                                             currentQuestion['options'][idx];
//                                         return _buildOption(
//                                           option['text'],
//                                           option['id'],
//                                           controller,
//                                           qId,
//                                           idx,
//                                           option['optionImageUrl'],
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 0.02.toHeightPercent()),
//                               if (currentQuestion['imageTag'] != null)
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: _buildImageTag(
//                                     currentQuestion['imageTag'],
//                                   ),
//                                 ),
//                               SizedBox(height: 0.04.toHeightPercent()),
//                             ],
//                           ),
//                         );
//                       });
//                     },
//                   ),
//                 ),
//                 _buildBottomNav(controller),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
//
//   // --- Helper Widgets ---
//
//   Widget _buildQuestionImage(String? url) {
//     // 1. URL empty hai toh gap bhi mat dikhao
//     if (url == null || url.isEmpty) return const SizedBox.shrink();
//
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 15),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: const Color(0xFF77EDF9).withOpacity(0.2)),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Image.network(
//           baseUrl + url,
//           fit: BoxFit.cover,
//           // Loading State
//           loadingBuilder: (context, child, loadingProgress) {
//             if (loadingProgress == null) return child;
//             return Container(
//               height: 150,
//               color: Colors.grey[50],
//               child: const Center(
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               ),
//             );
//           },
//           // Error State: Agar internet band ho ya URL expire ho jaye toh box gayab
//           errorBuilder: (context, error, stackTrace) {
//             debugPrint("Image Error: $error");
//             return const SizedBox.shrink(); // Box gayab ho jayega
//           },
//         ),
//       ),
//     );
//   }
//   PopupMenuItem<String> _buildPopupItem(String val, String text, Color color) {
//     return PopupMenuItem(
//       value: val,
//       child: Row(
//         children: [
//           Icon(Icons.bookmark, color: color, size: 20),
//           const SizedBox(width: 10),
//           Text(text),
//         ],
//       ),
//     );
//   }
//   Widget _buildOption(
//     String text,
//     String optId,
//     TestsController controller,
//     String qId,
//     int index,
//     String? imageUrl,
//   ) {
//     bool isSelected = controller.userSelections[qId] == optId;
//
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
//       decoration: BoxDecoration(
//         color: isSelected ? const Color(0xFFF0FEFF) : Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: isSelected ? AppColors.primary : Colors.transparent,
//           width: 1,
//         ),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(10),
//         child: InkWell(
//           onTap: () => controller.selectOption(qId, optId),
//           borderRadius: BorderRadius.circular(10),
//           child: Padding(
//             padding: EdgeInsets.all(0.04.toWidthPercent()),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (imageUrl != null && imageUrl.isNotEmpty) ...[
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       baseUrl + imageUrl,
//                       fit: BoxFit.contain,
//                       errorBuilder: (context, error, stackTrace) =>
//                           const SizedBox(),
//                     ),
//                   ),
//                   SizedBox(height: 0.01.toHeightPercent()),
//                 ],
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(0.015.toWidthPercent()),
//                       decoration: BoxDecoration(
//                         color: AppColors.primary,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         String.fromCharCode(65 + index), // A, B, C, D
//                         style: TextStyle(
//                           fontSize: 0.035.toWidthPercent(),
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 0.03.toWidthPercent()),
//                     Expanded(
//                       child: Text(
//                         text,
//                         style: TextStyle(
//                           fontSize: 0.038.toWidthPercent(),
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                     if (isSelected)
//                       const Icon(
//                         Icons.check_circle,
//                         color: AppColors.primary,
//                         size: 20,
//                       ),
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
//   Widget _buildDotsIndicator(TestsController controller) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 0.02.toHeightPercent()),
//       child: Obx(
//         () => Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(
//             controller.questionsList.length,
//             (index) => Container(
//               margin: const EdgeInsets.symmetric(horizontal: 3),
//               width: 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: index == controller.currentQuestionIndex.value
//                     ? AppColors.primary
//                     : Colors.grey[300],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<bool?> _showQuitConfirmationDialog(BuildContext context) {
//     return showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text(
//           'Quit Test?',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: const Text(
//           'Are you sure you want to quit the test? your progress will not be saved.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('No', style: TextStyle(color: Colors.black54)),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Yes, Quit', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomNav(TestsController controller) {
//     return Padding(
//       padding: EdgeInsets.all(0.04.toWidthPercent()),
//       child: Row(
//         children: [
//           Expanded(
//             child: Obx(
//               () => OutlinedButton(
//                 onPressed: controller.currentQuestionIndex.value > 0
//                     ? controller.previousQuestion
//                     : null,
//                 style: OutlinedButton.styleFrom(
//                   side: const BorderSide(color: AppColors.primary),
//                   padding: EdgeInsets.symmetric(
//                     vertical: 0.015.toHeightPercent(),
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Previous',
//                   style: TextStyle(
//                     color: AppColors.primary,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 0.04.toWidthPercent()),
//           Expanded(
//             child: Obx(() {
//               bool isLast =
//                   controller.currentQuestionIndex.value ==
//                   controller.questionsList.length - 1;
//               return ElevatedButton(
//                 onPressed: isLast
//                     ? controller.submitTest
//                     : controller.nextQuestion,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: Colors.white,
//                   padding: EdgeInsets.symmetric(
//                     vertical: 0.015.toHeightPercent(),
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: Text(
//                   isLast ? 'Submit' : 'Next',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildImageTag(String tagText) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF77EDF9).withOpacity(0.8),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         tagText,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 13,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

/*import 'package:codon/features/test/controllers/tests_controller.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

import '../../home/controllers/bookmark_controller.dart';
import '../../home/models/bookmark_model.dart';

class TestMCQScreen extends StatelessWidget {
  const TestMCQScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final TestsController controller = Get.find<TestsController>();
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String testName = args['testName'] ?? "Test";
    // return PopScope(
    //   canPop: false,
    //   onPopInvoked: (didPop) async {
    //     if (didPop) return;
    //     final shouldPop = await _showQuitConfirmationDialog(context);
    //     if (shouldPop == true) {
    //       Get.back();
    //     }
    //   },
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final shouldQuit = await _showQuitConfirmationDialog(context);
        if (shouldQuit == true) {
          // ────────────────────────────────────────
          // Sabse zaroori line yahan
          controller.timer?.cancel();
          controller.timer = null;
          // ────────────────────────────────────────

          Get.back();           // ya Get.offAll() agar home jana hai
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          appBar: AppBar(
            title: Text(
              testName,
              // "asdf asdfsdf",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              Center(
                child: Obx(
                      () => Text(
                    controller.timeDisplay.value,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black, size: 28),
                onPressed: () =>
                    _showQuitConfirmationDialog(context).then((value) {
                      if (value == true) Get.back();
                    }),
              ),
            ],
          ),
          body: Obx(() {
            if (controller.isTestCourseLoading.value ||
                controller.isExamTestsLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.questionsList.isEmpty) {
              return const Center(child: Text('No questions available'));
            }
            return Column(
              children: [
                _buildDotsIndicator(controller),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: controller.questionsList.length,
                    itemBuilder: (context, index) {
                      final currentQuestion = controller.questionsList[index];
                      final String qId = currentQuestion['id'];

                      return Obx(() {
                        return SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.04.toWidthPercent(),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 0.02.toHeightPercent()),
                              // White card for question and options
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
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${index + 1}. ${currentQuestion['questionText']}",
                                            style: TextStyle(
                                              fontSize: 0.042.toWidthPercent(),
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        // TextButton(onPressed: (){
                                        //   print("Abhi:- mcqsId : ${qId}");
                                        // }, child: Text("print")),
                                        // Obx(() {
                                        //   // final bookmarkCtrl = Get.put(BookmarkController());
                                        //   // print("Abhi:- mcqId: ${qId}");
                                        //   // final isBookmarked = bookmarkCtrl.isBookmarked(qId);
                                        //   // final category = bookmarkCtrl.getCategory(qId);
                                        //
                                        //   final bookmarkCtrl = Get.find<BookmarkController>();
                                        //
                                        //   // Bookmark list se check karo jiska mcq.id match karta ho
                                        //   final matchingBookmark = bookmarkCtrl.mostImportantBookmarks.firstWhere(
                                        //         (b) => b.mcq?.id == qId,
                                        //     orElse: () => bookmarkCtrl.veryImportantBookmarks.firstWhere(
                                        //           (b) => b.mcq?.id == qId,
                                        //       orElse: () => bookmarkCtrl.importantBookmarks.firstWhere(
                                        //             (b) => b.mcq?.id == qId,
                                        //         orElse: () => BookmarkModel(id: '', userId: '', type: '', category: '', createdAt: '', updatedAt: ''),
                                        //       ),
                                        //     ),
                                        //   );
                                        //
                                        //   final isBookmarked = matchingBookmark.mcq?.id == qId;
                                        //   final category = isBookmarked ? matchingBookmark.category : '';
                                        //
                                        //   Color iconColor;
                                        //
                                        //   if (!isBookmarked) {
                                        //     iconColor = AppColors.primary.withOpacity(0.5);
                                        //   } else {
                                        //     switch (category) {
                                        //       case 'mostimportant':
                                        //         iconColor = Colors.red;
                                        //         break;
                                        //       case 'veryimportant':
                                        //         iconColor = Colors.orange;
                                        //         break;
                                        //       case 'important':
                                        //         iconColor = Colors.blue;
                                        //         break;
                                        //       default:
                                        //         iconColor = AppColors.primary;
                                        //     }
                                        //   }
                                        //
                                        //   return PopupMenuButton<String>(
                                        //     icon: Container(
                                        //       // color: Colors.red,
                                        //       child: Icon(
                                        //         isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                        //         color: iconColor,
                                        //         size: 0.08.toWidthPercent(),
                                        //       ),
                                        //     ),
                                        //     onSelected: (value) {
                                        //       bookmarkCtrl.toggleBookmark(
                                        //         type: "mcq",
                                        //         itemId: qId,
                                        //         category: value,
                                        //       );
                                        //     },
                                        //     itemBuilder: (context) => [
                                        //       _buildPopupItem('mostimportant', 'Most Important', Colors.red),
                                        //       _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
                                        //       _buildPopupItem('important', 'Important', Colors.blue),
                                        //     ],
                                        //   );
                                        // })

                                        *//*  Obx(() {
                                          final bookmarkCtrl = Get.find<BookmarkController>();

                                          BookmarkModel? bookmark;

                                          bookmark = bookmarkCtrl.mostImportantBookmarks
                                              .where((b) => b.mcq?.id == qId)
                                              .cast<BookmarkModel?>()
                                              .firstOrNull ??
                                              bookmarkCtrl.veryImportantBookmarks
                                                  .where((b) => b.mcq?.id == qId)
                                                  .cast<BookmarkModel?>()
                                                  .firstOrNull ??
                                              bookmarkCtrl.importantBookmarks
                                                  .where((b) => b.mcq?.id == qId)
                                                  .cast<BookmarkModel?>()
                                                  .firstOrNull;

                                          final isBookmarked = bookmark != null;
                                          final category = bookmark?.category ?? '';

                                          Color iconColor = AppColors.primary.withOpacity(0.5);

                                          if (isBookmarked) {
                                            switch (category) {
                                              case 'mostimportant':
                                                iconColor = Colors.red;
                                                break;
                                              case 'veryimportant':
                                                iconColor = Colors.orange;
                                                break;
                                              case 'important':
                                                iconColor = Colors.blue;
                                                break;
                                            }
                                          }

                                          return PopupMenuButton<String>(
                                            icon: Icon(
                                              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                              color: iconColor,
                                              size: 0.08.toWidthPercent(),
                                            ),
                                            onSelected: (value) async {

                                              await bookmarkCtrl.toggleBookmark(
                                                type: "mcq",
                                                itemId: qId,
                                                category: value,
                                              );

                                              // important
                                              // await bookmarkCtrl.getBookmarks();
                                            },
                                            itemBuilder: (context) => [
                                              _buildPopupItem('mostimportant', 'Most Important', Colors.red),
                                              _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
                                              _buildPopupItem('important', 'Important', Colors.blue),
                                            ],
                                          );
                                        })*//*

                                        Obx(() {

                                          final bookmarkCtrl = Get.find<BookmarkController>();

                                          bool isMost = bookmarkCtrl.mostImportantBookmarks.any((b) => b.mcq?.id == qId);
                                          bool isVery = bookmarkCtrl.veryImportantBookmarks.any((b) => b.mcq?.id == qId);
                                          bool isImp = bookmarkCtrl.importantBookmarks.any((b) => b.mcq?.id == qId);

                                          bool isBookmarked = isMost || isVery || isImp;

                                          String category = "";

                                          if (isMost) {
                                            category = "mostimportant";
                                          } else if (isVery) {
                                            category = "veryimportant";
                                          } else if (isImp) {
                                            category = "important";
                                          }

                                          Color iconColor = AppColors.primary.withOpacity(0.5);

                                          if (category == "mostimportant") {
                                            iconColor = Colors.red;
                                          }
                                          else if (category == "veryimportant") {
                                            iconColor = Colors.orange;
                                          }
                                          else if (category == "important") {
                                            iconColor = Colors.blue;
                                          }

                                          return PopupMenuButton<String>(
                                            icon: Icon(
                                              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                              color: iconColor,
                                              size: 0.08.toWidthPercent(),
                                            ),

                                            onSelected: (value) async {

                                              await bookmarkCtrl.toggleBookmark(
                                                type: "mcq",
                                                itemId: qId,
                                                category: value,
                                              );

                                              // force refresh
                                              bookmarkCtrl.mostImportantBookmarks.refresh();
                                              bookmarkCtrl.veryImportantBookmarks.refresh();
                                              bookmarkCtrl.importantBookmarks.refresh();
                                            },

                                            itemBuilder: (context) => [
                                              _buildPopupItem('mostimportant', 'Most Important', Colors.red),
                                              _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
                                              _buildPopupItem('important', 'Important', Colors.blue),
                                            ],
                                          );
                                        })


                                      ],
                                    ),
                                    if (currentQuestion['questionImageUrl'] !=
                                        null)
                                      _buildQuestionImage(
                                        currentQuestion['questionImageUrl'],
                                      ),
                                    SizedBox(height: 0.03.toHeightPercent()),
                                    Divider(color: AppColors.primary),
                                    SizedBox(height: 0.03.toHeightPercent()),
                                    ...List.generate(
                                      currentQuestion['options'].length,
                                          (idx) {
                                        final option =
                                        currentQuestion['options'][idx];
                                        return _buildOption(
                                          option['text'],
                                          option['id'],
                                          controller,
                                          qId,
                                          idx,
                                          option['optionImageUrl'],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 0.02.toHeightPercent()),
                              if (currentQuestion['imageTag'] != null)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: _buildImageTag(
                                    currentQuestion['imageTag'],
                                  ),
                                ),
                              SizedBox(height: 0.04.toHeightPercent()),
                            ],
                          ),
                        );
                      });
                    },
                  ),
                ),
                _buildBottomNav(controller),
              ],
            );
          }),
        ),
      ),
    );
  }*/

import 'package:codon/features/test/controllers/tests_controller.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

import '../../home/controllers/bookmark_controller.dart';
import '../../home/models/bookmark_model.dart';

class TestMCQScreen extends StatelessWidget {
  const TestMCQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TestsController controller = Get.find<TestsController>();
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String testName = args['testName'] ?? "Test";

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldQuit = await _showQuitConfirmationDialog(context);
        if (shouldQuit == true) {
          controller.stopTimer();
          controller.isTestActive.value = false;
          Get.back();
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          appBar: AppBar(
            title: Text(
              testName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              Center(
                child: Obx(
                      () => Text(
                    controller.timeDisplay.value,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black, size: 28),
                onPressed: () async {
                  final shouldQuit = await _showQuitConfirmationDialog(context);
                  if (shouldQuit == true) {
                    controller.stopTimer();
                    controller.isTestActive.value = false;
                    Get.back();
                  }
                },
              ),
            ],
          ),
          body: Obx(() {
            if (controller.isTestCourseLoading.value ||
                controller.isExamTestsLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.questionsList.isEmpty) {
              return const Center(child: Text('No questions available'));
            }
            return Column(
              children: [
                _buildDotsIndicator(controller),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: controller.questionsList.length,
                    itemBuilder: (context, index) {
                      final currentQuestion = controller.questionsList[index];
                      final String qId = currentQuestion['id'];

                      return Obx(() {
                        return SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.04.toWidthPercent(),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 0.02.toHeightPercent()),
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
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${index + 1}. ${currentQuestion['questionText']}",
                                            style: TextStyle(
                                              fontSize: 0.042.toWidthPercent(),
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        Obx(() {
                                          final bookmarkCtrl = Get.find<BookmarkController>();

                                          bool isMost = bookmarkCtrl.mostImportantBookmarks.any((b) => b.mcq?.id == qId);
                                          bool isVery = bookmarkCtrl.veryImportantBookmarks.any((b) => b.mcq?.id == qId);
                                          bool isImp = bookmarkCtrl.importantBookmarks.any((b) => b.mcq?.id == qId);

                                          bool isBookmarked = isMost || isVery || isImp;

                                          String category = "";
                                          if (isMost) category = "mostimportant";
                                          else if (isVery) category = "veryimportant";
                                          else if (isImp) category = "important";

                                          Color iconColor = AppColors.primary.withOpacity(0.5);
                                          if (category == "mostimportant") iconColor = Colors.red;
                                          else if (category == "veryimportant") iconColor = Colors.orange;
                                          else if (category == "important") iconColor = Colors.blue;

                                          return PopupMenuButton<String>(
                                            icon: Icon(
                                              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                              color: iconColor,
                                              size: 0.08.toWidthPercent(),
                                            ),
                                            onSelected: (value) async {
                                              await bookmarkCtrl.toggleBookmark(
                                                type: "mcq",
                                                itemId: qId,
                                                category: value,
                                              );
                                              bookmarkCtrl.mostImportantBookmarks.refresh();
                                              bookmarkCtrl.veryImportantBookmarks.refresh();
                                              bookmarkCtrl.importantBookmarks.refresh();
                                            },
                                            itemBuilder: (context) => [
                                              _buildPopupItem('mostimportant', 'Most Important', Colors.red),
                                              _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
                                              _buildPopupItem('important', 'Important', Colors.blue),
                                              _buildPopupItem('removed', 'remove', Colors.grey),

                                            ],
                                          );
                                        }),
                                      ],
                                    ),
                                    if (currentQuestion['questionImageUrl'] != null)
                                      _buildQuestionImage(currentQuestion['questionImageUrl']),
                                    SizedBox(height: 0.03.toHeightPercent()),
                                    Divider(color: AppColors.primary),
                                    SizedBox(height: 0.03.toHeightPercent()),
                                    ...List.generate(
                                      currentQuestion['options'].length,
                                          (idx) {
                                        final option = currentQuestion['options'][idx];
                                        return _buildOption(
                                          option['text'],
                                          option['id'],
                                          controller,
                                          qId,
                                          idx,
                                          option['optionImageUrl'],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 0.02.toHeightPercent()),
                              if (currentQuestion['imageTag'] != null)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: _buildImageTag(currentQuestion['imageTag']),
                                ),
                              SizedBox(height: 0.04.toHeightPercent()),
                            ],
                          ),
                        );
                      });
                    },
                  ),
                ),
                _buildBottomNav(controller),
              ],
            );
          }),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  // Widget _buildQuestionImage(String? url) {
  //   // 1. URL empty hai toh gap bhi mat dikhao
  //   if (url == null || url.isEmpty) return const SizedBox.shrink();
  //
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 15),
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(15),
  //       border: Border.all(color: const Color(0xFF77EDF9).withOpacity(0.2)),
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(15),
  //       child: Image.network(
  //         baseUrl + url,
  //         fit: BoxFit.cover,
  //         // Loading State
  //         loadingBuilder: (context, child, loadingProgress) {
  //           if (loadingProgress == null) return child;
  //           return Container(
  //             height: 150,
  //             color: Colors.grey[50],
  //             child: const Center(
  //               child: CircularProgressIndicator(strokeWidth: 2),
  //             ),
  //           );
  //         },
  //         // Error State: Agar internet band ho ya URL expire ho jaye toh box gayab
  //         errorBuilder: (context, error, stackTrace) {
  //           debugPrint("Image Error: $error");
  //           return const SizedBox.shrink(); // Box gayab ho jayega
  //         },
  //       ),
  //     ),
  //   );
  // }
  // PopupMenuItem<String> _buildPopupItem(String val, String text, Color color) {
  //   return PopupMenuItem(
  //     value: val,
  //     child: Row(
  //       children: [
  //         Icon(Icons.bookmark, color: color, size: 20),
  //         const SizedBox(width: 10),
  //         Text(text),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildOption(
  //     String text,
  //     String optId,
  //     TestsController controller,
  //     String qId,
  //     int index,
  //     String? imageUrl,
  //     ) {
  //   bool isSelected = controller.userSelections[qId] == optId;
  //
  //   return Container(
  //     width: double.infinity,
  //     margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
  //     decoration: BoxDecoration(
  //       color: isSelected ? const Color(0xFFF0FEFF) : Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //       border: Border.all(
  //         color: isSelected ? AppColors.primary : Colors.transparent,
  //         width: 1,
  //       ),
  //     ),
  //     child: Material(
  //       color: Colors.transparent,
  //       borderRadius: BorderRadius.circular(10),
  //       child: InkWell(
  //         onTap: () => controller.selectOption(qId, optId),
  //         borderRadius: BorderRadius.circular(10),
  //         child: Padding(
  //           padding: EdgeInsets.all(0.04.toWidthPercent()),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               if (imageUrl != null && imageUrl.isNotEmpty) ...[
  //                 ClipRRect(
  //                   borderRadius: BorderRadius.circular(8),
  //                   child: Image.network(
  //                     baseUrl + imageUrl,
  //                     fit: BoxFit.contain,
  //                     errorBuilder: (context, error, stackTrace) =>
  //                     const SizedBox(),
  //                   ),
  //                 ),
  //                 SizedBox(height: 0.01.toHeightPercent()),
  //               ],
  //               Row(
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.all(0.015.toWidthPercent()),
  //                     decoration: BoxDecoration(
  //                       color: AppColors.primary,
  //                       borderRadius: BorderRadius.circular(5),
  //                     ),
  //                     child: Text(
  //                       String.fromCharCode(65 + index), // A, B, C, D
  //                       style: TextStyle(
  //                         fontSize: 0.035.toWidthPercent(),
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(width: 0.03.toWidthPercent()),
  //                   Expanded(
  //                     child: Text(
  //                       text,
  //                       style: TextStyle(
  //                         fontSize: 0.038.toWidthPercent(),
  //                         fontWeight: FontWeight.w600,
  //                         color: Colors.black87,
  //                       ),
  //                     ),
  //                   ),
  //                   if (isSelected)
  //                     const Icon(
  //                       Icons.check_circle,
  //                       color: AppColors.primary,
  //                       size: 20,
  //                     ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildQuestionImage(String? url) {
    if (url == null || url.isEmpty) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF77EDF9).withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          baseUrl + url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 150,
              color: Colors.grey[50],
              child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            debugPrint("Image Error: $error");
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String val, String text, Color color) {
    return PopupMenuItem(
      value: val,
      child: Row(
        children: [
          Icon(Icons.bookmark, color: color, size: 20),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildOption(
      String text,
      String optId,
      TestsController controller,
      String qId,
      int index,
      String? imageUrl,
      ) {
    bool isSelected = controller.userSelections[qId] == optId;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF0FEFF) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => controller.selectOption(qId, optId),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.all(0.04.toWidthPercent()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl != null && imageUrl.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      baseUrl + imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const SizedBox(),
                    ),
                  ),
                  SizedBox(height: 0.01.toHeightPercent()),
                ],
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(0.015.toWidthPercent()),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
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
                    SizedBox(width: 0.03.toWidthPercent()),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 0.038.toWidthPercent(),
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 20,
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

  // Widget _buildDotsIndicator(TestsController controller) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 0.02.toHeightPercent()),
  //     child: Obx(
  //           () => Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: List.generate(
  //           controller.questionsList.length,
  //               (index) => Container(
  //             margin: const EdgeInsets.symmetric(horizontal: 3),
  //             width: 8,
  //             height: 8,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: index == controller.currentQuestionIndex.value
  //                   ? AppColors.primary
  //                   : Colors.grey[300],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Future<bool?> _showQuitConfirmationDialog(BuildContext context) {
  //   return showDialog<bool>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text(
  //         'Quit Test?',
  //         style: TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //       content: const Text(
  //         'Are you sure you want to quit the test? your progress will not be saved.',
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: const Text('No', style: TextStyle(color: Colors.black54)),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: const Text('Yes, Quit', style: TextStyle(color: Colors.red)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildDotsIndicator(TestsController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.02.toHeightPercent()),
      child: Obx(
            () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            controller.questionsList.length,
                (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == controller.currentQuestionIndex.value
                    ? AppColors.primary
                    : Colors.grey[300],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showQuitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quit Test?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to quit the test? Your progress will not be saved.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No', style: TextStyle(color: Colors.black54)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes, Quit', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Widget _buildBottomNav(TestsController controller) {
  //   return Padding(
  //     padding: EdgeInsets.all(0.04.toWidthPercent()),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Obx(
  //                 () => OutlinedButton(
  //               onPressed: controller.currentQuestionIndex.value > 0
  //                   ? controller.previousQuestion
  //                   : null,
  //               style: OutlinedButton.styleFrom(
  //                 side: const BorderSide(color: AppColors.primary),
  //                 padding: EdgeInsets.symmetric(
  //                   vertical: 0.015.toHeightPercent(),
  //                 ),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //               ),
  //               child: const Text(
  //                 'Previous',
  //                 style: TextStyle(
  //                   color: AppColors.primary,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 0.04.toWidthPercent()),
  //         Expanded(
  //           child: Obx(() {
  //             bool isLast =
  //                 controller.currentQuestionIndex.value ==
  //                     controller.questionsList.length - 1;
  //             return ElevatedButton(
  //               onPressed: isLast
  //                   ? controller.submitTest
  //                   : controller.nextQuestion,
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: AppColors.primary,
  //                 foregroundColor: Colors.white,
  //                 padding: EdgeInsets.symmetric(
  //                   vertical: 0.015.toHeightPercent(),
  //                 ),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 elevation: 0,
  //               ),
  //               child: Text(
  //                 isLast ? 'Submit' : 'Next',
  //                 style: const TextStyle(fontWeight: FontWeight.bold),
  //               ),
  //             );
  //           }),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildImageTag(String tagText) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
  //     decoration: BoxDecoration(
  //       color: const Color(0xFF77EDF9).withOpacity(0.8),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Text(
  //       tagText,
  //       style: const TextStyle(
  //         color: Colors.white,
  //         fontSize: 13,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildBottomNav(TestsController controller) {
    return Padding(
      padding: EdgeInsets.all(0.04.toWidthPercent()),
      child: Row(
        children: [
          Expanded(
            child: Obx(
                  () => OutlinedButton(
                onPressed: controller.currentQuestionIndex.value > 0 ? controller.previousQuestion : null,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  padding: EdgeInsets.symmetric(vertical: 0.015.toHeightPercent()),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Previous',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(width: 0.04.toWidthPercent()),
          Expanded(
            child: Obx(() {
              bool isLast = controller.currentQuestionIndex.value == controller.questionsList.length - 1;
              return ElevatedButton(
                onPressed: isLast ? controller.submitTest : controller.nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 0.015.toHeightPercent()),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text(
                  isLast ? 'Submit' : 'Next',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildImageTag(String tagText) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF77EDF9).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tagText,
        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }
}