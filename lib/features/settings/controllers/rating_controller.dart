import 'package:codon/features/settings/services/rating_service.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  final RatingService _ratingService = Get.find<RatingService>();

  final rating = 0.obs;
  final reviewController = TextEditingController();

  void setRating(int value) {
    rating.value = value;
  }

  Future<void> submitRating(String targetId, String targetType) async {
    if (rating.value == 0) {
      Get.snackbar(
        'Error',
        'Please select a rating',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    final result = await _ratingService.rateUs(
      rating: rating.value,
      review: reviewController.text,
      targetId: targetId,
      targetType: targetType,
    );
    if (result['success'] == true) {
      Get.back();
      Get.snackbar(
        'Thank You!',
        'Your rating has been submitted successfully.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.black,
      );
    } else {
      Get.snackbar(
        'Oops!',
        result['message'],
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.black,
      );
    }
  }

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }
}
