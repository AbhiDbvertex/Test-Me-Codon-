import 'package:codon/features/home/screens/home_screen.dart';
import 'package:codon/features/subscription/controllers/subscription_controller.dart';
import 'package:codon/features/subscription/screens/widgets/subscription_details_sheet.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/constants.dart' as AppConstants;
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: const Text('Subscription'),
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => Get.offAll(() => HomeScreen()),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.06.toWidthPercent(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Get Premium',
                      style: TextStyle(
                        fontSize: 0.07.toWidthPercent(),
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 0.02.toHeightPercent()),

                    // Text(
                    //   'Unlock all the power of this mobile tool and\nenjoy digital experience like never before!',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 0.035.toWidthPercent(),
                    //     color: Colors.grey[600],
                    //     height: 1.5,
                    //   ),
                    // ),
                    // SizedBox(height: 0.04.toHeightPercent()),

                    // // Gift/Premium Illustration
                    // Container(
                    //   height: 0.2.toHeightPercent(),
                    //   child: Image.asset(
                    //     AppConstants.subscrptionPageImg,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    SizedBox(height: 0.04.toHeightPercent()),

                    // Plans List
                    Obx(() {
                      if (controller.isLoading.value) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.1.toHeightPercent(),
                            ),
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (controller.plans.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.1.toHeightPercent(),
                            ),
                            child: const Text(
                              'No subscription plans available.',
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: List.generate(controller.plans.length, (
                          index,
                        ) {
                          final plan = controller.plans[index];
                          final isSelected =
                              controller.selectedPlanIndex.value == index;
                          final pricing = plan.pricing.isNotEmpty
                              ? plan.pricing.first
                              : null;
                          final isBestValue = plan.name.toLowerCase().contains(
                            'best value',
                          );

                          return Container(
                            margin: EdgeInsets.only(
                              bottom: 0.02.toHeightPercent(),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F6F8),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                onTap: () {
                                  controller.selectPlan(index);
                                  controller.resetPromoCode();
                                  Get.bottomSheet(
                                    SubscriptionDetailsSheet(
                                      plan: plan,
                                      controller: controller,
                                    ),
                                    isScrollControlled: true,
                                  );
                                },
                                borderRadius: BorderRadius.circular(15),
                                highlightColor: AppColors.primary.withOpacity(
                                  0.1,
                                ),
                                splashColor: AppColors.primary.withOpacity(0.2),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 0.05.toWidthPercent(),
                                    vertical: 0.02.toHeightPercent(),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 0.5.toWidthPercent(),
                                            child: Text(
                                              plan.name,
                                              style: TextStyle(
                                                fontSize: 0.045
                                                    .toWidthPercent(),
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            text: TextSpan(
                                              text:
                                                  'INR ${pricing?.price ?? 0}',
                                              style: TextStyle(
                                                fontSize: 0.035
                                                    .toWidthPercent(),
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[700],
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      ' / ${pricing?.planLabel ?? ''}',
                                                  style: TextStyle(
                                                    fontSize: 0.03
                                                        .toWidthPercent(),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      if (isBestValue)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.success, // Green
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            'Best Value',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 0.03.toWidthPercent(),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    }),

                    SizedBox(height: 0.02.toHeightPercent()),

                    // Terms text
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.02.toWidthPercent(),
                      ),
                      child: Text(
                        'By placing this order, you agree to the Terms of Service and Privacy Policy. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 0.028.toWidthPercent(),
                          color: Colors.grey[500],
                          height: 1.5,
                        ),
                      ),
                    ),

                    SizedBox(height: 0.04.toHeightPercent()),

                    // Buy Now Button
                    SizedBox(
                      width: double.infinity,
                      child: /*ElevatedButton(
                        onPressed: () {
                          if (controller.plans.isEmpty) return;
                          final plan = controller
                              .plans[controller.selectedPlanIndex.value];
                          controller.resetPromoCode();
                          Get.bottomSheet(
                            SubscriptionDetailsSheet(
                              plan: plan,
                              controller: controller,
                            ),
                            isScrollControlled: true,
                          );
                        },*/
                      ElevatedButton(
                        onPressed:  controller.isPromoApplied.value
                            ? null
                            : () {
                          final selectedPricing =  controller.selectedPricing.value;
                          final selectedPlanId =  controller.selectedPlanId.value;
                          if (selectedPricing == null) return;

                           controller.applyPromoCode(
                            planId: selectedPlanId?.id ?? "",
                            originalPrice: selectedPricing.price,   // ← double bhej rahe
                            selectedMonths: selectedPricing.months, // ← dynamic months (1, 3, 6, 12 etc.)
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 0.045.toWidthPercent(),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
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
