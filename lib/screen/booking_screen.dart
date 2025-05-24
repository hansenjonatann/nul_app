import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:nul_app/controller/booking_controller.dart';
import 'package:nul_app/controller/location_controller.dart';
import 'package:nul_app/core.dart';
import 'package:nul_app/models/booking_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  final BookingController _bookingC = Get.find<BookingController>();
  final LocationController _locationC = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (_bookingC.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Booking> bookingList = _bookingC.bookings.value;

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _bookingC.getBookings();
                  },
                  child: bookingList.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Center(
                                child: Text(
                                  'Belum ada booking',
                                  style: GoogleFonts.montserrat(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '🗞️ ${booking.bookingCode ?? '-'}',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
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
                                            style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            '⏰ Waktu: ${booking.bookingTime}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            '👥 Jumlah: ${booking.headCount} Peserta',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: booking
                                                              .bookingStatus ==
                                                          'PENDING'
                                                      ? Colors.deepOrange
                                                      : booking.bookingStatus ==
                                                              'SUCCESS'
                                                          ? appSuccess
                                                          : appRed,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    booking.bookingStatus
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: appLightGrey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              booking.bookingStatus ==
                                                      'CANCELED'
                                                  ? const SizedBox()
                                                  : booking.bookingStatus ==
                                                          'SUCCESS'
                                                      ? InkWell(
                                                          onTap: () {
                                                            double
                                                                selectedRating =
                                                                0;

                                                            Get.defaultDialog(
                                                              title:
                                                                  "Beri Nilai Lokasi",
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  const SizedBox(
                                                                      height:
                                                                          8),
                                                                  Text(
                                                                    'Silakan beri rating untuk : ${booking.location?.name}',
                                                                    style: GoogleFonts.montserrat(
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          16),
                                                                  StatefulBuilder(
                                                                    builder:
                                                                        (context,
                                                                            setState) {
                                                                      return RatingBar
                                                                          .builder(
                                                                        initialRating:
                                                                            0,
                                                                        minRating:
                                                                            1,
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount:
                                                                            5,
                                                                        itemSize:
                                                                            36,
                                                                        itemPadding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                4.0),
                                                                        itemBuilder: (context, _) => const Icon(
                                                                            Icons
                                                                                .star,
                                                                            color:
                                                                                Colors.amber),
                                                                        onRatingUpdate:
                                                                            (rating) {
                                                                          setState(
                                                                              () {
                                                                            selectedRating =
                                                                                rating;
                                                                          });
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          16),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (selectedRating ==
                                                                          0) {
                                                                        Get.snackbar(
                                                                            "Peringatan",
                                                                            "Harap beri rating terlebih dahulu");
                                                                        return;
                                                                      }

                                                                      // TODO: Kirim rating ke server di sini
                                                                      print(
                                                                          "Rating diberikan: $selectedRating");

                                                                      _locationC.rate(
                                                                          id: booking.location?.id ??
                                                                              0,
                                                                          rate:
                                                                              selectedRating);
                                                                    },
                                                                    child: const Text(
                                                                        "Kirim"),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: appPrimary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                ' ⭐ Beri Nilai',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize: 12,
                                                                  color:
                                                                      appLightGrey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            _bookingC.cancel(
                                                                id: booking
                                                                        .id ??
                                                                    0);
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: appRed,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Cancel',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  color:
                                                                      appLightGrey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: CustomBottomNavbar(currentIndex: 1),
    );
  }
}
