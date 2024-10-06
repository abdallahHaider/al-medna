import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/models/reseller_dbet.dart';
import 'package:admin/models/trap.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;

import '../models/trap_pay.dart';

class ResellerController extends ChangeNotifier {
  List resellerss = [];
  List buyers = [];
  int totlCost = 0;
  ResellerDbet resellerDbet = ResellerDbet();

  Future<List> fetchData() async {
    try {
      var x = await getpi("/api/reseller/index");
      print(x.body);
      var data = jsonDecode(x.body);
      final List resellers =
          data["data"].map((json) => Reseller.fromJson(json)).toList();
      resellerss = resellers;
      return resellers;
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future getFetchData() async {
    try {
      var x = await getpi("/api/reseller/index");
      var data = jsonDecode(x.body);
      final List resellers =
          data["data"].map((json) => Reseller.fromJson(json)).toList();
      resellerss = resellers;
      notifyListeners();
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future addReseller(String name, String phone_number, String address,
      BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/reseller/create", {
        "full_name": name,
        "address": address,
        "phone_number": phone_number,
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      notifyListeners();

      snackBar(context, "تم اضافة الوكيل بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }

  Future delete(int id, BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/reseller/delete", {
        "reseller_id": id,
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      notifyListeners();
      Navigator.pop(context);
      snackBar(context, "تم حذف الوكيل بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }

  Future<List> getResellerinfo(String id) async {
    try {
      var x = await getpi("/api/trap/index?reseller_id=$id");
      var data = jsonDecode(x.body);

      final List Traps =
          data["data"]["data"].map((json) => Trap.fromJson(json)).toList();
      return Traps;
    } catch (e) {
      print(e);
      throw "حدثت مشكلة في جلب البيانات";
    }
  }

  Future getResellerinfodebt(String id) async {
    try {
      var x = await getpi("/api/trap/index?reseller_id=$id");
      var data = jsonDecode(x.body);

      resellerDbet = ResellerDbet.fromJson(data);
      // print(Traps);
      notifyListeners();
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future<List> getDbetPayinfo(String id) async {
    try {
      var x = await getpi("/api/trap_pay/index?reseller_id=$id");
      var data = jsonDecode(x.body);
      totlCost = data["total_cost_USD_pays"];
      final List Traps =
          data["data"].map((json) => TrapPay.fromJson(json)).toList();
      return Traps;
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  // int getTotelcost() {}

  Future<List> fetchHotelBuyer() async {
    try {
      var x = await getpi("/api/hotel_buyer/index");
      print(x.body);
      var data = jsonDecode(x.body);
      print(data["data"]);
      final List resellers =
          data["data"].map((json) => Reseller.fromJson(json)).toList();
      buyers = resellers;
      return resellers;
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future<String> addHotelBuyer(String name, String phone_number, String address,
      BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel_buyer/create", {
        "name": name,
        "address": address.isEmpty ? "_" : address,
        "phone_number": phone_number.isEmpty ? "0" : phone_number,
      });
      //  notifyListeners();
      //        Navigator.pop(context);
      // notifyListeners();
    } catch (e) {
      snackBar(context, e.toString(), true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      snackBar(context, "تم اضافة المشتري بنجاح", false);

      notifyListeners();
      return jsonDecode(x.body)["id"].toString();
    } else {
      snackBar(context, jsonDecode(x.body), true);
      throw "";
    }
  }

  Future deleteHotelbuer(int id, BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel_buyer/delete", {
        "id": id,
      });
      // notifyListeners();
    } catch (e) {
      snackBar(context, e.toString(), true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      Navigator.pop(context);
      notifyListeners();
      snackBar(context, "تم حذف المشتري بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }

  Future updateReseller(id, String name, String phone_number, String address,
      BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await putApi("/api/reseller/update", {
        "reseller_id": id,
        if (name.isNotEmpty) "full_name": name,
        if (address.isNotEmpty) "address": address,
        if (phone_number.isNotEmpty) "phone_number": phone_number,
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      notifyListeners();
      snackBar(context, "تم اضافة الوكيل بنجاح", false);
    } else {
      print(x.body);
      snackBar(context, jsonDecode(x.body), true);
    }
  }
}
