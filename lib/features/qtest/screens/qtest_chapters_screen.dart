import 'package:codon/features/home/controllers/bookmark_controller.dart';
import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/pearls/models/sub_subject_model.dart';

import 'package:codon/features/qtest/controllers/qtest_controller.dart';
import 'package:codon/features/qtest/screens/qtest_module_screen.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class QTestChaptersScreen extends StatelessWidget {
  final SubSubjectModel subSubject;
  final savebookmark;
  const QTestChaptersScreen({super.key, required this.subSubject, this.savebookmark});

  // @override
  // Widget build(BuildContext context) {
  //   final QTestController controller = Get.find<QTestController>();

  //   return Scaffold(
  //     backgroundColor: const Color(0xFFF8F8F8),
  //     appBar: DefaultAppBar(title: subSubject.name),
  //     body: FutureBuilder(
  //       future: Get.find<QTestController>().getChapters(
  //         subSubjectId: subSubject.id,
  //       //future: Get.find<PearlsController>().getChapters(subSubject.id),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text('Error: ${snapshot.error}'));
  //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //           return const Center(child: Text('No topics found'));
  //         } else {
  //           final topics = snapshot.data!;
  //           return ListView.builder(
  //             padding: EdgeInsets.all(0.04.toWidthPercent()),
  //             itemCount: topics.length,
  //             itemBuilder: (context, index) {
  //               final topic = topics[index];
  //               return GestureDetector(
  //                 onTap: () => Get.to(() => QTestModuleScreen(topic: topic)),
  //                 child: Container(
  //                   margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
  //                   padding: EdgeInsets.symmetric(
  //                     horizontal: 0.05.toWidthPercent(),
  //                     vertical: 0.025.toHeightPercent(),
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(
  //                       0.02.toWidthPercent(),
  //                     ),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.black.withOpacity(0.03),
  //                         blurRadius: 10,
  //                         offset: const Offset(0, 4),
  //                       ),
  //                     ],
  //                   ),
  //                   child: Row(
  //                     children: [
  //                       Container(
  //                         width: 0.65.toWidthPercent(),
  //                         child: Text(
  //                           topic.name,
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 1,
  //                           style: TextStyle(
  //                             fontSize: 0.05.toWidthPercent(),
  //                             fontWeight: FontWeight.bold,
  //                             color: AppColors.primary,
  //                           ),
  //                         ),
  //                       ),
  //                       const Spacer(),
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.end,
  //                         children: [
  //                           const Icon(
  //                             Icons.arrow_forward,
  //                             color: Color(0xFFE0E0E0),
  //                           ),
  //                           SizedBox(height: 0.005.toHeightPercent()),
  //                           Text(
  //                             "",
  //                             // topic.modulesCount,
  //                             style: TextStyle(
  //                               fontSize: 0.035.toWidthPercent(),
  //                               color: Colors.black45,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    print("Abhi savebookmark chapter: ${savebookmark}");
    final PearlsController controller = Get.find<PearlsController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getChapters(subSubject.id);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFEFEDED),
      // Uniform Video Screen Background
      appBar: DefaultAppBar(title: subSubject.name),
      body: Column(
        children: [
          SizedBox(height: 0.02.toHeightPercent()), // Top Gap
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Text('Error: ${controller.errorMessage.value}'),
                );
              }

              final chapters = controller.chaptersList;
              if (chapters.isEmpty) {
                return const Center(
                  child: Text(
                    "No Chapters Available",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
              print("chapter lneght ${chapters.length}");
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.04.toWidthPercent(),
                  vertical: 0.02.toHeightPercent(),
                ),
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  final chapter = chapters[index];
                  return _buildChapterCard(chapter);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterCard(dynamic chapter) {
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
      child: Stack(
        children: [
          InkWell(
            onTap: () => Get.to(
              () => QTestModuleScreen(
                chapterId: chapter.id,
                chapterName: chapter.name,
                savebookmark: savebookmark,
              ),
            ),
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.01.toHeightPercent()),
              child: ListTile(
                title: Text(
                  chapter.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 0.046.toWidthPercent(),
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: 0.3,
                  ),
                ),
                // subtitle: Padding(
                //   padding: const EdgeInsets.only(top: 4.0),
                //   child: Text(
                //     '${chapter.id.trim()}',
                //     style: TextStyle(
                //       fontSize: 0.034.toWidthPercent(),
                //       fontWeight: FontWeight.w600,
                //       color: Colors.black45,
                //     ),
                //   ),
                // ),
                subtitle: Container(
                  width: 0.3.toWidthPercent(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Topics: ${chapter.totalTopicsCount}',
                    style: TextStyle(
                      fontSize: 0.028.toWidthPercent(),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PopupMenuButton<String>(
                      icon: Obx(() {
                        Color iconColor;
                        if (!chapter.isBookMarked.value) {
                          iconColor = AppColors.primary.withOpacity(0.5);
                        } else {
                          switch (chapter.bookMarkedCategory.value) {
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
                          chapter.isBookMarked.value
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: iconColor,
                          size: 0.06.toWidthPercent(),
                        );
                      }),
                      onSelected: (value) {
                        Get.find<BookmarkController>().toggleBookmark(
                          type: "chapter",
                          itemId: chapter.id,
                          category: value,
                        );
                      },   // flutter.dbvertex@gmail.com
                      itemBuilder: (context) => [
                        _buildPopupItem(
                          'mostimportant',
                          'Most Important',
                          Colors.red,
                        ),
                        _buildPopupItem(
                          'veryimportant',
                          'Very Important',
                          Colors.orange,
                        ),
                        _buildPopupItem('important', 'Important', Colors.blue),
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
        ],
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
}
