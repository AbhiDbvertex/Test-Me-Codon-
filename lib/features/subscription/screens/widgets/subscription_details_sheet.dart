// import 'dart:convert';
//
// import 'package:codon/features/subscription/Models/plan_model.dart';
// import 'package:codon/features/subscription/controllers/subscription_controller.dart';
// import 'package:codon/utills/app_theme.dart';
// import 'package:codon/utills/screen_size_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../../utills/api_urls.dart';
// import '../../../../utills/prefs_service.dart';
//
// class SubscriptionDetailsSheet extends StatefulWidget {
//   final PlanModel plan;
//   final SubscriptionController controller;
//
//   const SubscriptionDetailsSheet({
//     super.key,
//     required this.plan,
//     required this.controller,
//   });
//
//   @override
//   State<SubscriptionDetailsSheet> createState() => _SubscriptionDetailsSheetState();
// }
//
// class _SubscriptionDetailsSheetState extends State<SubscriptionDetailsSheet> {
//
//   // SubscriptionDetailsSheet ke build ke andar ya initState mein
//   @override
//   void initState() {
//     super.initState();
//
//     // Pehli baar default pricing set kar do
//     if (widget.plan.pricing.isNotEmpty) {
//       widget.controller.selectedPricing.value = widget.plan.pricing.first;
//       widget.controller.currentPriceAfterDiscount.value = widget.plan.pricing.first.price;
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(25),
//         ),
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: 0.05.toWidthPercent(),
//         vertical: 0.03.toHeightPercent(),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               width: 50,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           SizedBox(height: 0.03.toHeightPercent()),
//           Text(
//             'Plan Details',
//             style: TextStyle(
//               fontSize: 0.05.toWidthPercent(),
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: 0.02.toHeightPercent()),
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Color(0xFFF3F6F8),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 0.5.toWidthPercent(),
//                       child: Text(
//                         widget.plan.name,
//                         style: TextStyle(
//                           fontSize: 0.045.toWidthPercent(),
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       'Access to all premium features',
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//                 // Obx(() {
//                 //   final pricing = widget.plan.pricing.isNotEmpty
//                 //       ? widget.plan.pricing.first
//                 //       : null;
//                 //   final originalPrice = 'INR ${pricing?.price ?? 0}';
//                 //   final price = widget.controller.isPromoApplied.value
//                 //       ? widget.controller.discountedPrice.value!
//                 //       : originalPrice;
//                 //   return Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.end,
//                 //     children: [
//                 //       if (widget.controller.isPromoApplied.value)
//                 //         Text(
//                 //           originalPrice,
//                 //           style: TextStyle(
//                 //             fontSize: 12,
//                 //             color: Colors.grey,
//                 //             decoration: TextDecoration.lineThrough,
//                 //           ),
//                 //         ),
//                 //       Text(
//                 //         price,
//                 //         style: TextStyle(
//                 //           fontSize: 0.045.toWidthPercent(),
//                 //           fontWeight: FontWeight.bold,
//                 //           color: AppColors.success,
//                 //         ),
//                 //       ),
//                 //       Text(
//                 //         pricing?.planLabel ?? '',
//                 //         style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                 //       ),
//                 //     ],
//                 //   );
//                 // }),
//                 Obx(() {
//                   final pricing = widget.controller.selectedPricing.value;   // ← yeh use karo
//
//                   if (pricing == null) return SizedBox();
//
//                   final originalPrice = 'INR ${pricing.price.toStringAsFixed(0)}';
//                   final displayPrice = widget.controller.isPromoApplied.value
//                       ? widget.controller.discountedPrice.value ?? originalPrice
//                       : originalPrice;
//
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       if (widget.controller.isPromoApplied.value)
//                         Text(
//                           originalPrice,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                       Text(
//                         displayPrice,
//                         style: TextStyle(
//                           fontSize: 0.045.toWidthPercent(),
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.success,
//                         ),
//                       ),
//                       Text(
//                         pricing.planLabel ?? '',
//                         style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                       ),
//                     ],
//                   );
//                 }),
//               ],
//             ),
//           ),
//           SizedBox(height: 0.03.toHeightPercent()),
//           Text(
//             'Have a Promo Code?',
//             style: TextStyle(
//               fontSize: 0.04.toWidthPercent(),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 10),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: widget.controller.promoCodeController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Code (e.g. CODON50)',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.grey[300]!),
//                     ),
//                     contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Obx(
//                 () => ElevatedButton(
//                   onPressed: widget.controller.isPromoApplied.value
//                       ? null
//                       : () {
//                           final pricing = widget.plan.pricing.isNotEmpty
//                               ? widget.plan.pricing.first
//                               : null;
//                           widget.controller.applyPromoCode(widget.plan.id,
//                             '${pricing?.price ?? 0}',
//                           );
//                          // widget.controller.applayPromoCode(widget.controller.promoCodeController,widget.plan.id,widget.pricing?.price,);
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 12,
//                     ),
//                   ),
//                   child: const Text(
//                     'Apply',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 0.04.toHeightPercent()),
//           Obx(
//             () => SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: widget.controller.isLoading.value
//                     ? null
//                     : () => widget.controller.proceedToPay(widget.plan),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: widget.controller.isLoading.value
//                     ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: Colors.black,
//                         ),
//                       )
//                     : Text(
//                         'Proceed to Pay',
//                         style: TextStyle(
//                           fontSize: 0.045.toWidthPercent(),
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//               ),
//             ),
//           ),
//           SizedBox(height: 0.02.toHeightPercent()),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:codon/features/subscription/Models/plan_model.dart';
import 'package:codon/features/subscription/controllers/subscription_controller.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SubscriptionDetailsSheet extends StatefulWidget {
  final PlanModel plan;
  final SubscriptionController controller;

  const SubscriptionDetailsSheet({
    super.key,
    required this.plan,
    required this.controller,
  });

  @override
  State<SubscriptionDetailsSheet> createState() =>
      _SubscriptionDetailsSheetState();
}

