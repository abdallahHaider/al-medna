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
  List authoritiesT = [];
  bool isEdit = false;
  String id = "";

  setedit(bool v) {
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

  Future getAuthority() async {
    Response x;
    try {
      x = await getpi("/api/authority/index");
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

  //////////////////////////////////////////////////////////////////////////////////////////
  Future getAuthorityTicks(id) async {
    Response x;
    try {
      x = await getpi("/api/authority_tickt/index?id=${id}");
      print(x.body);
      var data = jsonDecode(x.body);
      authoritiesT =
          data["data"].map((json) => AuthorityTickt.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future addAuthorityTicks(String authority_id, number_of_travel,
      price_of_travel, commission, BuildContext context) async {
    Response x;
    SmartDialog.showLoading();
    try {
      x = await postApi("/api/authority_tickt/create", {
        "authority_id": authority_id,
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

//TODO: Error frome API
  Future updateAuthorityTicks(String number_of_travel, price_of_travel,
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
