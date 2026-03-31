import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:codon/features/home/controllers/home_controller.dart';
import 'package:codon/features/home/models/daily_mcq_model.dart';
import 'package:codon/features/home/screens/bookmark_screen.dart';
import 'package:codon/features/subscription/screens/subscription_screen.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/features/pearls/screens/pearls_screen.dart';
import 'package:codon/features/qtest/screens/qtest_screen.dart';
import 'package:codon/features/test/screens/tests_list_screen.dart';
import 'package:codon/features/videos/screens/videos_list_screen.dart';
import 'package:codon/features/settings/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../utills/widgets/version_checker.dart';
import '../controllers/bookmark_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();
  bool isUpdateAvailable = false;
  @override
  void initState() {
    // TODO: implement initState
    Get.put(BookmarkController());
    super.initState();
    checkUpdate();
  }

  void checkUpdate() async {
    isUpdateAvailable = await VersionChecker.isUpdateAvailable();
    setState(() {});
  }

  void VersionCheckerIcon() async {
    final String  url = "";
    // Put your url on this

    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200 || response.statusCode == 201){
      // Flutter is a UI toolkit by Google used to build cross-platform apps from a single codebase.
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      top: false,

      child: Scaffold(
        floatingActionButton: isUpdateAvailable
            ? Container(
             padding: EdgeInsets.all(12),
             margin: EdgeInsets.symmetric(horizontal: 5),
             decoration: BoxDecoration(
             color: Colors.black87,
             borderRadius: BorderRadius.circular(16),
             boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              )
             ],
             ),
             child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              Icon(Icons.system_update, color: Colors.white),

              SizedBox(width: width * 0.01),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "New Version Available",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Update your app now",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              SizedBox(width: width*0.01),

              Container(
                decoration: BoxDecoration(),
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                    onPressed: () {
                      final Uri url = Uri.parse(
                          "market://details?id=com.testmee.app");
                      launchUrl(url);
                    },
                  child: Text("Update Now",style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ) : SizedBox(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        extendBody: true,
        backgroundColor: const Color(0xFFF8F8F8),
        body: Obx(() {
          switch (controller.currentIndex.value) {
            case 0:
              return _buildHomeContent(controller);
            case 1:
              return const PearlsScreen();
            case 2:
              return const QTestScreen(savebookmark: 'savebookmark',);
            case 3:
              return const TestsListScreen();
            case 4:
              return const VideosListScreen();
            default:
              return Center(
                child: Text(
                  'Coming Soon',
                  style: TextStyle(
                    fontSize: 0.05.toWidthPercent(),
                    color: Colors.grey,
                  ),
                ),
              );
          }
        }),
        bottomNavigationBar: Obx(
          () => Container(
            height: 0.085
                .toHeightPercent(), // Adjust this value to increase/decrease height
            child: BottomNavigationBar(
              elevation: 10,
              currentIndex: controller.currentIndex.value,
              onTap: controller.changeTab,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              iconSize: 50,
              selectedLabelStyle: TextStyle(
                fontSize: 0.035.toWidthPercent(),
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(fontSize: 0.035.toWidthPercent()),
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.primary,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black38,
              selectedFontSize: 0.03.toWidthPercent(),
              unselectedFontSize: 0.03.toWidthPercent(),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    homeIcon,
                    width: 0.08.toWidthPercent(),
                    height: 0.08.toWidthPercent(),
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 0
                          ? Colors.white
                          : Colors.black38,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    pearlsIcon,
                    width: 0.08.toWidthPercent(),
                    height: 0.08.toWidthPercent(),
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 1
                          ? Colors.white
                          : Colors.black38,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Codon',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    qtestIcon,
                    width: 0.08.toWidthPercent(),
                    height: 0.08.toWidthPercent(),
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 2
                          ? Colors.white
                          : Colors.black38,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Q Bank',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.checklist_rtl_outlined,
                    color: controller.currentIndex.value == 3
                        ? Colors.white
                        : Colors.black38,
                    size: 0.08.toWidthPercent(),
                  ),
                  label: 'Test Series',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.video_call_outlined,
                    color: controller.currentIndex.value == 4
                        ? Colors.white
                        : Colors.black38,
                    size: 0.08.toWidthPercent(),
                  ),
                  label: 'Videos',
                ),
              ],
            ),
          ),
        ),
      ),
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

  Widget _buildHomeContent(HomeController controller) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.to(() => const SettingsScreen());
            },
            icon: Icon(Icons.settings_outlined),
          ),
          elevation: 0,
          title: Obx(
            () =>
                (Get.find<UserController>().userModel.value!.name != null &&
                    Get.find<UserController>().userModel.value!.name!.isNotEmpty)
                ? RichText(
                    text: TextSpan(
                      text: 'Hello, ',
                      style: TextStyle(
                        fontSize: 0.05.toWidthPercent(),
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              Get.find<UserController>().userModel.value!.name,
                          style: TextStyle(
                            fontSize: 0.05.toWidthPercent(),
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 0.05.toWidthPercent(),
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.bookmark_border,
                color: Colors.black,
                size: 0.07.toWidthPercent(),
              ),
              onPressed: () => Get.to(() => BookmarkScreen()),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Module Completed Card
                Container(
                  padding: EdgeInsets.all(0.05.toWidthPercent()),
                  decoration: const BoxDecoration(color: AppColors.primary),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          //color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(homeLogo1),
                      ),
                      SizedBox(width: 0.02.toWidthPercent()),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                'Module Completed: ${controller.moduleCompleted.value}',
                                style: TextStyle(
                                  fontSize: 0.045.toWidthPercent(),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 0.01.toHeightPercent()),
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                0.03.toWidthPercent(),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => const SubscriptionScreen());
                                  // Get.showSnackbar(
                                  //   GetSnackBar(
                                  //     message: 'Coming Soon',
                                  //     backgroundColor: AppColors.primary,
                                  //     duration: Duration(seconds: 2),
                                  //     snackPosition: SnackPosition.TOP,
                                  //     isDismissible: true,
                                  //   ),
                                  // );
                                },
                                borderRadius: BorderRadius.circular(
                                  0.03.toWidthPercent(),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 0.03.toWidthPercent(),
                                    vertical: 0.005.toHeightPercent(),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                      0.03.toWidthPercent(),
                                    ),
                                  ),
                                  child: Text(
                                    'Pro Version',
                                    style: TextStyle(
                                      fontSize: 0.03.toWidthPercent(),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // MCQ of the Day
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.015.toHeightPercent(),
                  ),
                  child: Center(
                    child: Text(
                      'MCQ OF THE Day',
                      style: TextStyle(
                        fontSize: 0.035.toWidthPercent(),
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: controller.getMcqOfTheDay(),
                  builder: (context, snapshot) {
                    print("snapshot: ${snapshot.data}");
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final mcq = snapshot.data as DailyMcqModel;
                      print("mcq asaass: ${mcq.correctAnswer.toString()}");
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 0.04.toWidthPercent(),
                        ),
                        padding: EdgeInsets.all(0.05.toWidthPercent()),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            0.04.toWidthPercent(),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   mcq!.question.text,
                            //   style: TextStyle(
                            //     fontSize: 0.04.toWidthPercent(),
                            //     fontWeight: FontWeight.bold,
                            //     color: AppColors.primary,
                            //   ),
                            // ),

                            // Replace this:
                            // Text(
                            //   mcq!.question.text,
                            //   style: TextStyle(
                            //     fontSize: 0.04.toWidthPercent(),
                            //     fontWeight: FontWeight.bold,
                            //     color: AppColors.primary,
                            //   ),
                            // ),

// With this:
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    mcq!.question.text,
                                    style: TextStyle(
                                      fontSize: 0.04.toWidthPercent(),
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                // Bookmark button with popup menu
                                // Obx(() {
                                //   final bookmarkCtrl = Get.find<BookmarkController>();
                                //   // Use a unique key per MCQ id
                                //   final isBookmarked = bookmarkCtrl.isBookmarked(mcq.id);
                                //   final category = bookmarkCtrl.getCategory(mcq.id);
                                //
                                //   Color iconColor;
                                //   if (!isBookmarked) {
                                //
                                //     iconColor = AppColors.primary.withOpacity(0.5);
                                //   } else {
                                //     switch (category) {
                                //       case 'mostimportant':
                                //         iconColor = Colors.red;
                                //         break;
                                //       case 'veryimportant':
                                //         iconColor = Colors.orange;
                                //         break;
                                //       case 'important':
                                //         iconColor = Colors.blue;
                                //         break;
                                //
                                //       default:
                                //         iconColor = AppColors.primary;
                                //     }
                                //   }
                                //
                                //   return PopupMenuButton<String>(
                                //     icon: Icon(
                                //       isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                //       color: iconColor,
                                //       size: 0.06.toWidthPercent(),
                                //     ),
                                //     onSelected: (value) {
                                //       Get.find<BookmarkController>().toggleBookmark(
                                //         type: "mcq",
                                //         itemId: mcq.id,
                                //         category: value,
                                //       );
                                //     },
                                //     itemBuilder: (context) => [
                                //       _buildPopupItem('mostimportant', 'Most Important', Colors.red),
                                //       _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
                                //       _buildPopupItem('important', 'Important', Colors.blue),
                                //       // _buildPopupItem('remove', 'remove', Colors.grey),
                                //     ],
                                //   );
                                // }),

                                Obx(() {
                                  // final bookmarkCtrl = Get.put(BookmarkController());
                                  final bookmarkCtrl = Get.find<BookmarkController>();
                                  final isBookmarked = bookmarkCtrl.isBookmarked(mcq.id);
                                  final category = bookmarkCtrl.getCategory(mcq.id);

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
                                        type: "mcq",
                                        itemId: mcq.id,
                                        category: value,
                                      );
                                    },
                                    itemBuilder: (context) => [
                                      _buildPopupItem('mostimportant', 'Most Important', Colors.red),
                                      _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
                                      _buildPopupItem('important', 'Important', Colors.blue),
                                      _buildPopupItem('removed', 'remove', Colors.grey),
                                    ],
                                  );
                                })
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 0.01.toHeightPercent(),
                              ),
                              child: Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                              ),
                            ),
                            SizedBox(height: 0.01.toHeightPercent()),
                            // Options
                            Obx(
                              () => Column(
                                children: List.generate(mcq.options.length, (
                                  index,
                                ) {
                                  final option = mcq.options[index];
                                  final isSelected = controller.selectedAnswerIndex.value == index;
                                  final isCorrect = index == mcq.correctAnswer;
                                  final isAnswered = controller.isAnswered.value;

                                  Color bgColor = const Color(0xFFEAFEFE);
                                  Color textColor = Colors.black87;

                                  if (isAnswered) {
                                    if (isCorrect) {
                                      bgColor = const Color(
                                        0xFFA5F482,
                                      ); // Green for correct
                                      textColor = Colors.white;
                                    } else if (isSelected) {
                                      bgColor = const Color(
                                        0xFFFFA07A,
                                      ); // Red for wrong selected
                                      textColor = Colors.white;
                                    }
                                  }

                                  return Container(
                                    margin: EdgeInsets.only(
                                      bottom: 0.015.toHeightPercent(),
                                    ),
                                    child: Material(
                                      color: bgColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          0.01.toWidthPercent(),
                                        ),
                                        side: BorderSide(
                                          color: isSelected && !isAnswered
                                              ? AppColors.primary
                                              : const Color(0xFFD7FFFF),
                                          width: isSelected && !isAnswered
                                              ? 2
                                              : 1,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: isAnswered
                                            ? null
                                            : () => controller.selectAnswer(
                                                option.text,
                                                index,
                                              ),
                                        borderRadius: BorderRadius.circular(
                                          0.01.toWidthPercent(),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            0.04.toWidthPercent(),
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                    0.015.toWidthPercent(),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: isAnswered ? (isCorrect ? Colors.white.withOpacity(0.3,) : (isSelected ? Colors.white.withOpacity(0.3,) : AppColors.primary)) : AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(0.01.toWidthPercent(),),
                                                  ),
                                                  child: Text(
                                                    String.fromCharCode(
                                                      65 + index,
                                                    ), // A, B, C, D
                                                    style: TextStyle(
                                                      fontSize: 0.035
                                                          .toWidthPercent(),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 0.03.toWidthPercent(),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    option.text,
                                                    style: TextStyle(
                                                      fontSize: 0.038
                                                          .toWidthPercent(),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: textColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),

                            SizedBox(height: 0.02.toHeightPercent()),
                            // Submit Button
                            Obx(
                              () => !controller.isAnswered.value
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed:
                                            controller.selectedAnswer.value !=
                                                null
                                            ? () => controller
                                                  .submitDailyMcqAnswer(mcq.id)
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: Colors.white,
                                          disabledBackgroundColor:
                                              Colors.grey[300],
                                          padding: EdgeInsets.symmetric(
                                            vertical: 0.015.toHeightPercent(),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              0.02.toWidthPercent(),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Submit Answer',
                                          style: TextStyle(
                                            fontSize: 0.04.toWidthPercent(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(
                                        0.03.toWidthPercent(),
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            controller
                                                    .selectedAnswerIndex
                                                    .value ==
                                                mcq.correctAnswer
                                            ? const Color(0xFFA5F482)
                                            : const Color(0xFFFFA07A),
                                        borderRadius: BorderRadius.circular(
                                          0.02.toWidthPercent(),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            controller
                                                        .selectedAnswerIndex
                                                        .value ==
                                                    mcq.correctAnswer
                                                ? Icons.check_circle
                                                : Icons.cancel,
                                            color: Colors.white,
                                            size: 0.06.toWidthPercent(),
                                          ),
                                          SizedBox(
                                            width: 0.02.toWidthPercent(),
                                          ),
                                          Text(
                                            controller
                                                        .selectedAnswerIndex
                                                        .value ==
                                                    mcq.correctAnswer
                                                ? 'Correct Answer!'
                                                : 'Wrong Answer!',
                                            style: TextStyle(
                                              fontSize: 0.045.toWidthPercent(),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            // View Explanation Button - Only show after answering
                            Obx(
                              () => controller.isAnswered.value
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 0.02.toHeightPercent(),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: controller.togglePearl,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.primary,
                                              foregroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 0.012
                                                    .toHeightPercent(),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      0.02.toWidthPercent(),
                                                    ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  controller.showPearl.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  size: 0.045.toWidthPercent(),
                                                ),
                                                SizedBox(
                                                  width: 0.02.toWidthPercent(),
                                                ),
                                                Text(
                                                  controller.showPearl.value
                                                      ? 'Hide Explanation'
                                                      : 'View Explanation',
                                                  style: TextStyle(
                                                    fontSize: 0.04
                                                        .toWidthPercent(),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                            ),
                            // Explanation Section - Animated visibility
                            // Obx(
                            //   () => AnimatedSize(
                            //     duration: Duration(milliseconds: 300),
                            //     curve: Curves.easeInOut,
                            //     child: controller.showPearl.value
                            //         ? Column(
                            //             children: [
                            //               SizedBox(
                            //                 height: 0.02.toHeightPercent(),
                            //               ),
                            //               Container(
                            //                 width: double.infinity,
                            //                 padding: EdgeInsets.all(
                            //                   0.04.toWidthPercent(),
                            //                 ),
                            //                 decoration: BoxDecoration(
                            //                   color: const Color(0xFFF0F9FF),
                            //                   borderRadius:
                            //                       BorderRadius.circular(
                            //                         0.03.toWidthPercent(),
                            //                       ),
                            //                   border: Border.all(
                            //                     color: AppColors.primary,
                            //                     width: 1.5,
                            //                   ),
                            //                 ),
                            //                 child: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     Row(
                            //                       children: [
                            //                         Icon(
                            //                           Icons.lightbulb_outline,
                            //                           color: AppColors.primary,
                            //                           size: 0.05
                            //                               .toWidthPercent(),
                            //                         ),
                            //                         SizedBox(
                            //                           width: 0.02
                            //                               .toWidthPercent(),
                            //                         ),
                            //                         Text(
                            //                           'Explanation',
                            //                           style: TextStyle(
                            //                             fontSize: 0.042
                            //                                 .toWidthPercent(),
                            //                             fontWeight:
                            //                                 FontWeight.bold,
                            //                             color: const Color(
                            //                               0xFF6FEDFA,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                     SizedBox(
                            //                       height: 0.015
                            //                           .toHeightPercent(),
                            //                     ),
                            //                     Divider(
                            //                       color: AppColors.primary
                            //                           .withOpacity(0.3),
                            //                       thickness: 1,
                            //                     ),
                            //                     SizedBox(
                            //                       height: 0.01
                            //                           .toHeightPercent(),
                            //                     ),
                            //                     Text(
                            //                       mcq.explanation.text ??
                            //                           'No explanation available',
                            //                       style: TextStyle(
                            //                         fontSize: 0.037
                            //                             .toWidthPercent(),
                            //                         height: 1.5,
                            //                         color: Colors.black87,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ],
                            //           )
                            //         : SizedBox(),
                            //   ),
                            // ),

                            // Obx(() {
                            //   // ------------------ Important change yaha ------------------
                            //   final bookmarkCtrl = Get.find<BookmarkController>();   // ←← Get.put mat likhna
                            //
                            //   final isBookmarked = bookmarkCtrl.isBookmarked(mcq.id);
                            //   final category = bookmarkCtrl.getCategory(mcq.id);
                            //
                            //   Color iconColor = AppColors.primary.withOpacity(0.5); // default
                            //
                            //   if (isBookmarked) {
                            //     switch (category) {
                            //       case 'mostimportant':
                            //         iconColor = Colors.red;
                            //         break;
                            //       case 'veryimportant':
                            //         iconColor = Colors.orange;
                            //         break;
                            //       case 'important':
                            //         iconColor = Colors.blue;
                            //         break;
                            //       default:
                            //         iconColor = AppColors.primary;
                            //     }
                            //   }
                            //
                            //   return PopupMenuButton<String>(
                            //     icon: Icon(
                            //       isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            //       color: iconColor,
                            //       size: 0.06.toWidthPercent(),
                            //     ),
                            //     onSelected: (value) {
                            //       bookmarkCtrl.toggleBookmark(
                            //         type: "mcq",
                            //         itemId: mcq.id,
                            //         category: value,
                            //       );
                            //     },
                            //     itemBuilder: (context) => [
                            //       _buildPopupItem('mostimportant', 'Most Important', Colors.red),
                            //       _buildPopupItem('veryimportant', 'Very Important', Colors.orange),
                            //       _buildPopupItem('important', 'Important', Colors.blue),
                            //     ],
                            //   );
                            // })

                          ],
                        ),
                      );
                    } else {
                      return Center(child: Text('No MCQ of the day found'));
                    }
                  },
                ),

                SizedBox(height: 0.04.toHeightPercent()),

                // Pearls Card
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 0.04.toWidthPercent(),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4DF42),
                    borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
                    child: InkWell(
                      onTap: () => Get.to(() => const PearlsScreen()),
                      borderRadius: BorderRadius.circular(
                        0.04.toWidthPercent(),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(0.05.toWidthPercent()),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Codon',
                                  style: TextStyle(
                                    fontSize: 0.055.toWidthPercent(),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    '${controller.pearlsCount.value}',
                                    style: TextStyle(
                                      fontSize: 0.035.toWidthPercent(),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Image.asset(
                              booksImage,
                              width: 0.12.toWidthPercent(),
                              height: 0.12.toWidthPercent(),
                            ),

                            SizedBox(width: 0.02.toWidthPercent()),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 0.06.toWidthPercent(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 0.1.toHeightPercent()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOption(String option, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 0.015.toHeightPercent()),
        padding: EdgeInsets.all(0.04.toWidthPercent()),
        decoration: BoxDecoration(
          color: const Color(0xFFEAFEFE),
          border: Border.all(color: const Color(0xFFD7FFFF), width: 1),
          borderRadius: BorderRadius.circular(0.01.toWidthPercent()),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            option,
            style: TextStyle(
              fontSize: 0.038.toWidthPercent(),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}