import 'package:codon/features/qtest/controllers/custom_test_mcq_controller.dart';
import 'package:codon/features/qtest/models/custom_test_model.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class CustomTestMcqScreen extends StatelessWidget {
  final CustomTestModel customTest;
  const CustomTestMcqScreen({super.key, required this.customTest});

  @override
  Widget build(BuildContext context) {
    // Initialize controller with the provided custom test
    final CustomTestMcqController controller = Get.put(
      CustomTestMcqController(customTest: customTest),
      tag: DateTime.now().millisecondsSinceEpoch
          .toString(), // Unique tag to avoid controller reuse
    );

    final isRegularMode =
        customTest.requestedMode == 'regular' ||
        customTest.requestedMode == 'reguler';

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        _showQuitConfirmationDialog(context, controller);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
          title: Text(
            isRegularMode ? 'Practice Mode' : 'Exam Mode',
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
            if (customTest.isTimerRequired)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.timer, size: 18, color: Colors.red[700]),
                        const SizedBox(width: 4),
                        Obx(
                          () => Text(
                            controller.timeDisplay.value,
                            style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black, size: 28),
              onPressed: () => _showQuitConfirmationDialog(context, controller),
            ),
          ],
        ),
        body: customTest.data.isEmpty
            ? const Center(child: Text('No questions available'))
            : Column(
                children: [
                  Obx(() => _buildDotsIndicator(controller)),
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: controller.onPageChanged,
                      itemCount: customTest.data.length,
                      itemBuilder: (context, index) {
                        final question = customTest.data[index];
                        return Obx(() {
                          return SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.04.toWidthPercent(),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 0.02.toHeightPercent()),
                                _buildQuestionCard(
                                  question,
                                  index,
                                  controller,
                                  isRegularMode,
                                ),
                                SizedBox(height: 0.02.toHeightPercent()),
                                if (isRegularMode &&
                                    controller.userAnswers[question.id] != null)
                                  _buildExplanationSection(
                                    question,
                                    controller,
                                  ),
                                SizedBox(height: 0.04.toHeightPercent()),
                              ],
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  Obx(() => _buildBottomNav(controller)),
                ],
              ),
      ),
    );
  }

  Widget _buildQuestionCard(
    TestQuestion question,
    int index,
    CustomTestMcqController controller,
    bool isRegularMode,
  ) {
    return Container(
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
            "${index + 1}. ${question.question.text}",
            style: TextStyle(
              fontSize: 0.042.toWidthPercent(),
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          if (question.question.images.isNotEmpty)
            ...question.question.images.map((url) => _buildImage(url)),
          SizedBox(height: 0.03.toHeightPercent()),
          Divider(color: AppColors.primary),
          SizedBox(height: 0.03.toHeightPercent()),
          ...List.generate(
            question.options.length,
            (optIdx) => _buildOption(
              question.options[optIdx],
              optIdx,
              question,
              controller,
              isRegularMode,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    OptionModel option,
    int index,
    TestQuestion question,
    CustomTestMcqController controller,
    bool isRegularMode,
  ) {
    final selectedIndex = controller.userAnswers[question.id];
    final isAnswered = selectedIndex != null;
    final isSelected = selectedIndex == index;
    final isCorrect = index == question.correctAnswer;

    Color bgColor = const Color(0xFFF0FEFF);
    Color borderColor = Colors.transparent;
    Color textColor = Colors.black87;

    if (isAnswered) {
      if (isRegularMode) {
        if (isCorrect) {
          bgColor = const Color(0xFFA5F482);
          textColor = Colors.white;
        } else if (isSelected) {
          bgColor = const Color(0xFFFFA07A);
          textColor = Colors.white;
        }
      } else {
        // Exam Mode: just show selection without correct/wrong feedback
        if (isSelected) {
          bgColor = AppColors.primary.withOpacity(0.2);
          borderColor = AppColors.primary;
        }
      }
    }

    return GestureDetector(
      onTap: () => controller.selectAnswer(index),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
        padding: EdgeInsets.all(0.04.toWidthPercent()),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (option.image != null && option.image!.isNotEmpty)
              _buildImage(option.image!, isOption: true),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
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
    );
  }

  Widget _buildImage(String url, {bool isOption = false}) {
    return Padding(
      padding: EdgeInsets.only(top: isOption ? 0 : 10, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          baseUrl + (url.startsWith('/') ? '' : '/') + url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildExplanationSection(
    TestQuestion question,
    CustomTestMcqController controller,
  ) {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: controller.toggleExplanation,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('View Explanation'),
          ),
        ),
        Obx(() {
          if (!controller.showExplanation.value) return const SizedBox.shrink();
          return Container(
            margin: const EdgeInsets.only(top: 15),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HtmlWidget(question.explanation.text),
                ...question.explanation.images.map((url) => _buildImage(url)),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDotsIndicator(CustomTestMcqController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.02.toHeightPercent()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          customTest.data.length,
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
    );
  }

  Widget _buildBottomNav(CustomTestMcqController controller) {
    return Padding(
      padding: EdgeInsets.all(0.04.toWidthPercent()),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
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
          SizedBox(width: 0.04.toWidthPercent()),
          Expanded(
            child: ElevatedButton(
              onPressed: controller.nextQuestion,
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
                controller.currentQuestionIndex.value ==
                        customTest.data.length - 1
                    ? 'Submit'
                    : 'Next',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showQuitConfirmationDialog(
    BuildContext context,
    CustomTestMcqController controller,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Leave Test?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Do you want to submit your test before leaving?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              controller.submitQuiz();
            },
            child: const Text(
              'Leave & Submit',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
