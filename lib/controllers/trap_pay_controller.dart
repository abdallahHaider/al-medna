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
    if (page > 0) {
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
      final List resellers =
          data.map((json) => TrapPay.fromJson(json)).toList();
      resellerss = resellers;
      return resellers;
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  // Future getfetchData() async {
  //   // Simulate fetching data (replace with your actual logic)
  //   // await Future.delayed(Duration(seconds: 1));

  //   try {
  //     var x = await getpi("/api/trap_pay/index");
  //     var data = jsonDecode(x.body);
  //     final List resellers =
  //         data.map((json) => TrapPay.fromJson(json)).toList();
  //     resellerss = resellers;
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     throw "jjj";
  //   }
  // }

  Future addReseller(String costUSD, String costIQD, String IQD_to_USD,
      String reseller_id, BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/trap_pay/create", {
        "cost_USD": costUSD,
        "cost_IQD": costIQD,
        "reseller_id": reseller_id,
        "pay_number": "0",
        "IQD_to_USD": IQD_to_USD,
        "RAS_to_USD": "0"
      });

      print(x.body);
    } catch (e) {
      print(e);
      snackBar(context, e.toString(), true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }

    if (x.statusCode == 200 || x.statusCode == 201) {
      notifyListeners();
      snackBar(context, "تم اضافة التسديد بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
      print(x.body);
      throw "fddd";
    }
  }

  Future delete(int id, BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/trap_pay/delete", {
        "id": id,
      });
    } catch (e) {
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      notifyListeners();
      Navigator.pop(context);
    } else {
      throw jsonDecode(x.body);
    }
  }

  Future updatePay(String id, cost) async {
    print("11111111111111111111111111111111111");
    print(id);
    http.Response x;
    try {
      x = await postApi("/api/trap_pay/update", {
        "id": id,
        "cost": cost,
      });
    } catch (e) {
      throw e;
    }
    if (x.statusCode == 200) {
      notifyListeners();
    } else {
      throw jsonDecode(x.body)["message"];
    }
  }
}
