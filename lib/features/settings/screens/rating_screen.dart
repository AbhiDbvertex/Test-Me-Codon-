import 'package:codon/features/settings/controllers/rating_controller.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RatingController controller = Get.find<RatingController>();
    final args = Get.arguments;
    final String targetId = args['targetId'] ?? '';
    final String targetType = args['targetType'] ?? '';
    print(" targetId: $targetId, targetType: $targetType");

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const DefaultAppBar(title: 'Give Us Rating'),
        body: Column(
          children: [
            SizedBox(height: 0.02.toHeightPercent()),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 0.04.toHeightPercent()),
                    Image.asset(rateUsImage),
                    SizedBox(height: 0.04.toHeightPercent()),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 0.06.toWidthPercent(),
                      ),
                      padding: EdgeInsets.all(0.06.toWidthPercent()),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
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
                            'Share your experience\nwith us',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 0.06.toWidthPercent(),
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                              fontFamily: 'Serif',
                            ),
                          ),
                          SizedBox(height: 0.03.toHeightPercent()),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () => controller.setRating(index + 1),
                                  child: Icon(
                                    Icons.star,
                                    size: 0.12.toWidthPercent(),
                                    color: index < controller.rating.value
                                        ? AppColors.primary
                                        : Colors.grey[300],
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: 0.03.toHeightPercent()),
                          TextField(
                            controller: controller.reviewController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Enter review  about your experience',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 0.035.toWidthPercent(),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.grey[200]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.grey[100]!,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 0.04.toHeightPercent()),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => controller.submitRating(
                                    targetId,
                                    targetType,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 0.015.toHeightPercent(),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'Rate',
                                    style: TextStyle(
                                      fontSize: 0.045.toWidthPercent(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 0.04.toWidthPercent()),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Get.back(),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    side: const BorderSide(
                                      color: AppColors.primary,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 0.015.toHeightPercent(),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 0.045.toWidthPercent(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.04.toHeightPercent()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
