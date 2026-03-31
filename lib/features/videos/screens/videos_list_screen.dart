import 'package:codon/features/faculties/screens/faculties_screen.dart';
import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/pearls/screens/sub_subjects.dart';
import 'package:codon/features/videos/controllers/videos_controller.dart';
import 'package:codon/features/videos/domain/models/video_models.dart';
import 'package:codon/features/videos/screens/video_sub_subjects_screen.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class VideosListScreen extends StatelessWidget {
  const VideosListScreen({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   final VideosController controller = Get.find<VideosController>();

  //   return Scaffold(
  //     backgroundColor: const Color(0xFFEFEDED),
  //     appBar: AppBar(
  //       title: Text(
  //         'Videos',
  //         style: TextStyle(
  //           fontSize: 0.05.toWidthPercent(),
  //           fontWeight: FontWeight.bold,
  //           color: Colors.black,
  //         ),
  //       ),
  //       centerTitle: true,
  //       backgroundColor: Colors.white,
  //       surfaceTintColor: Colors.white,
  //       elevation: 0,
  //       automaticallyImplyLeading: false,
  //     ),
  //     body: Column(
  //       children: [
  //         SizedBox(height: 0.02.toHeightPercent()),
  //         Expanded(
  //           child: Obx(() {
  //             if (controller.isSubjectLoading.value) {
  //               return const Center(
  //                 child: CircularProgressIndicator(color: AppColors.primary),
  //               );
  //             }

  //             if (controller.subjects.isEmpty) {
  //               return const Center(child: Text("No Subjects Available"));
  //             }
  //             return ListView.builder(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: 0.04.toWidthPercent(),
  //                 vertical: 0.02.toHeightPercent(),
  //               ),
  //               itemCount: controller.subjects.length,
  //               itemBuilder: (context, index) {
  //                 final subject = controller.subjects[index];
  //                 return _buildSubjectCard(subject);
  //               },
  //             );
  //           }),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildSubjectCard(VideoSubject subject) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 0.01.toHeightPercent()),
  //     padding: EdgeInsets.symmetric(
  //       // horizontal: 0.08.toWidthPercent(),
  //       vertical: 0.02.toHeightPercent(),
  //     ),
  //     decoration: BoxDecoration(
  //       color: Color(0xFFFFFFFF),
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 10,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: InkWell(
  //       onTap: () => Get.to(
  //         () => const VideoSubSubjectsScreen(),
  //         arguments: {'id': subject.id, 'name': subject.name},
  //       ),
  //       child: ListTile(
  //         title: Text(
  //           subject.name,
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //           style: TextStyle(
  //             fontSize: 0.05.toWidthPercent(),
  //             fontWeight: FontWeight.bold,
  //             color: AppColors.primary,
  //           ),
  //         ),
  //         trailing: const Icon(Icons.arrow_forward, color: Color(0xFFE0E0E0)),
  //       ),
  //       // child: Column(
  //       //   crossAxisAlignment: CrossAxisAlignment.end,
  //       //   children: [
  //       //     Row(
  //       //       crossAxisAlignment: CrossAxisAlignment.start,

  //       //       children: [
  //       //         Flexible(
  //       //           child: Text(
  //       //             subSubject.name,
  //       //             maxLines: 2,
  //       //             overflow: TextOverflow.ellipsis,
  //       //             style: TextStyle(
  //       //               fontSize: 0.05.toWidthPercent(),
  //       //               fontWeight: FontWeight.bold,
  //       //               color: AppColors.primary,
  //       //             ),
  //       //           ),
  //       //         ),
  //       //         Spacer(),
  //       //         const Icon(Icons.arrow_forward, color: Color(0xFFE0E0E0)),
  //       //       ],
  //       //     ),
  //       //     Text(
  //       //       '(${subSubject.videoCount} Videos)',
  //       //       style: TextStyle(
  //       //         fontSize: 0.035.toWidthPercent(),
  //       //         color: Color(0xFFadb0b1),
  //       //         fontWeight: FontWeight.bold,
  //       //       ),
  //       //     ),
  //       //   ],
  //       // ),
  //     ),
  //   );
  //   // return Container(
  //   //   margin: EdgeInsets.only(bottom: 0.01.toHeightPercent()),
  //   //   decoration: BoxDecoration(
  //   //     color: Color(0xFFFFFFFF),
  //   //     borderRadius: BorderRadius.circular(15),
  //   //     boxShadow: [
  //   //       BoxShadow(
  //   //         color: Colors.black.withOpacity(0.05),
  //   //         blurRadius: 10,
  //   //         offset: const Offset(0, 4),
  //   //       ),
  //   //     ],
  //   //   ),
  //   //   child: Material(
  //   //     color: Colors.transparent,
  //   //     borderRadius: BorderRadius.circular(15),
  //   //     child: InkWell(
  //   //       onTap: () => Get.to(
  //   //         () => const VideoSubSubjectsScreen(),
  //   //         arguments: {'id': subject.id, 'name': subject.name},
  //   //       ),
  //   //       borderRadius: BorderRadius.circular(15),
  //   //       child: Padding(
  //   //         padding: EdgeInsets.all(0.03.toWidthPercent()),
  //   //         child: Row(
  //   //           children: [
  //   //             Expanded(
  //   //               child: Text(
  //   //                 subject.name,
  //   //                 maxLines: 2,
  //   //                 overflow: TextOverflow.ellipsis,
  //   //                 style: TextStyle(
  //   //                   fontSize: 0.05.toWidthPercent(),
  //   //                   fontWeight: FontWeight.bold,
  //   //                   color: AppColors.primary,
  //   //                 ),
  //   //               ),
  //   //             ),
  //   //             const Icon(Icons.arrow_forward, color: Color(0xFFE0E0E0)),
  //   //           ],
  //   //         ),
  //   //       ),
  //   //     ),
  //   //   ),
  //   // );
  // }
  Widget build(BuildContext context) {
    final PearlsController controller = Get.find<PearlsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFEFEDED),
      appBar: AppBar(
        title: Text(
          'Videos',
          style: TextStyle(
            fontSize: 0.05.toWidthPercent(),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 0.02.toHeightPercent()),
          Expanded(
            child: FutureBuilder(
              future: controller.getSubjects(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  final subjects = snapshot.data!;
                  if (subjects.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Subjects Available",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.04.toWidthPercent(),
                      vertical: 0.02.toHeightPercent(),
                    ),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      return _buildPearlSubjectCard(subject);
                    },
                  );
                }
                return const Center(child: Text('No Subjects Available'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPearlSubjectCard(dynamic subject) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.01.toHeightPercent()),
      padding: EdgeInsets.symmetric(vertical: 0.02.toHeightPercent()),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
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
          Get.to(() => VideoSubSubjectsScreen(subject: subject));
        },
        child: ListTile(
          title: Text(
            subject.name ?? 'N/A',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 0.05.toWidthPercent(),
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward, color: Color(0xFFE0E0E0)),
        ),
      ),
    );
  }
}
