import 'dart:async';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utills/app_theme.dart';
import '../../settings/screens/rating_screen.dart';
import '../controllers/videos_controller.dart';
import '../domain/models/video_models.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late BetterPlayerController _betterPlayerController;
  late VideoModule videoData;
  Timer? _syncTimer;

  @override
  void initState() {
    super.initState();
    _enableScreenProtection();
    videoData = Get.arguments as VideoModule;
    String videoFullUrl = "$baseUrl/${videoData.videoUrl}";

    // BetterPlayerDataSource dataSource = BetterPlayerDataSource(
    //   BetterPlayerDataSourceType.network,
    //   videoFullUrl,
    // );
    // _betterPlayerController = BetterPlayerController(
    //   BetterPlayerConfiguration(
    //     autoPlay: false,
    //     looping: false,
    //     aspectRatio: 16 / 9,
    //     fit: BoxFit.contain,
    //     controlsConfiguration: BetterPlayerControlsConfiguration(
    //       enablePlayPause: true,
    //       enableProgressText: true,
    //       enableSkips: true,
    //       // 10 sec ⏪⏩
    //       enablePlaybackSpeed: true,
    //       enableFullscreen: true,
    //       loadingColor: AppColors.primary,
    //       progressBarPlayedColor: AppColors.primary,
    //       progressBarHandleColor: AppColors.primary,
    //     ),
    //   ),
    //   betterPlayerDataSource: dataSource,
    // );

    _setupPlayer();
    _startSyncTimer();
  }

  void _setupPlayer() {
    String videoFullUrl = "$baseUrl/${videoData.videoUrl}";
    BetterPlayerBufferingConfiguration bufferingConfiguration =
        BetterPlayerBufferingConfiguration(
          minBufferMs: 3000,
          maxBufferMs: 30000,
          bufferForPlaybackMs: 1500,
          bufferForPlaybackAfterRebufferMs: 3000,
        );

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoFullUrl,
      bufferingConfiguration: bufferingConfiguration,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        maxCacheSize: 100 * 1024 * 1024,
      ),
    );

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        startAt: Duration(seconds: videoData.lastWatchTime.toInt()),
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        placeholder: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        showPlaceholderUntilPlay: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enablePlayPause: true,
          enableFullscreen: true,
          enableSkips: true,
          enablePlaybackSpeed: true,
          loadingColor: AppColors.primary,
          progressBarPlayedColor: AppColors.primary,
          progressBarHandleColor: AppColors.primary,
        ),
      ),
      betterPlayerDataSource: dataSource,
    );
  }

  void _startSyncTimer() {
    _syncTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _performSync();
    });
  }

  void _performSync() {
    final currentPos =
        _betterPlayerController
            .videoPlayerController
            ?.value
            .position
            .inSeconds ??
        0;
    final totalDuration =
        _betterPlayerController
            .videoPlayerController
            ?.value
            .duration
            ?.inSeconds ??
        0;

    if (currentPos > 0) {
      Get.find<VideosController>().syncVideoProgress(
        videoId: videoData.id,
        topicId: videoData.topicId,
        watchTime: currentPos,
        totalDuration: totalDuration,
      );
    }
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    _performSync();
    _betterPlayerController.dispose();
    _disableScreenProtection();
    super.dispose();
  }

  Future<void> _enableScreenProtection() async {
    await ScreenProtector.protectDataLeakageOn();
  }

  Future<void> _disableScreenProtection() async {
    await ScreenProtector.protectDataLeakageOff();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: DefaultAppBar(title: videoData.title),
        bottomNavigationBar: _buildReviewButton(),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 0.3.toHeightPercent(),
              color: Colors.black,
              child: BetterPlayer(controller: _betterPlayerController),
            ),

            SizedBox(height: 0.03.toHeightPercent()),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.04.toWidthPercent(),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        children: [
                          _buildModernRow(
                            'Title',
                            videoData.title,
                            isFirst: true,
                          ),

                          if (videoData.description.isNotEmpty)
                            _buildModernRow(
                              'Description',
                              videoData.description,
                            ),

                          if (videoData.notesUrl != null &&
                              videoData.notesUrl!.isNotEmpty)
                            _buildModernRow(
                              'Notes',
                              'Available (Tap to view)',
                              isLast: true,
                              isLink: true,
                              onTap: () async {
                                final String pdfUrl =
                                    "$baseUrl/${videoData.notesUrl}";
                                final Uri url = Uri.parse(pdfUrl);

                                print("Opening: $pdfUrl");

                                try {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                } catch (e) {
                                  Get.snackbar("Error", "cant open ");
                                }
                              },
                            ),
                        ],
                      ),
                    ),

                    // SizedBox(height: 0.04.toHeightPercent()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 0.25.toWidthPercent(),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  Widget _videoInfoPreview(BuildContext context) {
    return InkWell(
      onTap: () => _openDetailsSheet(context),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 0.01.toWidthPercent()),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theory of Curie-Weiss Law',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              'In this video see Curie-Weiss Law s detail ...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 6),
            Text(
              'See more',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetailsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailItem('Title', 'Theory of Curie-Weiss Law'),
                _detailItem(
                  'Description',
                  'Complete explanation of Curie-Weiss Law with examples.\nComplete explanation of Curie-Weiss Law with examples.\nComplete explanation of Curie-Weiss Law with examples.\nComplete explanation of Curie-Weiss Law with examples.\nComplete explanation of Curie-Weiss Law with examples.\nComplete explanation of Curie-Weiss Law with examples.\n',
                ),
                _detailItem('Tags', 'Curie, Weiss, Magnetic'),
                _detailItem('Pearl ID', 'PHY-OPT-1023'),
                _detailItem('Notes', 'Important for NEET preparation'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildModernRow(
    String label,
    String value, {
    bool isFirst = false,
    bool isLast = false,
    bool isLink = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column (Label)
            Container(
              width: 0.3.toWidthPercent(),
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade50,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            // Right Column (Value)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  value,
                  style: TextStyle(
                    color: isLink ? AppColors.primary : Colors.black54,
                    fontWeight: isLink ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => Get.to(
            () => const RatingScreen(),
            arguments: {"targetId": videoData.id, "targetType": "video"},
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 0.02.toHeightPercent()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 0,
          ),
          child: Text(
            'Leave a Rating',
            style: TextStyle(
              fontSize: 0.05.toWidthPercent(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
