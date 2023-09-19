import 'dart:convert';
import 'package:newapp/model/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharereferenceApp {
  static saveListData(String key, List value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = jsonEncode(value);
    await prefs.setString(key, data);
  }

  static getListData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(key);
    List data = jsonDecode(action ?? '[]');
    List<int> result = List<int>.from(data);
    return result;
  }
}
