import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/accounts/accounts_page.dart';
import 'package:admin/screens/bank/bank.dart';
import 'package:admin/screens/budget/budget_page.dart';
import 'package:admin/screens/campany/campany_page.dart';
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
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(DashboardScreen());
            },
          ),
          DrawerListTile(
            title: "الوكلاء",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(ResellerPage());
            },
          ),
          DrawerListTile(
            title: "الرحلات",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(TrapPage());
            },
          ),
          DrawerListTile(
            title: "تسديدات الرحلات",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(TrapPayPage());
            },
          ),
          DrawerListTile(
            title: "الخزنة",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(WalletPage());
            },
          ),
          DrawerListTile(
            title: "البنوك",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(BankPage());
            },
          ),
          DrawerListTile(
            title: "المصارف",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(AccountsPage());
            },
          ),
          DrawerListTile(
            title: "اضافة عملية",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(ActionBankCard());
            },
          ),
          DrawerListTile(
            title: "الشركات ",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(CampanyPage());
            },
          ),
          DrawerListTile(
            title: "الصرفيات ",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(ManySendPage());
            },
          ),
          DrawerListTile(
            title: "الميزانية ",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(BudgetPage());
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        // style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
