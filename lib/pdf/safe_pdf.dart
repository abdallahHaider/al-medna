import 'dart:io';
import 'package:admin/models/safe.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:spelling_number/spelling_number.dart';

Future<void> safePdf(Safe safe) async {
  final pdf = pw.Document();
  final fonddata = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final costmfond = pw.Font.ttf(fonddata);

  // تحميل صورة من assets
  final ByteData imageData = await rootBundle.load('assets/images/logo.png');
  final Uint8List imageBytes = imageData.buffer.asUint8List();

  final image = pw.MemoryImage(imageBytes);

  pdf.addPage(
    pw.Page(
      // pageFormat: PdfPageFormat.a5,
      pageTheme: pw.PageTheme(
          theme: pw.ThemeData.withFont(base: costmfond),
          margin: pw.EdgeInsets.all(10),
          pageFormat: PdfPageFormat.a4),
      build: (pw.Context context) {
        return pw.Column(
          children: [
            // Header Section
            pw.Container(
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(10),
                color: PdfColors.greenAccent,
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text('موصل - الايمن - دواسة خارج',
                          textDirection: pw.TextDirection.rtl,
                          style: pw.TextStyle(fontSize: 16)),
                      pw.Text('07736847528', style: pw.TextStyle(fontSize: 14)),
                      pw.Text('07701625569', style: pw.TextStyle(fontSize: 14)),
                      pw.Text('07507158337', style: pw.TextStyle(fontSize: 14)),
                    ],
                  ),
                  pw.Image(image, height: 100),
                  pw.Column(children: [
                    pw.Text('شركة المدينة المنورة العالمية',
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(
                          fontSize: 18,

                          // fontWeight: pw.FontWeight.bold
                        )),
                    pw.Text('للسفر والسياحة والحج والعمرة',
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(fontSize: 18)),
                  ])
                ],
              ),
            ),
            pw.SizedBox(height: 10),
            // Title Section
            pw.Text(
              '${safe.type == "pay" ? "سند قبض" : "سند صرف"}',
              style: pw.TextStyle(
                fontSize: 20, // fontWeight: pw.FontWeight.bold
              ),
              textDirection: pw.TextDirection.rtl,
            ),
            pw.SizedBox(height: 10),
            // Form Fields
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _buildTextField(label: 'رقم القيد : ' + safe.id.toString()),
                _buildTextField(
                    label:
                        'التاريخ: ${safe.createdAt.toString().substring(0, 10)}'),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: PdfPageFormat.a4.width - 175,
                  padding: pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text("${safe.owner}",
                      style: pw.TextStyle(fontSize: 12),
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.SizedBox(width: 5),
                _buildTextField(label: 'استلمت من السيد/ة'),
              ],
            ),

            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: PdfPageFormat.a4.width - 175,
                  padding: pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text("${safe.costIQD ?? safe.costUSD}",
                      style: pw.TextStyle(fontSize: 12),
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.SizedBox(width: 5),
                _buildTextField(
                    label:
                        'مبلغ قدره ${safe.costIQD == null ? "بالدولار" : "بالدينار"}'),
              ],
            ),

            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: PdfPageFormat.a4.width - 175,
                  padding: pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text(
                      setNumberWord("${safe.costIQD ?? safe.costUSD}",
                              safe.costIQD != null ? "دينار" : "دولار")
                          .toString(),
                      style: pw.TextStyle(fontSize: 12),
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.SizedBox(width: 5),
                _buildTextField(label: 'كتابتًا'),
              ],
            ),

            pw.SizedBox(height: 10),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: PdfPageFormat.a4.width - 175,
                  padding: pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text("${safe.note}",
                      style: pw.TextStyle(fontSize: 12),
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.SizedBox(width: 5),
                _buildTextField(label: 'وذلك عن'),
              ],
            ),

            pw.SizedBox(height: 20),
            // Signature Fields
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _buildTextField(label: 'المستلم'),
                _buildTextField(label: 'المحاسب'),
              ],
            ),
          ],
        );
      },
    ),
  );

  // // Preview the PDF file
  // await Printing.layoutPdf(
  //   onLayout: (PdfPageFormat format) async => pdf.save(),
  // );
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
  final file = File("${output.path}/${safe.owner}.pdf");
  await file.writeAsBytes(await pdf.save());

  print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

  // فتح ملف PDF باستخدام تطبيق خارجي
  await OpenFilex.open(file.path);
}

pw.Widget _buildTextField({required String label}) {
  return pw.Row(children: [
    pw.Container(
      width: 150,
      padding: pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey),
        borderRadius: pw.BorderRadius.circular(5),
      ),
      child: pw.Text(label,
          style: pw.TextStyle(fontSize: 12),
          textDirection: pw.TextDirection.rtl),
    ),
    // pw.Expanded(
    //   child:

    // )
  ]);
}

String setNumberWord(String value, String type) {
  double x = 0;
  if (value.isNotEmpty) {
    x = double.parse(value);
    return "${SpellingNumber(lang: 'ar').convert(x)} $type فقط لا غير "; // Add the phrase "only no other" to the word
  } else {
    return "";
  }
}
