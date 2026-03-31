import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ConnectWithUsScreen extends StatelessWidget {
  const ConnectWithUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: 'Connect With Us'),
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
                      privacyPolicyImg, // yaha aap connect image bhi laga sakte ho
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
                          .social-link {
                              display: block;
                              margin: 10px 0;
                              font-size: 16px;
                          }
                      </style>
                  </head>
                  <body>

                      <h1>CONNECT WITH US</h1>

                      <p><strong>Codon Classes & MMM — Mind Mentor Mitra</strong></p>

                      <div class="section">
                          <h2>Follow Us On</h2>

                          <a class="social-link" href="https://instagram.com/yourpage">
                              📸 Instagram
                          </a>

                          <a class="social-link" href="https://youtube.com/@yourchannel">
                              ▶️ YouTube
                          </a>

                          <a class="social-link" href="https://wa.me/919987134790">
                              💬 WhatsApp
                          </a>
                      </div>

                      <div class="section">
                          <h2>Contact Information</h2>
                          <p>
                              📧 Email: 
                              <a href="mailto:codonneetug@gmail.com">
                                  codonneetug@gmail.com
                              </a>
                          </p>
                          <p>
                              📞 Phone: +91 9987134790
                          </p>
                          <p>
                              🌐 Website: 
                              <a href="https://www.codonneetug.com">
                                  www.codonneetug.com
                              </a>
                          </p>
                      </div>

                      <div class="section">
                          <h2>Office Hours</h2>
                          <p>
                              Monday – Saturday: 9:00 AM – 6:00 PM<br>
                              Sunday: Closed
                          </p>
                      </div>

                      <p><strong>We are always happy to assist you!</strong></p>

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