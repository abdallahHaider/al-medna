import 'dart:convert';
import 'package:admin/api%20server/api_servers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BudgetController extends ChangeNotifier {
  Map<String, dynamic> budget = {};
  bool isLoading = true; // حالة التحميل

  double subUSD = 0;
  double subIQD = 0;
  double addbUSD = 0;
  double addbIQD = 0;

  updede() {
    notifyListeners();
  }

  Future getBuget() async {
    print("جلب البيانات جارٍ...");
    isLoading = true; // بدء التحميل
    notifyListeners();

    Response x;
    try {
      x = await getpi("/api/buget");
      var data = jsonDecode(x.body);
      print(x.body);
      budget = data;
    } catch (e) {
      print(e);
      throw "حصل خطأ في إرسال البيانات";
    } finally {
      isLoading = false; // إنهاء التحميل
      notifyListeners();
    }
  }
}
