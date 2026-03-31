import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../subscription/screens/subscription_screen.dart';

class OurPlansScreen extends StatelessWidget {
  const OurPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: 'Our Plans'),
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
                  SubscriptionScreen(),
                  // HtmlWidget("""
                  // <!DOCTYPE html>
                  // <html>
                  // <head>
                  //     <meta charset="UTF-8">
                  //     <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  //     <style>
                  //         body {
                  //             font-family: Arial, sans-serif;
                  //             line-height: 1.6;
                  //             color: #333;
                  //         }
                  //         .plan {
                  //             border: 1px solid #ddd;
                  //             padding: 20px;
                  //             margin-bottom: 20px;
                  //             border-radius: 10px;
                  //         }
                  //         .price {
                  //             font-size: 22px;
                  //             font-weight: bold;
                  //             color: #000;
                  //         }
                  //         .highlight {
                  //             color: #e91e63;
                  //             font-weight: bold;
                  //         }
                  //     </style>
                  // </head>
                  // <body>
                  //
                  //     <h1>OUR PLANS</h1>
                  //
                  //     <div class="plan">
                  //         <h2>Basic Plan</h2>
                  //         <p class="price">₹ 999 / Month</p>
                  //         <ul>
                  //             <li>Access to Recorded Classes</li>
                  //             <li>Study Materials</li>
                  //             <li>Basic Test Series</li>
                  //         </ul>
                  //     </div>
                  //
                  //     <div class="plan">
                  //         <h2>Pro Plan</h2>
                  //         <p class="price highlight">₹ 2,499 / 3 Months</p>
                  //         <ul>
                  //             <li>All Basic Features</li>
                  //             <li>Advanced Test Series</li>
                  //             <li>Doubt Support</li>
                  //         </ul>
                  //     </div>
                  //
                  //     <div class="plan">
                  //         <h2>Premium Plan</h2>
                  //         <p class="price highlight">₹ 4,999 / 6 Months</p>
                  //         <ul>
                  //             <li>All Pro Features</li>
                  //             <li>1-to-1 Mentorship (MMM)</li>
                  //             <li>Priority Support</li>
                  //         </ul>
                  //     </div>
                  //
                  //     <p><strong>For enrollment contact us via WhatsApp or call.</strong></p>
                  //
                  // </body>
                  // </html>
                  // """),

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