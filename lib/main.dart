import 'package:admin/controllers/action_controller.dart';
import 'package:admin/controllers/general_information.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'controllers/reseller_controller.dart';
import 'controllers/rootWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF171821),
          fontFamily: 'Alexandria',
          brightness: Brightness.dark),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
          ChangeNotifierProvider(
            create: (context) => Rootwidget(),
          ),
          ChangeNotifierProvider(
            create: (context) => ResellerController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ActionController(),
          ),
          ChangeNotifierProvider(
            create: (context) => GeneralInformationController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
//GeneralInformationController