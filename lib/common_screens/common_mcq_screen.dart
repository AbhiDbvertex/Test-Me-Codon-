import 'package:codon/features/qtest/controllers/qtest_controller.dart';
import 'package:codon/features/qtest/models/qtest_models.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonMCQScreen extends StatelessWidget {
  final String subjectName;
  const CommonMCQScreen({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    final QTestController controller = Get.find<QTestController>();
    // Ensure state is fresh when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetQuiz();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subjectName,
              style: TextStyle(
                fontSize: 0.05.toWidthPercent(),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '12:00',
              style: TextStyle(
                fontSize: 0.05.toWidthPercent(),
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Progress indicator: Dots
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.02.toHeightPercent()),
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
                      color: index == controller.currentQuestionIndex.value
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
                      horizontal: 0.06.toWidthPercent(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0.02.toHeightPercent()),
                        Container(
                          padding: EdgeInsets.all(0.04.toWidthPercent()),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Text(
                            currentQuestion.question.text,
                            style: TextStyle(
                              fontSize: 0.045.toWidthPercent(),
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: 0.04.toHeightPercent()),
                        ...List.generate(
                          currentQuestion.options.length,
                          (idx) => _buildOption(
                            currentQuestion.options[idx],
                            idx,
                            controller,
                            index,
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
          // Bottom Navigation Buttons
          Container(
            padding: EdgeInsets.all(0.06.toWidthPercent()),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => _buildActionButton(
                      'Previous',
                      onPressed: controller.currentQuestionIndex.value > 0
                          ? controller.previousQuestion
                          : null,
                      isOutline: true,
                    ),
                  ),
                ),
                SizedBox(width: 0.04.toWidthPercent()),
                Expanded(
                  child: Obx(() {
                    bool isLast =
                        controller.currentQuestionIndex.value ==
                        controller.questions.length - 1;
                    return _buildActionButton(
                      isLast ? 'Submit' : 'Next',
                      onPressed: controller.nextQuestion,
                      isOutline: false,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label, {
    VoidCallback? onPressed,
    bool isOutline = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutline ? Colors.white : AppColors.primary,
        foregroundColor: isOutline ? AppColors.primary : Colors.white,
        side: isOutline ? BorderSide(color: AppColors.primary) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 0.015.toHeightPercent()),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
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

    String prefix = String.fromCharCode(65 + index) + ". ";

    Color bgColor = Colors.white;
    Color textColor = Colors.black87;
    Color borderColor = Colors.grey[200]!;

    if (isAnswered) {
      if (isCorrectAnswer) {
        bgColor = const Color(0xFFA5F482); // Green for correct
        textColor = Colors.white;
        borderColor = Colors.transparent;
      } else if (isSelectedByUser) {
        bgColor = const Color(0xFFFFA07A); // Red/Orange for selected wrong
        textColor = Colors.white;
        borderColor = Colors.transparent;
      } else {
        bgColor = Colors.white;
        textColor = Colors.black87;
        borderColor = Colors.grey[200]!;
      }
    } else if (isSelectedByUser) {
      // Logic for immediate selection before persistence if needed,
      // effectively covered by isAnswered with current controller logic
    }

    return GestureDetector(
      onTap: isAnswered ? null : () => controller.selectAnswer(index),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
        padding: EdgeInsets.all(0.04.toWidthPercent()),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (option.image != null && option.image!.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  constraints: BoxConstraints(maxHeight: 0.2.toHeightPercent()),
                  width: double.infinity,
                  child: Image.network(
                    baseUrl + option.image!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 0.01.toHeightPercent()),
            ],
            Row(
              children: [
                Expanded(
                  child: Text(
                    prefix + option.text,
                    style: TextStyle(
                      fontSize: 0.04.toWidthPercent(),
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
}
