// import 'package:codon/features/home/controllers/bookmark_controller.dart';
// import 'package:codon/features/home/models/bookmark_model.dart';
// import 'package:codon/features/pearls/models/get_topic_model.dart';
// import 'package:codon/features/pearls/screens/chapters_screen.dart';
// import 'package:codon/features/pearls/screens/codon_detail_screen.dart';
// import 'package:codon/features/pearls/screens/topics_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'mcq_bookmark_detail.dart';
//
// class BookmarkScreen extends StatelessWidget {
//   const BookmarkScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // final BookmarkController controller = Get.put(BookmarkController());
//     final controller = Get.put(BookmarkController());
//
//     // ← Yeh line add kar do
//     controller.fetchAllBookmarks();   // har baar screen khulte hi fresh data
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFEDED),
//       appBar: AppBar(
//         title: const Text('Bookmarks'),
//
//         bottom: TabBar(
//           controller: controller.tabController,
//           labelColor: const Color(0xFF4DD0E1),
//           unselectedLabelColor: Colors.black,
//           indicatorSize: TabBarIndicatorSize.tab,
//           // indicator: BoxDecoration(
//           //   borderRadius: BorderRadius.circular(30),
//           //   color: const Color(0xFF4DD0E1), // Tera cyan color
//           // ),
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           tabs: const [
//             Tab(
//               child: Text(
//                 'Most Imp',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             Tab(
//               child: Text(
//                 'Very Imp',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             Tab(
//               child: Text(
//                 'Important',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//
//             // Tab(
//             //   child: Text(
//             //     'Removed',
//             //     style: TextStyle(fontWeight: FontWeight.bold),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         return TabBarView(
//           controller: controller.tabController,
//           children: [
//             _buildFilteredList(
//               controller.mostImportantBookmarks,
//               const Color(0xFFFF6B6B),
//             ),
//             _buildFilteredList(
//               controller.veryImportantBookmarks,
//               const Color(0xFFFFB74D),
//             ),
//             _buildFilteredList(
//               controller.importantBookmarks,
//               const Color(0xFF4DD0E1),
//             ),
//             // _buildFilteredList(
//             //   controller.removedBookmarks,
//             //   Colors.grey,
//             // ),
//
//
//           ],
//         );
//       }),
//     );
//   }
//
//   // List builder helper
//   Widget _buildFilteredList(List<BookmarkModel> bookmarks, Color color) {
//     if (bookmarks.isEmpty)
//       return const Center(child: Text("No bookmarks here"));
//
//     return RefreshIndicator(
//       onRefresh: () async => Get.find<BookmarkController>().fetchAllBookmarks(),
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: bookmarks.length,
//         itemBuilder: (context, index) =>
//             _buildBookmarkCard(bookmark: bookmarks[index], accentColor: color),
//       ),
//     );
//   }
//
//   Widget _buildBookmarkCard({
//     required BookmarkModel bookmark,
//     required Color accentColor,
//   }) {
//     String displayTitle = 'No Title';
//     if (bookmark.type == 'mcq' && bookmark.mcq != null) {
//       displayTitle = bookmark.mcq!.name ?? 'No Title';
//     } else if (bookmark.type == 'chapter' && bookmark.chapter != null) {
//       displayTitle = bookmark.chapter!.name ?? 'No Title';
//     } else if (bookmark.type == 'topic' && bookmark.topic != null) {
//       displayTitle = bookmark.topic!.name ?? 'No Title';
//     } else if (bookmark.type == 'subSubject' && bookmark.subSubject != null) {
//       displayTitle = bookmark.subSubject!.name ?? 'No Title';
//     } else {
//       displayTitle = '${bookmark.type.capitalizeFirst} Bookmark';
//     }
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(15),
//           onTap: () {
//             // print("Abhi:- bookmark type: ${bookmark.type}");
//             if (bookmark.type == 'chapter' && bookmark.chapter != null) {
//               print("Abhi:- bookmark type chapter: ${bookmark.type}");
//               print("Abhi:- bookmark type chapter id: ${bookmark.id}");
//               Get.to(
//                     () => TopicsScreen(
//                   chapterId: bookmark.chapter!.id,
//                   chapter: null,
//                 ),
//               );
//             } else if (bookmark.type == 'topic' && bookmark.topic != null) {
//               print("Abhi:- bookmark type topic: ${bookmark.type}");
//               print("Abhi:- bookmark type topic id: ${bookmark.topic!.id}");
//               Get.to(
//                     () => CodonDetailScreen(
//                   topics: [
//                     GetTopicModel(
//                       id: bookmark.topic!.id,
//                       name: bookmark.topic!.name ?? displayTitle,
//                       description: '',
//                       codonId: '',
//                       isBookMarked: true.obs,
//                       bookMarkedCategory: bookmark.category.obs,
//                     ),
//                   ],
//                   initialIndex: 0,
//                 ),
//               );
//             } else if (bookmark.type == 'subSubject' &&
//                 bookmark.subSubject != null) {
//               print("Abhi:- bookmark type subSubject: ${bookmark.type}");
//               print("Abhi:- bookmark type subSubject id: ${bookmark.subSubject!.id}");
//               Get.to(
//                     () => ChaptersScreen(
//                   subSubjectId: bookmark.subSubject!.id,
//                   subSubjectName: displayTitle,
//                 ),
//               );
//             } else if (bookmark.type == 'mcq' /*&& bookmark.mcq != null*/) {
//               // Navigation for MCQ - currently showing topic details or dedicated screen if available
//               print("Abhi:- bookmark type mcq: ${bookmark.type}");
//               // Get.to(() => CodonDetailScreen(
//               //     topics: [
//               //       GetTopicModel(
//               //         id: bookmark.mcq!.id,
//               //         name: bookmark.mcq!.name ?? displayTitle,
//               //         description: '',
//               //         codonId: '',
//               //         isBookMarked: true.obs,
//               //         bookMarkedCategory: bookmark.category.obs,
//               //       ),
//               //     ],
//               //     initialIndex: 0,
//               //   ),
//               print("Abhi:- bookmark type id: ${bookmark.id}");
//               Get.to(BookmarkMCQdetailScreen(id: bookmark.mcq?.id,title: bookmark.mcq?.name, )
//
//               );
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 // Icon
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: accentColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     bookmark.type == 'mcq'
//                         ? Icons.help_outline
//                         : Icons.description,
//                     color: accentColor,
//                     size: 24,
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//
//                 // Content
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Title
//                           Expanded(
//                             child: Text(
//                               displayTitle,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black87,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//
//                           // Bookmark Icon + Popup
//                           // Obx(() {
//                           //   final bookmarkCtrl = Get.find<BookmarkController>();
//                           //
//                           //   String _getCorrectItemId(BookmarkModel bookmark) {
//                           //     switch (bookmark.type.toLowerCase()) {
//                           //       case 'mcq':
//                           //         return bookmark.mcq?.id ?? bookmark.id ?? '';
//                           //       case 'topic':
//                           //         return bookmark.topic?.id ?? bookmark.id ?? '';
//                           //       case 'chapter':
//                           //         return bookmark.chapter?.id ?? bookmark.id ?? '';
//                           //       case 'subsubject':
//                           //         return bookmark.subSubject?.id ?? bookmark.id ?? '';
//                           //       default:
//                           //         return bookmark.id ?? '';
//                           //     }
//                           //   }
//                           //
//                           //   // ← Yeh line sabse important: sahi ID nikaal rahe hain
//                           //   final String itemId = _getCorrectItemId(bookmark);
//                           //
//                           //   final bool isBookmarked = bookmarkCtrl.isBookmarked(itemId);
//                           //   final String? currentCategory = bookmarkCtrl.getCategory(itemId);
//                           //
//                           //   Color iconColor = Colors.grey.withOpacity(0.6);
//                           //
//                           //   if (isBookmarked) {
//                           //     switch (currentCategory) {
//                           //       case 'mostimportant':
//                           //         iconColor = Colors.red;
//                           //         break;
//                           //       case 'veryimportant':
//                           //         iconColor = Colors.orange;
//                           //         break;
//                           //       case 'important':
//                           //         iconColor = const Color(0xFF4DD0E1);
//                           //         break;
//                           //     }
//                           //   }
//                           //
//                           //   return PopupMenuButton<String>(
//                           //     icon: Icon(
//                           //       isBookmarked ? Icons.bookmark : Icons.bookmark_border,
//                           //       color: iconColor,
//                           //       size: 28, // ya 0.06.toWidthPercent() agar extension use kar rahe ho
//                           //     ),
//                           //     onSelected: (selectedCategory) async {
//                           //       // ← yahan toggle + refresh
//                           //       await bookmarkCtrl.toggleBookmark(
//                           //         type: bookmark.type,
//                           //         itemId: itemId,
//                           //         category: selectedCategory,
//                           //       );
//                           //
//                           //       // Important: yeh line screen ko turant update karegi
//                           //       bookmarkCtrl.fetchAllBookmarks();
//                           //     },
//                           //     itemBuilder: (context) => [
//                           //       _buildPopupItem('mostimportant', 'Most Important', Colors.red),
//                           //       _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
//                           //       _buildPopupItem('important', 'Important', const Color(0xFF4DD0E1)),
//                           //       const PopupMenuDivider(),
//                           //       _buildPopupItem('remove', 'Remove Bookmark', Colors.grey),
//                           //     ],
//                           //   );
//                           // }),
//
//                           Obx(() {
//                             final bookmarkCtrl = Get.find<BookmarkController>();
//
//                             String _getCorrectItemId(BookmarkModel bookmark) {
//                               switch (bookmark.type.toLowerCase()) {
//                                 case 'mcq':
//                                   return bookmark.mcq?.id ?? bookmark.id ?? '';
//                                 case 'topic':
//                                   return bookmark.topic?.id ?? bookmark.id ?? '';
//                                 case 'chapter':
//                                   return bookmark.chapter?.id ?? bookmark.id ?? '';
//                                 case 'subsubject':
//                                   return bookmark.subSubject?.id ?? bookmark.id ?? '';
//                                 default:
//                                   return bookmark.id ?? '';
//                               }
//                             }
//
//                             final String itemId = _getCorrectItemId(bookmark);
//
//                             final bool isBookmarked = bookmarkCtrl.isBookmarked(itemId);
//                             final String? currentCategory = bookmarkCtrl.getCategory(itemId);
//
//                             // ← Debug line (baad mein hata dena)
//                             print("Bookmark icon → ID: $itemId | Bookmarked: $isBookmarked | Category: '$currentCategory'");
//
//                             Color iconColor = Colors.grey.withOpacity(0.7);
//
//                             if (isBookmarked && currentCategory != null) {
//                               final cat = currentCategory.toLowerCase().trim();
//                               if (cat.contains('mostimportant') || cat.contains('most imp')) {
//                                 iconColor = Colors.red.shade700;
//                               } else if (cat.contains('veryimportant') || cat.contains('very imp')) {
//                                 iconColor = Colors.orange.shade700;
//                               } else if (cat.contains('important')) {
//                                 iconColor = const Color(0xFF4DD0E1);
//                               }
//                             }
//
//                             return PopupMenuButton<String>(
//                               icon: Icon(
//                                 isBookmarked ? Icons.bookmark : Icons.bookmark_border,
//                                 color: iconColor,
//                                 size: 28,
//                               ),
//                               onSelected: (selectedCategory) async {
//                                 await bookmarkCtrl.toggleBookmark(
//                                   type: bookmark.type,
//                                   itemId: itemId,
//                                   category: selectedCategory,
//                                 );
//                                 bookmarkCtrl.fetchAllBookmarks();
//                               },
//                               itemBuilder: (context) => [
//                                 // _buildPopupItem('mostimportant', 'Most Important', Colors.red),
//                                 // _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
//                                 // _buildPopupItem('important', 'Important', const Color(0xFF4DD0E1)),
//                                 const PopupMenuDivider(),
//                                 _buildPopupItem('remove', 'Remove Bookmark', Colors.grey),
//                               ],
//                             );
//                           }),
//                         ],
//                       ),
//
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 3,
//                             ),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF4DD0E1).withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Text(
//                               bookmark.type.toUpperCase(),
//                               style: const TextStyle(
//                                 fontSize: 11,
//                                 color: Color(0xFF4DD0E1),
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Icon(
//                             Icons.access_time,
//                             size: 12,
//                             color: Colors.grey[400],
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             _formatDate(bookmark.createdAt),
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[500],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Arrow
//                 Icon(Icons.chevron_right, color: Colors.grey[300], size: 24),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   PopupMenuItem<String> _buildPopupItem(String val, String text, Color color) {
//     return PopupMenuItem(
//       value: val,
//       child: Row(
//         children: [
//           Icon(Icons.bookmark, color: color, size: 20),
//           const SizedBox(width: 10),
//           Text(text),
//         ],
//       ),
//     );
//   }
//
//   String _formatDate(String dateStr) {
//     try {
//       final DateTime dt = DateTime.parse(dateStr).toLocal();
//       final now = DateTime.now();
//       final difference = now.difference(dt);
//
//       if (difference.inDays == 0) return 'Today';
//       if (difference.inDays == 1) return 'Yesterday';
//       if (difference.inDays < 7) return '${difference.inDays} days ago';
//       if (difference.inDays < 30) {
//         final weeks = (difference.inDays / 7).floor();
//         return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
//       }
//
//       return "${dt.day}/${dt.month}/${dt.year}";
//     } catch (_) {
//       return 'Recently';
//     }
//   }
// }

import 'package:codon/features/home/controllers/bookmark_controller.dart';
import 'package:codon/features/home/models/bookmark_model.dart';
import 'package:codon/features/pearls/models/get_topic_model.dart';
import 'package:codon/features/pearls/screens/chapters_screen.dart';
import 'package:codon/features/pearls/screens/codon_detail_screen.dart';
import 'package:codon/features/pearls/screens/topics_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../qtest/screens/mcq_screen.dart';
import '../../qtest/screens/qtest_module_screen.dart';
import '../../videos/screens/video_modules_screen.dart';
import 'mcq_bookmark_detail.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final BookmarkController controller = Get.put(BookmarkController());
    final controller = Get.put(BookmarkController());

    // ← Yeh line add kar do
    controller.fetchAllBookmarks();   // har baar screen khulte hi fresh data

    return Scaffold(
      backgroundColor: const Color(0xFFEFEDED),
      appBar: AppBar(
        title: const Text('Bookmarks'),

        bottom: TabBar(
          controller: controller.tabController,
          labelColor: const Color(0xFF4DD0E1),
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          // indicator: BoxDecoration(
          //   borderRadius: BorderRadius.circular(30),
          //   color: const Color(0xFF4DD0E1), // Tera cyan color
          // ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tabs: const [
            Tab(
              child: Text(
                'Most Imp',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Tab(
              child: Text(
                'Very Imp',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Tab(
              child: Text(
                'Important',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return TabBarView(
          controller: controller.tabController,
          children: [
            _buildFilteredList(
              controller.mostImportantBookmarks,
              const Color(0xFFFF6B6B),
            ),
            _buildFilteredList(
              controller.veryImportantBookmarks,
              const Color(0xFFFFB74D),
            ),
            _buildFilteredList(
              controller.importantBookmarks,
              const Color(0xFF4DD0E1),
            ),
          ],
        );
      }),
    );
  }

  // List builder helper
  Widget _buildFilteredList(List<BookmarkModel> bookmarks, Color color) {
    if (bookmarks.isEmpty)
      return const Center(child: Text("No bookmarks here"));

    return RefreshIndicator(
      onRefresh: () async => Get.find<BookmarkController>().fetchAllBookmarks(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookmarks.length,
        itemBuilder: (context, index) =>
            _buildBookmarkCard(bookmark: bookmarks[index], accentColor: color),
      ),
    );
  }

  Widget _buildBookmarkCard({
    required BookmarkModel bookmark,
    required Color accentColor,
  }) {
    String displayTitle = 'No Title';
    if (bookmark.type == 'mcq' && bookmark.mcq != null) {
      displayTitle = bookmark.mcq!.name ?? 'No Title';
    } else if (bookmark.type == 'chapter' && bookmark.chapter != null) {
      displayTitle = bookmark.chapter!.name ?? 'No Title';
    } else if (bookmark.type == 'topic' && bookmark.topic != null) {
      displayTitle = bookmark.topic!.name ?? 'No Title';
    } else if (bookmark.type == 'subSubject' && bookmark.subSubject != null) {
      displayTitle = bookmark.subSubject!.name ?? 'No Title';
    } else {
      displayTitle = '${bookmark.type.capitalizeFirst} Bookmark';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            // print("Abhi:- bookmark type: ${bookmark.type}");
            if (bookmark.type == 'chapter' && bookmark.chapter != null) {
              print("Abhi:- bookmark type chapter: ${bookmark.type}");
              print("Abhi:- bookmark type chapter id: ${bookmark.id}");
              Get.to(
                    () => TopicsScreen(
                  chapterId: bookmark.chapter!.id,
                  chapter: null,
                ),
              );
            } else if (bookmark.type == 'topic' && bookmark.topic != null) {
              print("Abhi:- bookmark type topic: ${bookmark.type}");
              print("Abhi:- bookmark type topic id: ${bookmark.topic!.id}");
              Get.to(
                    () => CodonDetailScreen(
                  topics: [
                    GetTopicModel(
                      id: bookmark.topic!.id,
                      name: bookmark.topic!.name ?? displayTitle,
                      description: '',
                      codonId: '',
                      isBookMarked: true.obs,
                      bookMarkedCategory: bookmark.category.obs,
                    ),
                  ],
                  initialIndex: 0,
                ),
              );
            } else if (bookmark.type == 'subSubject' &&
                bookmark.subSubject != null) {
              print("Abhi:- bookmark type subSubject: ${bookmark.type}");
              print("Abhi:- bookmark type subSubject id: ${bookmark.subSubject!.id}");
              Get.to(
                    () => ChaptersScreen(
                  subSubjectId: bookmark.subSubject!.id,
                  subSubjectName: displayTitle,
                ),
              );
            } else if (bookmark.type == 'mcq' /*&& bookmark.mcq != null*/) {
              // Navigation for MCQ - currently showing topic details or dedicated screen if available
              print("Abhi:- bookmark type mcq: ${bookmark.type}");
              print("Abhi:- bookmark type id: ${bookmark.id}");
              Get.to(BookmarkMCQdetailScreen(id: bookmark.mcq?.id,title: bookmark.mcq?.name,)
              );
            }else if (bookmark.type == 'q-test' /*&& bookmark.mcq != null*/) {
              // Navigation for MCQ - currently showing topic details or dedicated screen if available
              print("Abhi:- bookmark type mcq: ${bookmark.type}");
              print("Abhi:- bookmark type id: ${bookmark.id}");
              // Get.to(QTestModuleScreen(chapterId: bookmark.itemId,  chapterName: bookmark.topic?.name ?? "",)
              Get.to(QTestModuleScreen(chapterId: "69946c182438e61fddf8a542",  chapterName: '',   )
              );
            } else if (bookmark.type == 'video' /*&& bookmark.mcq != null*/) {
              // Navigation for MCQ - currently showing topic details or dedicated screen if available
              print("Abhi:- bookmark type mcq: ${bookmark.type}");
              print("Abhi:- bookmark type chapterId: ${bookmark.chapterId}");
              // Get.to(QTestModuleScreen(chapterId: bookmark.itemId,  chapterName: bookmark.topic?.name ?? "",)
              Get.to(VideoModulesScreen( chapterId: bookmark.chapterId, bookmarkpass: "bookmarkpass",  )
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    bookmark.type == 'mcq'
                        ? Icons.help_outline
                        : Icons.description,
                    color: accentColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Title
                          Expanded(
                            child: Text(
                              displayTitle,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Obx(() {
                            final bookmarkCtrl = Get.find<BookmarkController>();

                            // String _getCorrectItemId(BookmarkModel bookmark) {
                            //   switch (bookmark.type.toLowerCase()) {
                            //     case 'mcq':
                            //       return bookmark.mcq?.id ?? bookmark.id ?? '';
                            //     case 'topic':
                            //       return bookmark.topic?.id ?? bookmark.id ?? '';
                            //     case 'chapter':
                            //       return bookmark.chapter?.id ?? bookmark.id ?? '';
                            //     case 'subsubject':
                            //       return bookmark.subSubject?.id ?? bookmark.id ?? '';
                            //     default:
                            //       return bookmark.id ?? '';
                            //   }
                            // }

                            String _getCorrectItemId(BookmarkModel b) {
                              print("Abhi:- get idtem id: ${b.itemId}");
                              final t = b.type.toLowerCase().trim();
                              switch (t) {
                                case 'mcq':
                                  return b.mcq?.id ?? b.id ?? '';
                                case 'topic':
                                  return b.topic?.id ?? b.id ?? '';
                                case 'chapter':
                                  return b.chapter?.id ?? b.id ?? '';
                                case 'subsubject':
                                case 'sub_subject':
                                  return b.subSubject?.id ?? b.id ?? '';

                              // Naye types — assuming id directly bookmark.id mein hai
                                case 'q-test':
                                case 'qtest':
                                case 'video':
                                  return b.itemId ?? '';          // agar model mein alag field nahi hai to yahi use karo

                                default:
                                  return b.itemId ?? '';
                              }
                            }

                            final String itemId = _getCorrectItemId(bookmark);

                            final bool isBookmarked = bookmarkCtrl.isBookmarked(itemId);
                            final String? currentCategory = bookmarkCtrl.getCategory(itemId);

                            // ← Debug line (baad mein hata dena)
                            print("Bookmark icon → ID: $itemId | Bookmarked: $isBookmarked | Category: '$currentCategory'");

                            Color iconColor = Colors.grey.withOpacity(0.7);

                            if (isBookmarked && currentCategory != null) {
                              final cat = currentCategory.toLowerCase().trim();
                              if (cat.contains('mostimportant') || cat.contains('most imp')) {
                                iconColor = Colors.red.shade700;
                              } else if (cat.contains('veryimportant') || cat.contains('very imp')) {
                                iconColor = Colors.orange.shade700;
                              } else if (cat.contains('important')) {
                                iconColor = const Color(0xFF4DD0E1);
                              }
                            }

                            return PopupMenuButton<String>(
                              icon: Icon(
                                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                color: iconColor,
                                size: 28,
                              ),
                              onSelected: (selectedCategory) async {
                                await bookmarkCtrl.toggleBookmark(
                                  type: bookmark.type,
                                  itemId: itemId,
                                  category: selectedCategory,
                                );
                                bookmarkCtrl.fetchAllBookmarks();
                              },
                              itemBuilder: (context) => [
                                // _buildPopupItem('mostimportant', 'Most Important', Colors.red),
                                // _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
                                // _buildPopupItem('important', 'Important', const Color(0xFF4DD0E1)),
                                const PopupMenuDivider(),
                                // _buildPopupItem('remove', 'Remove Bookmark', Colors.grey),
                                _buildPopupItem('mostimportant', 'Most Important', Colors.red),
                                _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
                                _buildPopupItem('important', 'Important', Colors.blue),
                                _buildPopupItem('removed', 'remove', Colors.grey),

                              ],
                            );
                          }),
                        ],
                      ),

                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4DD0E1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              bookmark.type.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF4DD0E1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(bookmark.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow
                Icon(Icons.chevron_right, color: Colors.grey[300], size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String val, String text, Color color) {
    return PopupMenuItem(
      value: val,
      child: Row(
        children: [
          Icon(Icons.bookmark, color: color, size: 20),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final DateTime dt = DateTime.parse(dateStr).toLocal();
      final now = DateTime.now();
      final difference = now.difference(dt);

      if (difference.inDays == 0) return 'Today';
      if (difference.inDays == 1) return 'Yesterday';
      if (difference.inDays < 7) return '${difference.inDays} days ago';
      if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
      }

      return "${dt.day}/${dt.month}/${dt.year}";
    } catch (_) {
      return 'Recently';
    }
  }
}
