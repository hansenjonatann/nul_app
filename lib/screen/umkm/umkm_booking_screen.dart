import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/controller/umkm/umkm-booking_controller.dart';

class UMKMBookingScreen extends StatefulWidget {
  const UMKMBookingScreen({super.key});

  @override
  State<UMKMBookingScreen> createState() => _UMKMBookingScreenState();
}

class _UMKMBookingScreenState extends State<UMKMBookingScreen> {
  final UMKMBookingController bookingC = Get.put(UMKMBookingController());

  int currentPage = 1;
  final int rowsPerPage = 5;

  @override
  void initState() {
    super.initState();
    bookingC.getBookings(page: currentPage);
  }

  void _goToPage(int page) {
    setState(() {
      currentPage = page;
    });
    bookingC.getBookings(page: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Daftar Booking"),
      ),
      body: SafeArea(
        child: Obx(() {
          if (bookingC.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (bookingC.bookings.value.isEmpty) {
            return const Center(child: Text("Belum ada booking."));
          }

          // total pages, as per count / rowsPerPage
          final totalPages =
              (bookingC.totalCount.value / rowsPerPage).ceil().clamp(1, 9999);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(12),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Kode')),
                      DataColumn(label: Text('Nama')),
                      DataColumn(label: Text('Lokasi')),
                      DataColumn(label: Text('Tanggal')),
                      DataColumn(label: Text('Jam')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Aksi')),
                    ],
                    rows: bookingC.bookings.value.map((booking) {
                      return DataRow(cells: [
                        DataCell(Text(booking.bookingCode ?? '-')),
                        DataCell(Text(booking.user?.name ?? '-')),
                        DataCell(Text(booking.location?.name ?? '-')),
                        DataCell(Text(booking.dateTime != null
                            ? DateFormat('dd-MM-yyyy')
                                .format(DateTime.parse(booking.dateTime!))
                            : '-')),
                        DataCell(Text(booking.bookingTime ?? '-')),
                        DataCell(Text(booking.bookingStatus ?? '-')),
                        DataCell(Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  bookingC.accept(id: booking.id ?? 0);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8)),
                                child: Obx(
                                  () => bookingC.loading.value == true
                                      ? CircularProgressIndicator()
                                      : Text("✔",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              color: appWhite)),
                                )),
                            const SizedBox(width: 6),
                            ElevatedButton(
                              onPressed: () {
                                bookingC.decline(id: booking.id ?? 0);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8)),
                              child: Obx(
                                () => bookingC.loading.value == true
                                    ? CircularProgressIndicator()
                                    : Text("X",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            color: appWhite)),
                              ),
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
              // Pagination controls
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: currentPage > 1
                          ? () => _goToPage(currentPage - 1)
                          : null,
                      child: const Text("Previous"),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "Page $currentPage of $totalPages",
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: currentPage < totalPages
                          ? () => _goToPage(currentPage + 1)
                          : null,
                      child: const Text("Next"),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
