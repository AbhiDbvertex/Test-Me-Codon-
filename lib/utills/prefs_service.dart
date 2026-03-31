import 'dart:convert';

import 'package:codon/features/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static saveAccessToken({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
  }

  static getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static saveRefreshToken({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('refresh_token', token);
  }

  static getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  static Future<bool> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static saveUser({required UserModel user}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));
  }

  static getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return UserModel.fromJson(jsonDecode(prefs.getString('user')!));
  }

  static Future<void> saveDailyMcqAnswer(String mcqId, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('daily_mcq_$mcqId', index);
  }

  static Future<int?> getDailyMcqAnswer(String mcqId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('daily_mcq_$mcqId');
  }
}
