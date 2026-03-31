import 'package:codon/features/test/controllers/tests_controller.dart';
import 'package:codon/features/test/domain/models/test_model.dart';
import 'package:codon/features/test/screens/test_mcq_screen.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestsListScreen extends StatefulWidget {
  const TestsListScreen({super.key});

  @override
  State<TestsListScreen> createState() => _TestsListScreenState();
}

class _TestsListScreenState extends State<TestsListScreen> {
  final TestsController controller = Get.find<TestsController>();
  @override
  Widget build(BuildContext context) {
    final String currentYear = DateTime.now().year.toString();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEFEDED),
        appBar: AppBar(
          title: Text(
            'Test Series',
            style: TextStyle(
              fontSize: 0.05.toWidthPercent(),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Obx(() {
          if (controller.isTestCourseLoading.value ||
              controller.isExamTestsLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (controller.groupedTestsByYear.isEmpty &&
              controller.examTests.isEmpty) {
            return const Center(child: Text("No Tests Available"));
          }
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 0.04.toWidthPercent()),
            children: [
              SizedBox(height: 0.02.toHeightPercent()),
              if (controller.examTests.isNotEmpty) ...[
                // Padding(
                //   padding: EdgeInsets.only(
                //     top: 0.02.toHeightPercent(),
                //     left: 0.02.toWidthPercent(),
                //   ),
                //   child: Text(
                //     "Exams",
                //     style: TextStyle(
                //       fontSize: 0.06.toWidthPercent(),
                //       fontWeight: FontWeight.w900,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
                ...controller.examTests
                    .map((test) => _buildExamTestCard(test))
                    .toList(),
              ],
              ...controller.groupedTestsByYear.keys.map((year) {
                Map<String, List<TestModel>> monthGroups =
                    controller.groupedTestsByYear[year]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (year != currentYear) _buildYearHeader(year),
                    ...monthGroups.keys.map((month) {
                      List<TestModel> tests = monthGroups[month]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMonthHeader(month),
                          ...tests.map((test) => _buildTestCard(test)).toList(),
                        ],
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
              SizedBox(height: 0.02.toHeightPercent()),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildMonthHeader(String month) {
    return Padding(
      padding: EdgeInsets.only(
        top: 0.02.toHeightPercent(),
        left: 0.06.toWidthPercent(),
        bottom: 0.01.toHeightPercent(),
      ),
      child: Row(
        children: [
          Text(
            month,
            style: TextStyle(
              fontSize: 0.04.toWidthPercent(),
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(width: 0.04.toWidthPercent()),
          Expanded(child: Divider(color: Colors.grey[300], thickness: 1.5)),
        ],
      ),
    );
  }

  Widget _buildTestCard(TestModel test) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.01.toHeightPercent()),
      padding: EdgeInsets.all(0.04.toWidthPercent()),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${test.category} - ${test.testTitle}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 0.045.toWidthPercent(),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 0.005.toHeightPercent()),
                Text(
                  "${test.mcqLimit} MCQs",
                  style: TextStyle(
                    fontSize: 0.035.toWidthPercent(),
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Obx(() {
          //   final bool isLoading = controller.startLoadingId.value == test.id;
          //   return ElevatedButton(
          //     onPressed: isLoading
          //         ? null
          //         : () => controller.startTest(
          //             testId: test.id,
          //             testTitle: test.testTitle,
          //           ),
          //
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: AppColors.primary,
          //       foregroundColor: Colors.white,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(22),
          //       ),
          //       elevation: 0,
          //       padding: EdgeInsets.symmetric(
          //         horizontal: 0.08.toWidthPercent(),
          //         vertical: 0.01.toHeightPercent(),
          //       ),
          //     ),
          //     child: isLoading
          //         ? const SizedBox(
          //             height: 20,
          //             width: 20,
          //             child: CircularProgressIndicator(
          //               color: Colors.white,
          //               strokeWidth: 2,
          //             ),
          //           )
          //         : const Text(
          //             'Start',
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white,
          //             ),
          //           ),
          //   );
          // }),
        ],
      ),
    );
  }

  Widget _buildExamTestCard(ExamTestModel test) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.01.toHeightPercent()),
      padding: EdgeInsets.all(0.04.toWidthPercent()),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  test.testTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 0.045.toWidthPercent(),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 0.005.toHeightPercent()),
                Text(
                  "${test.totalMcqCount} MCQs",
                  style: TextStyle(
                    fontSize: 0.035.toWidthPercent(),
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            final bool isLoading =
                controller.startLoadingId.value == test.testId;
            return ElevatedButton(
              onPressed: isLoading || test.totalMcqCount == 0
                  ? null
                  : () => controller.startExamTest(
                      testId: test.testId,
                      testTitle: test.testTitle,
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 0.08.toWidthPercent(),
                  vertical: 0.01.toHeightPercent(),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Start',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildYearHeader(String year) {
    return Padding(
      padding: EdgeInsets.only(
        top: 0.03.toHeightPercent(),
        left: 0.02.toWidthPercent(),
        bottom: 0.01.toHeightPercent(),
      ),
      child: Text(
        year,
        style: TextStyle(
          fontSize: 0.07.toWidthPercent(),
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }
}
