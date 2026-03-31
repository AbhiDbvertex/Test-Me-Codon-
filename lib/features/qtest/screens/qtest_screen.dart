import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/qtest/controllers/qtest_controller.dart';
import 'package:codon/features/qtest/screens/custom_module_screen.dart';
import 'package:codon/features/qtest/screens/custom_test_history_screen.dart';
import 'package:codon/features/qtest/screens/qtest_sub_subject_screen.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QTestScreen extends StatelessWidget {
  final savebookmark;
  const QTestScreen({super.key, this.savebookmark});

  @override
  Widget build(BuildContext context) {
    final QTestController controller = Get.find<QTestController>();
    print("Abhi savebookmark : ${savebookmark}");
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text(
          'Q Bank',
          style: TextStyle(
            fontSize: 0.05.toWidthPercent(),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //     onPressed: () => Get.to(() => const CustomTestHistoryScreen()),
        //     icon: const Icon(Icons.history, color: Colors.black),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          SizedBox(height: 0.02.toHeightPercent()),
          _buildCustomModuleHeader(),
          SizedBox(height: 0.02.toHeightPercent()),
          Expanded(
            child: FutureBuilder(
              future: Get.find<PearlsController>().getSubjects(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final subjects = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.04.toWidthPercent(),
                    ),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      return _buildSubjectTile(subject);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomModuleHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04.toWidthPercent()),
      child: ElevatedButton(
        onPressed: () => Get.to(() => const CustomModuleScreen()),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 0.06.toHeightPercent()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              addCircleIcon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            SizedBox(width: 0.03.toWidthPercent()),
            Text(
              'Custom Module MCQs',
              style: TextStyle(
                fontSize: 0.045.toWidthPercent(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectTile(subject) {
    return GestureDetector(
      onTap: () => Get.to(() => QTestSubSubjectScreen(subject: subject,savebookmark: savebookmark,)),
      child: Container(
        margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
        padding: EdgeInsets.symmetric(
          horizontal: 0.05.toWidthPercent(),
          vertical: 0.025.toHeightPercent(),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
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
            Container(
              width: 0.7.toWidthPercent(),
              child: Text(
                subject.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 0.05.toWidthPercent(),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.arrow_forward, color: Color(0xFFE0E0E0)),
                SizedBox(height: 0.005.toHeightPercent()),
                Text(
                  "",
                  //subject.modulesCount,
                  style: TextStyle(
                    fontSize: 0.035.toWidthPercent(),
                    color: Colors.black45,
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