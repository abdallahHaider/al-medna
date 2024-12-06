import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/authority.dart';
import 'package:admin/models/authority_tickt.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart';

class AuthorityController extends ChangeNotifier {
  bool isError = false;
  List authorities = [];
  List<AuthorityTicket> authoritiesT = [];
  bool isEdit = false;
  String id = "";
  setEdit(bool v) {
    isEdit = v;
    notifyListeners();
  }

  Future addAuthority(String name, BuildContext context) async {
    Response x;
    SmartDialog.showLoading();
    try {
      x = await postApi("/api/authority/create", {
        "name": name,
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      print(e);
      throw "حصل خطا في ارسال البيانات";
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      snackBar(context, "تمت العملية بنجاح", false);
      print(x.body);
    } else {
      snackBar(context, jsonDecode(x.body)["message"], true);
      throw jsonDecode(x.body);
    }
  }

  Future updateAuthority(String name, BuildContext context) async {
    Response x;
    SmartDialog.showLoading();
    try {
      x = await postApi("/api/authority/update", {
        "id": id,
        "name": name,
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      print(e);
      throw "حصل خطا في ارسال البيانات";
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      snackBar(context, "تمت العملية بنجاح", false);
      print(x.body);
    } else {
      snackBar(context, jsonDecode(x.body)["message"], true);
      throw jsonDecode(x.body);
    }
  }

  bool type = false;
  changeType() async {
    type = !type;
    authorities = await getAuthority();
    notifyListeners();
  }

  Future getAuthority() async {
    Response x;
    try {
      x = await getpi("/api/authority/index?type=${type == true ? 1 : 0}");
      print(x.body);
      var data = jsonDecode(x.body);
      authorities = data.map((json) => Authority.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future deletAuthority(id, BuildContext context) async {
    Response x;
    SmartDialog.showLoading();
    try {
      x = await postApi("/api/authority/delete", {"id": id});
    } catch (e) {
      snackBar(context, "حصل خطا في الرسال البيانات", true);
      print(e);
      throw "حصل خطا في ارسال البيانات";
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200) {
      getAuthority();
      snackBar(context, "تمت الحذف بنجاح", false);
      Navigator.pop(context);
    } else {
      snackBar(context, jsonDecode(x.body)["message"], true);
      print(x.body);
      throw jsonDecode(x.body);
    }
  }

  Future archiveauthority(id, BuildContext context) async {
    Response x;
    SmartDialog.showLoading();
    try {
      x = await postApi(
          "/api/authority/update", {"id": id, 'is_archive': false});
    } catch (e) {
      snackBar(context, e.toString(), true);
      print(e);
      throw "حصل خطا في ارسال البيانات";
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      snackBar(
          context,
          "تمت عملية ${type == false ? "الارشفه" : 'الغاء الارشفه'} بنجاح",
          false);
      print(x.body);
      authorities = await getAuthority();
    } else {
      snackBar(context, jsonDecode(x.body)["message"], true);
      throw jsonDecode(x.body);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  ///
  num allCostiqd = 0;
  num paidiqd = 0;
  num restiqd = 0;
  num allCostusd = 0;
  num paidusd = 0;
  num restusd = 0;
  int page = 1;
  bool iqd = true;
  setpage(int v) {
    page = page + v;
  }

  changeIT() {
    iqd = !iqd;
    notifyListeners();
  }

  Future getAuthorityTicks(id) async {
    allCostiqd = 0;
    paidiqd = 0;
    restiqd = 0;
    allCostusd = 0;
    paidusd = 0;
    restusd = 0;
    authoritiesT = [];

    Response x;
    try {
      x = await getpi("/api/authority_tickt/index?page=$page&id=${id}");
      print(x.body);
      var data = jsonDecode(x.body);
      allCostiqd = data["cost_iqd"];
      paidiqd = data["paid_iqd"];
      restiqd = data["rest_iqd"];
      allCostusd = data["cost_usd"];
      paidusd = data["paid_usd"];
      restusd = data["rest_usd"];
      for (var i in data["data"]) {
        authoritiesT.add(AuthorityTicket.fromJson(i));
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future addAuthorityTicks(
      String authority_id,
      number_of_travel,
      price_of_travel,
      commission,
      number_of_child,
      price_of_child,
      name,
      type,
      iqd_to_usd,
      BuildContext context) async {
    Response x;
    SmartDialog.showLoading();
    try {
      x = await postApi("/api/authority_tickt/create", {
        "authority_id": authority_id,
        "number_of_travel": number_of_travel,
        "price_of_travel": price_of_travel,
        "commission": commission,
        "number_of_child": number_of_child ?? "0",
        "price_of_child": price_of_child ?? "0",
        "name": name,
        'type': type,
        'IQD_to_USD': iqd_to_usd
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      print(e);
      throw "حصل خطا في ارسال البيانات";
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      snackBar(context, "تمت العملية بنجاح", false);
      print(x.body);
    } else {
      snackBar(context, jsonDecode(x.body)["message"], true);
      throw jsonDecode(x.body);
    }
  }

  Future deleteAuthorityTicks(id, BuildContext context) async {
    Response x;
    SmartDialog.showLoading();
    try {
      x = await postApi("/api/authority_tickt/delete", {"id": id});
    } catch (e) {
      snackBar(context, "حصل خطا في الرسال البيانات", true);
      print(e);
      throw "حصل خطا في ارسال البيانات";
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200) {
      getAuthority();
      snackBar(context, "تمت الحذف بنجاح", false);
      Navigator.pop(context);
    } else {
      snackBar(context, jsonDecode(x.body)["message"], true);
      print(x.body);
      throw jsonDecode(x.body);
    }
  }

  Future updateAuthorityTicks(id, String number_of_travel, price_of_travel,
      commission, BuildContext context) async {
    Response x;
    SmartDialog.showLoading();
    try {
      x = await postApi("/api/authority_tickt/update", {
        "id": id,
        "number_of_travel": number_of_travel,
        "price_of_travel": price_of_travel,
        "commission": commission
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      print(e);
      throw "حصل خطا في ارسال البيانات";
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      snackBar(context, "تمت العملية بنجاح", false);
      print(x.body);
    } else {
      snackBar(context, jsonDecode(x.body)["message"], true);
      throw jsonDecode(x.body);
    }
  }
}
