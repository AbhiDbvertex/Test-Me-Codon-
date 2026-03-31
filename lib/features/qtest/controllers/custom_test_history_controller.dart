import 'package:codon/features/qtest/models/custom_test_history_model.dart';
import 'package:codon/features/qtest/models/custom_test_model.dart';
import 'package:codon/features/qtest/screens/custom_test_mcq_screen.dart';
import 'package:codon/features/qtest/services/qtest_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTestHistoryController extends GetxController {
  final QTestService _qTestService = Get.find<QTestService>();

  var isLoading = false.obs;
  var isFetchingDetail = false.obs;
  var historyItems = <CustomTestHistoryItem>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final res = await _qTestService.getCustomTestHistory();
      if (res['success'] == true) {
        final historyResponse = CustomTestHistoryResponse.fromJson(res);
        historyItems.assignAll(historyResponse.data);
      } else {
        errorMessage.value = res['message'] ?? 'Failed to fetch history';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resumeTest(String id) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final res = await _qTestService.getCustomTestDetails(id);
      Get.back(); // Close loading dialog

      if (res['success'] == true) {
        final customTest = CustomTestModel.fromHistoryJson(res);
        Get.to(() => CustomTestMcqScreen(customTest: customTest));
      } else {
        Get.snackbar('Error', res['message'] ?? 'Failed to fetch test details');
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'An error occurred while starting the test');
    }
  }
}
