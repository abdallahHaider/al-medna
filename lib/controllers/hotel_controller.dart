import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart'as http;

class HotelController extends ChangeNotifier{

  List hotels=[];

  Future<List> fetchData() async {
    // Simulate fetching data (replace with your actual logic)
    // await Future.delayed(Duration(seconds: 1));
    
    try {
      var x= await getpi("/api/hotel/index");
      var data = jsonDecode(x.body);
      print(jsonDecode(x.body));
        final List resellers =
            data.map((json) => Reseller.fromJson(json)).toList();
      return resellers;
    } catch (e) {
      print(e);
      throw "jjj";
    }
    
  }
  Future getfetchData() async {
    // Simulate fetching data (replace with your actual logic)
    // await Future.delayed(Duration(seconds: 1));

    try {
      var x= await getpi("/api/hotel/index");
      var data = jsonDecode(x.body);
      print(jsonDecode(x.body));
      final List resellers =
      data.map((json) => Reseller.fromJson(json)).toList();
      hotels=resellers;
      notifyListeners();
    } catch (e) {
      print(e);
      throw "jjj";
    }

  }
  Future addReseller(String name,String phone_number,String address,BuildContext context)async{
    http.Response x;
    try {
      SmartDialog.showLoading();
     x =  await postApi("/api/hotel/create", {
        "full_name": name,
        "address": address,
        "phone_number": phone_number,
      });
       notifyListeners();
            //  Navigator.pop(context);

      snackBar(context, "تم اضافة الفندق بنجاح");
    } catch (e) {
        snackBar(context, e.toString());
      throw e;
    }finally{
      SmartDialog.dismiss();
    }
    if (x.statusCode==200||x.statusCode==201) {
    }else{
      snackBar(context, jsonDecode(x.body));
    }
  }
  Future delete(int id,BuildContext context)async{
    http.Response x;
    try {
      SmartDialog.showLoading();
     x =  await postApi("/api/hotel/delete", {
        "hotel_id": id,
      
      });
       notifyListeners();
             Navigator.pop(context);
             notifyListeners();

      snackBar(context, "تم حذف الفندق بنجاح");
    } catch (e) {
        snackBar(context, e.toString());
      throw e;
    }finally{
      SmartDialog.dismiss();
    }
    if (x.statusCode==200||x.statusCode==201) {
    }else{
      snackBar(context, jsonDecode(x.body));
    }
  }
}