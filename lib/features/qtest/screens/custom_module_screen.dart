import 'package:codon/features/pearls/models/subject_model.dart';
import 'package:codon/features/pearls/models/sub_subject_model.dart';
import 'package:codon/features/pearls/models/topic_model.dart';
import 'package:codon/features/qtest/models/tag_model.dart';
import 'package:codon/features/qtest/controllers/custom_module_controller.dart';
import 'package:codon/features/qtest/screens/custom_test_history_screen.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../pearls/models/Get_Chapters_Chapter_model.dart';

class CustomModuleScreen extends StatelessWidget {
  const CustomModuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomModuleController controller =
    Get.find<CustomModuleController>();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,     // Top status bar transparent
        statusBarIconBrightness: Brightness.dark, // Icons black rahe (light background ke liye)
        systemNavigationBarColor: Colors.transparent, // Bottom bar transparent
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        //appBar: const DefaultAppBar(title: 'Custom Module'),
        appBar: AppBar(
          title: Text(
            'Custom Module',
            style: TextStyle(
              fontSize: 0.05.toWidthPercent(),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Get.to(() => const CustomTestHistoryScreen()),
              icon: const Icon(Icons.history, color: Colors.black),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 0.02.toHeightPercent()),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(0.04.toWidthPercent()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDifficultySection(controller),
                    SizedBox(height: 0.03.toHeightPercent()),

                   /* // 1. Subject
                    Obx(
                          () => _buildSearchableDropdown(
                        title: 'Select Subject',
                        items: controller.subjects,
                        selectedValueId: controller.selectedSubjectId.value,
                        onSelected: controller.onSubjectSelected,
                        isLoading: controller.isLoadingSubjects.value,
                      ),
                    ),
                    SizedBox(height: 0.02.toHeightPercent()),

                    // 2. Sub Subject (only if subject selected)
                    Obx(() {
                      if (controller.selectedSubjectId.value.isEmpty) return const SizedBox.shrink();

                      return Column(
                        children: [
                          _buildSearchableDropdown(
                            title: 'Select Sub-Subject',
                            items: controller.subSubjects,
                            selectedValueId: controller.selectedSubSubjectId.value,
                            onSelected: controller.onSubSubjectSelected,
                            isLoading: controller.isLoadingSubSubjects.value,
                            isDisabled: controller.subSubjects.isEmpty,
                          ),
                          SizedBox(height: 0.02.toHeightPercent()),
                        ],
                      );
                    }),

                    // 3. Chapter (only if sub-subject selected)
                    Obx(() {
                      if (controller.selectedSubSubjectId.value.isEmpty) return const SizedBox.shrink();

                      return Column(
                        children: [
                          _buildSearchableDropdown(
                            title: 'Select Chapter',
                            items: controller.chapters,  // Now chapters list
                            selectedValueId: controller.selectedChapterId.value,
                            onSelected: controller.onChapterSelected,  // Now this fetches topics
                            isLoading: controller.isLoadingChapters.value,  // New loading for chapters
                            isDisabled: controller.chapters.isEmpty,
                          ),
                          SizedBox(height: 0.02.toHeightPercent()),
                        ],
                      );
                    }),
                    Obx(() {
                      if (controller.selectedChapterId.value.isEmpty) return const SizedBox.shrink();
                      print("Abhi:- selected chapterId: ${controller.selectedChapterId}");
                      return Column(
                        children: [
                          _buildSearchableDropdown(
                            title: 'Select Topic',
                            items: controller.topics,                     // ← topics list use karo (chapters nahi)
                            selectedValueId: controller.selectedTopicId.value,
                            onSelected: controller.onTopicSelected,       // ← alag function
                            isLoading: controller.isLoadingTopics.value,  // ← topic loading
                            isDisabled: controller.topics.isEmpty,
                          ),
                          SizedBox(height: 0.02.toHeightPercent()),
                        ],
                      );
                    }),

                    SizedBox(height: 0.03.toHeightPercent()),

                    // Tags (multi-select)
                    Obx(
                          () => _buildMultiSelectDropdown(
                        title: controller.selectedTagIds.isEmpty
                            ? 'Select Tags'
                            : controller.selectedTagsDisplay,
                        items: controller.tags,
                        selectedIds: controller.selectedTagIds,
                        onChanged: controller.toggleTag,
                        isLoading: controller.isLoadingTags.value,
                      ),
                    ),*/

                    // 1. Subject (No "All" option)
                    Obx(
                          () => _buildSearchableDropdown(
                        title: 'Select Subject',
                        items: controller.subjects,
                        selectedValueId: controller.selectedSubjectId.value,
                        onSelected: controller.onSubjectSelected,
                        isLoading: controller.isLoadingSubjects.value,
                        showAllOption: false,           // ← Subject ke liye All nahi
                      ),
                    ),
                    SizedBox(height: 0.02.toHeightPercent()),

                    // 2. Sub Subject
                    Obx(() {
                      if (controller.selectedSubjectId.value.isEmpty) return const SizedBox.shrink();

                      return Column(
                        children: [
                          _buildSearchableDropdown(
                            title: 'Select Sub-Subject',
                            items: controller.subSubjects,
                            selectedValueId: controller.selectedSubSubjectId.value,
                            onSelected: controller.onSubSubjectSelected,
                            isLoading: controller.isLoadingSubSubjects.value,
                            isDisabled: controller.subSubjects.isEmpty,
                            showAllOption: true,           // ← All option
                          ),
                          SizedBox(height: 0.02.toHeightPercent()),
                        ],
                      );
                    }),

                    // 3. Chapter
                    Obx(() {
                      if (controller.selectedSubSubjectId.value.isEmpty) return const SizedBox.shrink();

                      return Column(
                        children: [
                          _buildSearchableDropdown(
                            title: 'Select Chapter',
                            items: controller.chapters,
                            selectedValueId: controller.selectedChapterId.value,
                            onSelected: controller.onChapterSelected,
                            isLoading: controller.isLoadingChapters.value,
                            isDisabled: controller.chapters.isEmpty,
                            showAllOption: true,           // ← All option
                          ),
                          SizedBox(height: 0.02.toHeightPercent()),
                        ],
                      );
                    }),

                    // 4. Topic
                    Obx(() {
                      if (controller.selectedChapterId.value.isEmpty) return const SizedBox.shrink();

                      return Column(
                        children: [
                          _buildSearchableDropdown(
                            title: 'Select Topic',
                            items: controller.topics,
                            selectedValueId: controller.selectedTopicId.value,
                            onSelected: controller.onTopicSelected,
                            isLoading: controller.isLoadingTopics.value,
                            isDisabled: controller.topics.isEmpty,
                            showAllOption: true,           // ← All option
                          ),
                          SizedBox(height: 0.02.toHeightPercent()),
                        ],
                      );
                    }),

                    SizedBox(height: 0.03.toHeightPercent()),

                    // Tags (multi-select) - unchanged
                    Obx(
                          () => _buildMultiSelectDropdown(
                        title: controller.selectedTagIds.isEmpty
                            ? 'Select Tags'
                            : controller.selectedTagsDisplay,
                        items: controller.tags,
                        selectedIds: controller.selectedTagIds,
                        onChanged: controller.toggleTag,
                        isLoading: controller.isLoadingTags.value,
                      ),
                    ),

                    SizedBox(height: 0.03.toHeightPercent()),
                    _buildModeSection(controller),
                    SizedBox(height: 0.1.toHeightPercent()),
                    _buildActionButtons(controller),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultySection(CustomModuleController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Difficulty level',
          style: TextStyle(
            fontSize: 0.04.toWidthPercent(),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 0.015.toHeightPercent()),
        Container(
          padding: EdgeInsets.all(0.04.toWidthPercent()),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRadioButton(
                'All',
                'all',
                controller.difficultyLevel,
                    (val) => controller.setDifficulty(val),
              ),
              _buildRadioButton(
                'Easy',
                'easy',
                controller.difficultyLevel,
                    (val) => controller.setDifficulty(val),
              ),
              _buildRadioButton(
                'Medium',
                'medium',
                controller.difficultyLevel,
                    (val) => controller.setDifficulty(val),
              ),
              _buildRadioButton(
                'Hard',
                'hard',
                controller.difficultyLevel,
                    (val) => controller.setDifficulty(val),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModeSection(CustomModuleController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mode',
          style: TextStyle(
            fontSize: 0.04.toWidthPercent(),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 0.015.toHeightPercent()),
        Container(
          padding: EdgeInsets.all(0.04.toWidthPercent()),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildRadioButton(
                'Regular Mode',
                'reguler',
                controller.mode,
                    (val) => controller.setMode(val),
              ),
              SizedBox(width: 0.05.toWidthPercent()),
              _buildRadioButton(
                'Exam Mode',
                'exam',
                controller.mode,
                    (val) => controller.setMode(val),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButton(
      String label,
      String value,
      RxString groupValue,
      Function(String) onChanged,
      ) {
    return Obx(() {
      bool isSelected = groupValue.value == value;
      return GestureDetector(
        onTap: () => onChanged(value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 0.06.toWidthPercent(),
              height: 0.06.toWidthPercent(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.grey[300],
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                Icons.circle,
                color: Colors.white,
                size: 0.03.toWidthPercent(),
              )
                  : null,
            ),
            SizedBox(width: 0.02.toWidthPercent()),
            Text(
              label,
              style: TextStyle(
                fontSize: 0.035.toWidthPercent(),
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    });
  }

  // Widget _buildSearchableDropdown({
  //   required String title,
  //   required List<dynamic> items,
  //   required String selectedValueId,
  //   required Function(String?) onSelected,
  //   bool isLoading = false,
  //   bool isDisabled = false,
  // }) {
  //   return Opacity(
  //     opacity: isDisabled ? 0.5 : 1.0,
  //     child: Container(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: 0.05.toWidthPercent(),
  //         vertical: 0.015.toHeightPercent(),
  //       ),
  //       decoration: BoxDecoration(
  //         color: isDisabled ? Colors.grey[100] : Colors.white,
  //         borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
  //         boxShadow: isDisabled ? [] : [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.05),
  //             blurRadius: 10,
  //             offset: const Offset(0, 4),
  //           ),
  //         ],
  //       ),
  //       child: DropdownButtonHideUnderline(
  //         child: DropdownButton<String>(
  //           value: selectedValueId.isEmpty ? null : selectedValueId,
  //           hint: Text(
  //             title,
  //             style: TextStyle(
  //               fontSize: 0.04.toWidthPercent(),
  //               fontWeight: FontWeight.bold,
  //               color: isDisabled ? Colors.grey : Colors.black87,
  //             ),
  //           ),
  //           isExpanded: true,
  //           icon: isLoading
  //               ? SizedBox(
  //             width: 20,
  //             height: 20,
  //             child: CircularProgressIndicator(
  //               strokeWidth: 2,
  //               color: AppColors.primary,
  //             ),
  //           )
  //               : Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
  //           disabledHint: Text(title),
  //           onChanged: isDisabled || isLoading ? null : onSelected,
  //           items: items.map((item) {
  //             String id = '';
  //             String name = '';
  //             if (item is SubjectModel) {
  //               id = item.id;
  //               name = item.name;
  //             } else if (item is SubSubjectModel) {
  //               id = item.id;
  //               name = item.name;
  //             } else if (item is TopicModel) {
  //               id = item.id;
  //               name = item.name;
  //             } else if (item is GetChaptersChapterModel) {  // Updated for Chapter
  //               id = item.id;
  //               name = item.name;  // Assume name field exists
  //             } else if (item is CustomTestTagModel) {
  //               id = item.id;
  //               name = item.name;
  //             }
  //
  //             return DropdownMenuItem<String>(
  //               value: id,
  //               child: Text(
  //                 name,
  //                 style: TextStyle(fontSize: 0.035.toWidthPercent()),
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSearchableDropdown({
    required String title,
    required List<dynamic> items,
    required String selectedValueId,
    required Function(String?) onSelected,
    bool isLoading = false,
    bool isDisabled = false,
    bool showAllOption = true,           // ← New Parameter
  }) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0.05.toWidthPercent(),
          vertical: 0.015.toHeightPercent(),
        ),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[100] : Colors.white,
          borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
          boxShadow: isDisabled
              ? []
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValueId.isEmpty ? null : selectedValueId,
            hint: Text(
              title,
              style: TextStyle(
                fontSize: 0.04.toWidthPercent(),
                fontWeight: FontWeight.bold,
                color: isDisabled ? Colors.grey : Colors.black87,
              ),
            ),
            isExpanded: true,
            icon: isLoading
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
            )
                : const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
            disabledHint: Text(title),
            onChanged: isDisabled || isLoading ? null : onSelected,
            items: [
              // "All" Option (top pe)
              if (showAllOption)
                const DropdownMenuItem<String>(
                  value: "",           // empty string ko All maana hai
                  child: Text(
                    "All",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),

              // Actual Items
              ...items.map((item) {
                String id = '';
                String name = '';

                if (item is SubjectModel) {
                  id = item.id;
                  name = item.name;
                } else if (item is SubSubjectModel) {
                  id = item.id;
                  name = item.name;
                } else if (item is GetChaptersChapterModel) {
                  id = item.id;
                  name = item.name;
                } else if (item is TopicModel) {
                  id = item.id;
                  name = item.name;
                } else if (item is CustomTestTagModel) {
                  id = item.id;
                  name = item.name;
                }

                return DropdownMenuItem<String>(
                  value: id,
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 0.035.toWidthPercent()),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(CustomModuleController controller) {
    return Row(
      children: [
        Expanded(
          child: Obx(
                () => ElevatedButton(
              // onPressed: controller.isLoading.value
              //     ? null
              //     : controller.createCustomTest,
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: AppColors.primary,
              //   foregroundColor: Colors.white,
              //   padding: EdgeInsets.symmetric(
              //     vertical: 0.015.toHeightPercent(),
              //   ),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
              //   ),
              // ),
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                Get.dialog(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: const Text("Create New Custom Test"),
                    content: const Text(
                      "Your previous custom test will be discarded. "
                          "Do you want to continue?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back(); // close dialog
                          controller.createCustomTest();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text("Continue"),
                      ),
                    ],
                  ),
                );
              },
              child: controller.isLoading.value
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : Text(
                'Submit',
                style: TextStyle(
                  fontSize: 0.045.toWidthPercent(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 0.04.toWidthPercent()),
        Expanded(
          child: OutlinedButton(
            onPressed: controller.cancel,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary),
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 0.015.toHeightPercent()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
              ),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 0.045.toWidthPercent(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultiSelectDropdown({
    required String title,
    required List<CustomTestTagModel> items,
    required List<String> selectedIds,
    required Function(String) onChanged,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (isLoading || items.isEmpty) return;

        // Bilkul dropdown ki tarah menu dikhane ke liye dialog
        showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Select Tags",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 0.045.toWidthPercent(),
                    ),
                  ),
                ),
                const Divider(),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 0.4.toHeightPercent()),
                  child: StatefulBuilder(
                    builder: (context, setDialogState) {
                      return SingleChildScrollView(
                        child: Column(
                          children: items.map((tag) {
                            final isSelected = selectedIds.contains(tag.id);
                            return CheckboxListTile(
                              title: Text(
                                tag.name,
                                style: TextStyle(
                                  fontSize: 0.038.toWidthPercent(),
                                ),
                              ),
                              value: isSelected,
                              activeColor: AppColors.primary,
                              dense: true,
                              onChanged: (val) {
                                onChanged(tag.id);
                                setDialogState(
                                      () {},
                                ); // Turant tick/untick karne ke liye
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Done",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      // YE WAHI CONTAINER HAI JO SUBJECT DROPDOWN MEIN THA
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0.05.toWidthPercent(),
          vertical: 0.015.toHeightPercent(),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedIds.isEmpty
                    ? title
                    : "Tags Selected (${selectedIds.length})",
                style: TextStyle(
                  fontSize: 0.04.toWidthPercent(),
                  fontWeight: FontWeight.bold,
                  color: selectedIds.isEmpty
                      ? Colors.black87
                      : AppColors.primary,
                ),
              ),
            ),
            isLoading
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}