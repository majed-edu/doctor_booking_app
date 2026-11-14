import 'package:doctor_booking_app/features/doctor_details/ui/widgets/doctor_details_content.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Doctors doctor;
  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) => DoctorDetailsContent(doctor: doctor);
}
