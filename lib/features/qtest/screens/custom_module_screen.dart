// // import 'package:codon/features/pearls/models/subject_model.dart';
// // import 'package:codon/features/pearls/models/sub_subject_model.dart';
// // import 'package:codon/features/pearls/models/topic_model.dart';
// // import 'package:codon/features/qtest/models/tag_model.dart';
// // import 'package:codon/features/qtest/controllers/custom_module_controller.dart';
// // import 'package:codon/features/qtest/screens/custom_test_history_screen.dart';
// // import 'package:codon/utills/app_theme.dart';
// // import 'package:codon/utills/screen_size_utils.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';

// // import '../../pearls/models/Get_Chapters_Chapter_model.dart';

// // class CustomModuleScreen extends StatelessWidget {
// //   const CustomModuleScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final CustomModuleController controller =
// //     Get.find<CustomModuleController>();
// //     SystemChrome.setSystemUIOverlayStyle(
// //       const SystemUiOverlayStyle(
// //         statusBarColor: Colors.transparent,     // Top status bar transparent
// //         statusBarIconBrightness: Brightness.dark, // Icons black rahe (light background ke liye)
// //         systemNavigationBarColor: Colors.transparent, // Bottom bar transparent
// //         systemNavigationBarIconBrightness: Brightness.dark,
// //       ),
// //     );
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: Colors.white,
// //         //appBar: const DefaultAppBar(title: 'Custom Module'),
// //         appBar: AppBar(
// //           title: Text(
// //             'Custom Module',
// //             style: TextStyle(
// //               fontSize: 0.05.toWidthPercent(),
// //               fontWeight: FontWeight.bold,
// //               color: Colors.black,
// //             ),
// //           ),
// //           centerTitle: true,
// //           backgroundColor: Colors.white,
// //           elevation: 0,
// //           automaticallyImplyLeading: false,
// //           actions: [
// //             IconButton(
// //               onPressed: () => Get.to(() => const CustomTestHistoryScreen()),
// //               icon: const Icon(Icons.history, color: Colors.black),
// //             ),
// //           ],
// //         ),
// //         body: Column(
// //           children: [
// //             SizedBox(height: 0.02.toHeightPercent()),
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 padding: EdgeInsets.all(0.04.toWidthPercent()),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     _buildDifficultySection(controller),
// //                     SizedBox(height: 0.03.toHeightPercent()),

// //                    /* // 1. Subject
// //                     Obx(
// //                           () => _buildSearchableDropdown(
// //                         title: 'Select Subject',
// //                         items: controller.subjects,
// //                         selectedValueId: controller.selectedSubjectId.value,
// //                         onSelected: controller.onSubjectSelected,
// //                         isLoading: controller.isLoadingSubjects.value,
// //                       ),
// //                     ),
// //                     SizedBox(height: 0.02.toHeightPercent()),

// //                     // 2. Sub Subject (only if subject selected)
// //                     Obx(() {
// //                       if (controller.selectedSubjectId.value.isEmpty) return const SizedBox.shrink();

// //                       return Column(
// //                         children: [
// //                           _buildSearchableDropdown(
// //                             title: 'Select Sub-Subject',
// //                             items: controller.subSubjects,
// //                             selectedValueId: controller.selectedSubSubjectId.value,
// //                             onSelected: controller.onSubSubjectSelected,
// //                             isLoading: controller.isLoadingSubSubjects.value,
// //                             isDisabled: controller.subSubjects.isEmpty,
// //                           ),
// //                           SizedBox(height: 0.02.toHeightPercent()),
// //                         ],
// //                       );
// //                     }),

// //                     // 3. Chapter (only if sub-subject selected)
// //                     Obx(() {
// //                       if (controller.selectedSubSubjectId.value.isEmpty) return const SizedBox.shrink();

// //                       return Column(
// //                         children: [
// //                           _buildSearchableDropdown(
// //                             title: 'Select Chapter',
// //                             items: controller.chapters,  // Now chapters list
// //                             selectedValueId: controller.selectedChapterId.value,
// //                             onSelected: controller.onChapterSelected,  // Now this fetches topics
// //                             isLoading: controller.isLoadingChapters.value,  // New loading for chapters
// //                             isDisabled: controller.chapters.isEmpty,
// //                           ),
// //                           SizedBox(height: 0.02.toHeightPercent()),
// //                         ],
// //                       );
// //                     }),
// //                     Obx(() {
// //                       if (controller.selectedChapterId.value.isEmpty) return const SizedBox.shrink();
// //                       print("Abhi:- selected chapterId: ${controller.selectedChapterId}");
// //                       return Column(
// //                         children: [
// //                           _buildSearchableDropdown(
// //                             title: 'Select Topic',
// //                             items: controller.topics,                     // ← topics list use karo (chapters nahi)
// //                             selectedValueId: controller.selectedTopicId.value,
// //                             onSelected: controller.onTopicSelected,       // ← alag function
// //                             isLoading: controller.isLoadingTopics.value,  // ← topic loading
// //                             isDisabled: controller.topics.isEmpty,
// //                           ),
// //                           SizedBox(height: 0.02.toHeightPercent()),
// //                         ],
// //                       );
// //                     }),

// //                     SizedBox(height: 0.03.toHeightPercent()),

// //                     // Tags (multi-select)
// //                     Obx(
// //                           () => _buildMultiSelectDropdown(
// //                         title: controller.selectedTagIds.isEmpty
// //                             ? 'Select Tags'
// //                             : controller.selectedTagsDisplay,
// //                         items: controller.tags,
// //                         selectedIds: controller.selectedTagIds,
// //                         onChanged: controller.toggleTag,
// //                         isLoading: controller.isLoadingTags.value,
// //                       ),
// //                     ),*/

// //                     // 1. Subject (No "All" option)
// //                     Obx(
// //                           () => _buildSearchableDropdown(
// //                         title: 'Select Subject',
// //                         items: controller.subjects,
// //                         selectedValueId: controller.selectedSubjectId.value,
// //                         onSelected: controller.onSubjectSelected,
// //                         isLoading: controller.isLoadingSubjects.value,
// //                         showAllOption: false,           // ← Subject ke liye All nahi
// //                       ),
// //                     ),
// //                     SizedBox(height: 0.02.toHeightPercent()),

// //                     // 2. Sub Subject
// //                     Obx(() {
// //                       if (controller.selectedSubjectId.value.isEmpty) return const SizedBox.shrink();

// //                       return Column(
// //                         children: [
// //                           _buildSearchableDropdown(
// //                             title: 'Select Sub-Subject',
// //                             items: controller.subSubjects,
// //                             selectedValueId: controller.selectedSubSubjectId.value,
// //                             onSelected: controller.onSubSubjectSelected,
// //                             isLoading: controller.isLoadingSubSubjects.value,
// //                             isDisabled: controller.subSubjects.isEmpty,
// //                             showAllOption: true,           // ← All option
// //                           ),
// //                           SizedBox(height: 0.02.toHeightPercent()),
// //                         ],
// //                       );
// //                     }),

// //                     // 3. Chapter
// //                     Obx(() {
// //                       if (controller.selectedSubSubjectId.value.isEmpty) return const SizedBox.shrink();

// //                       return Column(
// //                         children: [
// //                           _buildSearchableDropdown(
// //                             title: 'Select Chapter',
// //                             items: controller.chapters,
// //                             selectedValueId: controller.selectedChapterId.value,
// //                             onSelected: controller.onChapterSelected,
// //                             isLoading: controller.isLoadingChapters.value,
// //                             isDisabled: controller.chapters.isEmpty,
// //                             showAllOption: true,           // ← All option
// //                           ),
// //                           SizedBox(height: 0.02.toHeightPercent()),
// //                         ],
// //                       );
// //                     }),

// //                     // 4. Topic
// //                     Obx(() {
// //                       if (controller.selectedChapterId.value.isEmpty) return const SizedBox.shrink();

// //                       return Column(
// //                         children: [
// //                           _buildSearchableDropdown(
// //                             title: 'Select Topic',
// //                             items: controller.topics,
// //                             selectedValueId: controller.selectedTopicId.value,
// //                             onSelected: controller.onTopicSelected,
// //                             isLoading: controller.isLoadingTopics.value,
// //                             isDisabled: controller.topics.isEmpty,
// //                             showAllOption: true,           // ← All option
// //                           ),
// //                           SizedBox(height: 0.02.toHeightPercent()),
// //                         ],
// //                       );
// //                     }),

// //                     SizedBox(height: 0.03.toHeightPercent()),

// //                     // Tags (multi-select) - unchanged
// //                     Obx(
// //                           () => _buildMultiSelectDropdown(
// //                         title: controller.selectedTagIds.isEmpty
// //                             ? 'Select Tags'
// //                             : controller.selectedTagsDisplay,
// //                         items: controller.tags,
// //                         selectedIds: controller.selectedTagIds,
// //                         onChanged: controller.toggleTag,
// //                         isLoading: controller.isLoadingTags.value,
// //                       ),
// //                     ),

