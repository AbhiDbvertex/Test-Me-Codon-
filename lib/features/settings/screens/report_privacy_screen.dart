import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utills/constants.dart';

class ReportPrivacyScreen extends StatefulWidget {
  const ReportPrivacyScreen({super.key});

  @override
  State<ReportPrivacyScreen> createState() => _ReportPrivacyScreenState();
}

class _ReportPrivacyScreenState extends State<ReportPrivacyScreen> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  Future<void> _sendReport() async {
    final String subject = subjectController.text.trim();
    final String message = messageController.text.trim();

    if (subject.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'codonneetug@gmail.com',
      query:
      'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(message)}',
    );

    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: 'Report Piracy Concern'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0.06.toWidthPercent()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            SizedBox(height: 0.02.toHeightPercent()),
            Center(
              child: SvgPicture.asset(
                privacyPolicyImg,
                width: 0.6.toWidthPercent(),
                height: 0.25.toHeightPercent(),
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "Report a Piracy Issue 🔒",
              style: TextStyle(
                fontSize: 0.05.toWidthPercent(),
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 0.02.toHeightPercent()),

            Text(
              "If you have any concerns regarding data privacy or misuse of information, please describe the issue below.",
              style: TextStyle(
                fontSize: 0.038.toWidthPercent(),
                color: Colors.grey[700],
              ),
            ),

            SizedBox(height: 0.05.toHeightPercent()),

            /// Subject Field
            /// Subject Field
            /// Subject Label
            Text(
              "Subject",
              style: TextStyle(
                fontSize: 0.04.toWidthPercent(),
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 6),

            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                hintText: "Enter subject",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
            ),

            SizedBox(height: 0.03.toHeightPercent()),

            /// Describe Issue Label
            Text(
              "Describe your issue",
              style: TextStyle(
                fontSize: 0.04.toWidthPercent(),
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 6),

            TextField(
              controller: messageController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write details about your Piracy concern",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
            ),

            //
            SizedBox(height: 0.05.toHeightPercent()),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sendReport,
                child: const Text("Submit Report"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}