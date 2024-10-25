import 'dart:io';
import 'dart:typed_data';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

Future<void> createHotelPDF({
  required String startDate,
  required String endDate,
  required String seller,
  required String buyer,
  required int roomCount,
  required double pricePerRoom,
}) async {
  final fonddata = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final costmfond = pw.Font.ttf(fonddata);

  // تحميل صورة من assets
  final ByteData imageData = await rootBundle.load('assets/images/forma.png');
  final Uint8List imageBytes = imageData.buffer.asUint8List();

  final image = pw.MemoryImage(imageBytes);
  // حساب السعر الكلي
  final totalPrice = roomCount * pricePerRoom;

  // إنشاء مستند PDF
  final pdf = pw.Document();

  // إضافة صفحة إلى مستند PDF
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginLeft: 5,
          marginRight: 5,
          marginTop: 5,
          marginBottom: 5,
        ),
        theme: pw.ThemeData.withFont(base: costmfond),
        textDirection: pw.TextDirection.rtl,
      ),
      build: (pw.Context context) {
        return pw.Stack(children: [
          pw.Image(
            image,
          ),
          pw.Positioned(
              top: 120,
              left: 10,
              right: 10,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // عنوان العقد
                  pw.Text('عقد شراء غرف',
                      style: pw.TextStyle(fontSize: 24),
                      textDirection: pw.TextDirection.rtl,
                      textAlign: pw.TextAlign.center),

                  // مقدمة العقد
                  pw.Text(
                      'بناءً على رغبة الطرف الأول (البائع) والطرف الثاني (المشتري) في إبرام اتفاقية بيع وشراء عدد من الغرف، فقد تم الاتفاق بينهما وفقاً للشروط والبنود التالية:'),

                  // بند التفاصيل العامة
                  pw.Text('1. التفاصيل العامة:',
                      style: pw.TextStyle(fontSize: 14),
                      textDirection: pw.TextDirection.rtl),
                  pw.Text(
                    'تاريخ العقد: من $startDate إلى $endDate',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'الطرف الأول (البائع): $seller',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'الطرف الثاني (المشتري): $buyer',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),

                  // بند تفاصيل الغرف والأسعار
                  pw.Text('2. تفاصيل الشراء:',
                      style: pw.TextStyle(
                        fontSize: 14,
                      ),
                      textDirection: pw.TextDirection.rtl),
                  pw.Text(
                    'عدد الغرف المشمولة: $roomCount غرفة',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'سعر الغرفة الواحدة: ${pricePerRoom.toStringAsFixed(2)} دينار',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'السعر الكلي: ${totalPrice.toStringAsFixed(2)} دينار',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),

                  // بند التزامات الطرفين
                  pw.Text('3. التزامات الطرفين:',
                      style: pw.TextStyle(fontSize: 14),
                      textDirection: pw.TextDirection.rtl),
                  pw.Text(
                    'يلتزم الطرف الأول بتوفير الغرف المتفق عليها وتسليمها للطرف الثاني في التاريخ المحدد.',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'يلتزم الطرف الثاني بدفع المبلغ المتفق عليه في موعده المحدد.',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),

                  // بند إنهاء العقد
                  pw.Text('4. شروط إنهاء العقد:',
                      style: pw.TextStyle(fontSize: 14),
                      textDirection: pw.TextDirection.rtl),
                  pw.Text(
                    'يحق للطرفين إنهاء العقد باتفاق مشترك.',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'يلتزم الطرف الذي يقرر إنهاء العقد بإخطار الطرف الآخر قبل فترة لا تقل عن 15 يوماً.',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),

                  // بند شروط عامة
                  pw.Text('5. شروط عامة:',
                      style: pw.TextStyle(
                        fontSize: 14,
                      ),
                      textDirection: pw.TextDirection.rtl),
                  pw.Text(
                    'يعتبر هذا العقد ساري المفعول بمجرد توقيعه من قبل الطرفين.',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'جميع الشروط والبنود في هذا العقد ملزمة للطرفين.',
                    style: pw.TextStyle(fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),

                  // التوقيعات
                  pw.Text('توقيع الطرف الأول (البائع):',
                      style: pw.TextStyle(fontSize: 12),
                      textDirection: pw.TextDirection.rtl),

                  pw.Text('توقيع الطرف الثاني (المشتري):',
                      style: pw.TextStyle(fontSize: 12),
                      textDirection: pw.TextDirection.rtl),
                ],
              ))
        ]);
      },
    ),
  );

  // // تحديد المسار وحفظ ملف PDF
  // final output = await getTemporaryDirectory();
  // final file = File("${output.path}/FormalContract.pdf");
  // await file.writeAsBytes(await pdf.save());

  // print('تم إنشاء ملف العقد الرسمي بنجاح في ${file.path}');

  // حفظ ملف PDF في جهازك
  final output = await getTemporaryDirectory();
  final file =
      File("${output.path}/${seller + DateTime.now().second.toString()}.pdf");
  await file.writeAsBytes(await pdf.save());

  print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

  // فتح ملف PDF باستخدام تطبيق خارجي
  await OpenFilex.open(file.path);

  // // حفظ ملف PDF على الويب
  // final bytes = await pdf.save();
  // final blob = Blob([bytes], 'application/pdf');
  // final url = Url.createObjectUrlFromBlob(blob);
  // final anchor = AnchorElement(href: url)
  //   ..setAttribute("download", "example.pdf")
  //   ..click();
  // Url.revokeObjectUrl(url);
}
