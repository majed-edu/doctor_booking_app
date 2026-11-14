import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'doctor_details_contact.dart';
import 'doctor_details_location.dart';
import 'doctor_details_profile.dart';
import 'doctor_details_stats.dart';
import 'doctor_details_booking_bar.dart';

class DoctorDetailsContent extends StatelessWidget {
  final Doctors doctor;
  const DoctorDetailsContent({super.key, required this.doctor});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: ColorsManager.darkBlue,
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        doctor.name ?? 'Doctor Details',
        style: TextStyles.font18DarkBlueBold,
      ),
      centerTitle: true,
    ),
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorDetailsProfile(doctor: doctor),
                  SizedBox(height: 24.h),
                  DoctorDetailsStats(doctor: doctor),
                  SizedBox(height: 24.h),
                  Text(
                    'About Doctor',
                    style: TextStyles.font18DarkBlueSemiBold,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    doctor.displayDescription.isNotEmpty
                        ? doctor.displayDescription
                        : 'Experienced professional dedicated to delivering comprehensive patient care.',
                    style: TextStyles.font14DarkBlueMedium.copyWith(
                      color: ColorsManager.gray,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Clinic & Location',
                    style: TextStyles.font18DarkBlueSemiBold,
                  ),
                  SizedBox(height: 12.h),
                  DoctorDetailsLocation(doctor: doctor),
                  SizedBox(height: 24.h),
                  if (doctor.phone != null || doctor.email != null) ...[
                    Text(
                      'Contact Information',
                      style: TextStyles.font18DarkBlueSemiBold,
                    ),
                    SizedBox(height: 12.h),
                    DoctorDetailsContact(doctor: doctor),
                    SizedBox(height: 24.h),
                  ],
                ],
              ),
            ),
          ),
          DoctorDetailsBookingBar(doctor: doctor),
        ],
      ),
    ),
  );
}
