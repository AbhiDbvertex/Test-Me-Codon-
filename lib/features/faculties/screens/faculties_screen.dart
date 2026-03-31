import 'package:codon/features/faculties/controllers/faculties_controller.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class FacultiesScreen extends StatelessWidget {
  const FacultiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEDED), // Light grey background
      appBar: AppBar(
        title: Text(
          'Faculties',
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
      body: const FacultiesList(),
    );
  }
}

class FacultiesList extends StatelessWidget {
  const FacultiesList({super.key});

  @override
  Widget build(BuildContext context) {
    final FacultiesController controller = Get.find<FacultiesController>();

    return Column(
      children: [
        SizedBox(height: 0.02.toHeightPercent()),
        Expanded(
          child: FutureBuilder(
            future: controller.getFaculties(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 0.15.toWidthPercent(),
                        color: Colors.grey,
                      ),
                      SizedBox(height: 0.02.toHeightPercent()),
                      Text(
                        'Error loading faculties',
                        style: TextStyle(
                          fontSize: 0.04.toWidthPercent(),
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 0.01.toHeightPercent()),
                      Text(
                        '${snapshot.error}',
                        style: TextStyle(
                          fontSize: 0.035.toWidthPercent(),
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasData) {
                final faculties = snapshot.data!;
                if (faculties.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 0.15.toWidthPercent(),
                          color: Colors.grey,
                        ),
                        SizedBox(height: 0.02.toHeightPercent()),
                        Text(
                          "No Faculties Available",
                          style: TextStyle(
                            fontSize: 0.04.toWidthPercent(),
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.04.toWidthPercent(),
                    vertical: 0.02.toHeightPercent(),
                  ),
                  itemCount: faculties.length,
                  itemBuilder: (context, index) {
                    final faculty = faculties[index];
                    return _buildFacultyCard(faculty);
                  },
                );
              }
              return const Center(child: Text('No Faculties Available'));
            },
          ),
        ),
        SizedBox(height: 0.08.toHeightPercent()),
      ],
    );
  }

  Widget _buildFacultyCard(dynamic faculty) {
    print("dbkhdbadk ${baseUrl}/uploads/${faculty.image}");
    return Container(
      margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
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
          // TODO: Navigate to faculty detail screen when implemented
          Get.snackbar(
            'Faculty Selected',
            faculty.name,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.primary,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: EdgeInsets.all(0.04.toWidthPercent()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Faculty Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "${baseUrl}/uploads/${faculty.image}",
                  width: 0.2.toWidthPercent(),
                  height: 0.2.toWidthPercent(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 0.2.toWidthPercent(),
                      height: 0.2.toWidthPercent(),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.school_outlined,
                        color: AppColors.primary,
                        size: 0.1.toWidthPercent(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 0.04.toWidthPercent()),
              // Faculty Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Faculty Name
                    Text(
                      faculty.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 0.045.toWidthPercent(),
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 0.005.toHeightPercent()),
                    // Degree
                    Text(
                      faculty.degree,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 0.035.toWidthPercent(),
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 0.008.toHeightPercent()),
                    // Description
                    ExpandableDescription(description: faculty.description),
                  ],
                ),
              ),
              // Arrow Icon
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 0.04.toWidthPercent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableDescription extends StatefulWidget {
  final String description;
  const ExpandableDescription({super.key, required this.description});

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          maxLines: isExpanded ? 100 : 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 0.032.toWidthPercent(),
            color: Colors.grey[600],
            height: 1.3,
          ),
        ),
        if (widget.description.length > 60) // Show toggle only if text is long
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                isExpanded ? "See Less" : "See More",
                style: TextStyle(
                  fontSize: 0.032.toWidthPercent(),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
