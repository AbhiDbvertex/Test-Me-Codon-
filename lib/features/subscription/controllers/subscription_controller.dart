// import 'dart:convert';
// import 'package:codon/features/subscription/Models/plan_model.dart';
// import 'package:codon/features/subscription/services/subscription_service.dart';
// import 'package:codon/features/auth/controllers/user_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import '../../../utills/api_urls.dart';
// import '../../../utills/prefs_service.dart';
//
// class SubscriptionController extends GetxController {
//   final SubscriptionService _subscriptionService =
//   Get.find<SubscriptionService>();
//   final UserController _userController = Get.find<UserController>();
//
//   late Razorpay _razorpay;
//
//   final selectedPlanIndex = 0.obs;
//   final isLoading = false.obs;
//   final plans = <PlanModel>[].obs;
//
//   final promoCodeController = TextEditingController();
//   final discountedPrice = RxnString();
//   final isPromoApplied = false.obs;
//
// // Naya add karo (sabse important)
//   final selectedPricing = Rxn<Pricing>();
//   final selectedMonth = Rxn<Pricing>();       // ← yeh current active pricing object hai
//   final selectedPlanId = Rxn<PlanModel>();       // ← yeh current active pricing object hai
//
// // Optional: real discounted amount number mein rakhne ke liye (double)
//   final currentPriceAfterDiscount = 0.0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     fetchPlans();
//   }
//
//   Future<void> fetchPlans() async {
//     try {
//       isLoading.value = true;
//       final response = await _subscriptionService.getPlans();
//       if (response['status'] == true) {
//         final List data = response['data'] ?? [];
//         plans.assignAll(data.map((json) => PlanModel.fromJson(json)).toList());
//       } else {
//         Get.snackbar('Error', response['message'] ?? 'Failed to fetch plans');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while fetching plans');
//       debugPrint('Error fetching plans: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   @override
//   void onClose() {
//     _razorpay.clear();
//     promoCodeController.dispose();
//     super.onClose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     debugPrint("Payment Success: ${response.paymentId}");
//     verifyPayment(response);
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     debugPrint("Payment Error: ${response.code} - ${response.message}");
//     Get.snackbar(
//       'Payment Failed',
//       response.message ?? 'Unknown error occurred',
//       backgroundColor: Colors.red,
//       colorText: Colors.white,
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     debugPrint("External Wallet: ${response.walletName}");
//   }
//
//   Future<void> verifyPayment(PaymentSuccessResponse response) async {
//     try {
//       isLoading.value = true;
//       final verifyResponse = await _subscriptionService.verifyPayment({
//         'razorpay_payment_id': response.paymentId,
//         'razorpay_order_id': response.orderId,
//         'razorpay_signature': response.signature,
//       });
//
//       if (verifyResponse['success'] == true) {
//         Get.snackbar(
//           'Success',
//           'Subscription activated successfully!',
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//         // Refresh profile to reflect active subscription
//         await _userController.refreshUserProfile();
//         // Optionally navigate to home or refresh profile
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar(
//           'Verification Failed',
//           verifyResponse['message'] ?? 'Failed to verify payment',
//           backgroundColor: Colors.orange,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       debugPrint("Error verifying payment: $e");
//       Get.snackbar('Error', 'An error occurred during verification');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // void selectPlan(int index) {
//   //   selectedPlanIndex.value = index;
//   // }
//
//   void selectPlan(int index) {
//     selectedPlanIndex.value = index;
//     final plan = plans[index];
//
//     if (plan.pricing.isNotEmpty) {
//       selectedPricing.value = plan.pricing.first;   // ya user ne koi dropdown se choose kiya to usko
//       currentPriceAfterDiscount.value = plan.pricing.first.price;
//       resetPromoCode(); // har baar naya plan → promo reset
//     }
//   }
//
//   // Future<void> applyPromoCode( String planId, originalPrice) async {
//   //   // if (promoCode) {
//   //   //   Get.snackbar('Error', 'Promo code daalo bhai');
//   //   //   return;
//   //   // }
//   //
//   //   isLoading.value = true;
//   //
//   //   print("Abhi:- planId: ${planId}, originalPrice: ${originalPrice}");
//   //
//   //   try {
//   //     // Tumhara API endpoint yahan daalna (jo bhi real hai)
//   //     final response = await http.post(
//   //       // final url = Uri.parse(promoCode);
//   //       Uri.parse(promoCode),     // ← yeh sahi endpoint daal dena
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Authorization': 'Bearer ${await PrefsService.getAccessToken()}',
//   //       },
//   //       body: jsonEncode({
//   //         "promoCode": promoCodeController.text.trim(),
//   //         "planId": planId,
//   //         "selectedMonths": 1,   // ya jo bhi user ne select kiya ho
//   //       }),
//   //     );
//   //
//   //     print("Abhi:- applay promocode : ${response.statusCode}");
//   //     print("Abhi:- applay promocode body: ${response.body}");
//   //
//   //     var responseData = jsonDecode(response.body);
//   //     if (response.statusCode == 200 || response.statusCode == 201) {
//   //       final data = jsonDecode(response.body);
//   //
//   //       if (data['success'] == true) {
//   //         // Backend se discounted price milna chahiye
//   //         double newPrice = (data['data']['discountedPrice'] ?? data['data']['price'])?.toDouble() ?? originalPrice;
//   //
//   //         // Important → update current pricing
//   //         if (selectedPricing.value != null) {
//   //           // Pricing object ko copy karke price change kar rahe
//   //           final updatedPricing = Pricing(
//   //             durationType: selectedPricing.value!.durationType,
//   //             months: selectedPricing.value!.months,
//   //             extraMonths: selectedPricing.value!.extraMonths,
//   //             totalMonths: selectedPricing.value!.totalMonths,
//   //             days: selectedPricing.value!.days,
//   //             price: newPrice,                    // ← yahan change
//   //             perDay: newPrice / selectedPricing.value!.days,
//   //             planLabel: selectedPricing.value!.planLabel,
//   //             discountLabel: data['data']['discountLabel'] ?? selectedPricing.value!.discountLabel,
//   //           );
//   //
//   //           selectedPricing.value = updatedPricing;
//   //           currentPriceAfterDiscount.value = newPrice;
//   //
//   //           // UI ke liye string bhi update
//   //           discountedPrice.value = 'INR ${newPrice.toStringAsFixed(0)}';
//   //           isPromoApplied.value = true;
//   //
//   //           Get.snackbar('Success', 'Promo code lag gaya! 🎉');
//   //         }
//   //       } else {
//   //         Get.snackbar('Failed', data['message'] ?? 'Invalid promo code');
//   //       }
//   //     } else {
//   //       Get.snackbar('Error', responseData['message']);
//   //     }
//   //   } catch (e) {
//   //     print("Promo apply error: $e");
//   //     Get.snackbar('Error', 'Something went wrong..?');
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }
//
//   Future<void> applyPromoCode({
//     required String planId,
//     required double originalPrice,          // ← double maango
//    required int selectedMonths,        // default 1, baad mein dynamic kar sakte ho
//   }) async {
//     if (promoCodeController.text.trim().isEmpty) {
//       Get.snackbar('Error', 'Please enter promo code');
//       return;
//     }
//
//     print("Abhi:- print planId: $planId, originalPrice:$originalPrice, selectedmonth: $selectedMonths}");
//
//     isLoading.value = true;
//
//     try {
//       final response = await http.post(
//         Uri.parse(promoCode),   // ← tumhara real endpoint daalo (abhi 'promoCode' variable galat tha)
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${await PrefsService.getAccessToken()}',
//         },
//         body: jsonEncode({
//           "promoCode": promoCodeController.text.trim(),
//           "planId": planId,
//           "selectedMonths": selectedMonths,   // ← yeh dynamic bhej rahe ho
//         }),
//       );
//
//       print("Promo apply status: ${response.statusCode}");
//       print("Promo apply body: ${response.body}");
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//
//         if (data['success'] == true) {
//           final promoData = data['data'];
//
//           // Important: String ko double mein convert karo
//           final double finalAmount = (promoData['finalAmount'] as num?)?.toDouble() ?? originalPrice;
//           final double discountAmount = (promoData['discountAmount'] as num?)?.toDouble() ?? 0;
//
//           // Pricing object update karo
//           if (selectedPricing.value != null) {
//             final old = selectedPricing.value!;
//
//             selectedPricing.value = Pricing(
//               durationType: old.durationType,
//               months: old.months,
//               extraMonths: old.extraMonths,
//               totalMonths: old.totalMonths,
//               days: old.days,
//               price: finalAmount,                      // ← yeh sabse zaroori
//               perDay: old.days > 0 ? finalAmount / old.days : 0,
//               planLabel: old.planLabel,
//               discountLabel: promoData['discountLabel'] ?? old.discountLabel ?? "Save ₹${discountAmount.toStringAsFixed(0)}",
//             );
//
//             currentPriceAfterDiscount.value = finalAmount;
//             discountedPrice.value = 'INR ${finalAmount.toStringAsFixed(0)}';
//             isPromoApplied.value = true;
//
//             Get.snackbar('Success', 'Promo applied! You save ₹${discountAmount.toStringAsFixed(0)} 🎉');
//           }
//         } else {
//           Get.snackbar('Failed', data['message'] ?? 'Invalid promo code');
//           resetPromoCode();
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to apply promo code');
//       }
//     } catch (e) {
//       print("Promo apply error: $e");
//       Get.snackbar('Error', 'Something went wrong');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void resetPromoCode() {
//     promoCodeController.clear();
//     isPromoApplied.value = false;
//     discountedPrice.value = null;
//   }
//
//
//   // void proceedToPay(PlanModel plan) async {
//   //   print("create payment → start");
//   //
//   //   if (plan.pricing.isEmpty) {
//   //     Get.snackbar('Error', 'No pricing available');
//   //     return;
//   //   }
//   //
//   //   // ────────────────────────────────────────────────
//   //   // Yahaan se final amount decide kar rahe hain
//   //   // ────────────────────────────────────────────────
//   //   final selectedPricing = this.selectedPricing.value ?? plan.pricing.first;
//   //
//   //   // Agar promo apply hua → discounted price use karo
//   //   final finalAmount = isPromoApplied.value
//   //       ? (currentPriceAfterDiscount.value > 0
//   //       ? currentPriceAfterDiscount.value
//   //       : selectedPricing.price)
//   //       : selectedPricing.price;
//   //
//   //   // Razorpay ke liye paise paise mein (×100)
//   //   final amountInPaise = (finalAmount * 100).round();
//   //
//   //   print("Final amount sending to Razorpay: ₹$finalAmount (₹${amountInPaise / 100})");
//   //
//   //   try {
//   //     isLoading.value = true;
//   //
//   //     // ────────────────────────────────────────────────
//   //     // Backend ko amount bhej rahe hain (sabse safe tareeka)
//   //     // ────────────────────────────────────────────────
//   //     final orderResponse = await _subscriptionService.createOrder(
//   //       planId: plan.id,
//   //       userId: _userController.userModel.value?.id ?? '',
//   //       // amount: amountInPaise,               // ← YEH NAYA PARAMETER
//   //       // agar chahiye to yeh bhi bhej sakte ho
//   //       // promoCode: isPromoApplied.value ? promoCodeController.text.trim() : null,
//   //     );
//   //
//   //     print("Backend order response: $orderResponse");
//   //
//   //     if (orderResponse['success'] == true) {
//   //       final backendAmount = orderResponse['amount'] ?? 0;
//   //
//   //       // Safety check – backend ne jo amount diya, usse match karna chahiye
//   //       if ((backendAmount / 100).abs() - finalAmount > 1) {
//   //         print("Warning: Amount mismatch! Frontend: $finalAmount | Backend: ${backendAmount / 100}");
//   //         // yahan chahiye to user ko bol sakte ho ya fallback kar sakte ho
//   //       }
//   //
//   //       var options = {
//   //         'key': 'rzp_test_SJTKjbIuvQ1Z5X',  // ya live key
//   //         'amount': backendAmount,           // ← backend se aaya amount use karo (sabse safe)
//   //         'name': 'Codon',
//   //         'order_id': orderResponse['orderId'],
//   //         'description': "Payment for Subscription",
//   //         'timeout': 300,
//   //         'prefill': {
//   //           'contact': _userController.userModel.value?.mobile ?? '',
//   //           'email': _userController.userModel.value?.email ?? '',
//   //         },
//   //         // optional but recommended
//   //         'theme': {
//   //           'color': '#your_brand_color',  // example: '#5E35B1'
//   //         },
//   //       };
//   //
//   //       _razorpay.open(options);
//   //     } else {
//   //       Get.snackbar(
//   //         'Error',
//   //         orderResponse['message'] ?? 'Failed to create order',
//   //         backgroundColor: Colors.red,
//   //         colorText: Colors.white,
//   //       );
//   //     }
//   //   } catch (e, stack) {
//   //     debugPrint("Error in proceedToPay: $e\n$stack");
//   //     Get.snackbar(
//   //       'Error',
//   //       'Payment initiate nahi ho paya',
//   //       backgroundColor: Colors.red,
//   //       colorText: Colors.white,
//   //     );
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }
//
//   /*void proceedToPay(PlanModel plan) async {
//     if (plan.pricing.isEmpty) {
//       Get.snackbar('Error', 'No pricing available');
//       return;
//     }
//
//     final selected = this.selectedPricing.value ?? plan.pricing.first;
//
//     // Final amount decide karo (promo laga to discounted, nahi to original)
//     final double finalAmount = isPromoApplied.value
//         ? currentPriceAfterDiscount.value
//         : selected.price;
//
//     final int amountInPaise = (finalAmount * 100).round();
//
//     try {
//       isLoading.value = true;
//
//       final orderResponse = await _subscriptionService.createOrder(
//         planId: plan.id,
//         userId: _userController.userModel.value?.id ?? '',
//         // amount: amountInPaise,           // ← optional — agar backend amount expect karta hai to bhejo
//         // promoCode: isPromoApplied.value ? promoCodeController.text.trim() : null,
//       );
//
//       if (orderResponse['success'] != true) {
//         Get.snackbar('Error', orderResponse['message'] ?? 'Failed to create order');
//         return;
//       }
//
//       final backendAmount = orderResponse['amount'] as int? ?? amountInPaise;
//
//       // Optional safety check
//       if ((backendAmount / 100 - finalAmount).abs() > 1) {
//         print("Amount mismatch warning → Frontend: $finalAmount | Backend: ${backendAmount/100}");
//       }
//
//       var options = {
//         'key': 'rzp_test_SJTKjbIuvQ1Z5X',
//         'amount': backendAmount,              // ← backend ka amount prefer karo (sabse safe)
//         'order_id': orderResponse['orderId'],
//         'name': 'Codon',
//         'description': 'Subscription - ${plan.name}',
//         'prefill': {
//           'contact': _userController.userModel.value?.mobile ?? '',
//           'email': _userController.userModel.value?.email ?? '',
//         },
//         'theme': {'color': '#5E35B1'},
//       };
//
//       _razorpay.open(options);
//     } catch (e) {
//       print("proceedToPay error: $e");
//       Get.snackbar('Error', 'Payment initiation failed');
//     } finally {
//       isLoading.value = false;
//     }
//   }*/
//
//   void proceedToPay(PlanModel plan) async {
//     if (plan.pricing.isEmpty || selectedPricing.value == null) {
//       Get.snackbar('Error', 'No pricing selected');
//       return;
//     }
//
//     final selected = selectedPricing.value!;
//
//     // Final amount jo user ko dikh raha hai (promo laga ya nahi)
//     final double finalAmount = isPromoApplied.value
//         ? currentPriceAfterDiscount.value
//         : selected.price;
//
//     if (finalAmount <= 0) {
//       Get.snackbar('Error', 'Invalid amount');
//       return;
//     }
//
//     final int amountInPaise = (finalAmount * 100).round();
//
//     print("→ Proceeding with amount: ₹$finalAmount (${amountInPaise} paise)");
//
//     try {
//       isLoading.value = true;
//
//       // ─── Most important change ───────────────────────────────
//       // final orderResponse = await _subscriptionService.createOrder(
//       //   planId: plan.id,
//       //   userId: _userController.userModel.value?.id ?? '',
//       //   // amount: amountInPaise,                      // ← yeh bhejo!
//       //   promocode: isPromoApplied.value
//       //       ? promoCodeController.text.trim()
//       //       : null,                                 // optional but helpful for backend
//       //   // selectedMonths: selected.months,            // extra safety
//       // );
//       final orderResponse = await _subscriptionService.createOrder(
//         planId: plan.id,
//         userId: _userController.userModel.value!.id,
//         promocode: isPromoApplied.value
//             ? promoCodeController.text.trim()
//             : null,
//       );
//       // ─────────────────────────────────────────────────────────
//
//       if (orderResponse['success'] != true) {
//         Get.snackbar('Error', orderResponse['message'] ?? 'Failed to create order');
//         return;
//       }
//
//       final int backendAmount = orderResponse['amount'] as int? ?? 0;
//
//
//       // Safety check – agar backend ne different amount diya to warning
//       if (backendAmount != amountInPaise) {
//         print("⚠️ Amount mismatch! Frontend wanted: $amountInPaise paise, Backend gave: $backendAmount");
//         // Tum decide kar sakte ho:
//         // - user ko error dikhao
//         // - ya backend ke amount ko trust karo (lekin risky)
//         // Best: backend ko fix karo ki frontend ka amount use kare
//       }
//
//       var options = {
//         'key': 'rzp_test_SJTKjbIuvQ1Z5X',   // ← test key hai, production mein change karna
//         'amount': backendAmount,            // backend se aaya (ideally same hona chahiye)
//         'order_id': orderResponse['orderId'],
//         'name': 'Codon',
//         'description': 'Subscription - ${plan.name} (${selected.planLabel})',
//         'prefill': {
//           'contact': _userController.userModel.value?.mobile ?? '',
//           'email': _userController.userModel.value?.email ?? '',
//         },
//         'theme': {'color': '#5E35B1'},
//       };
//
//       _razorpay.open(options);
//     } catch (e, stack) {
//       print("proceedToPay error: $e\n$stack");
//       Get.snackbar('Error', 'Payment could not be initiated');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:convert';
import 'package:codon/features/subscription/Models/plan_model.dart';
import 'package:codon/features/subscription/services/subscription_service.dart';
import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../utills/api_urls.dart';
import '../../../utills/prefs_service.dart';

