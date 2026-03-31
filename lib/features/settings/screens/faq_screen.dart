import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utills/widgets/default_appbar.dart';

class FaqModel {
  final String id;
  final String question;
  final String answer;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['_id'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  List<FaqModel> faqList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getFaq();
  }

  Future<void> getFaq() async {

    final response = await http.get(
      Uri.parse("https://api.codonneetug.com/api/faq"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List list = data['data'];

      setState(() {
        faqList = list.map((e) => FaqModel.fromJson(e)).toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(""),
      //   centerTitle: true,
      // ),
      appBar: DefaultAppBar(title: 'FAQ'),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/pngs/FAQ.png"),
              SizedBox(height: 30,),
              Expanded(
                child: ListView.builder(
                        itemCount: faqList.length,
                        itemBuilder: (context, index) {

                final faq = faqList[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 8),

                  child: ExpansionTile(
                    title: Text(
                      faq.question,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          faq.answer,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      )
                    ],
                  ),
                );
                        },
                      ),
              ),
            ],
          ),
    );
  }
}