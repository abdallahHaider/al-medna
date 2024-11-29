import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/bank.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart';

class AccountsController extends ChangeNotifier {
  List banks = [];

  List SmallBank = [];
  bool isLoading = false;

  Future getBank() async {
    isLoading = true;
    notifyListeners();
    Response x;
    try {
      x = await getpi("/api/bank/index");
      var data = jsonDecode(x.body);
      banks = data.map((json) => Bank.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Future getmyBank(String id) async {
  //   Response x;
  //   try {
  //     x = await getpi("/api/bank/index?bank_id=$id");
  //     var data = jsonDecode(x.body);
  //     mybanks = data.map((json) => Bank.fromJson(json)).toList();
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     throw "حصل خطا في ارسال البيانات";
  //   }
  // }

  Future getSmallBank() async {
    isLoading = true;
    notifyListeners();
    Response x;
    try {
      x = await getpi("/api/small_bank/index");
      var data = jsonDecode(x.body);
      SmallBank = data.map((json) => Bank.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future addBank(String name) async {
    Response x;
    try {
      x = await postApi("/api/bank/create", {"name": name});
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      getBank();
      print(x.body);
    } else {
      throw jsonDecode(x.body);
    }
  }

  Future addSmallBank(String name) async {
    Response x;
    try {
      x = await postApi("/api/small_bank/create", {"name": name});
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      getSmallBank();
      print(x.body);
    } else {
      throw jsonDecode(x.body);
    }
  }

  Future deletbank(id, BuildContext context) async {
    Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/bank/delete", {"id": id});

      if (x.statusCode == 200) {
        getBank();
        Navigator.pop(context);
        snackBar(context, "تم الحذف بنجاح", false);
      } else {
        snackBar(context, jsonDecode(x.body), true);
      }
    } catch (e) {
      snackBar(context, "حصل خطا غير متوقع", true);
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future deletSmallbank(id, BuildContext context) async {
    Response x;
    try {
      x = await postApi("/api/small_bank/delete", {"id": id});
      if (x.statusCode == 200) {
        getSmallBank();
        Navigator.pop(context);
        snackBar(context, "تم الحذف بنجاح", false);
      } else {
        snackBar(context, jsonDecode(x.body), true);
      }
    } catch (e) {
      snackBar(context, "حصل خطا غير متوقع", true);
      throw "حصل خطا في ارسال البيانات";
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future updateBank(id, String name) async {
    Response x;
    try {
      x = await postApi("/api/bank/update", {
        "id": id,
        "name": name,
      });
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      getBank();
      print(x.body);
    } else {
      throw jsonDecode(x.body);
    }
  }

  Future updateSmallbank(id, String name) async {
    Response x;
    try {
      x = await postApi("/api/small_bank/update", {
        "id": id,
        "name": name,
      });
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      getSmallBank();
      print(x.body);
    } else {
      throw jsonDecode(x.body);
    }
  }
}