// //                     SizedBox(height: 0.03.toHeightPercent()),
// //                     _buildModeSection(controller),
// //                     SizedBox(height: 0.1.toHeightPercent()),
// //                     _buildActionButtons(controller),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDifficultySection(CustomModuleController controller) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           'Difficulty level',
// //           style: TextStyle(
// //             fontSize: 0.04.toWidthPercent(),
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         SizedBox(height: 0.015.toHeightPercent()),
// //         Container(
// //           padding: EdgeInsets.all(0.04.toWidthPercent()),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.05),
// //                 blurRadius: 10,
// //                 offset: const Offset(0, 4),
// //               ),
// //             ],
// //           ),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               _buildRadioButton(
// //                 'All',
// //                 'all',
// //                 controller.difficultyLevel,
// //                     (val) => controller.setDifficulty(val),
// //               ),
// //               _buildRadioButton(
// //                 'Easy',
// //                 'easy',
// //                 controller.difficultyLevel,
// //                     (val) => controller.setDifficulty(val),
// //               ),
// //               _buildRadioButton(
// //                 'Medium',
// //                 'medium',
// //                 controller.difficultyLevel,
// //                     (val) => controller.setDifficulty(val),
// //               ),
// //               _buildRadioButton(
// //                 'Hard',
// //                 'hard',
// //                 controller.difficultyLevel,
// //                     (val) => controller.setDifficulty(val),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildModeSection(CustomModuleController controller) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           'Mode',
// //           style: TextStyle(
// //             fontSize: 0.04.toWidthPercent(),
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         SizedBox(height: 0.015.toHeightPercent()),
// //         Container(
// //           padding: EdgeInsets.all(0.04.toWidthPercent()),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.05),
// //                 blurRadius: 10,
// //                 offset: const Offset(0, 4),
// //               ),
// //             ],
// //           ),
// //           child: Row(
// //             children: [
// //               _buildRadioButton(
// //                 'Regular Mode',
// //                 'reguler',
// //                 controller.mode,
// //                     (val) => controller.setMode(val),
// //               ),
// //               SizedBox(width: 0.05.toWidthPercent()),
// //               _buildRadioButton(
// //                 'Exam Mode',
// //                 'exam',
// //                 controller.mode,
// //                     (val) => controller.setMode(val),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildRadioButton(
// //       String label,
// //       String value,
// //       RxString groupValue,
// //       Function(String) onChanged,
// //       ) {
// //     return Obx(() {
// //       bool isSelected = groupValue.value == value;
// //       return GestureDetector(
// //         onTap: () => onChanged(value),
// //         child: Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Container(
// //               width: 0.06.toWidthPercent(),
// //               height: 0.06.toWidthPercent(),
// //               decoration: BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 color: isSelected ? AppColors.primary : Colors.grey[300],
// //                 border: Border.all(
// //                   color: isSelected ? AppColors.primary : Colors.grey[400]!,
// //                   width: 2,
// //                 ),
// //               ),
// //               child: isSelected
// //                   ? Icon(
// //                 Icons.circle,
// //                 color: Colors.white,
// //                 size: 0.03.toWidthPercent(),
// //               )
// //                   : null,
// //             ),
// //             SizedBox(width: 0.02.toWidthPercent()),
// //             Text(
// //               label,
// //               style: TextStyle(
// //                 fontSize: 0.035.toWidthPercent(),
// //                 color: Colors.black87,
// //                 fontWeight: FontWeight.w500,
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     });
// //   }

// //   // Widget _buildSearchableDropdown({
// //   //   required String title,
// //   //   required List<dynamic> items,
// //   //   required String selectedValueId,
// //   //   required Function(String?) onSelected,
// //   //   bool isLoading = false,
// //   //   bool isDisabled = false,
// //   // }) {
// //   //   return Opacity(
// //   //     opacity: isDisabled ? 0.5 : 1.0,
// //   //     child: Container(
// //   //       padding: EdgeInsets.symmetric(
// //   //         horizontal: 0.05.toWidthPercent(),
// //   //         vertical: 0.015.toHeightPercent(),
// //   //       ),
// //   //       decoration: BoxDecoration(
// //   //         color: isDisabled ? Colors.grey[100] : Colors.white,
// //   //         borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
// //   //         boxShadow: isDisabled ? [] : [
// //   //           BoxShadow(
// //   //             color: Colors.black.withOpacity(0.05),
// //   //             blurRadius: 10,
// //   //             offset: const Offset(0, 4),
// //   //           ),
// //   //         ],
// //   //       ),
// //   //       child: DropdownButtonHideUnderline(
// //   //         child: DropdownButton<String>(
// //   //           value: selectedValueId.isEmpty ? null : selectedValueId,
// //   //           hint: Text(
// //   //             title,
// //   //             style: TextStyle(
// //   //               fontSize: 0.04.toWidthPercent(),
// //   //               fontWeight: FontWeight.bold,
// //   //               color: isDisabled ? Colors.grey : Colors.black87,
// //   //             ),
// //   //           ),
// //   //           isExpanded: true,
// //   //           icon: isLoading
// //   //               ? SizedBox(
// //   //             width: 20,
// //   //             height: 20,
// //   //             child: CircularProgressIndicator(
// //   //               strokeWidth: 2,
// //   //               color: AppColors.primary,
// //   //             ),
// //   //           )
// //   //               : Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
// //   //           disabledHint: Text(title),
// //   //           onChanged: isDisabled || isLoading ? null : onSelected,
// //   //           items: items.map((item) {
// //   //             String id = '';
// //   //             String name = '';
// //   //             if (item is SubjectModel) {
// //   //               id = item.id;
// //   //               name = item.name;
// //   //             } else if (item is SubSubjectModel) {
// //   //               id = item.id;
// //   //               name = item.name;
// //   //             } else if (item is TopicModel) {
// //   //               id = item.id;
// //   //               name = item.name;
// //   //             } else if (item is GetChaptersChapterModel) {  // Updated for Chapter
// //   //               id = item.id;
// //   //               name = item.name;  // Assume name field exists
// //   //             } else if (item is CustomTestTagModel) {
// //   //               id = item.id;
// //   //               name = item.name;
// //   //             }
// //   //
// //   //             return DropdownMenuItem<String>(
// //   //               value: id,
// //   //               child: Text(
// //   //                 name,
// //   //                 style: TextStyle(fontSize: 0.035.toWidthPercent()),
// //   //               ),
// //   //             );
// //   //           }).toList(),
// //   //         ),
// //   //       ),
// //   //     ),
// //   //   );
// //   // }

// //   Widget _buildSearchableDropdown({
// //     required String title,
// //     required List<dynamic> items,
// //     required String selectedValueId,
// //     required Function(String?) onSelected,
// //     bool isLoading = false,
// //     bool isDisabled = false,
// //     bool showAllOption = true,           // ← New Parameter
// //   }) {
// //     return Opacity(
// //       opacity: isDisabled ? 0.5 : 1.0,
// //       child: Container(
// //         padding: EdgeInsets.symmetric(
// //           horizontal: 0.05.toWidthPercent(),
// //           vertical: 0.015.toHeightPercent(),
// //         ),
// //         decoration: BoxDecoration(
// //           color: isDisabled ? Colors.grey[100] : Colors.white,
// //           borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
// //           boxShadow: isDisabled
// //               ? []
// //               : [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.05),
// //               blurRadius: 10,
// //               offset: const Offset(0, 4),
// //             ),
// //           ],
// //         ),
// //         child: DropdownButtonHideUnderline(
// //           child: DropdownButton<String>(
// //             value: selectedValueId.isEmpty ? null : selectedValueId,
// //             hint: Text(
// //               title,
// //               style: TextStyle(
// //                 fontSize: 0.04.toWidthPercent(),
// //                 fontWeight: FontWeight.bold,
// //                 color: isDisabled ? Colors.grey : Colors.black87,
// //               ),
// //             ),
// //             isExpanded: true,
// //             icon: isLoading
// //                 ? const SizedBox(
// //               width: 20,
// //               height: 20,
// //               child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
// //             )
// //                 : const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
// //             disabledHint: Text(title),
// //             onChanged: isDisabled || isLoading ? null : onSelected,
// //             items: [
// //               // "All" Option (top pe)
// //               if (showAllOption)
// //                 const DropdownMenuItem<String>(
// //                   value: "",           // empty string ko All maana hai
// //                   child: Text(
// //                     "All",
// //                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
// //                   ),
// //                 ),

// //               // Actual Items
// //               ...items.map((item) {
// //                 String id = '';
// //                 String name = '';

// //                 if (item is SubjectModel) {
// //                   id = item.id;
// //                   name = item.name;
// //                 } else if (item is SubSubjectModel) {
// //                   id = item.id;
// //                   name = item.name;
// //                 } else if (item is GetChaptersChapterModel) {
// //                   id = item.id;
// //                   name = item.name;
// //                 } else if (item is TopicModel) {
// //                   id = item.id;
// //                   name = item.name;
// //                 } else if (item is CustomTestTagModel) {
// //                   id = item.id;
// //                   name = item.name;
// //                 }

