import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PosthogService {
  Future<List<Map<String, dynamic>>> fetchSurveys() async {
    final response = await http.get(
      Uri.parse('https://app.posthog.com/api/surveys/'),
      headers: {
        'Authorization':
            'Bearer phc_za6nWkOZPQYfJGPGQff8tucXXvk2WbxlQMhHz9RENKK',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> surveys = jsonDecode(response.body);
      return surveys.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load surveys');
    }
  }

  void showSurveyDialog(Map<String, dynamic> survey) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text(survey['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: (survey['questions'] as List).map((question) {
              return ListTile(
                title: Text(question['text']),
                onTap: () {
                  // Umfrageantwort senden
                  sendSurveyResponse(survey['id'], question['id']);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void sendSurveyResponse(String surveyId, String questionId) async {
    final response = await http.post(
      Uri.parse('https://app.posthog.com/api/surveys/$surveyId/responses/'),
      headers: {
        'Authorization':
            'Bearer phc_za6nWkOZPQYfJGPGQff8tucXXvk2WbxlQMhHz9RENKK',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'question_id': questionId}),
    );

    if (response.statusCode != 200) {
      print('Failed to submit response');
    }
  }
}
