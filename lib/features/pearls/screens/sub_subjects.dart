import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/pearls/models/subject_model.dart';
import 'package:codon/features/pearls/screens/chapters_screen.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class SubSubjectsScreen extends StatelessWidget {
  final SubjectModel subject;
  const SubSubjectsScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final PearlsController controller = Get.find<PearlsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFEFEDED),
      appBar: DefaultAppBar(title: subject.name),
      body: Column(
        children: [
          SizedBox(height: 0.02.toHeightPercent()),
          Expanded(
            child: FutureBuilder(
              future: controller.getSubSubjects(subject.id),
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
                  final subSubjects = snapshot.data!;
                  if (subSubjects.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Sub-Subjects Found",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.04.toWidthPercent(),
                      vertical: 0.02.toHeightPercent(),
                    ),
                    itemCount: subSubjects.length,
                    itemBuilder: (context, index) {
                      final subSubject = subSubjects[index];
                      return _buildSubSubjectCard(subSubject);
                    },
                  );
                }
                return const Center(child: Text('No Sub-Subjects Available'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubSubjectCard(dynamic subSubject) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.01.toHeightPercent()),
      padding: EdgeInsets.symmetric(vertical: 0.015.toHeightPercent()),
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
        onTap: () => Get.to(() => ChaptersScreen(subSubject: subSubject)),
        child: ListTile(
          title: Text(
            subSubject.name ?? 'N/A',
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
          //     '${subSubject.id.trim()}',
          //     style: TextStyle(
          //       fontSize: 0.034.toWidthPercent(),
          //       fontWeight: FontWeight.w600,
          //       color: Colors.black45,
          //     ),
          //   ),
          // ),
          trailing: const Icon(Icons.arrow_forward, color: Color(0xFFE0E0E0)),
        ),
      ),
    );
  }
}
