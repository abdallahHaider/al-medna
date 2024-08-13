import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/transport.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;

import '../models/trap.dart';

class TrapController extends ChangeNotifier {
  List transports = [
    Transport(name: "بري", id: "street"),
    Transport(name: "جوي", id: "fly"),
  ];

  Future<Map> fetchData(String time,int page) async {
    // Simulate fetching data (replace with your actual logic)
    // await Future.delayed(Duration(seconds: 1));
    print("///////////////////////////////////////");
    print(time);

    try {
      Map hap = {};
      var x = await getpi("/api/trap/index?page=$page${time==""?"":time}");
      var data = jsonDecode(x.body)["data"];
      print(jsonDecode(x.body));
      final List resellers = [];
      for (int i = 0; i < data.length; i++) {
        var x = Trap.fromJson(data[i]);
        resellers.add(x);
      }
      hap["resellers"] = resellers;
      hap['total_cost_USD'] = jsonDecode(x.body)['total_cost_USD'];
      hap['total_cost_IQD'] = jsonDecode(x.body)['total_cost_IQD'];
      hap['total_cost_RAS'] = jsonDecode(x.body)['total_cost_RAS'];
      hap['total_cost_USD_pays'] = jsonDecode(x.body)['total_cost_USD_pays'];
      hap['total_cost_IQD_pays'] = jsonDecode(x.body)['total_cost_IQD_pays'];
      hap['total_cost_RAS_pays'] = jsonDecode(x.body)['total_cost_RAS_pays'];
      hap['start_date'] = jsonDecode(x.body)['start_date'];
      hap['end_date'] = jsonDecode(x.body)['end_date'];
      hap['count_trap']=jsonDecode(x.body)['count_trap'];
      hap['count_pays']=jsonDecode(x.body)['count_pays'];


      return hap;
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future addtrap(
      String duration,
      String quantity,
      String price_per_one,
      String RAS_to_USD,
      String IQD_to_USD,
      BuildContext context,
      String resslrid,
      String transportsid,
      String trapid) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      print('22222222222222');

      x = await postApi("/api/trap/create", {
        "hotel_id": trapid,
        "reseller_id": resslrid,
        "duration": duration,
        "quantity": quantity,
        "price_per_one": price_per_one,
        "RAS_to_USD": RAS_to_USD,
        "IQD_to_USD": IQD_to_USD,
        "transport": transportsid,
      });

      print(x.body);
    } catch (e) {
      snackBar(context, e.toString());
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      notifyListeners();
      snackBar(context, "تم اضافة الرحلة بنجاح");
    } else {
      snackBar(context, jsonDecode(x.body));
    }
  }

  Future delete(int id, BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/trap/delete", {
        "id": id,
      });
      notifyListeners();
      Navigator.pop(context);

      snackBar(context, "تم حذف الرحله بنجاح");
    } catch (e) {
      snackBar(context, e.toString());
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
    } else {
      snackBar(context, jsonDecode(x.body));
    }
  }
  void updete(){
    notifyListeners();
  }
}