class SubscriptionController extends GetxController {
  final SubscriptionService _subscriptionService =
  Get.find<SubscriptionService>();
  final UserController _userController = Get.find<UserController>();

  late Razorpay _razorpay;

  final selectedPlanIndex = 0.obs;
  final isLoading = false.obs;
  final plans = <PlanModel>[].obs;

  final promoCodeController = TextEditingController();
  final discountedPrice = RxnString();
  final isPromoApplied = false.obs;

// Naya add karo (sabse important)
  final selectedPricing = Rxn<Pricing>();
  final selectedMonth = Rxn<Pricing>();       // ← yeh current active pricing object hai
  final selectedPlanId = Rxn<PlanModel>();       // ← yeh current active pricing object hai

// Optional: real discounted amount number mein rakhne ke liye (double)
  final currentPriceAfterDiscount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    try {
      isLoading.value = true;
      final response = await _subscriptionService.getPlans();
      if (response['status'] == true) {
        final List data = response['data'] ?? [];
        plans.assignAll(data.map((json) => PlanModel.fromJson(json)).toList());
      } else {
        Get.snackbar('Error', response['message'] ?? 'Failed to fetch plans');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching plans');
      debugPrint('Error fetching plans: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _razorpay.clear();
    promoCodeController.dispose();
    super.onClose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("Payment Success: ${response.paymentId}");
    verifyPayment(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("Payment Error: ${response.code} - ${response.message}");
    Get.snackbar(
      'Payment Failed',
      response.message ?? 'Unknown error occurred',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("External Wallet: ${response.walletName}");
  }

  Future<void> verifyPayment(PaymentSuccessResponse response) async {
    try {
      isLoading.value = true;
      final verifyResponse = await _subscriptionService.verifyPayment({
        'razorpay_payment_id': response.paymentId,
        'razorpay_order_id': response.orderId,
        'razorpay_signature': response.signature,
      });

      if (verifyResponse['success'] == true) {
        Get.snackbar(
          'Success',
          'Subscription activated successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Refresh profile to reflect active subscription
        await _userController.refreshUserProfile();
        // Optionally navigate to home or refresh profile
        Get.offAllNamed('/home');
      } else {
        Get.snackbar(
          'Verification Failed',
          verifyResponse['message'] ?? 'Failed to verify payment',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error verifying payment: $e");
      Get.snackbar('Error', 'An error occurred during verification');
    } finally {
      isLoading.value = false;
    }
  }

  // void selectPlan(int index) {
  //   selectedPlanIndex.value = index;
  // }

  void selectPlan(int index) {
    selectedPlanIndex.value = index;
    final plan = plans[index];

    if (plan.pricing.isNotEmpty) {
      selectedPricing.value = plan.pricing.first;   // ya user ne koi dropdown se choose kiya to usko
      currentPriceAfterDiscount.value = plan.pricing.first.price;
      resetPromoCode(); // har baar naya plan → promo reset
    }
  }

  Future<void> applyPromoCode({
    required String planId,
    required double originalPrice,          // ← double maango
    required int selectedMonths,        // default 1, baad mein dynamic kar sakte ho
  }) async {
    if (promoCodeController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter promo code');
      return;
    }

    print("Abhi:- print planId: $planId, originalPrice:$originalPrice, selectedmonth: $selectedMonths}");

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(promoCode),   // ← tumhara real endpoint daalo (abhi 'promoCode' variable galat tha)
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await PrefsService.getAccessToken()}',
        },
        body: jsonEncode({
          "promoCode": promoCodeController.text.trim(),
          "planId": planId,
          "selectedMonths": selectedMonths,   // ← yeh dynamic bhej rahe ho
        }),
      );

      print("Promo apply status: ${response.statusCode}");
      print("Promo apply body: ${response.body}");

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final promoData = data['data'];

          // Important: String ko double mein convert karo
          final double finalAmount = (promoData['finalAmount'] as num?)?.toDouble() ?? originalPrice;
          final double discountAmount = (promoData['discountAmount'] as num?)?.toDouble() ?? 0;

          // Pricing object update karo
          if (selectedPricing.value != null) {
            final old = selectedPricing.value!;

            selectedPricing.value = Pricing(
              durationType: old.durationType,
              months: old.months,
              extraMonths: old.extraMonths,
              totalMonths: old.totalMonths,
              days: old.days,
              price: finalAmount,                      // ← yeh sabse zaroori
              perDay: old.days > 0 ? finalAmount / old.days : 0,
              planLabel: old.planLabel,
              discountLabel: promoData['discountLabel'] ?? old.discountLabel ?? "Save ₹${discountAmount.toStringAsFixed(0)}",
            );
            //json is format for sharing data server to app
            currentPriceAfterDiscount.value = finalAmount;
            discountedPrice.value = 'INR ${finalAmount.toStringAsFixed(0)}';
            isPromoApplied.value = true;

            Get.snackbar('Success', 'Promo applied! You save ₹${discountAmount.toStringAsFixed(0)}');
          }
        } else {
          Get.snackbar('Failed', data['message'] ?? 'Invalid promo code');
          resetPromoCode();
        }
      } else {
        Get.snackbar('Message', responseData['message']);
      }
    } catch (e) {
      print("Promo apply error: $e");
      // Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  void resetPromoCode() {
    promoCodeController.clear();
    isPromoApplied.value = false;
    discountedPrice.value = null;
  }

  // void proceedToPay(PlanModel plan , selectedMonth) async {
  //   if (plan.pricing.isEmpty || selectedPricing.value == null) {
  //     Get.snackbar('Error', 'No pricing selected');
  //     return;
  //   }
  //
  //   final selected = selectedPricing.value!;
  //
  //   // Final amount jo user ko dikh raha hai (promo laga ya nahi)
  //   final double finalAmount = isPromoApplied.value
  //       ? currentPriceAfterDiscount.value
  //       : selected.price;
  //
  //   if (finalAmount <= 0) {
  //     Get.snackbar('Error', 'Invalid amount');
  //     return;
  //     // 80000000 / 200
  //     // 600000 / 365
  //     //1643.835616
  //
  //   }
  //
  //   final int amountInPaise = (finalAmount * 100).round();
  //
  //   print("→ Proceeding with amount: ₹$finalAmount (${amountInPaise} paise)");
  //
  //   try {
  //     isLoading.value = true;
  //
  //     // ─── Most important change ───────────────────────────────
  //     // final orderResponse = await _subscriptionService.createOrder(
  //     //   planId: plan.id,
  //     //   userId: _userController.userModel.value?.id ?? '',
  //     //   // amount: amountInPaise,                      // ← yeh bhejo!
  //     //   promocode: isPromoApplied.value
  //     //       ? promoCodeController.text.trim()
  //     //       : null,                                 // optional but helpful for backend
  //     //   selectedMonths: selected.months,            // extra safety
  //     // );
  //     final orderResponse = await _subscriptionService.createOrder(
  //       planId: plan.id,
  //       userId: _userController.userModel.value!.id,
  //       promocode: isPromoApplied.value
  //           ? promoCodeController.text.trim()
  //           : null,
  //       selectedMonths: selected.months.toString()
  //     );
  //
  //     // ─────────────────────────────────────────────────────────
  //
  //     if (orderResponse['success'] != true) {
  //       Get.snackbar('Error a', orderResponse['message'] ?? 'Failed to create order');
  //       return;
  //     }
  //
  //     final int backendAmount = orderResponse['amount'] as int? ?? 0;
  //
  //     // Safety check – agar backend ne different amount diya to warning
  //     if (backendAmount != amountInPaise) {
  //       print("Amount mismatch! Frontend wanted: $amountInPaise paise, Backend gave: $backendAmount");
  //       // Tum decide kar sakte ho:
  //       // - user ko error dikhao
  //       // - ya backend ke amount ko trust karo (lekin risky)
  //       // Best: backend ko fix karo ki frontend ka amount use kare
  //     }
  //
  //
  //
  //     var options = {
  //       'key': 'rzp_test_SJTKjbIuvQ1Z5X',   // ← test key hai, production mein change karna
  //       'amount': backendAmount,            // backend se aaya (ideally same hona chahiye)
  //       'order_id': orderResponse['orderId'],
  //       'name': 'Codon',
  //       'description': 'Subscription Plan}',
  //       'prefill': {
  //         'contact': _userController.userModel.value?.mobile ?? '',
  //         'email': _userController.userModel.value?.email ?? '',
  //       },
  //       'theme': {'color': '#5E35B1'},
  //     };
  //
  //     _razorpay.open(options);
  //   } catch (e, stack) {
  //     print("proceedToPay error: $e\n$stack");
  //     Get.snackbar('Error', 'Payment could not be initiated');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void proceedToPay(PlanModel plan, selectedMonth) async {
    if (plan.pricing.isEmpty || selectedPricing.value == null) {
      Get.snackbar('Error', 'No pricing selected');
      return;
    }

    final selected = selectedPricing.value!;

    final double finalAmount = isPromoApplied.value
        ? currentPriceAfterDiscount.value
        : selected.price;

    print("→ Final Amount: ₹$finalAmount");

    try {
      isLoading.value = true;

      final orderResponse = await _subscriptionService.createOrder(
        planId: plan.id,
        userId: _userController.userModel.value!.id,
        promocode: isPromoApplied.value
            ? promoCodeController.text.trim()
            : null,
        selectedMonths: selected.months.toString(),
      );

      if (orderResponse['success'] != true) {
        Get.snackbar('Error', orderResponse['message'] ?? 'Failed to create order');
        return;
      }

      final int backendAmount = orderResponse['amount'] as int? ?? 0;

      // 🔥 ===== FREE PLAN FLOW =====
      // if (backendAmount == 0 || finalAmount <= 0) {
      //   print("→ Free plan detected, skipping Razorpay");
      //
      //   final fakeResponse = PaymentSuccessResponse(
      //     "FREE_${DateTime.now().millisecondsSinceEpoch}", // paymentId
      //     orderResponse['orderId'],                        // orderId
      //     "FREE_SIGNATURE",                                // signature
      //     null,                                            // 🔥 extra param (add this)
      //   );
      //
      //   _handlePaymentSuccess(fakeResponse);
      //   return;
      // }
      if (backendAmount == 0 || finalAmount <= 0) {
        print("→ 100% discount, order created, skipping Razorpay & verify");

        Get.snackbar(
          'Success',
          'Subscription activated successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await _userController.refreshUserProfile();
        Get.offAllNamed('/home');
        return;
      }
      final int amountInPaise = (finalAmount * 100).round();

      if (backendAmount != amountInPaise) {
        print(
            "Amount mismatch! Frontend: $amountInPaise, Backend: $backendAmount");
      }

      var options = {
        'key': 'rzp_test_SJTKjbIuvQ1Z5X',
        'amount': backendAmount,
        'order_id': orderResponse['orderId'],
        'name': 'Codon',
        'description': 'Subscription Plan',
        'prefill': {
          'contact': _userController.userModel.value?.mobile ?? '',
          'email': _userController.userModel.value?.email ?? '',
        },
        'theme': {'color': '#5E35B1'},
      };

      print("→ Opening Razorpay with ₹${backendAmount / 100}");

      _razorpay.open(options);
    } catch (e, stack) {
      print("proceedToPay error: $e\n$stack");
      Get.snackbar('Error', 'Payment could not be initiated');
    } finally {
      isLoading.value = false;
    }
  }
}