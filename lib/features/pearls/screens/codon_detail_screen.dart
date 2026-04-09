import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/pearls/models/get_topic_model.dart';
import 'package:codon/features/pearls/models/subject_model.dart';
import 'package:codon/features/pearls/models/topic_details_model.dart';
import 'package:codon/features/pearls/screens/chapters_screen.dart';
import 'package:codon/features/pearls/screens/sub_subjects.dart';
import 'package:codon/features/pearls/screens/topics_screen.dart';
import 'package:codon/features/qtest/screens/mcq_screen.dart';
import 'package:codon/features/qtest/screens/qtest_module_screen.dart';
import 'package:codon/features/subscription/screens/subscription_screen.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../home/controllers/bookmark_controller.dart';

class CodonDetailScreen extends StatefulWidget {
  final List<GetTopicModel> topics;
  final int initialIndex;

  const CodonDetailScreen({
    super.key,
    required this.topics,
    required this.initialIndex,
  });

  @override
  State<CodonDetailScreen> createState() => _CodonDetailScreenState();
}

class _CodonDetailScreenState extends State<CodonDetailScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void _navigateToNext() {
    if (currentIndex < widget.topics.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void _navigateToPrevious() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTopic = widget.topics[currentIndex];
    final PearlsController controller = Get.find<PearlsController>();

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: DefaultAppBar(title: currentTopic.name),
        bottomNavigationBar: _buildNavigationButtons(),
        body: FutureBuilder<TopicDetailModel?>(
          key: ValueKey(currentTopic.id),
          future: controller.fetchTopicDetails(currentTopic.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Text(
                  'Failed to load details',
                  style: TextStyle(fontSize: 0.04.toWidthPercent()),
                ),
              );
            }

            final detail = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(detail),
                  Padding(
                    padding: EdgeInsets.all(0.04.toWidthPercent()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _buildHierarchy(detail),
                        SizedBox(height: 0.02.toHeightPercent()),
                        _buildTopicInfo(detail),
                        SizedBox(height: 0.03.toHeightPercent()),
                        _buildStatsGrid(detail),
                        SizedBox(height: 0.02.toHeightPercent()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      height: 0.08.toHeightPercent(),
      padding: EdgeInsets.symmetric(horizontal: 0.04.toWidthPercent()),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavButton(
            onPressed: currentIndex > 0 ? _navigateToPrevious : null,
            icon: Icons.arrow_back_ios,
            label: "Previous",
            isLeft: true,
          ),
          _buildNavButton(
            onPressed: currentIndex < widget.topics.length - 1
                ? _navigateToNext
                : null,
            icon: Icons.arrow_forward_ios,
            label: "Next",
            isLeft: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    required bool isLeft,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey[200],
        disabledForegroundColor: Colors.grey[400],
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(
          horizontal: 0.04.toWidthPercent(),
          vertical: 0.01.toHeightPercent(),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLeft) Icon(icon, size: 16),
          if (isLeft) SizedBox(width: 0.02.toWidthPercent()),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 0.038.toWidthPercent(),
            ),
          ),
          if (!isLeft) SizedBox(width: 0.02.toWidthPercent()),
          if (!isLeft) Icon(icon, size: 16),
        ],
      ),
    );
  }

  Widget _buildHeader(TopicDetailModel detail) {
    return Container(
      width: double.infinity,
      height: 0.08.toHeightPercent(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.auto_stories,
            //   size: 0.15.toWidthPercent(),
            //   color: Colors.white,
            // ),
            SizedBox(height: 0.01.toHeightPercent()),
            Text(
              " codon Id-${detail.topic.codonId}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 0.04.toWidthPercent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildHierarchy(TopicDetailModel detail) {
  //   return Container(
  //     padding: EdgeInsets.all(0.03.toWidthPercent()),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.grey.withOpacity(0.2)),
  //     ),
  //     child: Column(
  //       children: [
  //         _buildHierarchyItem(
  //           Icons.subject,
  //           "Subject",
  //           detail.hierarchy.subject,
  //           onTap: () {
  //             if (detail.hierarchy.subjectId.isNotEmpty) {
  //               Get.to(
  //                 () => SubSubjectsScreen(
  //                   subject: SubjectModel(
  //                     id: detail.hierarchy.subjectId,
  //                     name: detail.hierarchy.subject,
  //                     order: 0,
  //                   ),
  //                 ),
  //               );
  //             }
  //           },
  //         ),
  //         const Divider(),
  //         _buildHierarchyItem(
  //           Icons.category,
  //           "Sub-Subject",
  //           detail.hierarchy.subSubject,
  //           onTap: () {
  //             if (detail.hierarchy.subSubjectId.isNotEmpty) {
  //               Get.to(
  //                 () => ChaptersScreen(
  //                   subSubjectId: detail.hierarchy.subSubjectId,
  //                   subSubjectName: detail.hierarchy.subSubject,
  //                 ),
  //               );
  //             }
  //           },
  //         ),
  //         const Divider(),
  //         _buildHierarchyItem(
  //           Icons.menu_book,
  //           "Chapter",
  //           detail.hierarchy.chapter,
  //           onTap: () {
  //             if (detail.hierarchy.chapterId.isNotEmpty) {
  //               Get.to(
  //                 () => TopicsScreen(chapterId: detail.hierarchy.chapterId),
  //               );
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildHierarchyItem(
    IconData icon,
    String label,
    String value, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.005.toHeightPercent()),
        child: Row(
          children: [
            Icon(icon, size: 0.05.toWidthPercent(), color: AppColors.primary),
            SizedBox(width: 0.03.toWidthPercent()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 0.03.toWidthPercent(),
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 0.035.toWidthPercent(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.chevron_right,
                size: 0.05.toWidthPercent(),
                color: Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicInfo(TopicDetailModel detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                detail.topic.name,
                // "asdfsdaf asdfs adf asd fsdaf sdaf sadfasdfsda fsd fsadf",
                style: TextStyle(
                  fontSize: 0.05.toWidthPercent(),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            Obx(() {
              final bookmarkCtrl = Get.put(BookmarkController());

              final isBookmarked = bookmarkCtrl.isBookmarked(detail.topic.id);
              final category = bookmarkCtrl.getCategory(detail.topic.id);

              Color iconColor;

              if (!isBookmarked) {
                iconColor = AppColors.primary.withOpacity(0.5);
              } else {
                switch (category) {
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

              return PopupMenuButton<String>(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: iconColor,
                  size: 0.06.toWidthPercent(),
                ),
                onSelected: (value) {
                  bookmarkCtrl.toggleBookmark(
                    type: "topic",
                    itemId: detail.topic.id,
                    category: value,
                  );
                },
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
              );
            }),
          ],
        ),
        SizedBox(height: 0.01.toHeightPercent()),
        HtmlWidget(
          detail.topic.description,
          textStyle: TextStyle(
            fontSize: 0.038.toWidthPercent(),
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ],
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

  Widget _buildStatsGrid(TopicDetailModel detail) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1,
      mainAxisSpacing: 0.02.toWidthPercent(),
      crossAxisSpacing: 0.02.toWidthPercent(),
      children: [
        //_buildStatCard(Icons.play_circle, "Videos", stats.videos),
        detail.stats.mcqs == 0
            ? Container()
            : _buildStatCard(Icons.quiz, "MCQs", detail.stats.mcqs, detail),
        // _buildStatCard(Icons.note, "Notes", stats.notes),
      ],
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String label,
    int count,
    TopicDetailModel detail,
  ) {
    return InkWell(
      onTap: () {
        if (label == "MCQs") {
          final user = Get.find<UserController>().userModel.value;
          if (user?.activeSubscription ?? false) {
            print("Abhi:- chapterid tap mcq: ${detail.hierarchy.chapterId}");
            print("Abhi:- topicId tap mcq: ${detail.topic.id}");
            Get.to(
              // () => QTestModuleScreen(
              //   // chapterId: detail.hierarchy.chapterId,
              //   chapterId: detail.topic.id,
              //   chapterName: detail.hierarchy.chapter,
              //   codeonpass: "codon",
              // ),
              () => MCQScreen(topicId: detail.topic.id, codonpass: "codon"),
            );
          } else {
            Get.to(() => const SubscriptionScreen());
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 0.08.toWidthPercent()),
            SizedBox(height: 0.005.toHeightPercent()),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 0.04.toWidthPercent(),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 0.03.toWidthPercent(),
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
