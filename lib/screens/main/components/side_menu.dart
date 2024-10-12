import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/accounts/accounts_page.dart';
import 'package:admin/screens/authority/authority_page.dart';
import 'package:admin/screens/bank/bank.dart';
import 'package:admin/screens/budget/budget_page.dart';
import 'package:admin/screens/campany/campany_page.dart';
import 'package:admin/screens/hotel/hotel_page.dart';
import 'package:admin/screens/many%20send/many_send.dart';
import 'package:admin/screens/trap%20pay/trap_pay.dart';
import 'package:admin/screens/wallet/wallet_page.dart';
import 'package:admin/screens/widgets/action_bank_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../dashboard/dashboard_screen.dart';
import '../../reseller/reseller_page.dart';
import '../../trap/trap_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(246, 251, 255, 1),
      child: ListView(
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              "assets/images/logo.png",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "شركة المدينة المنورة للحج والعمرة",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Divider(),
          DrawerListTile(
            title: "الرئيسية",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 1;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(DashboardScreen());
            },
            index: 1,
          ),
          DrawerListTile(
            title: "الوكلاء",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 2;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(ResellerPage());
            },
            index: 2,
          ),
          DrawerListTile(
            title: "الرحلات",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 3;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(TrapPage());
            },
            index: 3,
          ),
          DrawerListTile(
            title: "تسديدات الرحلات",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 4;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(TrapPayPage());
            },
            index: 4,
          ),
          DrawerListTile(
            title: " الصندوق الرئيسي",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 5;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(WalletPage());
            },
            index: 5,
          ),
          DrawerListTile(
            title: "البنوك",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 6;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(BankPage());
            },
            index: 6,
          ),
          DrawerListTile(
            title: "المنافذ",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 7;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(AccountsPage());
            },
            index: 7,
          ),
          DrawerListTile(
            title: "اضافة عملية",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 8;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(ActionBankCard());
            },
            index: 8,
          ),
          DrawerListTile(
            title: "الشركات ",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 9;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(CampanyPage());
            },
            index: 9,
          ),
          DrawerListTile(
            title: "الصرفيات ",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 10;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(ManySendPage());
            },
            index: 10,
          ),
          DrawerListTile(
            title: "الميزانية ",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 11;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(BudgetPage());
            },
            index: 11,
          ),
          DrawerListTile(
            title: "الفنادق",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 12;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(HotelPage());
            },
            index: 12,
          ),
          DrawerListTile(
            title: "هيئة الحج والعمرة",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false).index = 13;
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(AuthorityPage());
            },
            index: 13,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.index,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<Rootwidget>(builder: (BuildContext c, x, W) {
      return Container(
        width: 100,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Color.fromRGBO(
                246, 251, 255, 1), //x.index == index ? primaryColor : null,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
        child: ListTile(
          onTap: press,
          horizontalTitleGap: 0.0,
          leading: x.index != index
              ? SvgPicture.asset(
                  svgSrc,
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  height: 16,
                )
              : SizedBox(
                  width: 10,
                ),
          title: Text(
            title,
          ),
        ),
      );
    });
  }
}
