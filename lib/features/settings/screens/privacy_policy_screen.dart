import 'package:codon/features/settings/controllers/settings_controller.dart';
import 'package:codon/features/settings/services/setting_service.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: 'Privacy Policy'),
      body: Column(
        children: [
          SizedBox(height: 0.02.toHeightPercent()),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(0.06.toWidthPercent()),
              child: Column(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      privacyPolicyImg,
                      width: 0.6.toWidthPercent(),
                      height: 0.25.toHeightPercent(),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 0.04.toHeightPercent()),
                  FutureBuilder(
                    future: Get.find<SettingsController>().getPrivacyPolicy(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final data = snapshot.data!;
                        return HtmlWidget(data);
                      }
                    },
                  ),
                  SizedBox(height: 0.04.toHeightPercent()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
