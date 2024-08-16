import 'package:admin/controllers/action_controller.dart';
import 'package:admin/models/recent_file.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utl/constants.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: secondaryColor,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "اخر العمليات",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Consumer<ActionController>(builder: (e, a, s) {
              return FutureBuilder(
                  future: a.fetchData(),
                  builder: (gg, bb) {
                    if (bb.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (bb.hasError) {
                      return ErorrWidget();
                    } else {
                      return SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          columnSpacing: defaultPadding,
                          // minWidth: 600,
                          columns: [
                            DataColumn(
                              label: Text("اسم العملية"),
                            ),
                            DataColumn(
                              label: Text("تاريخ الانشاء"),
                            ),
                            DataColumn(
                              label: Text("ملاحظات"),
                            ),
                          ],

                          rows: List.generate(
                            bb.data!.length,
                            (index) => recentFileDataRow(bb.data![index]),
                          ),
                        ),
                      );
                    }
                  });
            }),
          ],
        ),
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(defaultPadding * 0.75),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: fileInfo.color.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset(
                fileInfo.icon!,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!.toString().substring(0, 10))),
      DataCell(Text(fileInfo.size!)),
    ],
  );
}
