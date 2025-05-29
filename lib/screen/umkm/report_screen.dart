import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel/excel.dart';
import 'package:nul_app/controller/booking_controller.dart';
import 'package:nul_app/controller/umkm/report/booking_report_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart'; // Assuming appPrimary, appLightGrey are defined here

class BookingReportScreen extends StatelessWidget {
  const BookingReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the BookingController instance
    final BookingReportController bookingController =
        Get.find<BookingReportController>();

    // Function to export to Excel
    Future<void> exportToExcel(BuildContext context) async {
      var excel = Excel.createExcel();
      Sheet sheet = excel['Bookings'];

      // Add headers
      sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue('Kode');
      sheet.cell(CellIndex.indexByString('B1')).value =
          TextCellValue('Customer Name');
      sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue('Date');
      sheet.cell(CellIndex.indexByString('D1')).value = TextCellValue('Status');

      // Add data from controller
      for (int i = 0; i < bookingController.bookings.value.length; i++) {
        sheet.cell(CellIndex.indexByString('A${i + 2}')).value = TextCellValue(
            bookingController.bookings.value[i].bookingCode.toString());
        sheet.cell(CellIndex.indexByString('B${i + 2}')).value = TextCellValue(
            bookingController.bookings.value[i].user?.name ?? 'N/A');
        sheet.cell(CellIndex.indexByString('C${i + 2}')).value = TextCellValue(
            bookingController.bookings.value[i].dateTime ?? 'N/A');
        sheet.cell(CellIndex.indexByString('D${i + 2}')).value = TextCellValue(
            bookingController.bookings.value[i].bookingStatus ?? 'N/A');
      }

      // Save the file
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/booking_report.xlsx';
      final file = File(path);
      await file.writeAsBytes(excel.encode()!);

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exported to Excel at $path')),
      );

      // Note: Add storage permissions for Android/iOS in a production app
    }

    // Function to export to PDF
    Future<void> exportToPdf(BuildContext context) async {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Table(
            border: pw.TableBorder.all(),
            children: [
              // Header row
              pw.TableRow(
                children: [
                  pw.Text('Code',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Customer Name',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Date',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Status',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
              // Data rows
              ...bookingController.bookings.value.map(
                (booking) => pw.TableRow(
                  children: [
                    pw.Text(booking.bookingCode.toString()),
                    pw.Text(booking.user?.name ?? 'N/A'),
                    pw.Text(booking.dateTime ?? 'N/A'),
                    pw.Text(booking.bookingStatus ?? 'N/A'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      // Save the file
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/booking_report.pdf';
      final file = File(path);
      await file.writeAsBytes(await pdf.save());

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exported to PDF at $path')),
      );

      // Optionally, open the PDF for preview
      await Printing.sharePdf(
          bytes: await pdf.save(), filename: 'booking_report.pdf');

      // Note: Add storage permissions for Android/iOS in a production app
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => bookingController.loading.value == true
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    // Loading indicator or Data Table
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Code')),
                            DataColumn(label: Text('Customer Name')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: bookingController.bookings.value
                              .map(
                                (booking) => DataRow(
                                  cells: [
                                    DataCell(
                                        Text(booking.bookingCode.toString())),
                                    DataCell(Text(booking.user?.name ?? 'N/A')),
                                    DataCell(Text(booking.dateTime ?? 'N/A')),
                                    DataCell(
                                        Text(booking.bookingStatus ?? 'N/A')),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Refactored Export Buttons
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildExportButton(
                              context: context,
                              icon: Icons.table_chart,
                              label: 'Export to Excel',
                              onPressed: () => exportToExcel(context),
                            ),
                            const SizedBox(width: 16),
                            _buildExportButton(
                              context: context,
                              icon: Icons.picture_as_pdf,
                              label: 'Export to PDF',
                              onPressed: () => exportToPdf(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // Helper widget for export buttons
  Widget _buildExportButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: appPrimary,
          foregroundColor: appLightGrey,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          textStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