// //                 return DropdownMenuItem<String>(
// //                   value: id,
// //                   child: Text(
// //                     name,
// //                     style: TextStyle(fontSize: 0.035.toWidthPercent()),
// //                   ),
// //                 );
// //               }).toList(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildActionButtons(CustomModuleController controller) {
// //     return Row(
// //       children: [
// //         Expanded(
// //           child: Obx(
// //                 () => ElevatedButton(
// //               // onPressed: controller.isLoading.value
// //               //     ? null
// //               //     : controller.createCustomTest,
// //               // style: ElevatedButton.styleFrom(
// //               //   backgroundColor: AppColors.primary,
// //               //   foregroundColor: Colors.white,
// //               //   padding: EdgeInsets.symmetric(
// //               //     vertical: 0.015.toHeightPercent(),
// //               //   ),
// //               //   shape: RoundedRectangleBorder(
// //               //     borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
// //               //   ),
// //               // ),
// //               onPressed: controller.isLoading.value
// //                   ? null
// //                   : () {
// //                 Get.dialog(
// //                   AlertDialog(
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     title: const Text("Create New Custom Test"),
// //                     content: const Text(
// //                       "Your previous custom test will be discarded. "
// //                           "Do you want to continue?",
// //                     ),
// //                     actions: [
// //                       TextButton(
// //                         onPressed: () => Get.back(),
// //                         child: const Text("Cancel"),
// //                       ),
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           Get.back(); // close dialog
// //                           controller.createCustomTest();
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: AppColors.primary,
// //                         ),
// //                         child: const Text("Continue"),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               },
// //               child: controller.isLoading.value
// //                   ? const SizedBox(
// //                 height: 20,
// //                 width: 20,
// //                 child: CircularProgressIndicator(
// //                   color: Colors.white,
// //                   strokeWidth: 2,
// //                 ),
// //               )
// //                   : Text(
// //                 'Submit',
// //                 style: TextStyle(
// //                   fontSize: 0.045.toWidthPercent(),
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //         SizedBox(width: 0.04.toWidthPercent()),
// //         Expanded(
// //           child: OutlinedButton(
// //             onPressed: controller.cancel,
// //             style: OutlinedButton.styleFrom(
// //               side: BorderSide(color: AppColors.primary),
// //               foregroundColor: Colors.black,
// //               padding: EdgeInsets.symmetric(vertical: 0.015.toHeightPercent()),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
// //               ),
// //             ),
// //             child: Text(
// //               'Cancel',
// //               style: TextStyle(
// //                 fontSize: 0.045.toWidthPercent(),
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildMultiSelectDropdown({
// //     required String title,
// //     required List<CustomTestTagModel> items,
// //     required List<String> selectedIds,
// //     required Function(String) onChanged,
// //     bool isLoading = false,
// //   }) {
// //     return GestureDetector(
// //       onTap: () {
// //         if (isLoading || items.isEmpty) return;

// //         // Bilkul dropdown ki tarah menu dikhane ke liye dialog
// //         showDialog(
// //           context: Get.context!,
// //           builder: (context) => AlertDialog(
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(15),
// //             ),
// //             contentPadding: const EdgeInsets.symmetric(vertical: 10),
// //             content: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(12.0),
// //                   child: Text(
// //                     "Select Tags",
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 0.045.toWidthPercent(),
// //                     ),
// //                   ),
// //                 ),
// //                 const Divider(),
// //                 ConstrainedBox(
// //                   constraints: BoxConstraints(maxHeight: 0.4.toHeightPercent()),
// //                   child: StatefulBuilder(
// //                     builder: (context, setDialogState) {
// //                       return SingleChildScrollView(
// //                         child: Column(
// //                           children: items.map((tag) {
// //                             final isSelected = selectedIds.contains(tag.id);
// //                             return CheckboxListTile(
// //                               title: Text(
// //                                 tag.name,
// //                                 style: TextStyle(
// //                                   fontSize: 0.038.toWidthPercent(),
// //                                 ),
// //                               ),
// //                               value: isSelected,
// //                               activeColor: AppColors.primary,
// //                               dense: true,
// //                               onChanged: (val) {
// //                                 onChanged(tag.id);
// //                                 setDialogState(
// //                                       () {},
// //                                 ); // Turant tick/untick karne ke liye
// //                               },
// //                               controlAffinity: ListTileControlAffinity.leading,
// //                             );
// //                           }).toList(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //                 const Divider(),
// //                 TextButton(
// //                   onPressed: () => Get.back(),
// //                   child: Text(
// //                     "Done",
// //                     style: TextStyle(
// //                       color: AppColors.primary,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //       // YE WAHI CONTAINER HAI JO SUBJECT DROPDOWN MEIN THA
// //       child: Container(
// //         padding: EdgeInsets.symmetric(
// //           horizontal: 0.05.toWidthPercent(),
// //           vertical: 0.015.toHeightPercent(),
// //         ),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.05),
// //               blurRadius: 10,
// //               offset: const Offset(0, 4),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Expanded(
// //               child: Text(
// //                 selectedIds.isEmpty
// //                     ? title
// //                     : "Tags Selected (${selectedIds.length})",
// //                 style: TextStyle(
// //                   fontSize: 0.04.toWidthPercent(),
// //                   fontWeight: FontWeight.bold,
// //                   color: selectedIds.isEmpty
// //                       ? Colors.black87
// //                       : AppColors.primary,
// //                 ),
// //               ),
// //             ),
// //             isLoading
// //                 ? const SizedBox(
// //               width: 20,
// //               height: 20,
// //               child: CircularProgressIndicator(strokeWidth: 2),
// //             )
// //                 : Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // import 'package:codon/features/pearls/models/subject_model.dart';
// // import 'package:codon/features/pearls/models/sub_subject_model.dart';
// // import 'package:codon/features/pearls/models/topic_model.dart';
// // import 'package:codon/features/qtest/models/tag_model.dart';
// // import 'package:codon/features/qtest/controllers/custom_module_controller.dart';
// // import 'package:codon/features/qtest/screens/custom_test_history_screen.dart';
// // import 'package:codon/utills/app_theme.dart';
// // import 'package:codon/utills/screen_size_utils.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';

// // import '../../pearls/models/Get_Chapters_Chapter_model.dart';

// // class CustomModuleScreen extends StatelessWidget {
// //   const CustomModuleScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final CustomModuleController controller =
// //         Get.find<CustomModuleController>();

// //     SystemChrome.setSystemUIOverlayStyle(
// //       const SystemUiOverlayStyle(
// //         statusBarColor: Colors.transparent,
// //         statusBarIconBrightness: Brightness.dark,
// //         systemNavigationBarColor: Colors.transparent,
// //         systemNavigationBarIconBrightness: Brightness.dark,
// //       ),
// //     );

// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: Colors.white,
// //         appBar: AppBar(
// //           title: Text(
// //             'Custom Module',
// //             style: TextStyle(
// //               fontSize: 0.05.toWidthPercent(),
// //               fontWeight: FontWeight.bold,
// //               color: Colors.black,
// //             ),
// //           ),
// //           centerTitle: true,
// //           backgroundColor: Colors.white,
// //           elevation: 0,
// //           automaticallyImplyLeading: false,
// //           actions: [
// //             IconButton(
// //               onPressed: () => Get.to(() => const CustomTestHistoryScreen()),
// //               icon: const Icon(Icons.history, color: Colors.black),
// //             ),
// //           ],
// //         ),
// //         body: Column(
// //           children: [
// //             SizedBox(height: 0.02.toHeightPercent()),
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 padding: EdgeInsets.all(0.04.toWidthPercent()),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // Difficulty
// //                     _buildDifficultySection(controller),
// //                     SizedBox(height: 0.03.toHeightPercent()),

// //                     // Subject
// //                     Obx(
// //                       () => _buildSearchableDropdown(
// //                         title: 'Select Subject',
// //                         items: controller.subjects,
// //                         selectedValueId: controller.selectedSubjectId.value,
// //                         onSelected: controller.onSubjectSelected,
// //                         isLoading: controller.isLoadingSubjects.value,
// //                         showAllOption: false,
// //                       ),
// //                     ),
// //                     SizedBox(height: 0.02.toHeightPercent()),

// //                     // Sub Subject
// //                     Obx(() {
// //                       if (controller.selectedSubjectId.value.isEmpty)
// //                         return const SizedBox.shrink();
// //                       return Column(
// //                         children: [
// //                           _buildSearchableDropdown(
// //                             title: 'Select Sub-Subject',
// //                             items: controller.subSubjects,
// //                             selectedValueId:
// //                                 controller.selectedSubSubjectId.value,
// //                             onSelected: controller.onSubSubjectSelected,
// //                             isLoading: controller.isLoadingSubSubjects.value,
// //                             isDisabled: controller.subSubjects.isEmpty,
// //                             showAllOption: true,
// //                           ),
// //                           SizedBox(height: 0.02.toHeightPercent()),
// //                         ],
// //                       );
// //                     }),

// //                     // Chapter — multi-select
// //                     Obx(() {
// //                       if (controller.selectedSubSubjectId.value.isEmpty)
// //                         return const SizedBox.shrink();
// //                       return Column(
// //                         children: [
// //                           _buildMultiSelectExpander(
// //                             title: 'Select Chapter',
// //                             items: controller.chapters,
// //                             selectedIds: controller.selectedChapterIds,
// //                             getId: (c) => (c as GetChaptersChapterModel).id,
// //                             getName: (c) => (c as GetChaptersChapterModel).name,
// //                             onToggle: controller.toggleChapter,
// //                             isLoading: controller.isLoadingChapters.value,
// //                             isDisabled:
// //                                 controller.chapters.isEmpty &&
// //                                 !controller.isLoadingChapters.value,
// //                           ),
// //                           SizedBox(height: 0.02.toHeightPercent()),
// //                         ],
// //                       );
// //                     }),

// //                     // Topic — multi-select
// //                     Obx(() {
// //                       if (controller.selectedChapterIds.isEmpty)
// //                         return const SizedBox.shrink();
// //                       return Column(
// //                         children: [
// //                           _buildMultiSelectExpander(
// //                             title: 'Select Topic',
// //                             items: controller.topics,
// //                             selectedIds: controller.selectedTopicIds,
// //                             getId: (t) => (t as TopicModel).id,
// //                             getName: (t) => (t as TopicModel).name,
// //                             onToggle: controller.toggleTopic,
// //                             isLoading: controller.isLoadingTopics.value,
// //                             isDisabled:
// //                                 controller.topics.isEmpty &&
// //                                 !controller.isLoadingTopics.value,
// //                           ),
// //                           SizedBox(height: 0.02.toHeightPercent()),
// //                         ],
// //                       );
// //                     }),

// //                     SizedBox(height: 0.03.toHeightPercent()),

// //                     // Tags
// //                     Obx(
// //                       () => _buildMultiSelectDropdown(
// //                         title: controller.selectedTagIds.isEmpty
// //                             ? 'Select Tags'
// //                             : controller.selectedTagsDisplay,
// //                         items: controller.tags,
// //                         selectedIds: controller.selectedTagIds,
// //                         onChanged: controller.toggleTag,
// //                         isLoading: controller.isLoadingTags.value,
// //                       ),
// //                     ),

// //                     SizedBox(height: 0.03.toHeightPercent()),
// //                     _buildModeSection(controller),
// //                     SizedBox(height: 0.1.toHeightPercent()),
// //                     _buildActionButtons(controller),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ─── Difficulty ───────────────────────────────────────────────────────────

// //   Widget _buildDifficultySection(CustomModuleController controller) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           'Difficulty level',
// //           style: TextStyle(
// //             fontSize: 0.04.toWidthPercent(),
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         SizedBox(height: 0.015.toHeightPercent()),
// //         Container(
// //           padding: EdgeInsets.all(0.04.toWidthPercent()),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.05),
// //                 blurRadius: 10,
// //                 offset: const Offset(0, 4),
// //               ),
// //             ],
// //           ),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               _buildRadioButton(
// //                 'All',
// //                 'all',
// //                 controller.difficultyLevel,
// //                 controller.setDifficulty,
// //               ),
// //               _buildRadioButton(
// //                 'Easy',
// //                 'easy',
// //                 controller.difficultyLevel,
// //                 controller.setDifficulty,
// //               ),
// //               _buildRadioButton(
// //                 'Medium',
// //                 'medium',
// //                 controller.difficultyLevel,
// //                 controller.setDifficulty,
// //               ),
// //               _buildRadioButton(
// //                 'Hard',
// //                 'hard',
// //                 controller.difficultyLevel,
// //                 controller.setDifficulty,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   // ─── Mode ─────────────────────────────────────────────────────────────────

// //   Widget _buildModeSection(CustomModuleController controller) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           'Mode',
// //           style: TextStyle(
// //             fontSize: 0.04.toWidthPercent(),
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         SizedBox(height: 0.015.toHeightPercent()),
// //         Container(
// //           padding: EdgeInsets.all(0.04.toWidthPercent()),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.05),
// //                 blurRadius: 10,
// //                 offset: const Offset(0, 4),
// //               ),
// //             ],
// //           ),
// //           child: Row(
// //             children: [
// //               _buildRadioButton(
// //                 'Regular Mode',
// //                 'reguler',
// //                 controller.mode,
// //                 controller.setMode,
// //               ),
// //               SizedBox(width: 0.05.toWidthPercent()),
// //               _buildRadioButton(
// //                 'Exam Mode',
// //                 'exam',
// //                 controller.mode,
// //                 controller.setMode,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   // ─── Radio Button ─────────────────────────────────────────────────────────

// //   Widget _buildRadioButton(
// //     String label,
// //     String value,
// //     RxString groupValue,
// //     Function(String) onChanged,
// //   ) {
// //     return Obx(() {
// //       final isSelected = groupValue.value == value;
// //       return GestureDetector(
// //         onTap: () => onChanged(value),
// //         child: Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Container(
// //               width: 0.06.toWidthPercent(),
// //               height: 0.06.toWidthPercent(),
// //               decoration: BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 color: isSelected ? AppColors.primary : Colors.grey[300],
// //                 border: Border.all(
// //                   color: isSelected ? AppColors.primary : Colors.grey[400]!,
// //                   width: 2,
// //                 ),
// //               ),
// //               child: isSelected
// //                   ? Icon(
// //                       Icons.circle,
// //                       color: Colors.white,
// //                       size: 0.03.toWidthPercent(),
// //                     )
// //                   : null,
// //             ),
// //             SizedBox(width: 0.02.toWidthPercent()),
// //             Text(
// //               label,
// //               style: TextStyle(
// //                 fontSize: 0.035.toWidthPercent(),
// //                 color: Colors.black87,
// //                 fontWeight: FontWeight.w500,
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     });
// //   }

