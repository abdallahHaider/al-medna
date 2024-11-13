import 'dart:convert';
import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/company.dart';
import 'package:admin/models/companyy.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart';

class CompanyController extends ChangeNotifier {
  List companys = [];
  List myCompanys = [];

  String total_price_t = "0";
  String total_room_price_per_night = "0";
  String total = "0";
  String pay = "0";
  String rest = "0";
  int page = 1;
  bool showT = false;
  bool isTashera= false;
  bool ishotel= false;
    bool istotal= false;
  bool ispay= false;
  bool isrest = false;
  bool isrestUSD = false;
  


  setT() {
    showT = true;
    notifyListeners();
  }
  convertTashera(){
    isTashera = !isTashera;
        notifyListeners();
  }
  convertHotel(){
    ishotel = !ishotel;
        notifyListeners();
  }
   convertTotal(){
    istotal = !istotal;
        notifyListeners();
  }
  convertPay(){
    ispay = !ispay;
        notifyListeners();

  }
   convertrest(){
    isrest = !isrest;
        notifyListeners();

  }
  convertRestUsd(){
    isrestUSD = !isrestUSD;
            notifyListeners();

  }
  

  Future getCompanys() async {
    Response x;
    try {
      x = await getpi("/api/company/index");
      print(x.body);
      var data = jsonDecode(x.body);
      companys = data.map((json) => Company.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future addBank(String name) async {
    Response x;
    try {
      x = await postApi("/api/company/create", {"name": name});
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      getCompanys();
      print(x.body);
    } else {
      throw jsonDecode(x.body);
    }
  }

  Future deletbank(id, BuildContext context) async {
    Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/company/delete", {"id": id});
      if (x.statusCode == 200) {
        getCompanys();
        Navigator.pop(context);
        snackBar(context, "تم الحذف بنجاح", false);
      } else {
        print(x.body);
        snackBar(context, jsonDecode(x.body), true);
      }
    } catch (e) {
      snackBar(context, "حصل خطا في ارسال البيانات", true);
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future deletCompanyPor(id, BuildContext context) async {
    Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi(
          "/api/company_program/delete", {"company_program_id": id});
      if (x.statusCode == 200) {
        // getCompanys();
        notifyListeners();
        Navigator.pop(context);
        snackBar(context, "تم الحذف بنجاح", false);
      } else {
        print(x.body);
        snackBar(context, jsonDecode(x.body), true);
      }
    } catch (e) {
      print(e);
      snackBar(context, "حصل خطا في ارسال البيانات", true);
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future getAllData(String id) async {
    Response x;
    try {
      x = await getpi("/api/company_program/index?page=$page&id=$id");
      // print(x.body);
      var data = jsonDecode(x.body);
      print(x.body);

      total = data["total"].toString();
      total_price_t = data["total_price_t"].toString();
      total_room_price_per_night =
          data["total_room_price_per_night"].toString();
      pay = data["pay"].toString();
      rest = data["rest"].toString();

      if (data["total_price_t"] > 0) {
        setT();
      }

      myCompanys = data["data"].map((json) => Companyy.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
    // print(x.body);
  }

  Future addMove(
      String company_id,
      String group_number,
      String number_t,
      String price_t,
      String hotel_name,
      String rooms,
      String nights,
      String room_price_per_night,
      String created_at,
      String hotel_name_maka,
      String rooms_maka,
      String nights_maka,
      String room_price_per_night_maka) async {
    Response x;
    try {
      x = await postApi("/api/company_program/create", {
        "company_id": company_id,
        "group_number": group_number,
        "number_t": number_t,
        "price_t": price_t,
        if (hotel_name.isNotEmpty) "hotel_name": hotel_name,
        if (hotel_name_maka.isNotEmpty) "hotel_name_maka": hotel_name_maka,
        if (rooms.isNotEmpty) "rooms": rooms,
        if (rooms_maka.isNotEmpty) "rooms_maka": rooms_maka,
        if (nights.isNotEmpty) "nights": nights,
        if (nights_maka.isNotEmpty) "nights_maka": nights_maka,
        if (room_price_per_night.isNotEmpty)
          "room_price_per_night": room_price_per_night,
        if (room_price_per_night_maka.isNotEmpty)
          "room_price_per_night_maka": room_price_per_night_maka,
        "created_at": created_at,
      });
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      getCompanys();
      print(x.body);
    } else {
      throw jsonDecode(x.body);
    }
  }

  void updete(String id, int page) {
    this.page = this.page + page;
    getAllData(id);
  }

  // Future getDealsData(String id) async {
  //   Response x;
  //   try {
  //     x = await getpi("/api/company_program/index?page=$page&id=$id");
  //     var data = jsonDecode(x.body);
  //     print(x.body);
  //     myCompanys = data["data"].map((json) => Companyy.fromJson(json)).toList();
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     throw "حصل خطا في ارسال البيانات";
  //   }
  // }
}
