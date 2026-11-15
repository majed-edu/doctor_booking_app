import 'package:doctor_booking_app/features/booking/ui/widgets/booking_content.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  final Doctors doctor;
  const BookingScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) => BookingContent(doctor: doctor);
}
