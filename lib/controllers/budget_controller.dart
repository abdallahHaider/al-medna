import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BudgetController extends ChangeNotifier {
  Map<String, dynamic> budget = {};
  Future getBuget() async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Response x;
    try {
      x = await getpi("/api/buget");
      var data = jsonDecode(x.body);
      print(x.body);
      budget = data;
      // banks = data.map((json) => Bank.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }
}
