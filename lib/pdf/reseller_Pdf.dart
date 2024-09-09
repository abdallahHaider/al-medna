import 'dart:io';
import 'package:admin/models/reseller.dart';
import 'package:admin/models/reseller_dbet.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> ResellerToPdf(
    Reseller reseller, ResellerDbet dbet, List traps) async {
  final pdf = pw.Document();

  // تحميل الخط مرة واحدة
  final fontData = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final customFont = pw.Font.ttf(fontData);

  // تحديد أنماط النص بدون textDirection
  // final textStyle = pw.TextStyle(fontSize: 20);

  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        theme: pw.ThemeData.withFont(base: customFont),
        margin: pw.EdgeInsets.all(20),
      ),
      build: (pw.Context context) => pw.Center(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("كشف حساب",
                style:
                    pw.TextStyle(fontSize: 24, fontBold: pw.Font.courierBold()),
                textDirection: pw.TextDirection.rtl),
            pw.SizedBox(height: 20),

            // الصف العلوي لاسم الوكيل
            _buildAgentRow(reseller.fullName ?? "اسم غير متوفر"),
            pw.SizedBox(height: 20),

            // الجدول الرئيسي
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                _buildTableHeader(),
                ..._buildTableRows(traps),
              ],
            ),
            pw.SizedBox(height: 20),

            // ملخص الحساب
            _buildSummary(dbet),
          ],
        ),
      ),
    ),
  );

  // حفظ ملف PDF في جهازك
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/${reseller.fullName ?? 'reseller'}.pdf");
  await file.writeAsBytes(await pdf.save());

  print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

  // فتح ملف PDF باستخدام تطبيق خارجي
  await OpenFilex.open(file.path);
}

// دالة لبناء صف اسم الوكيل
pw.Widget _buildAgentRow(String agentName) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Expanded(
        child: pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          padding: pw.EdgeInsets.all(10),
          child: pw.Text(agentName,
              textAlign: pw.TextAlign.center,
              textDirection: pw.TextDirection.rtl),
        ),
      ),
      pw.Expanded(
        child: pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          padding: pw.EdgeInsets.all(10),
          child: pw.Text("اسم الوكيل",
              textAlign: pw.TextAlign.center,
              textDirection: pw.TextDirection.rtl),
        ),
      ),
    ],
  );
}

// دالة لإنشاء رأس الجدول
pw.TableRow _buildTableHeader() {
  return pw.TableRow(
    decoration: pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(),
        top: pw.BorderSide(),
        left: pw.BorderSide(),
        right: pw.BorderSide(),
      ),
    ),
    children: [
      _buildHeaderCell("المتبقي"),
      _buildHeaderCell("السداد"),
      _buildHeaderCell("رقم الفاتورة"),
      _buildHeaderCell("مجموع الحساب"),
      _buildHeaderCell("عدد المعتمرين"),
      _buildHeaderCell("التاريخ"),
      _buildHeaderCell("رقم الرحلة"),
      _buildHeaderCell("ت"),
    ],
  );
}

// دالة لإنشاء خلية الرأس
pw.Widget _buildHeaderCell(String title) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 5),
    child: pw.Text(title,
        textDirection: pw.TextDirection.rtl, style: pw.TextStyle()),
  );
}

// دالة لإنشاء الصفوف من البيانات
List<pw.TableRow> _buildTableRows(List traps) {
  return List.generate(
    traps.length,
    (index) {
      final trap = traps[index];
      final isPayment = trap.type == "trap_pay";
      return pw.TableRow(
        decoration: pw.BoxDecoration(
          color: isPayment ? null : PdfColors.grey400,
          border: pw.Border.all(),
        ),
        children: [
          _buildTableCell(trap.nowDebt ?? ""),
          _buildTableCell(isPayment ? trap.price ?? "" : ""),
          _buildTableCell(isPayment ? trap.id.toString() : ""),
          _buildTableCell(isPayment ? "" : trap.price ?? ""),
          _buildTableCell(isPayment ? "" : trap.quantity.toString()),
          _buildTableCell(trap.createdAt.toString().substring(0, 10)),
          _buildTableCell(isPayment ? "" : trap.id.toString()),
          _buildTableCell((index + 1).toString()),
        ],
      );
    },
  );
}

// دالة لإنشاء خلية الجدول
pw.Widget _buildTableCell(String content) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 5),
    child: pw.Text(content, textDirection: pw.TextDirection.rtl),
  );
}

// دالة لبناء ملخص الحساب
pw.Widget _buildSummary(ResellerDbet dbet) {
  final totalRemaining = ((double.tryParse(dbet.totalCostUsdPays!) ?? 0) -
          (double.tryParse(dbet.totalCostUsd!) ?? 0))
      .toString();

  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.center,
    children: [
      _buildSummaryItem("مجموع المتبقي", totalRemaining),
      _buildSummaryItem("مجموع السداد", dbet.totalCostUsdPays!),
      _buildSummaryItem("مجموع الطلب", "-${dbet.totalCostUsd!}"),
    ],
  );
}

// دالة لإنشاء عنصر الملخص
pw.Widget _buildSummaryItem(String title, String value) {
  return pw.Container(
    decoration: pw.BoxDecoration(border: pw.Border.all()),
    padding: pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: pw.Column(
      children: [
        pw.Text(title, textDirection: pw.TextDirection.rtl),
        pw.Text(value,
            style: pw.TextStyle(fontSize: 20),
            textDirection: pw.TextDirection.rtl),
      ],
    ),
  );
}
