import 'package:codon/utills/api_urls.dart';
import 'package:get/get.dart';

import '../../../utills/base_api_client.dart';

abstract class RatingService {
  Future<Map<String, dynamic>> rateUs({
    required int rating,
    required String review,
    required String targetId,
    required String targetType,
  });
}

class RatingServiceImpl implements RatingService {
  final BaseApiClient _api = Get.find<BaseApiClient>();

  @override
  Future<Map<String, dynamic>> rateUs({
    required int rating,
    required String review,
    required String targetId,
    required String targetType,
  }) async {
    final response = await _api.call(
      url: ratingUrl,
      method: 'POST',
      body: {
        "rating": rating,
        "review": review,
        "targetId": targetId,
        "targetType": targetType,
      },
    );
    if (response['success'] == true && response['data'] != null) {
      return response;
    }
    return response;
  }
}
