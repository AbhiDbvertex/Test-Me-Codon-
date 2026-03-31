import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/base_api_client.dart';
import 'package:get/get.dart';

class SubscriptionService {
  final BaseApiClient _api = Get.find<BaseApiClient>();

  Future<Map<String, dynamic>> getPlans() async {
    return _api.call(url: getPlansUrl, method: 'GET');
  }

  Future<Map<String, dynamic>> createOrder({
    required String planId,
    required String userId,
    required String? promocode,
    required String? selectedMonths,
  }) async {
    return _api.call(
      url: createOrderUrl,
      method: 'POST',
      body: {'planId': planId, 'userId': userId , 'promoCode': promocode,'selectedMonths': selectedMonths},
    );
  }

  Future<Map<String, dynamic>> verifyPayment(Map<String, dynamic> data) async {
    return _api.call(url: verifyPaymentUrl, method: 'POST', body: data);
  }
}
