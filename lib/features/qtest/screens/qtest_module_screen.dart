import 'package:codon/features/qtest/controllers/qtest_controller.dart';
import 'package:codon/features/qtest/models/chapter_test_model.dart';
import 'package:codon/features/qtest/screens/mcq_screen.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QTestModuleScreen extends StatefulWidget {
  final String chapterId;
  final String chapterName;
  final String? codeonpass;
  final savebookmark;

  const QTestModuleScreen({
    super.key,
    required this.chapterId,
    required this.chapterName,
     this.codeonpass,
    this.savebookmark,
  });

  @override
  State<QTestModuleScreen> createState() => _QTestModuleScreenState();
}

class _QTestModuleScreenState extends State<QTestModuleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final QTestController controller = Get.find<QTestController>();
    print("Abhi savebookmark QTestModuleScreen: ${widget.savebookmark}");
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text(
          widget.chapterName,
          style: TextStyle(
            fontSize: 0.05.toWidthPercent(),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0.01.toHeightPercent()),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(0.08.toWidthPercent()),
                bottomRight: Radius.circular(0.08.toWidthPercent()),
              ),
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 0.06.toWidthPercent(),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: AppColors.primary,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              dividerColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              //indicator: const BoxDecoration(color: Colors.white),
              indicatorColor: Colors.white,
              isScrollable: true,
              indicatorWeight: 4,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Paused'),
                Tab(text: 'Completed'),
                Tab(text: 'Not Started'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildModuleList(controller, 'All'),
          _buildModuleList(controller, 'Paused'),
          _buildModuleList(controller, 'Completed'),
          _buildModuleList(controller, 'Not Started'),
        ],
      ),
    );
  }

  Widget _buildModuleList(QTestController controller, String status) {
    return FutureBuilder<List<ChapterTestModel>>(
      future: controller.getQTests(chapterId: widget.chapterId),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (asyncSnapshot.hasError) {
          return Center(child: Text('Error: ${asyncSnapshot.error}'));
        }
        if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
          return const Center(child: Text('No tests found'));
        }

        List<ChapterTestModel> tests = asyncSnapshot.data!;

        // Filter based on status
        if (status != 'All') {
          String backendStatus = '';
          if (status == 'Paused') {
            backendStatus = 'IN_PROGRESS';
          } else if (status == 'Completed') {
            backendStatus = 'COMPLETED';
          } else if (status == 'Not Started') {
            backendStatus = 'NOT_STARTED';
          }
          tests = tests.where((t) => t.status == backendStatus).toList();
        }

        if (tests.isEmpty) {
          return const Center(child: Text('No tests found in this category'));
        }
        return ListView.builder(
          padding: EdgeInsets.all(0.04.toWidthPercent()),
          itemCount: tests.length,
          itemBuilder: (context, index) {
            final test = tests[index];
            return Container(
              margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
              padding: EdgeInsets.all(0.04.toWidthPercent()),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // App Logo Placeholder
                  Container(
                    width: 0.15.toWidthPercent(),
                    height: 0.15.toWidthPercent(),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(
                        0.01.toWidthPercent(),
                      ),
                    ),
                    child: const Icon(Icons.quiz, color: Colors.grey),
                  ),
                  SizedBox(width: 0.04.toWidthPercent()),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          test.testTitle,
                          style: TextStyle(
                            fontSize: 0.045.toWidthPercent(),
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${test.totalQuestions}/${test.mcqLimit} Questions',
                          style: TextStyle(
                            fontSize: 0.035.toWidthPercent(),
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          'Status: ${test.status.replaceAll('_', ' ')}',
                          style: TextStyle(
                            fontSize: 0.03.toWidthPercent(),
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _showStartDialog(context, test),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.05.toWidthPercent(),
                      ),
                      minimumSize: Size(0, 0.04.toHeightPercent()),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showStartDialog(BuildContext context, ChapterTestModel test) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 0.08.toHeightPercent(),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: const Icon(
                Icons.quiz_rounded,
                size: 40,
                color: Colors.white,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(0.06.toWidthPercent()),
              child: Column(
                children: [
                  Text(
                    "Are you ready for the challenge?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 0.052.toWidthPercent(),
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 0.015.toHeightPercent()),

                  Text(
                    "You are about to start:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 0.034.toWidthPercent(),
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "'${test.testTitle}'",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 0.042.toWidthPercent(),
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(thickness: 1),
                  ),

                  _detailRow(
                    Icons.format_list_numbered_rtl,
                    "Test contains ${test.mcqLimit} questions.",
                  ),
                  _detailRow(
                    Icons.lightbulb_outline,
                    "Take your time and read each question carefully.",
                  ),

                  SizedBox(height: 0.03.toHeightPercent()),

                  // Final Action Question
                  Text(
                    "Shall we proceed?",
                    style: TextStyle(
                      fontSize: 0.038.toWidthPercent(),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 0.02.toHeightPercent()),

                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "NOT YET",
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); //69a4a5179343e21ba6f4a01d
                            print("Abhi:- topicId tap mcq: ${widget.chapterId}");
                            // Get.to(() => MCQScreen(qTest: test,topicId: widget.chapterId, codonpass: widget.codeonpass,));
                            Get.to(() => MCQScreen(qTest: test, ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                          ),
                          child: const Text(
                            "YES, START",
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

  // Helper for Detail Rows
  Widget _detailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 0.032.toWidthPercent(),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
