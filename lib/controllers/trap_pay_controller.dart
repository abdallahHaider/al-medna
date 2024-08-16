import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/trap_pay.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;

class TrapPayController extends ChangeNotifier {
  List resellerss = [];
  int page = 1;

  void addpage(int mepage) {
    if (page > 1) {
      page = page + mepage;
      notifyListeners();
    }
  }

  Future<List> fetchData() async {
    // Simulate fetching data (replace with your actual logic)
    // await Future.delayed(Duration(seconds: 1));

    try {
      var x = await getpi("/api/trap_pay/index?page=$page");
      var data = jsonDecode(x.body)["data"];
      print(jsonDecode(x.body));
      final List resellers =
          data.map((json) => TrapPay.fromJson(json)).toList();
      resellerss = resellers;
      return resellers;
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future getfetchData() async {
    // Simulate fetching data (replace with your actual logic)
    // await Future.delayed(Duration(seconds: 1));

    try {
      var x = await getpi("/api/trap_pay/index");
      var data = jsonDecode(x.body);
      print(jsonDecode(x.body));
      final List resellers =
          data.map((json) => TrapPay.fromJson(json)).toList();
      resellerss = resellers;
      notifyListeners();
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future addReseller(String name, String phone_number, String address,
      String rId, BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/trap_pay/create", {
        "cost": name,
        "reseller_id": rId,
        "pay_number": "0",
        "IQD_to_USD": address,
        "RAS_to_USD": "0"
      });
      notifyListeners();
      // Navigator.pop(context);

      snackBar(context, "تم اضافة التسديد بنجاح");
    } catch (e) {
      snackBar(context, e.toString());
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
    } else {
      snackBar(context, jsonDecode(x.body));
    }
  }

  Future delete(int id, BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/trap_pay/delete", {
        "reseller_id": id,
      });
      notifyListeners();
      Navigator.pop(context);

      snackBar(context, "تم حذف التسديد بنجاح");
    } catch (e) {
      snackBar(context, e.toString());
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
    } else {
      snackBar(context, jsonDecode(x.body));
    }
  }
}
