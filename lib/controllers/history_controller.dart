import 'dart:async';
import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/history.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart';

class HistoryController extends ChangeNotifier {
  List history = [];
  bool isHistoryLoading = false;
  bool isHistoryError = false;

  Future<void> getHistory() async {
    Response x;
    isHistoryLoading = true;
    isHistoryError = false;
    notifyListeners();
    try {
      print(DateTime.now().toString().substring(0, 10));
      x = await getpi(
          "/api/daily_action/index?date=${DateTime.now().toString().substring(0, 10)}");
      // print(jsonDecode(x.body));
      if (x.statusCode == 200) {
        var data = jsonDecode(x.body);
        history = data.map((json) => History.fromJson(json)).toList();
        isHistoryLoading = false;
        isHistoryError = false;
        notifyListeners();
      } else {
        isHistoryLoading = false;
        isHistoryError = true;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      isHistoryLoading = false;
      isHistoryError = true;
      notifyListeners();
    }
  }

  // daily_action/restore

  Future<void> restoreHistory(BuildContext context, int id) async {
    Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/daily_action/restore", {"id": id});
      if (x.statusCode == 200) {
        await getHistory();
        snackBar(context, "تم التراجع بنجاح", false);
      } else {
        print(x.body);
        snackBar(context, jsonDecode(x.body)["message"], true);
        await getHistory();
        throw jsonDecode(x.body);
      }
    } catch (e) {
      print(e);
      snackBar(context, "حصل خطا غير متوقع", true);
      throw "حصل خطا غير متوقع";
    } finally {
      SmartDialog.dismiss();
    }
  }

  String getType(String type) {
    if (type == "update") {
      return "تعديل";
    }
    if (type == "add") {
      return "إضافة";
    }
    if (type == "delete") {
      return "حذف";
    } else {
      return "";
    }
  }
}
