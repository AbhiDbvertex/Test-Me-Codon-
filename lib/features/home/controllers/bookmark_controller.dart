// import 'package:codon/features/home/home_service.dart';
// import 'package:codon/features/home/models/bookmark_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../pearls/controllers/pearls_controller.dart';
// /*
// class BookmarkController extends GetxController {
//   final HomeService _homeService = Get.find<HomeService>();
//
//   var isLoadingMostImportant = false.obs;
//   var isLoadingVeryImportant = false.obs;
//   var isLoadingImportant = false.obs;
//
//   var mostImportantBookmarks = <BookmarkModel>[].obs;
//   var veryImportantBookmarks = <BookmarkModel>[].obs;
//   var importantBookmarks = <BookmarkModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllBookmarks();
//   }
//
//   void fetchAllBookmarks() {
//     fetchBookmarks(
//       category: 'mostimportant',
//       list: mostImportantBookmarks,
//       loader: isLoadingMostImportant,
//     );
//     fetchBookmarks(
//       category: 'veryimportant',
//       list: veryImportantBookmarks,
//       loader: isLoadingVeryImportant,
//     );
//     fetchBookmarks(
//       category: 'important',
//       list: importantBookmarks,
//       loader: isLoadingImportant,
//     );
//   }
//
//   Future<void> fetchBookmarks({
//     required String category,
//     required RxList<BookmarkModel> list,
//     required RxBool loader,
//   }) async {
//     try {
//       loader(true);
//       final res = await _homeService.getBookmarks(category: category);
//       if (res['success'] == true) {
//         final List<BookmarkModel> fetched = (res['data'] as List)
//             .map((e) => BookmarkModel.fromJson(e))
//             .toList();
//         list.assignAll(fetched);
//       } else {
//         // Handle error if needed
//       }
//     } catch (e) {
//       print("Error fetching $category bookmarks: $e");
//     } finally {
//       loader(false);
//     }
//   }
//
//   Future<void> toggleBookmark({
//     required String type,
//     required String itemId,
//     required String userId,
//     required String category,
//   }) async {
//     try {
//       final res = await _homeService.toggleBookmark(
//         type: type,
//         itemId: itemId,
//         userId: userId,
//         category: category,
//       );
//       if (res['success'] == true) {
//         // Handle success if needed
//         Get.snackbar(
//           'Success',
//           res['message'],
//           snackPosition: SnackPosition.TOP,
//         );
//       } else {
//         Get.snackbar('Error', res['message'], snackPosition: SnackPosition.TOP);
//       }
//     } catch (e) {
//       print("Error toggling bookmark: $e");
//     }
//   }
// }
// */
//
// class BookmarkController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   final HomeService _homeService = Get.find<HomeService>();
//   final RxMap<String, String> _bookmarkedItems = <String, String>{}.obs;
//   late TabController tabController;
//
//   var isLoading = false.obs;
//
//   var mostImportantBookmarks = <BookmarkModel>[].obs;
//   var veryImportantBookmarks = <BookmarkModel>[].obs;
//   var importantBookmarks = <BookmarkModel>[].obs;
//   var removedBookmarks = <BookmarkModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     tabController = TabController(length: 3, vsync: this);
//     fetchAllBookmarks();
//   }
//
//   // In BookmarkController
//
// // Reactive map: mcqId → category
//
//
//   bool isBookmarked(String itemId) {
//     return _bookmarkedItems.containsKey(itemId);
//   }
//
//   String getCategory(String itemId) {
//     return _bookmarkedItems[itemId] ?? '';
//   }
//
// // Update your existing toggleBookmark to also update _bookmarkedItems:
// //   Future<void> toggleBookmark({
// //     required String type,
// //     required String itemId,
// //     required String category,
// //   }) async
// //   {
// //     if (_bookmarkedItems[itemId] == category) {
// //       // Remove bookmark
// //       print("sdcfzsdf${category}");
// //       _bookmarkedItems.remove(itemId);
// //       // your existing API call to remove...
// //
// //     } else {
// //       // Add/update bookmark
// //       _bookmarkedItems[itemId] = category;
// //       // your existing API call to add...
// //       print("hello${category}");
// //     }
// //   }
//
//   Future<void> fetchAllBookmarks() async {
//     try {
//       isLoading(true);
//       // Service call bina category ke (Single API call)
//       final res = await _homeService.getBookmarks();
//
//       if (res['success'] == true) {
//         final List<BookmarkModel> allData = (res['data'] as List)
//             .map((e) => BookmarkModel.fromJson(e))
//             .toList();
//
//         // Local Filtering logic
//         mostImportantBookmarks.assignAll(
//           allData.where((e) => e.category == 'mostimportant').toList(),
//         );
//         veryImportantBookmarks.assignAll(
//           allData.where((e) => e.category == 'veryimportant').toList(),
//         );
//         importantBookmarks.assignAll(
//           allData.where((e) => e.category == 'important').toList(),
//         );
//         removedBookmarks.assignAll(
//           allData.where((e) => e.category == 'removed').toList(),
//         );
//
//       }
//     } catch (e) {
//       print("Error fetching bookmarks: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> toggleBookmark({
//     required String type,
//     required String itemId,
//     // required String userId,
//     required String category,
//   }) async {
//     try {
//       final res = await _homeService.toggleBookmark(
//         type: type,
//         itemId: itemId,
//         // userId: userId,
//         category: category,
//       );
//       if (res['success'] == true) {
//         // Handle success if needed
//         final pearlsController = Get.find<PearlsController>();
//
//         var chapter = pearlsController.chaptersList.firstWhereOrNull(
//           (e) => e.id == itemId,
//         );
//         if (chapter != null) {
//           chapter.isBookMarked.value = true;
//           chapter.bookMarkedCategory.value = category;
//         }
//         Get.snackbar(
//           'Success',
//           res['message'],
//           snackPosition: SnackPosition.TOP,
//         );
//       } else {
//         String errorMessage = res['message'] ?? "Something went wrong";
//
//         if (errorMessage.contains("E11000") ||
//             errorMessage.contains("duplicate key")) {
//           errorMessage = "This item is already in your bookmarks!";
//         }
//
//         Get.snackbar('Alert', errorMessage, snackPosition: SnackPosition.TOP);
//       }
//     } catch (e) {
//       print("Error toggling bookmark: $e");
//       Get.snackbar('Error', 'Failed to update bookmark. Please try again.');
//     }
//   }
//
// }

