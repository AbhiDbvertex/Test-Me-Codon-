import 'package:codon/features/pearls/models/Get_Chapters_Chapter_model.dart';
import 'package:codon/features/videos/controllers/videos_controller.dart';
import 'package:codon/features/videos/domain/models/video_models.dart';
import 'package:codon/features/videos/screens/video_player_screen.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class VideoModulesScreen extends StatelessWidget {
  GetChaptersChapterModel? chapter;
  final chapterId;
  final bookmarkpass;
  VideoModulesScreen({super.key,  this.chapter, this.chapterId, this.bookmarkpass});

  @override
  Widget build(BuildContext context) {
    final VideosController controller = Get.find<VideosController>();

    // final String topicId = args['id'];
    // final String topicName = args['name'];

    WidgetsBinding.instance.addPostFrameCallback((_) {
    if(bookmarkpass == 'bookmarkpass') {
      controller.getChapterVideos(chapterId: chapterId);
    } else{
      controller.getChapterVideos(chapterId: chapter?.id ?? "");
    }
    }); //
    return Scaffold(
      backgroundColor: const Color(0xFFEFEDED),
      appBar: DefaultAppBar(title: chapter?.name ?? ""),
      body: Column(
        children: [
          SizedBox(height: 0.02.toHeightPercent()),
          _buildTabs(controller),
          Expanded(
            child: Obx(() {
              if (controller.isModuleLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // 2. Empty check
              if (controller.filteredModules.isEmpty) {
                return const Center(
                  child: Text("No videos found in this category"),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(0.04.toWidthPercent()),
                itemCount: controller.filteredModules.length,
                itemBuilder: (context, index) {
                  final module = controller.filteredModules[index];
                  return _buildVideoCard(module);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(VideosController controller) {
    return Container(
      height: 0.06.toHeightPercent(),
      color: AppColors.primary,
      child: Obx(
        () => ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _buildTabItem('All', 0, controller),
            _buildTabItem('Paused', 1, controller),
            _buildTabItem('Completed', 2, controller),
            _buildTabItem('Unattended', 3, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index, VideosController controller) {
    bool isSelected = controller.selectedTab.value == index;
    return GestureDetector(
      onTap: () => controller.selectedTab.value = index,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.05.toWidthPercent()),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(isSelected ? 1.0 : 0.7),
              fontWeight: FontWeight.bold,
              fontSize: 0.042.toWidthPercent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(VideoModule module) {
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
      child: Padding(
        padding: EdgeInsets.all(0.03.toWidthPercent()),
        child: Row(
          children: [
            Container(
              width: 0.2.toWidthPercent(),
              height: 0.2.toWidthPercent(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 1. Image
                    Image.network(
                      "$baseUrl/${module.thumbnailUrl}",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_circle_fill,
                        color: Colors.black54,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 0.04.toWidthPercent()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    module.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 0.045.toWidthPercent(),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(
                        ' ${module.avgRating?.toString() ?? "0.0"}',
                        style: TextStyle(
                          fontSize: 0.035.toWidthPercent(),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () =>
                  Get.to(() => const VideoPlayerScreen(), arguments: module),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                elevation: 4,
                shadowColor: Colors.black.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                module.statusTag == VideoStatus.completed ? 'Done' : 'Start',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
