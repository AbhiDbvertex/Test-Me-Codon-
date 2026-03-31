import 'package:codon/features/settings/screens/rating_screen.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class QuizResultScreen extends StatelessWidget {
  final int totalMcqs;
  final int correct;
  final int wrong;
  final int notAttempted;
  final String targetType;
  final String? chapterId;
  final String? scorePercentage;
  final List<dynamic>? questions;
  final Map<String, dynamic>? userAnswers;

  const QuizResultScreen({
    super.key,
    required this.totalMcqs,
    required this.correct,
    required this.wrong,
    required this.notAttempted,
    required this.targetType,
    this.chapterId,
    this.scorePercentage,
    this.questions,
    this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.06.toWidthPercent()),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: 0.04.toHeightPercent()),
                _buildPerformanceSection(),
                if (questions != null && questions!.isNotEmpty) ...[
                  SizedBox(height: 0.04.toHeightPercent()),
                  _buildReviewSection(),
                ],
                SizedBox(height: 0.04.toHeightPercent()),
                _buildReviewButton(),
                SizedBox(height: 0.04.toHeightPercent()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 48),
            Text(
              'Quiz Result',
              style: TextStyle(
                fontSize: 0.05.toWidthPercent(),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black, size: 28),
              onPressed: () => Get.back(),
            ),
          ],
        ),
        Text(
          'You Performed',
          style: TextStyle(
            fontSize: 0.06.toWidthPercent(),
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceSection() {
    final double calculatedPercentage = totalMcqs > 0
        ? (correct / totalMcqs) * 100
        : 0;
    final String displayPercentage =
        scorePercentage ?? calculatedPercentage.toStringAsFixed(0);

    return Container(
      padding: EdgeInsets.all(0.06.toWidthPercent()),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '$displayPercentage%',
            style: TextStyle(
              fontSize: 0.12.toWidthPercent(),
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            'Score',
            style: TextStyle(
              fontSize: 0.04.toWidthPercent(),
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 0.04.toHeightPercent()),
          _buildSegmentedBar(),
          SizedBox(height: 0.06.toHeightPercent()),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildSegmentedBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 24,
        child: Row(
          children: [
            if (correct > 0)
              Expanded(
                flex: correct,
                child: Container(color: const Color(0xFFA5F482)),
              ),
            if (wrong > 0)
              Expanded(
                flex: wrong,
                child: Container(color: const Color(0xFFFFA07A)),
              ),
            if (notAttempted > 0)
              Expanded(
                flex: notAttempted,
                child: Container(color: const Color(0xFFF0F0F0)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      children: [
        _buildLegendItem(const Color(0xFFA5F482), '$correct Correct'),
        SizedBox(height: 0.02.toHeightPercent()),
        _buildLegendItem(const Color(0xFFFFA07A), '$wrong Wrong'),
        SizedBox(height: 0.02.toHeightPercent()),
        _buildLegendItem(
          const Color(0xFFF0F0F0),
          '$notAttempted Not Attempted',
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        SizedBox(width: 0.1.toWidthPercent()),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 0.04.toWidthPercent()),
        Text(
          text,
          style: TextStyle(
            fontSize: 0.035.toWidthPercent(),
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(
            () => const RatingScreen(),
            arguments: {"targetId": chapterId ?? "", "targetType": targetType},
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
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review Questions',
          style: TextStyle(
            fontSize: 0.05.toWidthPercent(),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 0.02.toHeightPercent()),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: questions!.length,
          itemBuilder: (context, index) {
            final question = questions![index];
            return _buildQuestionCard(question, index);
          },
        ),
      ],
    );
  }

  Widget _buildQuestionCard(dynamic question, int index) {
    final String qText = question.question.text;
    final List<String> qImages = question.question.images;
    final List<dynamic> options = question.options;
    final int correctAnswer = question.correctAnswer;
    final String qId = question.id;
    final int? selectedIndex = userAnswers?[qId];

    bool isCorrect = selectedIndex == correctAnswer;
    bool isUnattempted = selectedIndex == null;

    return Container(
      margin: EdgeInsets.only(bottom: 0.03.toHeightPercent()),
      padding: EdgeInsets.all(0.04.toWidthPercent()),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isUnattempted
                      ? Colors.grey[100]
                      : isCorrect
                      ? Colors.green[50]
                      : Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isUnattempted
                      ? 'Unattempted'
                      : isCorrect
                      ? 'Correct'
                      : 'Incorrect',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isUnattempted
                        ? Colors.grey[600]
                        : isCorrect
                        ? Colors.green[700]
                        : Colors.red[700],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 0.02.toHeightPercent()),
          HtmlWidget(
            qText,
            textStyle: TextStyle(
              fontSize: 0.04.toWidthPercent(),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (qImages.isNotEmpty) ...[
            SizedBox(height: 0.02.toHeightPercent()),
            ...qImages.map(
              (img) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    img.startsWith('http') ? img : baseUrl + img,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(),
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 0.02.toHeightPercent()),
          ...List.generate(options.length, (idx) {
            final option = options[idx];
            bool isOptionCorrect = idx == correctAnswer;
            bool isOptionSelected = idx == selectedIndex;

            Color bgColor = Colors.white;
            Color borderColor = Colors.grey[300]!;
            Color textColor = Colors.black87;

            if (isOptionCorrect) {
              bgColor = Colors.green[50]!;
              borderColor = Colors.green;
              textColor = Colors.green[700]!;
            } else if (isOptionSelected && !isCorrect) {
              bgColor = Colors.red[50]!;
              borderColor = Colors.red;
              textColor = Colors.red[700]!;
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: borderColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        String.fromCharCode(65 + idx),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: HtmlWidget(
                      option.text,
                      textStyle: TextStyle(
                        color: textColor,
                        fontWeight: isOptionCorrect || isOptionSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (isOptionCorrect)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                  if (isOptionSelected && !isCorrect)
                    const Icon(Icons.cancel, color: Colors.red, size: 20),
                ],
              ),
            );
          }),
          if (question.explanation.text.isNotEmpty) ...[
            SizedBox(height: 0.02.toHeightPercent()),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Explanation:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  HtmlWidget(
                    question.explanation.text,
                    textStyle: TextStyle(color: Colors.blue[900]),
                  ),
                  if (question.explanation.images.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    ...question.explanation.images.map(
                      (img) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            img.startsWith('http') ? img : baseUrl + img,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox(),
                          ),
                        ),
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
  }
}
