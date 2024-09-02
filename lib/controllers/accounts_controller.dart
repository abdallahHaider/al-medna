import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/bank.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AccountsController extends ChangeNotifier {
  List banks = [];

  List SmallBank = [];

  Future getBank() async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Response x;
    try {
      x = await getpi("/api/bank/index");
      var data = jsonDecode(x.body);
      banks = data.map((json) => Bank.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
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
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Response x;
    try {
      x = await getpi("/api/small_bank/index");
      var data = jsonDecode(x.body);
      SmallBank = data.map((json) => Bank.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
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

  Future deletbank(id) async {
    Response x;
    try {
      x = await postApi("/api/bank/delete", {"id": id});
      if (x.statusCode == 200) {
        getBank();
      } else {
        throw jsonDecode(x.body);
      }
    } catch (e) {
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future deletSmallbank(id) async {
    Response x;
    try {
      x = await postApi("/api/small_bank/delete", {"id": id});
      if (x.statusCode == 200) {
        getSmallBank();
      } else {
        throw jsonDecode(x.body);
      }
    } catch (e) {
      throw "حصل خطا في ارسال البيانات";
    }
  }
}