// //   // ─── Single-select Dropdown ───────────────────────────────────────────────

// //   Widget _buildSearchableDropdown({
// //     required String title,
// //     required List<dynamic> items,
// //     required String selectedValueId,
// //     required Function(String?) onSelected,
// //     bool isLoading = false,
// //     bool isDisabled = false,
// //     bool showAllOption = true,
// //   }) {
// //     return Opacity(
// //       opacity: isDisabled ? 0.5 : 1.0,
// //       child: Container(
// //         padding: EdgeInsets.symmetric(
// //           horizontal: 0.05.toWidthPercent(),
// //           vertical: 0.015.toHeightPercent(),
// //         ),
// //         decoration: BoxDecoration(
// //           color: isDisabled ? Colors.grey[100] : Colors.white,
// //           borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
// //           boxShadow: isDisabled
// //               ? []
// //               : [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.05),
// //                     blurRadius: 10,
// //                     offset: const Offset(0, 4),
// //                   ),
// //                 ],
// //         ),
// //         child: DropdownButtonHideUnderline(
// //           child: DropdownButton<String>(
// //             value: selectedValueId.isEmpty ? null : selectedValueId,
// //             hint: Text(
// //               title,
// //               style: TextStyle(
// //                 fontSize: 0.04.toWidthPercent(),
// //                 fontWeight: FontWeight.bold,
// //                 color: isDisabled ? Colors.grey : Colors.black87,
// //               ),
// //             ),
// //             isExpanded: true,
// //             icon: isLoading
// //                 ? const SizedBox(
// //                     width: 20,
// //                     height: 20,
// //                     child: CircularProgressIndicator(
// //                       strokeWidth: 2,
// //                       color: AppColors.primary,
// //                     ),
// //                   )
// //                 : const Icon(
// //                     Icons.keyboard_arrow_down,
// //                     color: AppColors.primary,
// //                   ),
// //             disabledHint: Text(title),
// //             onChanged: isDisabled || isLoading ? null : onSelected,
// //             items: [
// //               if (showAllOption)
// //                 const DropdownMenuItem<String>(
// //                   value: "",
// //                   child: Text(
// //                     "All",
// //                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
// //                   ),
// //                 ),
// //               ...items.map((item) {
// //                 String id = '';
// //                 String name = '';
// //                 if (item is SubjectModel) {
// //                   id = item.id;
// //                   name = item.name;
// //                 } else if (item is SubSubjectModel) {
// //                   id = item.id;
// //                   name = item.name;
// //                 } else if (item is GetChaptersChapterModel) {
// //                   id = item.id;
// //                   name = item.name;
// //                 } else if (item is TopicModel) {
// //                   id = item.id;
// //                   name = item.name;
// //                 } else if (item is CustomTestTagModel) {
// //                   id = item.id;
// //                   name = item.name;
// //                 }
// //                 return DropdownMenuItem<String>(
// //                   value: id,
// //                   child: Text(
// //                     name,
// //                     style: TextStyle(fontSize: 0.035.toWidthPercent()),
// //                   ),
// //                 );
// //               }).toList(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // ─── Multi-select Expander (Chapter & Topic) ──────────────────────────────

// //   Widget _buildMultiSelectExpander({
// //     required String title,
// //     required List<dynamic> items,
// //     required RxList<String> selectedIds,
// //     required String Function(dynamic) getId,
// //     required String Function(dynamic) getName,
// //     required Function(String) onToggle,
// //     bool isLoading = false,
// //     bool isDisabled = false,
// //   }) {
// //     final isExpanded = false.obs;

