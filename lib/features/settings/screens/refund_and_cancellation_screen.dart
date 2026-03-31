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

class RefundAndCancellationPolicyScreen extends StatelessWidget {
  const RefundAndCancellationPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: 'Refund & Cancellation Policy'),
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
                    <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <style>
                            body {
                                font-family: Arial, sans-serif;
                                line-height: 1.6;
                                margin: 40px;
                                color: #333;
                            }
                            h1, h2 {
                                color: #000;
                            }
                            .section {
                                margin-bottom: 30px;
                            }
                            .contact {
                                margin-top: 20px;
                            }
                        </style>
                    </head>
                    <body>

                        <h1>REFUND & CANCELLATION POLICY</h1>

                        <p><strong>Codon Classes & MMM — Mind Mentor Mitra</strong><br>
                        Website: <a href="https://www.codonneetug.com" target="_blank">www.codonneetug.com</a><br>
                        Email: <a href="mailto:codonneetug@gmail.com">codonneetug@gmail.com</a><br>
                        Phone: +91 9987134790</p>

                        <p><strong>Last Updated:</strong> February 2026</p>

                        <div class="section">
                            <h2>1. Introduction</h2>
                            <p>
                                This Refund and Cancellation Policy outlines the terms under which payments made for courses,
                                mentorship programs, or services offered by Codon Classes and MMM (Mind Mentor Mitra)
                                may be cancelled or refunded.
                            </p>
                            <p>
                                By enrolling in our programs or purchasing our services, you agree to this policy.
                            </p>
                        </div>

                        <div class="section">
                            <h2>2. General Policy</h2>
                            <p>
                                All purchases made for courses, mentorship programs, study materials, or services are considered final.
                            </p>
                            <p>
                                Due to the digital nature of our content and immediate access to learning materials,
                                refunds are generally not applicable once access has been granted.
                            </p>
                        </div>

                        <div class="section">
                            <h2>3. Cancellation Policy</h2>
                            <p>
                                Users may request cancellation of enrollment before access to course content or services has been granted.
                            </p>
                            <p>
                                Once the course, mentorship session, or digital content access has been activated,
                                cancellation requests will not be accepted.
                            </p>
                        </div>

                        <div class="section">
                            <h2>4. Refund Eligibility</h2>
                            <p>Refunds may be considered only under the following circumstances:</p>
                            <ul>
                                <li>Duplicate payment made due to technical error</li>
                                <li>Payment made but access not provided within a reasonable time</li>
                                <li>Transaction failure where amount is deducted but service not activated</li>
                                <li>Cancellation requested before access activation</li>
                            </ul>
                            <p>
                                Any approved refund will be processed at the sole discretion of Codon Classes.
                            </p>
                        </div>

                        <div class="section">
                            <h2>5. Non-Refundable Situations</h2>
                            <p>Refunds will not be provided in the following cases:</p>
                            <ul>
                                <li>Change of mind after enrollment</li>
                                <li>Lack of usage of services</li>
                                <li>Dissatisfaction due to personal expectations</li>
                                <li>Failure to clear exams</li>
                                <li>Partial use of course or mentorship</li>
                                <li>Missed sessions or inactivity</li>
                                <li>Technical issues at user’s device or internet</li>
                                <li>Violation of terms or misconduct</li>
                            </ul>
                        </div>

                        <div class="section">
                            <h2>6. MMM Mentorship Sessions</h2>
                            <p>
                                Fees paid for mentorship sessions under MMM are non-refundable once the session has been scheduled or conducted.
                            </p>
                            <p>
                                Rescheduling may be allowed subject to availability and prior notice.
                            </p>
                        </div>

                        <div class="section">
                            <h2>7. Refund Process</h2>
                            <p>
                                If eligible, refunds will be processed within 7–14 working days through the original payment method.
                            </p>
                            <p>
                                Processing timelines may vary depending on banks or payment providers.
                            </p>
                        </div>

                        <div class="section">
                            <h2>8. Course Transfers</h2>
                            <p>
                                Course enrollments are non-transferable and cannot be transferred to another user or future batch
                                unless explicitly approved by Codon Classes.
                            </p>
                        </div>

                        <div class="section">
                            <h2>9. Exceptional Circumstances</h2>
                            <p>
                                In rare or genuine cases, refund requests may be reviewed individually.
                                The final decision will remain solely with Codon Classes management.
                            </p>
                        </div>

                        <div class="section">
                            <h2>10. Changes to Policy</h2>
                            <p>
                                Codon Classes reserves the right to modify this policy at any time without prior notice.
                                Updated versions will be posted on the website.
                            </p>
                        </div>

                        <div class="section contact">
                            <h2>11. Contact for Refund Requests</h2>
                            <p>
                                For any cancellation or refund request, please contact:
                            </p>
                            <p>
                                📧 <a href="mailto:codonneetug@gmail.com">codonneetug@gmail.com</a><br>
                                📞 +91 9987134790<br>
                                🌐 <a href="https://www.codonneetug.com" target="_blank">www.codonneetug.com</a>
                            </p>
                        </div>
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
