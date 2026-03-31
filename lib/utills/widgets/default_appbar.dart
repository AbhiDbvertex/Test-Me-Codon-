import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const DefaultAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,

      elevation: 2,
      centerTitle: true,
      leadingWidth: 0.2.toWidthPercent(),
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0.01.toHeightPercent()),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0.08.toWidthPercent()),
              bottomRight: Radius.circular(0.08.toWidthPercent()),
            ),
          ),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 0.06.toWidthPercent(),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 0.05.toWidthPercent(),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0.08.toHeightPercent());
}