import 'package:codon/features/home/home_service.dart';
import 'package:codon/features/home/models/bookmark_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pearls/controllers/pearls_controller.dart';


class BookmarkController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final HomeService _homeService = Get.find<HomeService>();
  final RxMap<String, String> _bookmarkedItems = <String, String>{}.obs;
  late TabController tabController;

  var isLoading = false.obs;

  final RxMap<String, String> bookmarkedMcqs = <String, String>{}.obs;

  var mostImportantBookmarks = <BookmarkModel>[].obs;
  var veryImportantBookmarks = <BookmarkModel>[].obs;
  var importantBookmarks = <BookmarkModel>[].obs;
  var removedBookmarks = <BookmarkModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    fetchAllBookmarks();
  }

  // In BookmarkController

// Reactive map: mcqId → category


  bool isBookmarked(String itemId) {
    return _bookmarkedItems.containsKey(itemId);
  }

  String getCategory(String itemId) {
    return _bookmarkedItems[itemId] ?? '';
  }

  /*Future<void> fetchAllBookmarks() async {
    try {
      isLoading(true);
      // Service call bina category ke (Single API call)
      final res = await _homeService.getBookmarks();

      if (res['success'] == true) {
        final List<BookmarkModel> allData = (res['data'] as List)
            .map((e) => BookmarkModel.fromJson(e))
            .toList();

        // Local Filtering logic
        mostImportantBookmarks.assignAll(
          allData.where((e) => e.category == 'mostimportant').toList(),
        );
        veryImportantBookmarks.assignAll(
          allData.where((e) => e.category == 'veryimportant').toList(),
        );
        importantBookmarks.assignAll(
          allData.where((e) => e.category == 'important').toList(),
        );
        removedBookmarks.assignAll(
          allData.where((e) => e.category == 'removed').toList(),
        );

      }
    } catch (e) {
      print("Error fetching bookmarks: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleBookmark({
    required String type,
    required String itemId,
    // required String userId,
    required String category,
  }) async {
    try {
      final res = await _homeService.toggleBookmark(
        type: type,
        itemId: itemId,
        // userId: userId,
        category: category,
      );
      if (res['success'] == true) {
        // Handle success if needed
        final pearlsController = Get.find<PearlsController>();

        var chapter = pearlsController.chaptersList.firstWhereOrNull(
              (e) => e.id == itemId,
        );
        if (chapter != null) {
          chapter.isBookMarked.value = true;
          chapter.bookMarkedCategory.value = category;
        }
        Get.snackbar(
          'Success',
          res['message'],
          snackPosition: SnackPosition.TOP,
        );
      } else {
        String errorMessage = res['message'] ?? "Something went wrong";

        if (errorMessage.contains("E11000") ||
            errorMessage.contains("duplicate key")) {
          errorMessage = "This item is already in your bookmarks!";
        }

        Get.snackbar('Alert', errorMessage, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print("Error toggling bookmark: $e");
      Get.snackbar('Error', 'Failed to update bookmark. Please try again.');
    }
  }
*/

  Future<void> fetchAllBookmarks() async {
    try {
      isLoading(true);
      final res = await _homeService.getBookmarks();

      if (res['success'] == true) {
        final List<BookmarkModel> allData = (res['data'] as List)
            .map((e) => BookmarkModel.fromJson(e))
            .toList();

        // ────────────────────────────────────────────────────────
        // Sabse important: local reactive map ko bhar do
        _bookmarkedItems.clear();
        for (var bm in allData) {
          if (bm.category != 'removed' && bm.category.isNotEmpty) {
            _bookmarkedItems[bm.id ?? bm.id ?? ''] = bm.category;
          }
        }
        // ────────────────────────────────────────────────────────

        // ab list bhi update kar sakte ho (optional lekin achha practice)
        mostImportantBookmarks.assignAll(
          allData.where((e) => e.category == 'mostimportant').toList(),
        );
        veryImportantBookmarks.assignAll(
          allData.where((e) => e.category == 'veryimportant').toList(),
        );
        importantBookmarks.assignAll(
          allData.where((e) => e.category == 'important').toList(),
        );
        removedBookmarks.assignAll(
          allData.where((e) => e.category == 'removed').toList(),
        );
      }
    } catch (e) {
      print("Error fetching bookmarks: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleBookmark({
    required String type,
    required String itemId,
    required String category,
  }) async {
    try {
      Map<String, dynamic> res;

      if (category == 'removed' || category.isEmpty) {
        // ── Remove flow: call the separate remove API ──
        res = await _homeService.removeBookmark(
          type: type,
          itemId: itemId,
        );
      } else {
        // ── Add/update flow: call toggle API ──
        res = await _homeService.toggleBookmark(
          type: type,
          itemId: itemId,
          category: category,
        );
      }

      if (res['success'] == true) {
        // Update local reactive map
        if (category == 'removed' || category.isEmpty) {
          _bookmarkedItems.remove(itemId);
        } else {
          _bookmarkedItems[itemId] = category;
        }
        _bookmarkedItems.refresh();

        // Update pearls controller
        final pearlsController = Get.find<PearlsController>();
        var chapter = pearlsController.chaptersList
            .firstWhereOrNull((e) => e.id == itemId);
        if (chapter != null) {
          chapter.isBookMarked.value =
              category != 'removed' && category.isNotEmpty;
          chapter.bookMarkedCategory.value = category;
        }

        Get.snackbar('Success', res['message'],
            snackPosition: SnackPosition.TOP);
      } else {
        String errorMessage = res['message'] ?? "Something went wrong";
        if (errorMessage.contains("E11000") ||
            errorMessage.contains("duplicate key")) {
          errorMessage = "This item is already in your bookmarks!";
        }
        Get.snackbar('Alert', errorMessage,
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print("Error toggling/removing bookmark: $e");
      Get.snackbar('Error', 'Failed to update bookmark. Please try again.');
    }
  }

  // Future<void> toggleBookmark({
  //   required String type,
  //   required String itemId,
  //   required String category,
  // }) async {
  //   try {
  //     final res = await _homeService.toggleBookmark(
  //       type: type,
  //       itemId: itemId,
  //       category: category,
  //     );
  //
  //     if (res['success'] == true) {
  //       // ────────────────────────────────────────────────
  //       // Local state ko turant update karo
  //       if (category == 'removed' || category == '') {
  //
  //         _bookmarkedItems.remove(itemId);
  //       } else {
  //         _bookmarkedItems[itemId] = category;
  //       }
  //       // ────────────────────────────────────────────────
  //
  //       // UI ko force refresh (zaruri nahi lekin safe hai)
  //       _bookmarkedItems.refresh();
  //
  //       // pearls controller update (tumhara existing code)
  //       final pearlsController = Get.find<PearlsController>();
  //       var chapter = pearlsController.chaptersList.firstWhereOrNull(
  //             (e) => e.id == itemId,
  //       );
  //       if (chapter != null) {
  //         chapter.isBookMarked.value = category != 'removed' && category.isNotEmpty;
  //         chapter.bookMarkedCategory.value = category;
  //       }
  //
  //       Get.snackbar('Success', res['message'], snackPosition: SnackPosition.TOP);
  //
  //       // Optional: fresh list fetch kar sakte ho agar backend se aur changes aaye
  //       // fetchAllBookmarks();   // ← yeh line bhi daal sakte ho agar zarurat pade
  //     } else {
  //       // error handling same
  //     }
  //   } catch (e) {
  //     print("Error toggling bookmark: $e");
  //     Get.snackbar('Error', 'Failed to update bookmark.');
  //   }
  // }



}
