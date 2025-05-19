import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nul_app/controller/booking_controller.dart';
import 'package:get/get.dart';
import 'package:nul_app/core.dart';
import 'package:nul_app/models/booking_model.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  final BookingController _bookingC = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (_bookingC.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Booking> bookingList = _bookingC.bookings.value;

          return bookingList.isEmpty
              ? Center(
                  child: Text(
                    'Belum ada booking',
                    style: GoogleFonts.montserrat(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: bookingList.length,
                  itemBuilder: (context, index) {
                    final booking = bookingList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: Image.network(
                              booking.location?.imageUrl ??
                                  'https://via.placeholder.com/120',
                              width: 120,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '📍 ${booking.location?.name ?? '-'}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '🗓️ Tanggal: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(booking.dateTime!))}',
                                    style: GoogleFonts.montserrat(fontSize: 13),
                                  ),
                                  Text(
                                    '⏰ Waktu: ${booking.bookingTime}',
                                    style: GoogleFonts.montserrat(fontSize: 13),
                                  ),
                                  Text(
                                    '👥 Jumlah: ${booking.headCount} Peserta',
                                    style: GoogleFonts.montserrat(fontSize: 13),
                                  ),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
        }),
      ),
      bottomNavigationBar: CustomBottomNavbar(currentIndex: 2),
    );
  }
}
