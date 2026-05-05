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
            leading: IconButton(
              icon: const Icon(Icons.grid_view_rounded, color: AppColors.primary),
              onPressed: () => _showReviewSheet(context, controller),
            ),
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
                                          final bookmarkCtrl =
                                              Get.find<BookmarkController>();

                                          bool isMost = bookmarkCtrl
                                              .mostImportantBookmarks
                                              .any((b) => b.mcq?.id == qId);
                                          bool isVery = bookmarkCtrl
                                              .veryImportantBookmarks
                                              .any((b) => b.mcq?.id == qId);
                                          bool isImp = bookmarkCtrl
                                              .importantBookmarks
                                              .any((b) => b.mcq?.id == qId);

                                          bool isBookmarked =
                                              isMost || isVery || isImp;

                                          String category = "";
                                          if (isMost)
                                            category = "mostimportant";
                                          else if (isVery)
                                            category = "veryimportant";
                                          else if (isImp)
                                            category = "important";

                                          Color iconColor = AppColors.primary
                                              .withOpacity(0.5);
                                          if (category == "mostimportant")
                                            iconColor = Colors.red;
                                          else if (category == "veryimportant")
                                            iconColor = Colors.orange;
                                          else if (category == "important")
                                            iconColor = Colors.blue;

                                          return PopupMenuButton<String>(
                                            icon: Icon(
                                              isBookmarked
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              color: iconColor,
                                              size: 0.08.toWidthPercent(),
                                            ),
                                            onSelected: (value) async {
                                              await bookmarkCtrl.toggleBookmark(
                                                type: "mcq",
                                                itemId: qId,
                                                category: value,
                                              );
                                              bookmarkCtrl
                                                  .mostImportantBookmarks
                                                  .refresh();
                                              bookmarkCtrl
                                                  .veryImportantBookmarks
                                                  .refresh();
                                              bookmarkCtrl.importantBookmarks
                                                  .refresh();
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
                              if (currentQuestion['imageTag'] != null &&
                                  currentQuestion['imageTag'] != "")
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
                _buildBottomNav(context, controller),
              ],
            );
          }),
        ),
      ),
    );
  }

  void _showReviewSheet(BuildContext context, TestsController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ReviewSheet(controller: controller),
    );
  }

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
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
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
        title: const Text(
          'Quit Test?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to quit the test? Your progress will not be saved.',
        ),
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

  Widget _buildBottomNav(BuildContext context, TestsController controller) {
    return Padding(
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
                  padding: EdgeInsets.symmetric(
                    vertical: 0.015.toHeightPercent(),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Previous',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 0.04.toWidthPercent()),
          Expanded(
            child: Obx(() {
              bool isLast =
                  controller.currentQuestionIndex.value ==
                  controller.questionsList.length - 1;
              return ElevatedButton(
                onPressed: isLast
                    ? controller.submitTest
                    : controller.nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: 0.015.toHeightPercent(),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ReviewSheet extends StatefulWidget {
  final TestsController controller;
  const _ReviewSheet({required this.controller});

  @override
  State<_ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<_ReviewSheet> {
  int selectedPart = 0;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    int questionsPerPart = 25;
    int totalParts = (controller.questionsList.length / questionsPerPart).ceil();
    if (totalParts == 0) totalParts = 1;

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                Obx(() => Text(
                      controller.timeDisplay.value,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(),
          if (totalParts > 1)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(totalParts, (index) {
                  bool isSelected = selectedPart == index;
                  return InkWell(
                    onTap: () => setState(() => selectedPart = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Part ${index + 1}",
                        style: TextStyle(
                          color: isSelected ? AppColors.primary : Colors.grey,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Obx(() => Text(
                  "Currently attempting question ${controller.currentQuestionIndex.value + 1}",
                  style: const TextStyle(color: Colors.grey),
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                int start = selectedPart * questionsPerPart;
                int end =
                    (start + questionsPerPart) > controller.questionsList.length
                        ? controller.questionsList.length
                        : (start + questionsPerPart);

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: end - start,
                  itemBuilder: (context, index) {
                    int questionIdx = start + index;
                    final question = controller.questionsList[questionIdx];
                    final qId = question['id'];
                    bool isAttempted = controller.userSelections[qId] != null;
                    bool isCurrent =
                        controller.currentQuestionIndex.value == questionIdx;

                    return InkWell(
                      onTap: () {
                        controller.pageController.jumpToPage(questionIdx);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? AppColors.primary.withOpacity(0.8)
                              : (isAttempted
                                  ? AppColors.primary.withOpacity(0.1)
                                  : Colors.white),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isCurrent
                                ? AppColors.primary
                                : Colors.grey.shade300,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "${questionIdx + 1}",
                            style: TextStyle(
                              color: isCurrent ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.submitTest();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary.withOpacity(0.4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("SUBMIT",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
