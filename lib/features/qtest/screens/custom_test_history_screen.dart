import 'package:codon/features/qtest/controllers/custom_test_history_controller.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomTestHistoryScreen extends StatelessWidget {
  const CustomTestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTestHistoryController controller = Get.put(
      CustomTestHistoryController(),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: const DefaultAppBar(title: 'Custom Test History'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } //
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                ElevatedButton(
                  onPressed: controller.fetchHistory,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.historyItems.isEmpty) {
          return const Center(child: Text('No history found'));
        }

        return ListView.builder(
          padding: EdgeInsets.all(0.04.toWidthPercent()),
          itemCount: controller.historyItems.length,
          itemBuilder: (context, index) {
            final item = controller.historyItems[index];
            return _buildHistoryCard(item);
          },
        );
      }),
    );
  }

  Widget _buildHistoryCard(item) {
    final date = DateTime.parse(item.createdAt).toLocal();
    final formattedDate = DateFormat('MMM dd, yyyy - hh:mm a').format(date);
    final result = item.result;

    return GestureDetector(
      onTap: () => Get.find<CustomTestHistoryController>().resumeTest(item.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.mode.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 0.035.toWidthPercent(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: item.status == 'completed'
                        ? Colors.green[50]
                        : Colors.orange[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // child: Text(
                  //   item.status.isNotEmpty
                  //       ? item.status[0].toUpperCase() +
                  //             item.status.substring(1)
                  //       : '',
                  //   style: TextStyle(
                  //     color: item.status == 'completed'
                  //         ? Colors.green[700]
                  //         : Colors.orange[700],
                  //     fontSize: 0.03.toWidthPercent(),
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ),
              ],
            ),
            SizedBox(height: 0.01.toHeightPercent()),
            Text(
              formattedDate,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 0.035.toWidthPercent(),
              ),
            ),
            if (result != null) ...[
              SizedBox(height: 0.02.toHeightPercent()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem(
                    'Score',
                    '${result.scorePercentage.toStringAsFixed(1)}%',
                  ),
                  _buildStatItem('Questions', '${result.totalQuestions}'),
                  _buildStatItem(
                    'Correct',
                    '${result.correct}',
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 0.03.toWidthPercent(),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black87,
            fontSize: 0.04.toWidthPercent(),
          ),
        ),
      ],
    );
  }
}
