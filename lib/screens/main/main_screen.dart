import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/rootWidget.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      backgroundColor: bgColor,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Consumer<Rootwidget>(
                            builder: (BuildContext context, value, Widget? child) {
                              return value.mywidget;
                            },
                             ),)
          ],
        ),
      ),
    );
  }
}
