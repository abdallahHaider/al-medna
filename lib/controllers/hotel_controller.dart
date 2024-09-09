import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/hotel_buy.dart';
import 'package:admin/models/reseller.dart';
// import 'package:admin/screens/hotel/hotel_profile.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;

class HotelController extends ChangeNotifier {
  List hotels = [];
  List hotelbuy = [];
  String total_cost = "";

  Future<List> fetchData() async {
    // Simulate fetching data (replace with your actual logic)
    // await Future.delayed(Duration(seconds: 1));

    try {
      var x = await getpi("/api/hotel/index");
      print(x.body);
      var data = jsonDecode(x.body);
      final List resellers =
          data.map((json) => Reseller.fromJson(json)).toList();
      return resellers;
    } catch (e) {
      print("11111111111111111111");
      print(e);
      throw "jjj";
    }
  }

  Future getFetchData() async {
    // Simulate fetching data (replace with your actual logic)
    // await Future.delayed(Duration(seconds: 1));

    try {
      var x = await getpi("/api/hotel/index");
      var data = jsonDecode(x.body);
      final List resellers =
          data.map((json) => Reseller.fromJson(json)).toList();
      hotels = resellers;
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
      x = await postApi("/api/hotel/create", {
        "full_name": name,
        "address": address,
        "phone_number": phone_number,
      });

      //  Navigator.pop(context);
    } catch (e) {
      snackBar(context, e.toString(), false);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      notifyListeners();
      snackBar(context, "تم اضافة الفندق بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }

  Future delete(int id, BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel/delete", {
        "id": id,
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      notifyListeners();
      Navigator.pop(context);
      snackBar(context, "تم حذف الفندق بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }

  Future getHotelBuy(id) async {
    // Simulate fetching data (replace with your actual logic)
    // await Future.delayed(Duration(seconds: 1));

    try {
      var x = await getpi("/api/hotel_tick/index/buy?hotel_id=$id");
      print(x.body);
      var data = jsonDecode(x.body);
      total_cost = data["total_cost"].toString();
      hotelbuy = data["data"].map((json) => HotelBuy.fromJson(json)).toList();
      print(x.body);
      notifyListeners();
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future addBuyHotel(hotel_id, String rooms, String room_price_per_night,
      String nights, BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel_tick/create", {
        "hotel_id": hotel_id,
        "rooms": rooms,
        "nights": nights,
        "room_price_per_night": room_price_per_night,
      });

      //  Navigator.pop(context);
    } catch (e) {
      snackBar(context, e.toString(), false);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      getHotelBuy(hotel_id);
      snackBar(context, "تم اضافة الفندق بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }
}
