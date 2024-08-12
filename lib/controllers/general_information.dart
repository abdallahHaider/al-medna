import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/my_files.dart';
import 'package:admin/models/recent_file.dart';

import 'package:flutter/material.dart';

class GeneralInformationController extends ChangeNotifier {
  Future<List> fetchData() async {
    // Simulate fetching data (replace with your actual logic)
    // await Future.delayed(Duration(seconds: 1));

    try {
      var x = await getpi("/api/general_information");
      var data = jsonDecode(x.body);
      print(jsonDecode(x.body));
      final List actions = [];

      actions.add(CloudStorageInfo(
          title: 'عدد الوكلاء',
          totalStorage: 'وكيل',
          numOfFiles: data['resellers'],
          color: Colors.blue,
          svgSrc: 'assets/icons/menu_tran.svg'
          )
          );
      actions.add(CloudStorageInfo(
          title: 'عدد الرحلات',
          totalStorage: 'رحله',
          numOfFiles: data['traps'],
          color: Colors.yellow,
                    svgSrc: 'assets/icons/menu_task.svg'

          ));
      actions.add(CloudStorageInfo(
          title: 'عدد الفنادق',
          totalStorage: 'فندق',
          numOfFiles: data['hotels'],
                    svgSrc: 'assets/icons/menu_store.svg',

          color: Color.fromARGB(255, 87, 162, 215)),
          );
      actions.add(CloudStorageInfo(
                  svgSrc: 'assets/icons/menu_doc.svg'
,
          title: 'عدد الفواتير',
          totalStorage: 'فاتورة',
          numOfFiles: data['trap_pay'],
          color: Color.fromARGB(255, 132, 38, 138)));

      return actions;
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }
}



//general_information