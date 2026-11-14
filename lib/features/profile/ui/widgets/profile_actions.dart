import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/main_layout/logic/main_layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ColorsManager.lighterGray),
    ),
    child: Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.calendar_today_outlined,
            color: ColorsManager.mainBlue,
          ),
          title: Text(
            'My Appointments',
            style: TextStyles.font14DarkBlueMedium,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: ColorsManager.gray,
          ),
          onTap: () => context.read<MainLayoutCubit>().changeTab(2),
        ),
        Divider(height: 1, color: ColorsManager.lighterGray),
        ListTile(
          leading: const Icon(
            Icons.medical_services_outlined,
            color: ColorsManager.mainBlue,
          ),
          title: Text(
            'Explore Doctors',
            style: TextStyles.font14DarkBlueMedium,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: ColorsManager.gray,
          ),
          onTap: () => context.read<MainLayoutCubit>().changeTab(1),
        ),
      ],
    ),
  );
}
