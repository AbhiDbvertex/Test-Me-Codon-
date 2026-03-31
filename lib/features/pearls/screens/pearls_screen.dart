import 'package:codon/features/faculties/screens/faculties_screen.dart';
import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/pearls/screens/sub_subjects.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class PearlsScreen extends StatelessWidget {
  const PearlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PearlsController controller = Get.find<PearlsController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFEFEDED), // Light grey background
        appBar: AppBar(
          title: Text(
            'Codon',
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
          bottom: TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontSize: 0.04.toWidthPercent(),
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(text: 'Codon'),
              Tab(text: 'Faculties'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Pearls Tab
            Column(
              children: [
                SizedBox(height: 0.02.toHeightPercent()),
                Expanded(
                  child: FutureBuilder(
                    future: controller.getSubjects(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
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
            // Faculties Tab
            const FacultiesList(),
          ],
        ),
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
          Get.to(() => SubSubjectsScreen(subject: subject));
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
