import 'dart:convert';
import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/recent_file.dart';
import 'package:flutter/material.dart';

class ActionController extends ChangeNotifier {
  Future<List> fetchData() async {
    // Simulate fetching data (replace with your actual logic)
    // await Future.delayed(Duration(seconds: 1));

    try {
      var x = await getpi("/api/action/index");
      var data = jsonDecode(x.body);
      print(jsonDecode(x.body));
      final List actions = [];
      for (var i in data['data']) {
        actions.add(RecentFile(
            date: i['created_at'],
            icon: i['type'] == "reseller"
                ? "assets/icons/menu_tran.svg"
                : "assets/icons/menu_task.svg",
            title: i['name'],
            size: i['note'],
            color: i['operation'] == 'create' ? Colors.green : Colors.red));
      }

      return actions;
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }
}
