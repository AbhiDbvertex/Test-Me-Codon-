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

import '../../home/controllers/bookmark_controller.dart';

class MCQScreen extends StatelessWidget {
  final ChapterTestModel? qTest;
  final topicId;
  final codonpass;
  const MCQScreen({super.key, this.qTest, this.topicId, this.codonpass});

  @override
  Widget build(BuildContext context) {
    final QTestController controller = Get.find<QTestController>();

    // Reset quiz state when entering the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // controller.fetchQTest(topicId);
      print("Abhi:- MCQScreen topicId: ${topicId}");
      if (codonpass == 'codon') {
        controller.fetchQTest(topicId);
      } else {
        controller.fetchQTest(qTest!.id); //
      }
    });

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await _showQuitConfirmationDialog(context);
        if (shouldPop == true) {
          Get.back();
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Color(0xFFF8F8F8),
          appBar: AppBar(
            title: Text(
              qTest?.testTitle ?? "",
              style: TextStyle(
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
              Obx(
                () => Container(
                  margin: const EdgeInsets.only(right: 1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${controller.remainingSeconds.value}s',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.questions.isEmpty) {
              return const Center(child: Text('No questions available'));
            }
            return Column(
              children: [
                // Progress indicator: Dots
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.02.toHeightPercent(),
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.questions.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                index == controller.currentQuestionIndex.value
                                ? AppColors.primary
                                : Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: controller.questions.length,
                    itemBuilder: (context, index) {
                      final currentQuestion = controller.questions[index];
                      return Obx(() {
                        return SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.04.toWidthPercent(),
                          ),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
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
                                      // color: Colors.red,
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
                                            (index + 1).toString() +
                                                ". " +
                                                currentQuestion.question.text,
                                            style: TextStyle(
                                              fontSize: 0.048.toWidthPercent(),
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                255,
                                                54,
                                                92,
                                                95,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(() {
                                          final bookmarkCtrl = Get.put(
                                            BookmarkController(),
                                          );

                                          final isBookmarked = bookmarkCtrl
                                              .isBookmarked(
                                                currentQuestion.question.mcqId,
                                              );
                                          final category = bookmarkCtrl
                                              .getCategory(
                                                currentQuestion.question.mcqId,
                                              );

                                          Color iconColor;

                                          if (!isBookmarked) {
                                            iconColor = AppColors.primary
                                                .withOpacity(0.5);
                                          } else {
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
                                              default:
                                                iconColor = AppColors.primary;
                                            }
                                          }

                                          return PopupMenuButton<String>(
                                            icon: Icon(
                                              isBookmarked
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              color: iconColor,
                                              size: 0.06.toWidthPercent(),
                                            ),
                                            onSelected: (value) {
                                              bookmarkCtrl.toggleBookmark(
                                                type: "mcq",
                                                itemId: currentQuestion
                                                    .question
                                                    .mcqId,
                                                category: value,
                                              );
                                            },
                                            itemBuilder: (context) => [
                                              _buildPopupItem(
                                                'mostimportant',
                                                'Most Important',
                                                Colors.red,
                                              ),
                                              _buildPopupItem(
                                                'veryimportant',
                                                'Very Important',
                                                Colors.orange,
                                              ),
                                              _buildPopupItem(
                                                'important',
                                                'Important',
                                                Colors.blue,
                                              ),
                                              _buildPopupItem(
                                                'removed',
                                                'remove',
                                                Colors.grey,
                                              ),
                                            ],
                                          );
                                        }),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),

                                    if (currentQuestion
                                        .question
                                        .images
                                        .isNotEmpty) ...[
                                      SizedBox(height: 0.02.toHeightPercent()),
                                      ...currentQuestion.question.images.map(
                                        (img) =>
                                            _buildQuestionImage(baseUrl + img),

                                        // (img) => ClipRRect(
                                        //   borderRadius: BorderRadius.circular(12),
                                        //   child: Container(
                                        //     constraints: BoxConstraints(
                                        //       maxHeight: 0.2.toHeightPercent(),
                                        //     ),
                                        //     width: double.infinity,
                                        //     child: Image.network(
                                        //       baseUrl + img,
                                        //       fit: BoxFit.contain,
                                        //       errorBuilder:
                                        //           (context, error, stackTrace) =>
                                        //               const SizedBox(),
                                        //     ),
                                        //   ),
                                        // ),
                                      ),
                                    ],
                                    SizedBox(height: 0.03.toHeightPercent()),
                                    Divider(color: AppColors.primary),
                                    SizedBox(height: 0.03.toHeightPercent()),
                                    ...List.generate(
                                      currentQuestion.options.length,
                                      (idx) => _buildOption(
                                        currentQuestion.options[idx],
                                        idx,
                                        controller,
                                        index,
                                      ),
                                    ),
                                    SizedBox(height: 0.02.toHeightPercent()),
                                    // MCQ ID Section
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.05,
                                              ),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'MCQ ID: ${currentQuestion.id}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 0.035
                                                      .toWidthPercent(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(
                                              Icons.copy_rounded,
                                              size: 18,
                                              color: Colors.grey[400],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 0.02.toHeightPercent()),
                              // Tags and Pearl ID Row (outside card)
                              if (currentQuestion.tags.isNotEmpty ||
                                  currentQuestion.tagId.isNotEmpty)
                                Wrap(
                                  alignment: WrapAlignment.end,
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    if (currentQuestion.tags.isNotEmpty)
                                      ...currentQuestion.tags.map(
                                        (tag) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            tag.startsWith('#') ? tag : "#$tag",
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 0.03.toWidthPercent(),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    else if (currentQuestion.tagId.isNotEmpty)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          currentQuestion.tagId.startsWith('#')
                                              ? currentQuestion.tagId
                                              : "#${currentQuestion.tagId}",
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 0.03.toWidthPercent(),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              SizedBox(height: 0.02.toHeightPercent()),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: currentQuestion.codonId,
                                      ),
                                    );
                                    Get.snackbar(
                                      'Copied',
                                      'Codon ID copied to clipboard',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.black87,
                                      colorText: Colors.white,
                                      duration: const Duration(seconds: 1),
                                      margin: const EdgeInsets.all(10),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Codon ID: ${currentQuestion.codonId}',
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 0.03.toWidthPercent(),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Icon(
                                          Icons.copy_rounded,
                                          size: 0.035.toWidthPercent(),
                                          color: Colors.grey[600],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.02.toHeightPercent()),
                              // View Explanation Button (outside card)
                              controller.userAnswers.containsKey(
                                    currentQuestion.id,
                                  )
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      width: 0.6.toWidthPercent(),
                                      height: 0.06.toHeightPercent(),

                                      // child: ElevatedButton(
                                      //   onPressed: controller.togglePearl,
                                      //   style: ElevatedButton.styleFrom(
                                      //     backgroundColor: AppColors.primary,
                                      //     foregroundColor: Colors.grey[700],
                                      //     padding: EdgeInsets.symmetric(
                                      //       vertical: 0.012.toHeightPercent(),
                                      //     ),
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(
                                      //         10,
                                      //       ),
                                      //     ),
                                      //     elevation: 0,
                                      //   ),
                                      //   child: Text(
                                      //     'View Explanation',
                                      //     style: TextStyle(
                                      //       fontSize: 0.025.toWidthPercent(),
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ),
                                      child: ElevatedButton(
                                        onPressed: controller.togglePearl,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 0.012.toHeightPercent(),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              0.02.toWidthPercent(),
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              controller.showPearl.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              size: 0.045.toWidthPercent(),
                                            ),
                                            SizedBox(
                                              width: 0.02.toWidthPercent(),
                                            ),
                                            Text(
                                              controller.showPearl.value
                                                  ? 'Hide Explanation'
                                                  : 'View Explanation',
                                              style: TextStyle(
                                                fontSize: 0.04.toWidthPercent(),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 0.03.toHeightPercent()),
                              if (controller.showPearl.value && (currentQuestion.explanation.images.isNotEmpty || currentQuestion.explanation.text.isNotEmpty)) ...[
                                SizedBox(height: 0.02.toHeightPercent()),
                                // Explanation Content
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HtmlWidget(
                                        currentQuestion.explanation.text,
                                      ),
                                      if (currentQuestion
                                          .explanation
                                          .images
                                          .isNotEmpty) ...[
                                        SizedBox(height: 10),
                                        ...currentQuestion.explanation.images
                                            .map(
                                              (img) => Image.network(
                                                img,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => const SizedBox(),
                                              ),
                                            ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      });
                    },
                  ),
                ),
                // Bottom Nav
                Padding(
                  padding: EdgeInsets.all(0.04.toWidthPercent()),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => OutlinedButton(
                            onPressed: controller.currentQuestionIndex.value > 0
                                ? controller.previousQuestion
                                : null,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Previous',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 0.04.toWidthPercent()),
                      Expanded(
                        child: Obx(() {
                          bool isLast =
                              controller.currentQuestionIndex.value ==
                              controller.questions.length - 1;
                          return ElevatedButton(
                            onPressed: () {
                              if (isLast) {
                                _showSubmitConfirmationDialog(
                                  context,
                                  controller,
                                  codonpass == 'codon',
                                ); // Call Dialog
                              } else {
                                if (codonpass == 'codon') {
                                  controller.nextQuestion(
                                    isFromCodonPass: true,
                                  );
                                } else {
                                  controller.nextQuestion();
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(isLast ? 'Submit' : 'Next'),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildOption(
    McqOption option,
    int index,
    QTestController controller,
    int questionIndex,
  ) {
    final currentQuestion = controller.questions[questionIndex];
    bool isAnswered = controller.userAnswers.containsKey(currentQuestion.id);
    bool isCorrectAnswer = index == currentQuestion.correctAnswer;
    bool isSelectedByUser = controller.selectedAnswerIndex.value == index;

    Color bgColor = const Color(0xFFF0FEFF);
    Color textColor = Colors.black87;

    if (isAnswered) {
      if (isCorrectAnswer) {
        bgColor = const Color(0xFFA5F482); // Green for correct answer
        textColor = Colors.white;
      } else if (isSelectedByUser) {
        bgColor = const Color(
          0xFFFFA07A,
        ); // Red/Orange for selected wrong answer
        textColor = Colors.white;
      } else {
        bgColor = const Color(
          0xFFF0FEFF,
        ); // Default for unselected wrong options
        textColor = Colors.black87;
      }
    } else if (isSelectedByUser) {
      // This case might not be reached if we disable selection after answer,
      // but keeping it for immediate feedback logic if needed before persisting 'isAnswered' state fully?
      // Actually with the controller change, isSelectedByUser will be true and isAnswered will be true immediately.
      // So the logic above covers it.
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
                      scale: 8,
                      // height: 100,
                      // width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(),
                    ),
                  ),
                  SizedBox(height: 0.01.toHeightPercent()),
                ],
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(0.015.toWidthPercent()),
                      decoration: BoxDecoration(
                        color: isAnswered
                            ? (isCorrectAnswer
                                  ? Colors.white.withOpacity(0.3)
                                  : (isSelectedByUser
                                        ? Colors.white.withOpacity(0.3)
                                        : AppColors.primary))
                            : AppColors.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        String.fromCharCode(65 + index), // A, B, C, D
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

  Widget _buildQuestionImage(String? url) {
    // 1. URL empty hai toh gap bhi mat dikhao
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
          url,
          fit: BoxFit.cover,
          // Loading State
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 150,
              color: Colors.grey[50],
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
          // Error State: Agar internet band ho ya URL expire ho jaye toh box gayab
          errorBuilder: (context, error, stackTrace) {
            debugPrint("Image Error: $error");
            return const SizedBox.shrink(); // Box gayab ho jayega
          },
        ),
      ),
    );
  }

  Future<bool?> _showQuitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Red Alert Header
            Container(
              height: 0.07.toHeightPercent(),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                size: 35,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0.06.toWidthPercent()),
              child: Column(
                children: [
                  Text(
                    "Quit Assessment?",
                    style: TextStyle(
                      fontSize: 0.05.toWidthPercent(),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 0.015.toHeightPercent()),
                  Text(
                    "Are you sure you want to leave? Your current progress in this session might not be saved.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 0.035.toWidthPercent(),
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.03.toHeightPercent()),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text(
                            "CONTINUE TEST",
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "QUIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSubmitConfirmationDialog(
    BuildContext context,
    QTestController controller,
    bool isFromCodonPass,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cyan Success Header
            Container(
              height: 0.07.toHeightPercent(),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: const Icon(
                Icons.check_circle_outline,
                size: 35,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0.06.toWidthPercent()),
              child: Column(
                children: [
                  Text(
                    "Final Submission",
                    style: TextStyle(
                      fontSize: 0.05.toWidthPercent(),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 0.015.toHeightPercent()),
                  Text(
                    "You have reached the end of the test. Would you like to submit your answers and view the result?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 0.035.toWidthPercent(),
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.03.toHeightPercent()),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "REVIEW",
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            controller.nextQuestion(
                              isFromCodonPass: isFromCodonPass,
                            ); // Final Submit Logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "SUBMIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
}