// //     return Obx(() {
// //       return Opacity(
// //         opacity: isDisabled ? 0.5 : 1.0,
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Header
// //             GestureDetector(
// //               onTap: () {
// //                 if (!isDisabled && !isLoading) isExpanded.toggle();
// //               },
// //               child: Container(
// //                 padding: EdgeInsets.symmetric(
// //                   horizontal: 0.05.toWidthPercent(),
// //                   vertical: 0.015.toHeightPercent(),
// //                 ),
// //                 decoration: BoxDecoration(
// //                   color: isDisabled ? Colors.grey[100] : Colors.white,
// //                   borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
// //                   boxShadow: isDisabled
// //                       ? []
// //                       : [
// //                           BoxShadow(
// //                             color: Colors.black.withOpacity(0.05),
// //                             blurRadius: 10,
// //                             offset: const Offset(0, 4),
// //                           ),
// //                         ],
// //                 ),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Expanded(
// //                       child: Text(
// //                         selectedIds.isEmpty
// //                             ? title
// //                             : '$title (${selectedIds.length} selected)',
// //                         style: TextStyle(
// //                           fontSize: 0.04.toWidthPercent(),
// //                           fontWeight: FontWeight.bold,
// //                           color: selectedIds.isEmpty
// //                               ? Colors.black87
// //                               : AppColors.primary,
// //                         ),
// //                       ),
// //                     ),
// //                     isLoading
// //                         ? const SizedBox(
// //                             width: 20,
// //                             height: 20,
// //                             child: CircularProgressIndicator(
// //                               strokeWidth: 2,
// //                               color: AppColors.primary,
// //                             ),
// //                           )
// //                         : Icon(
// //                             isExpanded.value
// //                                 ? Icons.keyboard_arrow_up
// //                                 : Icons.keyboard_arrow_down,
// //                             color: AppColors.primary,
// //                           ),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             // Options list
// //             if (isExpanded.value)
// //               Container(
// //                 margin: const EdgeInsets.only(top: 4),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black.withOpacity(0.05),
// //                       blurRadius: 10,
// //                       offset: const Offset(0, 4),
// //                     ),
// //                   ],
// //                 ),
// //                 child: items.isEmpty
// //                     ? Padding(
// //                         padding: EdgeInsets.all(0.04.toWidthPercent()),
// //                         child: Center(
// //                           child: Text(
// //                             'No items available',
// //                             style: TextStyle(
// //                               fontSize: 0.035.toWidthPercent(),
// //                               color: Colors.grey,
// //                             ),
// //                           ),
// //                         ),
// //                       )
// //                     : Column(
// //                         children: items.map((item) {
// //                           final id = getId(item);
// //                           final name = getName(item);
// //                           final isSelected = selectedIds.contains(id);
// //                           return CheckboxListTile(
// //                             title: Text(
// //                               name,
// //                               style: TextStyle(
// //                                 fontSize: 0.035.toWidthPercent(),
// //                               ),
// //                             ),
// //                             value: isSelected,
// //                             activeColor: AppColors.primary,
// //                             dense: true,
// //                             controlAffinity: ListTileControlAffinity.leading,
// //                             onChanged: (_) => onToggle(id),
// //                           );
// //                         }).toList(),
// //                       ),
// //               ),

// //             // Selected chips
// //             if (selectedIds.isNotEmpty)
// //               Padding(
// //                 padding: const EdgeInsets.only(top: 8),
// //                 child: Wrap(
// //                   spacing: 6,
// //                   runSpacing: 6,
// //                   children: selectedIds.map((id) {
// //                     final item = items.firstWhereOrNull((e) => getId(e) == id);
// //                     final name = item != null ? getName(item) : id;
// //                     return Chip(
// //                       label: Text(
// //                         name,
// //                         style: TextStyle(
// //                           fontSize: 12,
// //                           color: AppColors.primary,
// //                         ),
// //                       ),
// //                       backgroundColor: AppColors.primary.withOpacity(0.1),
// //                       deleteIconColor: AppColors.primary,
// //                       onDeleted: () => onToggle(id),
// //                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //                       padding: EdgeInsets.zero,
// //                     );
// //                   }).toList(),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       );
// //     });
// //   }

// //   // ─── Tags Multi-select Dialog ─────────────────────────────────────────────

// //   Widget _buildMultiSelectDropdown({
// //     required String title,
// //     required List<CustomTestTagModel> items,
// //     required List<String> selectedIds,
// //     required Function(String) onChanged,
// //     bool isLoading = false,
// //   }) {
// //     return GestureDetector(
// //       onTap: () {
// //         if (isLoading || items.isEmpty) return;
// //         showDialog(
// //           context: Get.context!,
// //           builder: (context) => AlertDialog(
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(15),
// //             ),
// //             contentPadding: const EdgeInsets.symmetric(vertical: 10),
// //             content: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(12.0),
// //                   child: Text(
// //                     "Select Tags",
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 0.045.toWidthPercent(),
// //                     ),
// //                   ),
// //                 ),
// //                 const Divider(),
// //                 ConstrainedBox(
// //                   constraints: BoxConstraints(maxHeight: 0.4.toHeightPercent()),
// //                   child: StatefulBuilder(
// //                     builder: (context, setDialogState) {
// //                       return SingleChildScrollView(
// //                         child: Column(
// //                           children: items.map((tag) {
// //                             final isSelected = selectedIds.contains(tag.id);
// //                             return CheckboxListTile(
// //                               title: Text(
// //                                 tag.name,
// //                                 style: TextStyle(
// //                                   fontSize: 0.038.toWidthPercent(),
// //                                 ),
// //                               ),
// //                               value: isSelected,
// //                               activeColor: AppColors.primary,
// //                               dense: true,
// //                               onChanged: (val) {
// //                                 onChanged(tag.id);
// //                                 setDialogState(() {});
// //                               },
// //                               controlAffinity: ListTileControlAffinity.leading,
// //                             );
// //                           }).toList(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //                 const Divider(),
// //                 TextButton(
// //                   onPressed: () => Get.back(),
// //                   child: Text(
// //                     "Done",
// //                     style: TextStyle(
// //                       color: AppColors.primary,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //       child: Container(
// //         padding: EdgeInsets.symmetric(
// //           horizontal: 0.05.toWidthPercent(),
// //           vertical: 0.015.toHeightPercent(),
// //         ),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.05),
// //               blurRadius: 10,
// //               offset: const Offset(0, 4),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Expanded(
// //               child: Text(
// //                 selectedIds.isEmpty
// //                     ? title
// //                     : "Tags Selected (${selectedIds.length})",
// //                 style: TextStyle(
// //                   fontSize: 0.04.toWidthPercent(),
// //                   fontWeight: FontWeight.bold,
// //                   color: selectedIds.isEmpty
// //                       ? Colors.black87
// //                       : AppColors.primary,
// //                 ),
// //               ),
// //             ),
// //             isLoading
// //                 ? const SizedBox(
// //                     width: 20,
// //                     height: 20,
// //                     child: CircularProgressIndicator(strokeWidth: 2),
// //                   )
// //                 : Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ─── Action Buttons ───────────────────────────────────────────────────────

// //   Widget _buildActionButtons(CustomModuleController controller) {
// //     return Row(
// //       children: [
// //         Expanded(
// //           child: Obx(
// //             () => ElevatedButton(
// //               onPressed: controller.isLoading.value
// //                   ? null
// //                   : () {
// //                       Get.dialog(
// //                         AlertDialog(
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(12),
// //                           ),
// //                           title: const Text("Create New Custom Test"),
// //                           content: const Text(
// //                             "Your previous custom test will be discarded. "
// //                             "Do you want to continue?",
// //                           ),
// //                           actions: [
// //                             TextButton(
// //                               onPressed: () => Get.back(),
// //                               child: const Text("Cancel"),
// //                             ),
// //                             ElevatedButton(
// //                               onPressed: () {
// //                                 Get.back();
// //                                 controller.createCustomTest();
// //                               },
// //                               style: ElevatedButton.styleFrom(
// //                                 backgroundColor: AppColors.primary,
// //                               ),
// //                               child: const Text("Continue"),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: AppColors.primary,
// //                 foregroundColor: Colors.white,
// //                 padding: EdgeInsets.symmetric(
// //                   vertical: 0.015.toHeightPercent(),
// //                 ),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
// //                 ),
// //               ),
// //               child: controller.isLoading.value
// //                   ? const SizedBox(
// //                       height: 20,
// //                       width: 20,
// //                       child: CircularProgressIndicator(
// //                         color: Colors.white,
// //                         strokeWidth: 2,
// //                       ),
// //                     )
// //                   : Text(
// //                       'Submit',
// //                       style: TextStyle(
// //                         fontSize: 0.045.toWidthPercent(),
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //             ),
// //           ),
// //         ),
// //         SizedBox(width: 0.04.toWidthPercent()),
// //         Expanded(
// //           child: OutlinedButton(
// //             onPressed: controller.cancel,
// //             style: OutlinedButton.styleFrom(
// //               side: BorderSide(color: AppColors.primary),
// //               foregroundColor: Colors.black,
// //               padding: EdgeInsets.symmetric(vertical: 0.015.toHeightPercent()),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
// //               ),
// //             ),
// //             child: Text(
// //               'Cancel',
// //               style: TextStyle(
// //                 fontSize: 0.045.toWidthPercent(),
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// import 'package:codon/features/pearls/models/subject_model.dart';
// import 'package:codon/features/pearls/models/sub_subject_model.dart';
// import 'package:codon/features/pearls/models/topic_model.dart';
// import 'package:codon/features/qtest/models/tag_model.dart';
// import 'package:codon/features/qtest/controllers/custom_module_controller.dart';
// import 'package:codon/features/qtest/screens/custom_test_history_screen.dart';
// import 'package:codon/utills/app_theme.dart';
// import 'package:codon/utills/screen_size_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// import '../../pearls/models/Get_Chapters_Chapter_model.dart';

// class CustomModuleScreen extends StatelessWidget {
//   const CustomModuleScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CustomModuleController controller =
//         Get.find<CustomModuleController>();

