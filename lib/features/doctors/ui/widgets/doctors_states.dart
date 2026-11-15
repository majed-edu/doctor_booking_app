import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/doctors/logic/doctors_cubit.dart';
import 'package:doctor_booking_app/features/doctors/ui/widgets/doctor_card.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DoctorsLoading extends StatelessWidget {
  const DoctorsLoading({super.key});
  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    itemCount: 6,
    separatorBuilder: (_, __) => verticalSpace(12),
    itemBuilder: (_, __) => Shimmer.fromColors(
      baseColor: ColorsManager.lighterGray,
      highlightColor: Colors.white,
      child: Container(
        height: 110.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}

class DoctorsEmptyState extends StatelessWidget {
  const DoctorsEmptyState({super.key});
  @override
  Widget build(BuildContext context) => _StateMessage(
    icon: Icons.search_off_rounded,
    title: 'No Doctors Found',
    message:
        'We could not find any doctors matching your search or filter criteria.',
    buttonLabel: 'Clear All Filters',
    onPressed: () => context.read<DoctorsCubit>().clearAllFilters(),
  );
}

class DoctorsErrorState extends StatelessWidget {
  final String? error;
  const DoctorsErrorState({super.key, this.error});
  @override
  Widget build(BuildContext context) => _StateMessage(
    icon: Icons.error_outline_rounded,
    title: 'Unable to Load Doctors',
    message: error ?? 'An unexpected error occurred. Please try again.',
    buttonLabel: 'Try Again',
    onPressed: () => context.read<DoctorsCubit>().fetchDoctors(),
  );
}

class _StateMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onPressed;
  const _StateMessage({
    required this.icon,
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 54.sp, color: ColorsManager.lightGray),
          verticalSpace(16),
          Text(title, style: TextStyles.font18DarkBlueSemiBold),
          verticalSpace(8),
          Text(
            message,
            style: TextStyles.font12GrayRegular,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              buttonLabel,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

class DoctorsList extends StatelessWidget {
  final List<Doctors> doctors;
  const DoctorsList({super.key, required this.doctors});
  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: () => context.read<DoctorsCubit>().fetchDoctors(),
    color: ColorsManager.mainBlue,
    child: ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      itemCount: doctors.length,
      separatorBuilder: (_, __) => verticalSpace(12),
      itemBuilder: (_, index) => DoctorCard(doctor: doctors[index]),
    ),
  );
}
