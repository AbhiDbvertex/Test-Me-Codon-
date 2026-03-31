import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/pearls/models/sub_subject_model.dart';
import 'package:codon/features/pearls/models/subject_model.dart';
import 'package:codon/features/qtest/controllers/qtest_controller.dart';
import 'package:codon/features/qtest/screens/qtest_chapters_screen.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class QTestSubSubjectScreen extends StatelessWidget {
  final SubjectModel subject;
  final savebookmark;
  const QTestSubSubjectScreen({super.key, required this.subject, this.savebookmark});

  @override
  Widget build(BuildContext context) {
    //final QTestController controller = Get.find<QTestController>();
    print("Abhi savebookmark : ${savebookmark}");
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: DefaultAppBar(title: subject.name),
      body: FutureBuilder(
        future: Get.find<PearlsController>().getSubSubjects(subject.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No sub-subjects found'));
          } else {
            final subSubjects = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(0.04.toWidthPercent()),
              itemCount: subSubjects.length,
              itemBuilder: (context, index) {
                final subSubject = subSubjects[index];
                return GestureDetector(
                  onTap: () =>
                      Get.to(() => QTestChaptersScreen(subSubject: subSubject,savebookmark: savebookmark,)),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.05.toWidthPercent(),
                      vertical: 0.025.toHeightPercent(),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        0.02.toWidthPercent(),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 0.7.toWidthPercent(),
                          child: Text(
                            subSubject.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 0.05.toWidthPercent(),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFFE0E0E0),
                            ),
                            SizedBox(height: 0.005.toHeightPercent()),
                            Text(
                              "",
                              //subSubject.modulesCount,
                              style: TextStyle(
                                fontSize: 0.035.toWidthPercent(),
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
