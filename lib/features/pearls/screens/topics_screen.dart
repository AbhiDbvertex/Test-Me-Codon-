// import 'package:codon/features/home/controllers/bookmark_controller.dart';
// import 'package:codon/features/pearls/controllers/pearls_controller.dart';
// import 'package:codon/features/pearls/models/Get_Chapters_Chapter_model.dart';
// import 'package:codon/features/pearls/models/get_topic_model.dart';
// import 'package:codon/features/pearls/screens/codon_detail_screen.dart';
// import 'package:codon/utills/app_theme.dart';
// import 'package:codon/utills/screen_size_utils.dart';
// import 'package:codon/utills/widgets/default_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class TopicsScreen extends StatelessWidget {
//   final String? chapterId;
//   final GetChaptersChapterModel? chapter;
//   const TopicsScreen({super.key, this.chapter, this.chapterId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFEDED),
//       appBar: DefaultAppBar(title: "Topics"),
//       body: Column(
//         children: [
//           SizedBox(height: 0.02.toHeightPercent()),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 0.04.toWidthPercent()),
//               child: FutureBuilder(
//                 future: Get.find<PearlsController>().getTopics(
//                   chapterId: chapterId ?? chapter!.id,
//                 ),
//                 builder: (context, snapshot) {
//                   print("snapshot ${snapshot.data}");
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasError) {
//                       return Center(child: Text("Error: ${snapshot.error}"));
//                     } else {
//                       final topics = snapshot.data;
//                       return ListView.builder(
//                         itemCount: topics?.length ?? 0,
//                         itemBuilder: (context, index) {
//                           return _buildTopicCard(
//                             topics!,
//                             index,
//                             chapterId ?? chapter!.id,
//                           );
//                         },
//                       );
//                     }
//                   } else {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTopicCard(
//     List<GetTopicModel> topics,
//     int index,
//     String activeChapterId,
//   ) {
//     final topic = topics[index];
//     print("topic name ${topic.name}, id: ${topic.id}");
//     // Try to find the chapter in the controller list if not provided
//     final PearlsController pearlsController = Get.find<PearlsController>();
//     final resolvedChapter =
//         chapter ?? pearlsController.chaptersList.firstWhereOrNull((c) => c.id == activeChapterId,);
//         // chapter ?? topic.id;
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 0.01.toHeightPercent()),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: InkWell(
//         onTap: () => Get.to(
//           () => CodonDetailScreen(topics: topics, initialIndex: index),
//         ),
//         borderRadius: BorderRadius.circular(15),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 0.01.toHeightPercent()),
//           child: ListTile(
//             title: Text(
//               topic.name,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 0.046.toWidthPercent(),
//                 fontWeight: FontWeight.w800,
//                 color: AppColors.primary,
//                 letterSpacing: 0.3,
//               ),
//             ),
//             subtitle: Padding(
//               padding: const EdgeInsets.only(top: 4.0),
//               child: Text(
//                 topic.codonId.trim(),
//                 style: TextStyle(
//                   fontSize: 0.034.toWidthPercent(),
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black45,
//                 ),
//               ),
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (resolvedChapter != null)
//                   PopupMenuButton<String>(
//                     icon: Obx(() {
//                       Color iconColor;
//                       if (!resolvedChapter.isBookMarked.value) {
//                         iconColor = AppColors.primary.withOpacity(0.5);
//                       } else {
//                         switch (resolvedChapter.bookMarkedCategory.value) {
//                           case 'mostimportant':
//                             iconColor = Colors.red;
//                             break;
//                           case 'veryimportant':
//                             iconColor = Colors.orange;
//                             break;
//                           case 'important':
//                             iconColor = Colors.blue;
//                             break;
//                           default:
//                             iconColor = AppColors.primary;
//                         }
//                       }
//                       return Icon(
//                         resolvedChapter.isBookMarked.value
//                             ? Icons.bookmark
//                             : Icons.bookmark_border,
//                         color: iconColor,
//                         size: 0.06.toWidthPercent(),
//                       );
//                     }),
//                     onSelected: (value) {
//                       Get.find<BookmarkController>().toggleBookmark(
//                         // type: "chapter",
//                         type: "topic",
//                         // itemId: resolvedChapter.id,
//                         itemId: topic.id,
//                         category: value,
//                       );
//                     },
//                     itemBuilder: (context) => [
//                       _buildPopupItem(
//                         'mostimportant',
//                         'Most Important',
//                         Colors.red,
//                       ),
//                       _buildPopupItem(
//                         'veryimportant',
//                         'Very Important',
//                         Colors.orange,
//                       ),
//                       _buildPopupItem('important', 'Important', Colors.blue),
//                     ],
//                   ),
//                 const Icon(
//                   Icons.arrow_forward,
//                   color: Color(0xFFE0E0E0),
//                   size: 20,
//                 ),
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
// }

import 'package:codon/features/home/controllers/bookmark_controller.dart';
import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/pearls/models/Get_Chapters_Chapter_model.dart';
import 'package:codon/features/pearls/models/get_topic_model.dart';
import 'package:codon/features/pearls/screens/codon_detail_screen.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicsScreen extends StatelessWidget {
  final String? chapterId;
  final GetChaptersChapterModel? chapter;

  const TopicsScreen({super.key, this.chapter, this.chapterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEDED),
      appBar: DefaultAppBar(title: "Topics"),
      body: Column(
        children: [
          SizedBox(height: 0.02.toHeightPercent()),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.04.toWidthPercent()),
              child: FutureBuilder<List<GetTopicModel>>(
                future: Get.find<PearlsController>().getTopics(
                  chapterId: chapterId ?? chapter!.id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    final topics = snapshot.data ?? [];

                    return ListView.builder(
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        return _buildTopicCard(topics, index);
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(List<GetTopicModel> topics, int index) {
    final topic = topics[index];

    return Container(
      margin: EdgeInsets.only(bottom: 0.01.toHeightPercent()),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => CodonDetailScreen(
            topics: topics,
            initialIndex: index,
            chapterId: chapterId ?? chapter!.id,
          ));
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.01.toHeightPercent()),
          child: ListTile(
            title: Text(
              topic.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 0.046.toWidthPercent(),
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                letterSpacing: 0.3,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                topic.codonId.trim(),
                style: TextStyle(
                  fontSize: 0.034.toWidthPercent(),
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMenuButton<String>(
                  icon: Obx(() {
                    Color iconColor;

                    if (!topic.isBookMarked.value) {
                      iconColor = AppColors.primary.withOpacity(0.5);
                    } else {
                      switch (topic.bookMarkedCategory.value) {
                        case 'mostimportant':
                          iconColor = Colors.red;
                          break;
                        case 'veryimportant':
                          iconColor = Colors.orange;
                          break;
                        case 'important':
                          iconColor = Colors.blue;
                          break;
                        default:
                          iconColor = AppColors.primary;
                      }
                    }

                    return Icon(
                      topic.isBookMarked.value
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: iconColor,
                      size: 0.06.toWidthPercent(),
                    );
                  }),
                  onSelected: (value) {
                    Get.find<BookmarkController>().toggleBookmark(
                      type: "topic",
                      itemId: topic.id,
                      category: value,
                    );

                    // UI update locally
                    topic.isBookMarked.value = true;
                    topic.bookMarkedCategory.value = value;
                  },
                  itemBuilder: (context) => [
                    _buildPopupItem(
                        'mostimportant', 'Most Important', Colors.red),
                    _buildPopupItem(
                        'veryimportant', 'Very Important', Colors.orange),
                    _buildPopupItem('important', 'Important                                                                                          ', Colors.blue),
                    _buildPopupItem('removed', 'remove', Colors.grey),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Color(0xFFE0E0E0),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(
      String val, String text, Color color) {
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
}
