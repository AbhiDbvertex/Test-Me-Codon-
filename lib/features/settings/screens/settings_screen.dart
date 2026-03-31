// import 'package:codon/features/settings/controllers/settings_controller.dart';
// import 'package:codon/utills/screen_size_utils.dart';
// import 'package:codon/utills/widgets/default_appbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final SettingsController controller = Get.find<SettingsController>();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: DefaultAppBar(title: 'Settings'),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 0.05.toWidthPercent()),
//         child: Column(
//           children: [
//             SizedBox(height: 0.02.toHeightPercent()),
//             _buildSettingsTile(
//               icon: Icons.person_outline,
//               title: 'Edit Profile',
//               onTap: () => controller.navigateTo('Edit Profile'),
//             ),
//             // _buildSettingsTile(
//             //   icon: Icons.info_outline,
//             //   title: 'My Favourites',
//             //   onTap: () => controller.navigateTo('My Favourites'),
//             // ),
//             // _buildSettingsTile(
//             //   icon: Icons.history,
//             //   title: 'History',
//             //   onTap: () => controller.navigateTo('History'),
//             // ),
//             _buildSettingsTile(
//               icon: Icons.contact_support_outlined,
//               title: 'About us',
//               onTap: () => controller.navigateTo('About us'),
//             ),
//             _buildSettingsTile(
//               icon: Icons.lock_outline,
//               title: 'PRIVACY',
//               onTap: () => controller.navigateTo('PRIVACY'),
//             ),
//             _buildSettingsTile(
//               icon: CupertinoIcons.refresh_circled,
//               title: 'Refund & Cancellation',
//               onTap: () =>
//                   controller.navigateTo('Refund & Cancellation Policy'),
//             ),
//             _buildSettingsTile(
//               icon: Icons.description_outlined,
//               title: 'Terms & Condition',
//               onTap: () => controller.navigateTo('Terms & Condition'),
//             ),
//             _buildSettingsTile(
//               icon: Icons.question_mark,
//               title: 'FAQ',
//               onTap: () => controller.navigateTo('faq'),
//             ),
//             _buildSettingsTile(
//               icon: Icons.password_outlined,
//               title: 'CHANGE PASSWORD',
//               onTap: () => controller.navigateTo('CHANGE PASSWORD'),
//             ),
//             _buildSettingsTile(
//               icon: Icons.call,
//               title: 'Connect with us',
//               onTap: () => controller.navigateTo('Connect with us'),
//             ),
//
//             _buildSettingsTile(
//               icon: Icons.workspace_premium_outlined,
//               title: 'Our Plans',
//               onTap: () => controller.navigateTo('Our Plans'),
//             ),
//
//             _buildSettingsTile(
//               icon: Icons.star_rate_outlined,
//               title: 'Rate Us',
//               onTap: () => controller.navigateTo('Rate Us'),
//             ),
//
//             _buildSettingsTile(
//               icon: Icons.share,
//               title: 'Share Us',
//               onTap: () => controller.navigateTo('Share Us'),
//             ),
//
//             _buildSettingsTile(
//               icon: Icons.report_problem_outlined,
//               title: 'Report Piracy',
//               onTap: () => controller.navigateTo('Report Privacy'),
//             ),
//             SizedBox(height: 0.05.toHeightPercent()),
//
//             _buildLogoutButton(controller),
//             SizedBox(height: 0.05.toHeightPercent()),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSettingsTile({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 0.05.toWidthPercent(),
//               vertical: 0.015.toHeightPercent(),
//             ),
//             child: Row(
//               children: [
//                 Icon(icon, color: Colors.black87, size: 0.06.toWidthPercent()),
//                 SizedBox(width: 0.04.toWidthPercent()),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 0.04.toWidthPercent(),
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   Icons.chevron_right,
//                   color: Colors.black54,
//                   size: 0.06.toWidthPercent(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget _buildLogoutButton(SettingsController controller) {
//   //   return Center(
//   //     child: Container(
//   //       decoration: BoxDecoration(
//   //         color: const Color(0xFFF8F8F8),
//   //         borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
//   //         boxShadow: [
//   //           BoxShadow(
//   //             color: Colors.black.withOpacity(0.08),
//   //             blurRadius: 10,
//   //             offset: const Offset(0, 6),
//   //           ),
//   //         ],
//   //       ),
//   //       child: Material(
//   //         color: Colors.transparent,
//   //         borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
//   //         child: InkWell(
//   //           onTap: controller.logout,
//   //           borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
//   //           child: Padding(
//   //             padding: EdgeInsets.symmetric(
//   //               horizontal: 0.1.toWidthPercent(),
//   //               vertical: 0.015.toHeightPercent(),
//   //             ),
//   //             child: Row(
//   //               mainAxisSize: MainAxisSize.min,
//   //               children: [
//   //                 Icon(
//   //                   Icons.logout,
//   //                   color: Colors.black,
//   //                   size: 0.05.toWidthPercent(),
//   //                 ),
//   //                 SizedBox(width: 0.02.toWidthPercent()),
//   //                 Text(
//   //                   'LOG OUT',
//   //                   style: TextStyle(
//   //                     fontSize: 0.04.toWidthPercent(),
//   //                     fontWeight: FontWeight.bold,
//   //                     color: Colors.black,
//   //                     letterSpacing: 1.1,
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   // Widget _buildLogoutButton(SettingsController controller) {
//   //   return Center(
//   //     child: Container(
//   //       decoration: BoxDecoration(
//   //         color: const Color(0xFFF8F8F8),
//   //         borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
//   //         boxShadow: [
//   //           BoxShadow(
//   //             color: Colors.black.withOpacity(0.08),
//   //             blurRadius: 10,
//   //             offset: const Offset(0, 6),
//   //           ),
//   //         ],
//   //       ),
//   //       child: Material(
//   //         color: Colors.transparent,
//   //         borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
//   //         child: InkWell(
//   //           onTap: () {
//   //             Get.defaultDialog(
//   //               title: "Logout",
//   //               middleText: "Are you sure you want to logout?",
//   //               textCancel: "Cancel",
//   //               textConfirm: "Logout",
//   //               confirmTextColor: Colors.white,
//   //               onConfirm: () {
//   //                 Get.back();
//   //                 controller.logout();
//   //               },
//   //             );
//   //           },
//   //           borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
//   //           child: Padding(
//   //             padding: EdgeInsets.symmetric(
//   //               horizontal: 0.1.toWidthPercent(),
//   //               vertical: 0.015.toHeightPercent(),
//   //             ),
//   //             child: Row(
//   //               mainAxisSize: MainAxisSize.min,
//   //               children: [
//   //                 Icon(
//   //                   Icons.logout,
//   //                   color: Colors.black,
//   //                   size: 0.05.toWidthPercent(),
//   //                 ),
//   //                 SizedBox(width: 0.02.toWidthPercent()),
//   //                 Text(
//   //                   'LOG OUT',
//   //                   style: TextStyle(
//   //                     fontSize: 0.04.toWidthPercent(),
//   //                     fontWeight: FontWeight.bold,
//   //                     color: Colors.black,
//   //                     letterSpacing: 1.1,
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget _buildLogoutButton(SettingsController controller) {
//     return Center(
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFFF8F8F8),
//           borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 10,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Material(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
//             onTap: () {
//               Get.generalDialog(
//                 barrierDismissible: true,
//                 barrierLabel: "Logout",
//                 transitionDuration: const Duration(milliseconds: 350),
//                 pageBuilder: (context, animation, secondaryAnimation) {
//                   return const SizedBox();
//                 },
//                 transitionBuilder: (context, animation, secondaryAnimation, child) {
//                   final curved =
//                   CurvedAnimation(parent: animation, curve: Curves.easeInOutBack);
//
//                   return ScaleTransition(
//                     scale: curved,
//                     child: FadeTransition(
//                       opacity: animation,
//                       child: Center(
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 40),
//                           padding: const EdgeInsets.all(22),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Material(
//                             color: Colors.transparent,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(
//                                   Icons.logout,
//                                   size: 50,
//                                   color: Colors.red,
//                                 ),
//                                 const SizedBox(height: 12),
//                                 const Text(
//                                   "Logout",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 const Text(
//                                   "Are you sure you want to logout?",
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     TextButton(
//                                       onPressed: () {
//                                         Get.back();
//                                       },
//                                       child: const Text("Cancel"),
//                                     ),
//                                     ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.red,
//                                       ),
//                                       onPressed: () {
//                                         Get.back();
//                                         controller.logout();
//                                       },
//                                       child: const Text("Logout"),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 0.1.toWidthPercent(),
//                 vertical: 0.015.toHeightPercent(),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.logout,
//                     color: Colors.black,
//                     size: 0.05.toWidthPercent(),
//                   ),
//                   SizedBox(width: 0.02.toWidthPercent()),
//                   Text(
//                     'LOG OUT',
//                     style: TextStyle(
//                       fontSize: 0.04.toWidthPercent(),
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                       letterSpacing: 1.1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }

import 'package:codon/features/settings/controllers/settings_controller.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.find<SettingsController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(title: 'Settings'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0.05.toWidthPercent()),
        child: Column(
          children: [
            SizedBox(height: 0.02.toHeightPercent()),

            // Normal Tiles
            _buildSettingsTile(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () => controller.navigateTo('Edit Profile'),
            ),

            _buildSettingsTile(
              icon: Icons.contact_support_outlined,
              title: 'About us',
              onTap: () => controller.navigateTo('About us'),
            ),

            _buildSettingsTile(
              icon: Icons.workspace_premium_outlined,
              title: 'Our Plans',
              onTap: () => controller.navigateTo('Our Plans'),
            ),

            _buildSettingsTile(
              icon: Icons.star_rate_outlined,
              title: 'Rate Us',
              onTap: () => controller.navigateTo('Rate Us'),
            ),

            _buildSettingsTile(
              icon: Icons.share,
              title: 'Share Us',
              onTap: () => controller.navigateTo('Share Us'),
            ),

            _buildSettingsTile(
              icon: Icons.report_problem_outlined,
              title: 'Report Piracy',
              onTap: () => controller.navigateTo('Report Privacy'),
            ),

            // ==================== OTHER DROPDOWN ====================
            _buildOtherDropdown(controller),

            SizedBox(height: 0.05.toHeightPercent()),
            _buildLogoutButton(controller),
            SizedBox(height: 0.05.toHeightPercent()),
          ],
        ),
      ),
    );
  }

  // ====================== OTHER DROPDOWN WIDGET ======================
  Widget _buildOtherDropdown(SettingsController controller) {
    return Obx(() => Container(
      margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Tile (Clickable)
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
            child: InkWell(
              borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
              onTap: () {
                controller.isOtherExpanded.value = !controller.isOtherExpanded.value;
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.05.toWidthPercent(),
                  vertical: 0.015.toHeightPercent(),
                ),
                child: Row(
                  children: [
                    Icon(Icons.more_horiz, color: Colors.black87, size: 0.06.toWidthPercent()),
                    SizedBox(width: 0.04.toWidthPercent()),
                    Expanded(
                      child: Text(
                        'Other',
                        style: TextStyle(
                          fontSize: 0.04.toWidthPercent(),
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Icon(
                      controller.isOtherExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.black54,
                      size: 0.06.toWidthPercent(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Expandable Content
          if (controller.isOtherExpanded.value) ...[
            const Divider(height: 1, thickness: 1, color: Colors.black12),
            _buildSubTile(
              icon: Icons.lock_outline,
              title: 'Privacy Policy',
              onTap: () => controller.navigateTo('PRIVACY'),
            ),
            _buildSubTile(
              icon: CupertinoIcons.refresh_circled,
              title: 'Refund & Cancellation',
              onTap: () => controller.navigateTo('Refund & Cancellation Policy'),
            ),
            _buildSubTile(
              icon: Icons.description_outlined,
              title: 'Terms & Condition',
              onTap: () => controller.navigateTo('Terms & Condition'),
            ),
            _buildSubTile(
              icon: Icons.question_mark,
              title: 'FAQ',
              onTap: () => controller.navigateTo('faq'),
            ),
          ],
        ],
      ),
    ));
  }

  // Sub Tile for dropdown items (without shadow)
  Widget _buildSubTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.05.toWidthPercent() + 0.06.toWidthPercent() + 0.04.toWidthPercent(), // icon + spacing
            vertical: 0.015.toHeightPercent(),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black87, size: 0.055.toWidthPercent()),
              SizedBox(width: 0.04.toWidthPercent()),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 0.038.toWidthPercent(),
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.black54,
                size: 0.055.toWidthPercent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Existing Settings Tile (unchanged)
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(0.04.toWidthPercent()),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.05.toWidthPercent(),
              vertical: 0.015.toHeightPercent(),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.black87, size: 0.06.toWidthPercent()),
                SizedBox(width: 0.04.toWidthPercent()),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 0.04.toWidthPercent(),
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.black54,
                  size: 0.06.toWidthPercent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Logout Button (same as you had)
  Widget _buildLogoutButton(SettingsController controller) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
          child: InkWell(
            borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
            onTap: () {
              Get.generalDialog(
                barrierDismissible: true,
                barrierLabel: "Logout",
                transitionDuration: const Duration(milliseconds: 350),
                pageBuilder: (context, animation, secondaryAnimation) => const SizedBox(),
                transitionBuilder: (context, animation, secondaryAnimation, child) {
                  final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOutBack);
                  return ScaleTransition(
                    scale: curved,
                    child: FadeTransition(
                      opacity: animation,
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.logout, size: 50, color: Colors.red),
                              const SizedBox(height: 12),
                              const Text("Logout", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              const Text("Are you sure you want to logout?", textAlign: TextAlign.center),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    onPressed: () {
                                      Get.back();
                                      controller.logout();
                                    },
                                    child: const Text("Logout"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.1.toWidthPercent(),
                vertical: 0.015.toHeightPercent(),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout, color: Colors.black, size: 0.05.toWidthPercent()),
                  SizedBox(width: 0.02.toWidthPercent()),
                  Text(
                    'LOG OUT',
                    style: TextStyle(
                      fontSize: 0.04.toWidthPercent(),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}