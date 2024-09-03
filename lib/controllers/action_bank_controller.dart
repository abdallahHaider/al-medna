import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/mine_action.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spelling_number/spelling_number.dart';

class ActionBankController extends ChangeNotifier {
  List<dynamic> mineActions = [];
  List<dynamic> mineActionsTO = [];

  String type = "";
  String typeTO = "";
  String isIQD = "";
  String fromID = "";
  String toID = "";
  bool isfrom = true;
  bool isTo = true;
  String numberWord = "";

  void setType(String type) {
    print("111111111111111111111111111111");
    print(type);
    if (type == "البنك") {
      this.type = "bank";
      getFromdata();
      isfrom = true;
    }
    if (type == "الصيرفة") {
      this.type = "small_bank";
      getFromdata();
      isfrom = true;
    }
    if (type == "الخزنة") {
      this.type = "";
      mineActions.clear();
      getFromdata();
      isfrom = false;
    }
    notifyListeners();
  }

  void setTypeTO(String type) {
    print("111111111111111111111111111111");
    print(type);
    if (type == "البنك") {
      this.typeTO = "bank";
      getTodata();
      isTo = true;
    }
    if (type == "الصيرفة") {
      this.typeTO = "small_bank";

      getTodata();
      isTo = true;
    }
    if (type == "الخزنة") {
      this.typeTO = "";
      mineActionsTO.clear();
      getTodata();
      isTo = false;
    }
    notifyListeners();
  }

  Future getFromdata() async {
    mineActions.clear();
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Response x;
    try {
      x = await getpi("/api/$type/index");
      print(x.body);
      var data = jsonDecode(x.body);
      mineActions = data.map((json) => MineAction.fromJson(json)).toList();
      fromID = mineActions.first.id.toString();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future getTodata() async {
    mineActionsTO.clear();
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Response x;
    try {
      x = await getpi("/api/$typeTO/index");
      print(x.body);
      var data = jsonDecode(x.body);
      mineActionsTO = data.map((json) => MineAction.fromJson(json)).toList();
      toID = mineActionsTO.first.id.toString();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future addpay(String cost, String Kade) async {
    print(cost);
    print(Kade);
    print(toID);
    print(fromID);
    print(type);
    print(typeTO);
    print(isTo);

    Response x;
    try {
      x = await postApi("/api/transactions/create", {
        if (type == "bank") "f_bank": fromID,
        if (type == "small_bank") "f_small_bank": fromID,
        if (typeTO == "bank") "t_bank": toID,
        if (typeTO == "small_bank") "t_small_bank": toID,
        if (isIQD == "t") "cost_USD": cost,
        if (isIQD == "f") "cost_IQD": cost,
        "number_kade": Kade,
      });
      print(x.body);
      print(x.statusCode);
      notifyListeners();
      if (x.statusCode != 200) {
        throw jsonDecode(x.body);
      }
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  void setNumberWord(String value, String type) {
    int x = 0;
    if (value.isNotEmpty) {
      x = int.parse(value);
      numberWord = SpellingNumber(lang: 'ar').convert(x);
      numberWord =
          "${numberWord} $type فقط لا غير "; // Add the phrase "only no other" to the word
      notifyListeners();
    }
  }
}