//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//         systemNavigationBarColor: Colors.transparent,
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ),
//     );

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text(
//             'Custom Module',
//             style: TextStyle(
//               fontSize: 0.05.toWidthPercent(),
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           actions: [
//             IconButton(
//               onPressed: () => Get.to(() => const CustomTestHistoryScreen()),
//               icon: const Icon(Icons.history, color: Colors.black),
//             ),
//           ],
//         ),
//         body: Column(
//           children: [
//             SizedBox(height: 0.02.toHeightPercent()),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.all(0.04.toWidthPercent()),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Difficulty
//                     _buildDifficultySection(controller),
//                     SizedBox(height: 0.03.toHeightPercent()),

//                     // Subject
//                     Obx(
//                       () => _buildSearchableDropdown(
//                         title: 'Select Subject',
//                         items: controller.subjects,
//                         selectedValueId: controller.selectedSubjectId.value,
//                         onSelected: controller.onSubjectSelected,
//                         isLoading: controller.isLoadingSubjects.value,
//                         showAllOption: false,
//                       ),
//                     ),
//                     SizedBox(height: 0.02.toHeightPercent()),

//                     // Sub Subject
//                     Obx(() {
//                       if (controller.selectedSubjectId.value.isEmpty)
//                         return const SizedBox.shrink();
//                       return Column(
//                         children: [
//                           _buildSearchableDropdown(
//                             title: 'Select Sub-Subject',
//                             items: controller.subSubjects,
//                             selectedValueId:
//                                 controller.selectedSubSubjectId.value,
//                             onSelected: controller.onSubSubjectSelected,
//                             isLoading: controller.isLoadingSubSubjects.value,
//                             isDisabled: controller.subSubjects.isEmpty,
//                             showAllOption: true,
//                           ),
//                           SizedBox(height: 0.02.toHeightPercent()),
//                         ],
//                       );
//                     }),

//                     // Chapter — multi-select
//                     Obx(() {
//                       if (controller.selectedSubSubjectId.value.isEmpty)
//                         return const SizedBox.shrink();
//                       return Column(
//                         children: [
//                           _buildMultiSelectExpander(
//                             title: 'Select Chapter',
//                             items: controller.chapters,
//                             selectedIds: controller.selectedChapterIds,
//                             getId: (c) => (c as GetChaptersChapterModel).id,
//                             getName: (c) => (c as GetChaptersChapterModel).name,
//                             onToggle: controller.toggleChapter,
//                             isLoading: controller.isLoadingChapters.value,
//                             isDisabled:
//                                 controller.chapters.isEmpty &&
//                                 !controller.isLoadingChapters.value,
//                           ),
//                           SizedBox(height: 0.02.toHeightPercent()),
//                         ],
//                       );
//                     }),

//                     // Topic — multi-select
//                     Obx(() {
//                       if (controller.selectedChapterIds.isEmpty)
//                         return const SizedBox.shrink();
//                       return Column(
//                         children: [
//                           _buildMultiSelectExpander(
//                             title: 'Select Topic',
//                             items: controller.topics,
//                             selectedIds: controller.selectedTopicIds,
//                             getId: (t) => (t as TopicModel).id,
//                             getName: (t) => (t as TopicModel).name,
//                             onToggle: controller.toggleTopic,
//                             isLoading: controller.isLoadingTopics.value,
//                             isDisabled:
//                                 controller.topics.isEmpty &&
//                                 !controller.isLoadingTopics.value,
//                           ),
//                           SizedBox(height: 0.02.toHeightPercent()),
//                         ],
//                       );
//                     }),

//                     SizedBox(height: 0.03.toHeightPercent()),

//                     // Tags
//                     Obx(
//                       () => _buildMultiSelectDropdown(
//                         title: controller.selectedTagIds.isEmpty
//                             ? 'Select Tags'
//                             : controller.selectedTagsDisplay,
//                         items: controller.tags,
//                         selectedIds: controller.selectedTagIds,
//                         onChanged: controller.toggleTag,
//                         isLoading: controller.isLoadingTags.value,
//                       ),
//                     ),

//                     SizedBox(height: 0.03.toHeightPercent()),

//                     // Number of Questions
//                     _buildNumberOfQuestionsSection(controller),
//                     SizedBox(height: 0.03.toHeightPercent()),

//                     // Mode
//                     _buildModeSection(controller),
//                     SizedBox(height: 0.1.toHeightPercent()),

//                     // Buttons
//                     _buildActionButtons(controller),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ─── Difficulty ────────────────────────────────────────────────────────────

//   Widget _buildDifficultySection(CustomModuleController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Difficulty level',
//           style: TextStyle(
//             fontSize: 0.04.toWidthPercent(),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 0.015.toHeightPercent()),
//         Container(
//           padding: EdgeInsets.all(0.04.toWidthPercent()),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildRadioButton(
//                 'All',
//                 'all',
//                 controller.difficultyLevel,
//                 controller.setDifficulty,
//               ),
//               _buildRadioButton(
//                 'Easy',
//                 'easy',
//                 controller.difficultyLevel,
//                 controller.setDifficulty,
//               ),
//               _buildRadioButton(
//                 'Medium',
//                 'medium',
//                 controller.difficultyLevel,
//                 controller.setDifficulty,
//               ),
//               _buildRadioButton(
//                 'Hard',
//                 'hard',
//                 controller.difficultyLevel,
//                 controller.setDifficulty,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ─── Number of Questions ───────────────────────────────────────────────────

//   Widget _buildNumberOfQuestionsSection(CustomModuleController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Number of Questions',
//           style: TextStyle(
//             fontSize: 0.04.toWidthPercent(),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 0.015.toHeightPercent()),
//         Obx(
//           () => Container(
//             padding: EdgeInsets.all(0.04.toWidthPercent()),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: controller.questionOptions.map((count) {
//                 final isSelected = controller.numberOfQuestions.value == count;
//                 return GestureDetector(
//                   onTap: () => controller.setNumberOfQuestions(count),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     width: 0.17.toWidthPercent(),
//                     height: 0.1.toHeightPercent(),
//                     decoration: BoxDecoration(
//                       color: isSelected ? AppColors.primary : Colors.grey[100],
//                       borderRadius: BorderRadius.circular(
//                         0.03.toWidthPercent(),
//                       ),
//                       border: Border.all(
//                         color: isSelected
//                             ? AppColors.primary
//                             : Colors.grey[300]!,
//                         width: 1.5,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         '$count',
//                         style: TextStyle(
//                           fontSize: 0.045.toWidthPercent(),
//                           fontWeight: FontWeight.bold,
//                           color: isSelected ? Colors.white : Colors.black54,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // ─── Mode ──────────────────────────────────────────────────────────────────

//   Widget _buildModeSection(CustomModuleController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Mode',
//           style: TextStyle(
//             fontSize: 0.04.toWidthPercent(),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 0.015.toHeightPercent()),
//         Container(
//           padding: EdgeInsets.all(0.04.toWidthPercent()),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               _buildRadioButton(
//                 'Regular Mode',
//                 'regular',
//                 controller.mode,
//                 controller.setMode,
//               ),
//               SizedBox(width: 0.05.toWidthPercent()),
//               _buildRadioButton(
//                 'Exam Mode',
//                 'exam',
//                 controller.mode,
//                 controller.setMode,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ─── Radio Button ──────────────────────────────────────────────────────────

//   Widget _buildRadioButton(
//     String label,
//     String value,
//     RxString groupValue,
//     Function(String) onChanged,
//   ) {
//     return Obx(() {
//       final isSelected = groupValue.value == value;
//       return GestureDetector(
//         onTap: () => onChanged(value),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 0.06.toWidthPercent(),
//               height: 0.06.toWidthPercent(),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: isSelected ? AppColors.primary : Colors.grey[300],
//                 border: Border.all(
//                   color: isSelected ? AppColors.primary : Colors.grey[400]!,
//                   width: 2,
//                 ),
//               ),
//               child: isSelected
//                   ? Icon(
//                       Icons.circle,
//                       color: Colors.white,
//                       size: 0.03.toWidthPercent(),
//                     )
//                   : null,
//             ),
//             SizedBox(width: 0.02.toWidthPercent()),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 0.035.toWidthPercent(),
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   // ─── Single-select Dropdown ────────────────────────────────────────────────

//   Widget _buildSearchableDropdown({
//     required String title,
//     required List<dynamic> items,
//     required String selectedValueId,
//     required Function(String?) onSelected,
//     bool isLoading = false,
//     bool isDisabled = false,
//     bool showAllOption = true,
//   }) {
//     return Opacity(
//       opacity: isDisabled ? 0.5 : 1.0,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: 0.05.toWidthPercent(),
//           vertical: 0.015.toHeightPercent(),
//         ),
//         decoration: BoxDecoration(
//           color: isDisabled ? Colors.grey[100] : Colors.white,
//           borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
//           boxShadow: isDisabled
//               ? []
//               : [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: selectedValueId.isEmpty ? null : selectedValueId,
//             hint: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 0.04.toWidthPercent(),
//                 fontWeight: FontWeight.bold,
//                 color: isDisabled ? Colors.grey : Colors.black87,
//               ),
//             ),
//             isExpanded: true,
//             icon: isLoading
//                 ? const SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       color: AppColors.primary,
//                     ),
//                   )
//                 : const Icon(
//                     Icons.keyboard_arrow_down,
//                     color: AppColors.primary,
//                   ),
//             disabledHint: Text(title),
//             onChanged: isDisabled || isLoading ? null : onSelected,
//             items: [
//               if (showAllOption)
//                 const DropdownMenuItem<String>(
//                   value: "",
//                   child: Text(
//                     "All",
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ...items.map((item) {
//                 String id = '';
//                 String name = '';
//                 if (item is SubjectModel) {
//                   id = item.id;
//                   name = item.name;
//                 } else if (item is SubSubjectModel) {
//                   id = item.id;
//                   name = item.name;
//                 } else if (item is GetChaptersChapterModel) {
//                   id = item.id;
//                   name = item.name;
//                 } else if (item is TopicModel) {
//                   id = item.id;
//                   name = item.name;
//                 } else if (item is CustomTestTagModel) {
//                   id = item.id;
//                   name = item.name;
//                 }
//                 return DropdownMenuItem<String>(
//                   value: id,
//                   child: Text(
//                     name,
//                     style: TextStyle(fontSize: 0.035.toWidthPercent()),
//                   ),
//                 );
//               }).toList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ─── Multi-select Expander (Chapter & Topic) ───────────────────────────────

//   Widget _buildMultiSelectExpander({
//     required String title,
//     required List<dynamic> items,
//     required RxList<String> selectedIds,
//     required String Function(dynamic) getId,
//     required String Function(dynamic) getName,
//     required Function(String) onToggle,
//     bool isLoading = false,
//     bool isDisabled = false,
//   }) {
//     final isExpanded = false.obs;

//     return Obx(() {
//       return Opacity(
//         opacity: isDisabled ? 0.5 : 1.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             GestureDetector(
//               onTap: () {
//                 if (!isDisabled && !isLoading) isExpanded.toggle();
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 0.05.toWidthPercent(),
//                   vertical: 0.015.toHeightPercent(),
//                 ),
//                 decoration: BoxDecoration(
//                   color: isDisabled ? Colors.grey[100] : Colors.white,
//                   borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
//                   boxShadow: isDisabled
//                       ? []
//                       : [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         selectedIds.isEmpty
//                             ? title
//                             : '$title (${selectedIds.length} selected)',
//                         style: TextStyle(
//                           fontSize: 0.04.toWidthPercent(),
//                           fontWeight: FontWeight.bold,
//                           color: selectedIds.isEmpty
//                               ? Colors.black87
//                               : AppColors.primary,
//                         ),
//                       ),
//                     ),
//                     isLoading
//                         ? const SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: AppColors.primary,
//                             ),
//                           )
//                         : Icon(
//                             isExpanded.value
//                                 ? Icons.keyboard_arrow_up
//                                 : Icons.keyboard_arrow_down,
//                             color: AppColors.primary,
//                           ),
//                   ],
//                 ),
//               ),
//             ),

//             // Options list
//             if (isExpanded.value)
//               Container(
//                 margin: const EdgeInsets.only(top: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: items.isEmpty
//                     ? Padding(
//                         padding: EdgeInsets.all(0.04.toWidthPercent()),
//                         child: Center(
//                           child: Text(
//                             'No items available',
//                             style: TextStyle(
//                               fontSize: 0.035.toWidthPercent(),
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       )
//                     : Column(
//                         children: items.map((item) {
//                           final id = getId(item);
//                           final name = getName(item);
//                           final isSelected = selectedIds.contains(id);
//                           return CheckboxListTile(
//                             title: Text(
//                               name,
//                               style: TextStyle(
//                                 fontSize: 0.035.toWidthPercent(),
//                               ),
//                             ),
//                             value: isSelected,
//                             activeColor: AppColors.primary,
//                             dense: true,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             onChanged: (_) => onToggle(id),
//                           );
//                         }).toList(),
//                       ),
//               ),

//             // Selected chips
//             if (selectedIds.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top: 8),
//                 child: Wrap(
//                   spacing: 6,
//                   runSpacing: 6,
//                   children: selectedIds.map((id) {
//                     final item = items.firstWhereOrNull((e) => getId(e) == id);
//                     final name = item != null ? getName(item) : id;
//                     return Chip(
//                       label: Text(
//                         name,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                       backgroundColor: AppColors.primary.withOpacity(0.1),
//                       deleteIconColor: AppColors.primary,
//                       onDeleted: () => onToggle(id),
//                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       padding: EdgeInsets.zero,
//                     );
//                   }).toList(),
//                 ),
//               ),
//           ],
//         ),
//       );
//     });
//   }

//   // ─── Tags Multi-select Dialog ──────────────────────────────────────────────

//   Widget _buildMultiSelectDropdown({
//     required String title,
//     required List<CustomTestTagModel> items,
//     required List<String> selectedIds,
//     required Function(String) onChanged,
//     bool isLoading = false,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         if (isLoading || items.isEmpty) return;
//         showDialog(
//           context: Get.context!,
//           builder: (context) => AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             contentPadding: const EdgeInsets.symmetric(vertical: 10),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Text(
//                     "Select Tags",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 0.045.toWidthPercent(),
//                     ),
//                   ),
//                 ),
//                 const Divider(),
//                 ConstrainedBox(
//                   constraints: BoxConstraints(maxHeight: 0.4.toHeightPercent()),
//                   child: StatefulBuilder(
//                     builder: (context, setDialogState) {
//                       return SingleChildScrollView(
//                         child: Column(
//                           children: items.map((tag) {
//                             final isSelected = selectedIds.contains(tag.id);
//                             return CheckboxListTile(
//                               title: Text(
//                                 tag.name,
//                                 style: TextStyle(
//                                   fontSize: 0.038.toWidthPercent(),
//                                 ),
//                               ),
//                               value: isSelected,
//                               activeColor: AppColors.primary,
//                               dense: true,
//                               onChanged: (val) {
//                                 onChanged(tag.id);
//                                 setDialogState(() {});
//                               },
//                               controlAffinity: ListTileControlAffinity.leading,
//                             );
//                           }).toList(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const Divider(),
//                 TextButton(
//                   onPressed: () => Get.back(),
//                   child: Text(
//                     "Done",
//                     style: TextStyle(
//                       color: AppColors.primary,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: 0.05.toWidthPercent(),
//           vertical: 0.015.toHeightPercent(),
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 selectedIds.isEmpty
//                     ? title
//                     : "Tags Selected (${selectedIds.length})",
//                 style: TextStyle(
//                   fontSize: 0.04.toWidthPercent(),
//                   fontWeight: FontWeight.bold,
//                   color: selectedIds.isEmpty
//                       ? Colors.black87
//                       : AppColors.primary,
//                 ),
//               ),
//             ),
//             isLoading
//                 ? const SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   )
//                 : Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
//           ],
//         ),
//       ),
//     );
//   }

//   // ─── Action Buttons ────────────────────────────────────────────────────────

//   Widget _buildActionButtons(CustomModuleController controller) {
//     return Row(
//       children: [
//         Expanded(
//           child: Obx(
//             () => ElevatedButton(
//               onPressed: controller.isLoading.value
//                   ? null
//                   : () {
//                       Get.dialog(
//                         AlertDialog(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           title: const Text("Create New Custom Test"),
//                           content: const Text(
//                             "Your previous custom test will be discarded. "
//                             "Do you want to continue?",
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Get.back(),
//                               child: const Text("Cancel"),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Get.back();
//                                 controller.createCustomTest();
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.primary,
//                               ),
//                               child: const Text("Continue"),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(
//                   vertical: 0.015.toHeightPercent(),
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
//                 ),
//               ),
//               child: controller.isLoading.value
//                   ? const SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 2,
//                       ),
//                     )
//                   : Text(
//                       'Submit',
//                       style: TextStyle(
//                         fontSize: 0.045.toWidthPercent(),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//             ),
//           ),
//         ),
//         SizedBox(width: 0.04.toWidthPercent()),
//         Expanded(
//           child: OutlinedButton(
//             onPressed: controller.cancel,
//             style: OutlinedButton.styleFrom(
//               side: BorderSide(color: AppColors.primary),
//               foregroundColor: Colors.black,
//               padding: EdgeInsets.symmetric(vertical: 0.015.toHeightPercent()),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
//               ),
//             ),
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 fontSize: 0.045.toWidthPercent(),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
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
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                    // Difficulty
                    _buildDifficultySection(controller),
                    SizedBox(height: 0.03.toHeightPercent()),

                    // Subject — multi-select
                    Obx(
                      () => _buildMultiSelectExpander(
                        title: 'Select Subject',
                        items: controller.subjects,
                        selectedIds: controller.selectedSubjectIds,
                        getId: (s) => (s as SubjectModel).id,
                        getName: (s) => (s as SubjectModel).name,
                        onToggle: controller.toggleSubject,
                        onSelectAll: controller.selectAllSubjects,
                        isLoading: controller.isLoadingSubjects.value,
                        isDisabled:
                            controller.subjects.isEmpty &&
                            !controller.isLoadingSubjects.value,
                      ),
                    ),
                    SizedBox(height: 0.02.toHeightPercent()),

                    // Sub Subject — multi-select
                    Obx(() {
                      if (controller.selectedSubjectIds.isEmpty)
                        return const SizedBox.shrink();
                      return Column(
                        children: [
                          _buildMultiSelectExpander(
                            title: 'Select Sub-Subject',
                            items: controller.subSubjects,
                            selectedIds: controller.selectedSubSubjectIds,
                            getId: (s) => (s as SubSubjectModel).id,
                            getName: (s) => (s as SubSubjectModel).name,
                            onToggle: controller.toggleSubSubject,
                            onSelectAll: controller.selectAllSubSubjects,
                            isLoading: controller.isLoadingSubSubjects.value,
                            isDisabled:
                                controller.subSubjects.isEmpty &&
                                !controller.isLoadingSubSubjects.value,
                          ),
                          SizedBox(height: 0.02.toHeightPercent()),
                        ],
                      );
                    }),

                    // Chapter — multi-select
                    Obx(() {
                      if (controller.selectedSubSubjectIds.isEmpty)
                        return const SizedBox.shrink();
                      return Column(
                        children: [
                          _buildMultiSelectExpander(
                            title: 'Select Chapter',
                            items: controller.chapters,
                            selectedIds: controller.selectedChapterIds,
                            getId: (c) => (c as GetChaptersChapterModel).id,
                            getName: (c) => (c as GetChaptersChapterModel).name,
                            onToggle: controller.toggleChapter,
                            onSelectAll: controller.selectAllChapters,
                            isLoading: controller.isLoadingChapters.value,
                            isDisabled:
                                controller.chapters.isEmpty &&
                                !controller.isLoadingChapters.value,
                          ),
                          SizedBox(height: 0.02.toHeightPercent()),
                        ],
                      );
                    }),

                    // Topic — multi-select
                    Obx(() {
                      if (controller.selectedChapterIds.isEmpty)
                        return const SizedBox.shrink();
                      return Column(
                        children: [
                          _buildMultiSelectExpander(
                            title: 'Select Topic',
                            items: controller.topics,
                            selectedIds: controller.selectedTopicIds,
                            getId: (t) => (t as TopicModel).id,
                            getName: (t) => (t as TopicModel).name,
                            onToggle: controller.toggleTopic,
                            onSelectAll: controller.selectAllTopics,
                            isLoading: controller.isLoadingTopics.value,
                            isDisabled:
                                controller.topics.isEmpty &&
                                !controller.isLoadingTopics.value,
                          ),
                          SizedBox(height: 0.02.toHeightPercent()),
                        ],
                      );
                    }),

                    SizedBox(height: 0.03.toHeightPercent()),

                    // Tags
                    Obx(
                      () => _buildMultiSelectDropdown(
                        title: 'Select Tags',
                        items: controller.tags,
                        selectedIds: controller.selectedTagIds,
                        onChanged: controller.toggleTag,
                        onSelectAll: controller.selectAllTags,
                        isLoading: controller.isLoadingTags.value,
                      ),
                    ),

                    SizedBox(height: 0.03.toHeightPercent()),

                    // Number of Questions
                    _buildNumberOfQuestionsSection(controller),
                    SizedBox(height: 0.03.toHeightPercent()),

                    // Mode
                    _buildModeSection(controller),
                    SizedBox(height: 0.1.toHeightPercent()),

                    // Buttons
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

  // ─── Difficulty ────────────────────────────────────────────────────────────

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
                controller.setDifficulty,
              ),
              _buildRadioButton(
                'Easy',
                'easy',
                controller.difficultyLevel,
                controller.setDifficulty,
              ),
              _buildRadioButton(
                'Medium',
                'medium',
                controller.difficultyLevel,
                controller.setDifficulty,
              ),
              _buildRadioButton(
                'Hard',
                'hard',
                controller.difficultyLevel,
                controller.setDifficulty,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Number of Questions ───────────────────────────────────────────────────

  Widget _buildNumberOfQuestionsSection(CustomModuleController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Number of Questions',
          style: TextStyle(
            fontSize: 0.04.toWidthPercent(),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 0.015.toHeightPercent()),
        Obx(
          () => Container(
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
              children: controller.questionOptions.map((count) {
                final isSelected = controller.numberOfQuestions.value == count;
                return GestureDetector(
                  onTap: () => controller.setNumberOfQuestions(count),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 0.17.toWidthPercent(),
                    height: 0.1.toHeightPercent(),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.grey[100],
                      borderRadius: BorderRadius.circular(
                        0.03.toWidthPercent(),
                      ),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$count',
                        style: TextStyle(
                          fontSize: 0.045.toWidthPercent(),
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // ─── Mode ──────────────────────────────────────────────────────────────────

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
                'regular',
                controller.mode,
                controller.setMode,
              ),
              SizedBox(width: 0.05.toWidthPercent()),
              _buildRadioButton(
                'Exam Mode',
                'exam',
                controller.mode,
                controller.setMode,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Radio Button ──────────────────────────────────────────────────────────

  Widget _buildRadioButton(
    String label,
    String value,
    RxString groupValue,
    Function(String) onChanged,
  ) {
    return Obx(() {
      final isSelected = groupValue.value == value;
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

  // ─── Multi-select Expander (Subject, Sub-Subject, Chapter, Topic) ──────────

  Widget _buildMultiSelectExpander({
    required String title,
    required List<dynamic> items,
    required RxList<String> selectedIds,
    required String Function(dynamic) getId,
    required String Function(dynamic) getName,
    required Function(String) onToggle,
    required Function() onSelectAll,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    final isExpanded = false.obs;

    return Obx(() {
      // Calculate if all items are selected
      final validItemIds = items.map((item) => getId(item)).toList();
      final isAllSelected =
          validItemIds.isNotEmpty &&
          selectedIds.length == validItemIds.length &&
          validItemIds.every((id) => selectedIds.contains(id));

      return Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            GestureDetector(
              onTap: () {
                if (!isDisabled && !isLoading) isExpanded.toggle();
              },
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selectedIds.isEmpty
                            ? title
                            : '$title (${selectedIds.length} selected)',
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
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          )
                        : Icon(
                            isExpanded.value
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColors.primary,
                          ),
                  ],
                ),
              ),
            ),

            // Options list
            if (isExpanded.value)
              Container(
                margin: const EdgeInsets.only(top: 4),
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
                child: items.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(0.04.toWidthPercent()),
                        child: Center(
                          child: Text(
                            'No items available',
                            style: TextStyle(
                              fontSize: 0.035.toWidthPercent(),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          // "Select All" option
                          CheckboxListTile(
                            title: Text(
                              'Select All',
                              style: TextStyle(
                                fontSize: 0.035.toWidthPercent(),
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            value: isAllSelected,
                            activeColor: AppColors.primary,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (_) {
                              print(
                                "Select All tapped. Current: $isAllSelected, selectedIds: ${selectedIds.toList()}",
                              );
                              onSelectAll();
                            },
                          ),
                          const Divider(height: 1),
                          // Individual items
                          ...items.map((item) {
                            final id = getId(item);
                            final name = getName(item);
                            final isSelected = selectedIds.contains(id);
                            return CheckboxListTile(
                              title: Text(
                                name,
                                style: TextStyle(
                                  fontSize: 0.035.toWidthPercent(),
                                ),
                              ),
                              value: isSelected,
                              activeColor: AppColors.primary,
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (_) {
                                print(
                                  "Toggled $id: $name. Previously selected: $isSelected",
                                );
                                onToggle(id);
                              },
                            );
                          }).toList(),
                        ],
                      ),
              ),

            // Selected chips
            if (selectedIds.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: selectedIds.map((id) {
                    final item = items.firstWhereOrNull((e) => getId(e) == id);
                    final name = item != null ? getName(item) : id;
                    return Chip(
                      label: Text(
                        name,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      deleteIconColor: AppColors.primary,
                      onDeleted: () => onToggle(id),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      );
    });
  }

  // ─── Tags Multi-select Dialog ──────────────────────────────────────────────

  Widget _buildMultiSelectDropdown({
    required String title,
    required List<CustomTestTagModel> items,
    required List<String> selectedIds,
    required Function(String) onChanged,
    required Function() onSelectAll,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (isLoading || items.isEmpty) return;
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
                      // Calculate if all tags are selected
                      final isAllSelectedNow =
                          items.isNotEmpty &&
                          selectedIds.length == items.length &&
                          items.every((tag) => selectedIds.contains(tag.id));

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            // "Select All" option for tags
                            CheckboxListTile(
                              title: Text(
                                'Select All',
                                style: TextStyle(
                                  fontSize: 0.038.toWidthPercent(),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                              value: isAllSelectedNow,
                              activeColor: AppColors.primary,
                              dense: true,
                              onChanged: (val) {
                                print(
                                  "Tags Select All tapped. Current: $isAllSelectedNow",
                                );
                                onSelectAll();
                                setDialogState(() {});
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            const Divider(),
                            // Individual tags
                            ...items.map((tag) {
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
                                  print(
                                    "Toggled tag ${tag.id}: ${tag.name}. Previously selected: $isSelected",
                                  );
                                  onChanged(tag.id);
                                  setDialogState(() {});
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              );
                            }).toList(),
                          ],
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
              child: Obx(
                () => Text(
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

  // ─── Action Buttons ────────────────────────────────────────────────────────

  Widget _buildActionButtons(CustomModuleController controller) {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => ElevatedButton(
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
                                Get.back();
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: 0.015.toHeightPercent(),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.02.toWidthPercent()),
                ),
              ),
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
}
