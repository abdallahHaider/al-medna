import 'dart:io';

import 'package:admin/models/reseller.dart';
import 'package:admin/models/reseller_dbet.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> ResellerToPdf(
    Reseller reseller, ResellerDbet dbet, List traps) async {
  final pdf = pw.Document();
  final fonddata = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final costmfond = pw.Font.ttf(fonddata);

  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(theme: pw.ThemeData.withFont(base: costmfond)),
      build: (pw.Context context) => pw.Center(
          child: pw
              .Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
        pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text("كشف حساب ",
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(
                      fontSize: 24, fontBold: pw.Font.courierBold())),
            ]),
        pw.SizedBox(height: 20),
        pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Expanded(
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                    pw.Text("مجموع الطلب : ${dbet.totalCostUsd}",
                        textDirection: pw.TextDirection.rtl),
                    pw.Text("مجموع التسديدات  : ${dbet.totalCostUsdPays}",
                        textDirection: pw.TextDirection.rtl),
                    pw.Text("عدد التسديدات : ${dbet.countPays}",
                        textDirection: pw.TextDirection.rtl),
                    pw.Text(
                        "مجموع المتبقي : ${(dbet.totalCostUsdPays ?? 0) - (dbet.totalCostUsd ?? 0)}",
                        textDirection: pw.TextDirection.rtl),
                  ])),
              pw.Expanded(
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                    pw.Text("اسم الوكيل : ${reseller.fullName}",
                        textDirection: pw.TextDirection.rtl),
                    pw.Text("العنوان  : ${reseller.address}",
                        textDirection: pw.TextDirection.rtl),
                    pw.Text("رقم الهاتف  : ${reseller.phoneNumber}",
                        textDirection: pw.TextDirection.rtl),
                    pw.Text(
                        "تاريخ انشاء الحساب  : ${reseller.createdAt.toString().substring(0, 10)}",
                        textDirection: pw.TextDirection.rtl),
                  ])),
            ]),
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            // إضافة صف العناوين هنا
            pw.TableRow(
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(),
                  top: pw.BorderSide(),
                  left: pw.BorderSide(),
                  right: pw.BorderSide(),
                ),
              ),
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("السعر", textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("الغرفة الثنائية",
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("الغرفة الثلاثية",
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("الغرفة الرباعية",
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child:
                      pw.Text("الأطفال", textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("الرضع", textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("تاريخ الإنشاء",
                      textDirection: pw.TextDirection.rtl),
                ),
              ],
            ),
            // إضافة البيانات بعد صف العناوين
            ...List.generate(
              traps.length,
              (index) => pw.TableRow(
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(),
                    top: pw.BorderSide(),
                    left: pw.BorderSide(),
                    right: pw.BorderSide(),
                  ),
                ),
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5),
                    child: pw.Text(traps[index].price.toString(),
                        textDirection: pw.TextDirection.rtl),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5),
                    child: pw.Text(traps[index].coupleRoom.toString(),
                        textDirection: pw.TextDirection.rtl),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5),
                    child: pw.Text(traps[index].tripleRoom.toString(),
                        textDirection: pw.TextDirection.rtl),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5),
                    child: pw.Text(traps[index].quadrupleRoom.toString(),
                        textDirection: pw.TextDirection.rtl),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5),
                    child: pw.Text(traps[index].child.toString(),
                        textDirection: pw.TextDirection.rtl),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5),
                    child: pw.Text(traps[index].veryChild.toString(),
                        textDirection: pw.TextDirection.rtl),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 5),
                    child: pw.Text(
                        traps[index].createdAt.toString().substring(0, 10),
                        textDirection: pw.TextDirection.rtl),
                  ),
                ],
              ),
            ),
          ],
        ),
      ])),
    ),
  );

  // // حفظ ملف PDF على الويب
  // final bytes = await pdf.save();
  // final blob = html.Blob([bytes], 'application/pdf');
  // final url = html.Url.createObjectUrlFromBlob(blob);
  // final anchor = html.AnchorElement(href: url)
  //   ..setAttribute("download", "example.pdf")
  //   ..click();
  // html.Url.revokeObjectUrl(url);

  // حفظ ملف PDF في جهازك
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/${reseller.fullName}.pdf");
  await file.writeAsBytes(await pdf.save());

  print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

  // فتح ملف PDF باستخدام تطبيق خارجي
  await OpenFilex.open(file.path);
}
