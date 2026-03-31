import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/base_api_client.dart';

abstract class HomeService {
  Future<Map<String, dynamic>> getDailyMcq();
  Future<Map<String, dynamic>> getBookmarks();
  Future<Map<String, dynamic>> getDashboardStats();
  Future<Map<String, dynamic>> toggleBookmark({
    required String type,
    required String itemId,
    required String category,
  });
  Future<Map<String, dynamic>> countAllTopics();
  Future<Map<String, dynamic>> removeBookmark({
  required String itemId,
    required String type,
});

}

class HomeServiceImpl implements HomeService {
  final BaseApiClient _apiClient = BaseApiClient();

  @override
  Future<Map<String, dynamic>> getDailyMcq() async {
    return _apiClient.call(url: dailyMcqUrl, method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> getBookmarks() async {

    return _apiClient.call(url: listBookmarksUrl, method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> getDashboardStats() async {
    return _apiClient.call(url: dashboardStatsUrl, method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> toggleBookmark({
    required String type,
    required String itemId,
    required String category,
  }) {
    print("type: $type");
    print("item_id: $itemId");
    print("category: $category");

    return _apiClient.call(
      url: toggleBookmarkUrl,
      method: 'POST',
      body: {'type': type, 'itemId': itemId, 'category': category},
    );
  }

  @override
  Future<Map<String, dynamic>> removeBookmark({
    required String type,
    required String itemId,
  }) {
    return _apiClient.call(
      url: '$removeBookmarkUrl?type=$type&itemId=$itemId',
      method: 'DELETE',
    );
  }

  @override
  Future<Map<String, dynamic>> countAllTopics() async {
    return _apiClient.call(url: countAllTopicsUrl, method: 'GET');
  }
}
