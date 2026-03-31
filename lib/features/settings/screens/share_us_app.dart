import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class ShareUsScreen extends StatelessWidget {
  const ShareUsScreen({super.key});

  final String appLink =
      // "https://play.google.com/store/apps/details?id=your.app.id";
      "https://play.google.com/store/apps/details?id=com.testmee.app&pcampaignid=web_share";

  Future<void> _shareApp() async {
    await Share.share(
      "🚀 Check out Codon Classes App!\n\n"
          "Best platform for NEET preparation 📚\n\n"
          "Download now:\n$appLink",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: 'Share The App'),
      body: Padding(
        padding: EdgeInsets.all(0.06.toWidthPercent()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.share_rounded,
              size: 0.25.toWidthPercent(),
              color: Colors.blue,
            ),
            SizedBox(height: 0.05.toHeightPercent()),
            Text(
              "Share Codon Classes 📤",
              style: TextStyle(
                fontSize: 0.05.toWidthPercent(),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.02.toHeightPercent()),
            Text(
              "Enjoying the app? Share it with your friends and help them prepare better!",
              style: TextStyle(
                fontSize: 0.038.toWidthPercent(),
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.07.toHeightPercent()),

            /// Share Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _shareApp,
                icon: const Icon(Icons.share),
                label: const Text("Share Now"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.018.toHeightPercent(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}