class _SubscriptionDetailsSheetState extends State<SubscriptionDetailsSheet> {
  // SubscriptionDetailsSheet ke build ke andar ya initState mein
  @override
  void initState() {
    super.initState();

    // Pehli baar default pricing set kar do
    if (widget.plan.pricing.isNotEmpty) {
      widget.controller.selectedPricing.value = widget.plan.pricing.first;
      widget.controller.currentPriceAfterDiscount.value =
          widget.plan.pricing.first.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 0.05.toWidthPercent(),
        vertical: 0.03.toHeightPercent(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 0.03.toHeightPercent()),
          Text(
            'Plan Details',
            style: TextStyle(
              fontSize: 0.05.toWidthPercent(),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 0.02.toHeightPercent()),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF3F6F8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 0.5.toWidthPercent(),
                      child: Text(
                        widget.plan.name,
                        style: TextStyle(
                          fontSize: 0.045.toWidthPercent(),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Access to all premium features',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                // Obx(() {
                //   final pricing = widget.plan.pricing.isNotEmpty
                //       ? widget.plan.pricing.first
                //       : null;
                //   final originalPrice = 'INR ${pricing?.price ?? 0}';
                //   final price = widget.controller.isPromoApplied.value
                //       ? widget.controller.discountedPrice.value!
                //       : originalPrice;
                //   return Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       if (widget.controller.isPromoApplied.value)
                //         Text(
                //           originalPrice,
                //           style: TextStyle(
                //             fontSize: 12,
                //             color: Colors.grey,
                //             decoration: TextDecoration.lineThrough,
                //           ),
                //         ),
                //       Text(
                //         price,
                //         style: TextStyle(
                //           fontSize: 0.045.toWidthPercent(),
                //           fontWeight: FontWeight.bold,
                //           color: AppColors.success,
                //         ),
                //       ),
                //       Text(
                //         pricing?.planLabel ?? '',
                //         style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                //       ),
                //     ],
                //   );
                // }),
                Obx(() {
                  final pricing =
                      widget.controller.selectedPricing.value; // ← yeh use karo

                  if (pricing == null) return SizedBox();

                  final originalPrice =
                      'INR ${pricing.price.toStringAsFixed(0)}';
                  final displayPrice = widget.controller.isPromoApplied.value
                      ? widget.controller.discountedPrice.value ?? originalPrice
                      : originalPrice;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (widget.controller.isPromoApplied.value)
                        Text(
                          originalPrice,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Text(
                        displayPrice,
                        style: TextStyle(
                          fontSize: 0.045.toWidthPercent(),
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                        ),
                      ),
                      Text(
                        pricing.planLabel ?? '',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 0.03.toHeightPercent()),
          Text(
            'Have a Promo Code?',
            style: TextStyle(
              fontSize: 0.04.toWidthPercent(),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller.promoCodeController,
                  decoration: InputDecoration(
                    hintText: 'Enter Code (e.g. CODON50)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Obx(
                () => ElevatedButton(
                  onPressed: widget.controller.isPromoApplied.value
                      ? null
                      : () {
                          final pricing = widget.plan.pricing.isNotEmpty
                              ? widget.plan.pricing.first
                              : null;
                          widget.controller.applyPromoCode(
                            planId: widget.plan.id,
                            originalPrice: pricing?.price ?? 0.0,
                            selectedMonths: pricing?.months ?? 0,
                          );
                          // widget.controller.applayPromoCode(widget.controller.promoCodeController,widget.plan.id,widget.pricing?.price,);
                        },
                  // onPressed: widget.controller.isPromoApplied.value
                  //     ? null
                  //     : () {
                  //   final pricing = widget.controller.selectedPricing.value;
                  //   if (pricing == null) return;
                  //
                  //   widget.controller.applyPromoCode(
                  //     planId: widget.plan.id,
                  //     originalPrice: pricing.price,           // current (maybe already discounted)
                  //     selectedMonths: pricing.months,         // ← yeh important change
                  //   );
                  // },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 0.04.toHeightPercent()),
          // flutter is a ui tool kit by google used to build cross platform application
          // Obx(
          //
          //       () => SizedBox(
          //     width: double.infinity,
          //     child: ElevatedButton(
          //    final pricing = widget.controller.selectedPricing.value;
          //       onPressed: widget.controller.isLoading.value
          //           ? null
          //           : () => widget.controller.proceedToPay(widget.plan ,pricing.months,),
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: AppColors.primary,
          //         padding: const EdgeInsets.symmetric(vertical: 16),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(15),
          //         ),
          //       ),
          //       child: widget.controller.isLoading.value
          //           ? const SizedBox(
          //         height: 20,
          //         width: 20,
          //         child: CircularProgressIndicator(
          //           strokeWidth: 2,
          //           color: Colors.black,
          //         ),
          //       )
          //           : Text(
          //         'Proceed to Pay',
          //         style: TextStyle(
          //           fontSize: 0.045.toWidthPercent(),
          //           fontWeight: FontWeight.bold,
          //           color: Colors.black,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Obx(() {
            final pricing = widget.controller.selectedPricing.value;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.controller.isLoading.value
                    ? null
                    : () => widget.controller.proceedToPay(
                        widget.plan,
                        pricing?.months,
                      ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                  child: widget.controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      )
                    : Text(
                        'Proceed to Pay',
                        style: TextStyle(
                          fontSize: 0.045.toWidthPercent(),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
              ),
            );
          }),
          SizedBox(height: 0.02.toHeightPercent()),
        ],
      ),
    );
  }
}
