import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/models/mine_action.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
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
  bool isPay = true;

  void setIsPay(bool v) {
    isPay = v;
    notifyListeners();
  }

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
    if (type == "الشركات") {
      this.type = "company";
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

  void setTypeTO(String type, BuildContext context) {
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

    if (type == "الشركات") {
      this.typeTO = "company";
      getTodata();
      isTo = true;
    }
    if (type == "الهيات") {
      this.typeTO = "authority";
      getTodata();
      isTo = true;
    }

    if (type == "الخزنة") {
      this.typeTO = "";
      mineActionsTO.clear();
      getTodata();
      isTo = false;
    }
    if (type == 'فنادق مكة') {
      print("444444444444");
      this.typeTO = "1";
      Provider.of<HotelController>(context, listen: false).getFetchData(true);
      // Provider.of<HotelController>(context, listen: false).getFetchData(false);
      // getTodata();
      isTo = false;
    }
    if (type == 'فنادق المدينة') {
      print("444444444444");
      this.typeTO = "1";
      // Provider.of<HotelController>(context, listen: false).getFetchData(true);
      Provider.of<HotelController>(context, listen: false).getFetchData(false);
      // getTodata();
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
    print("11111111111111111111111");
    print(cost);
    // print(Kade);
    print("to id : " + toID);
    print("frome id " + fromID);
    print("tyoe : " + type);
    print("type to " + typeTO);
    print(isIQD);
    print("1111111111111111111111111");

    Response x;
    try {
      x = await postApi("/api/transactions/create", {
        if (type == "bank") "f_bank": fromID,
        if (type == "small_bank") "f_small_bank": fromID,
        if (type == "company") "f_company": fromID,
        if (typeTO == "bank") "t_bank": toID,
        if (typeTO == "company") "t_company": toID,
        if (typeTO == "small_bank") "t_small_bank": toID,
        if (typeTO == "authority") "t_authority": toID,
        if (typeTO == "1") "t_hotel": toID,
        if (isIQD == "t") "cost_USD": cost,
        if (isIQD == "f") "cost_IQD": cost,
        if (isIQD == "r") "cost_USD": double.parse(cost) / 3.75,
        "number_kade": "0",
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
