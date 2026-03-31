import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class RateUsScreen extends StatelessWidget {
  const RateUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: 'Rate Us'),
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
                  HtmlWidget("""
                  <!DOCTYPE html>
                  <html>
                  <head>
                      <meta charset="UTF-8">
                      <meta name="viewport" content="width=device-width, initial-scale=1.0">
                      <style>
                          body {
                              font-family: Arial, sans-serif;
                              line-height: 1.6;
                              color: #333;
                          }
                          h1, h2 {
                              color: #000;
                          }
                          .section {
                              margin-bottom: 25px;
                          }
                          .rate-link {
                              display: block;
                              margin: 12px 0;
                              font-size: 16px;
                          }
                      </style>
                  </head>
                  <body>

                      <h1>RATE US</h1>

                      <p><strong> Codon Classes & MMM — Mind Mentor Mitra</strong></p>

                      <div class="section">
                          <h2>Love Our App? ⭐</h2>
                          <p>
                              Your feedback helps us improve and serve you better.
                              Please take a moment to rate us on the Play Store.
                          </p>

                          <a class="rate-link" href="https://play.google.com/store/apps/details?id=com.testmee.app&pcampaignid=web_share">
                              ⭐ Rate Us on Play Store
                          </a>
                      </div>

                      <div class="section">
                          <h2>Share Your Feedback</h2>
                          <p>
                              📧 Email us at:
                              <a href="mailto:codonneetug@gmail.com">
                                  codonneetug@gmail.com
                              </a>
                          </p>
                      </div>

                      <p><strong>Thank you for your support! ❤️</strong></p>

                  </body>
                  </html>
                  """),
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