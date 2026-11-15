import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/features/main_layout/logic/main_layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainLayoutNavigation extends StatelessWidget {
  final int activeIndex;
  const MainLayoutNavigation({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(color: ColorsManager.lighterGray, width: 1),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          offset: const Offset(0, -2),
          blurRadius: 8,
        ),
      ],
    ),
    child: BottomNavigationBar(
      currentIndex: activeIndex,
      onTap: (index) => context.read<MainLayoutCubit>().changeTab(index),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 0,
      selectedItemColor: ColorsManager.mainBlue,
      unselectedItemColor: ColorsManager.gray,
      selectedFontSize: 11.sp,
      unselectedFontSize: 11.sp,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services_outlined),
          activeIcon: Icon(Icons.medical_services_rounded),
          label: 'Doctors',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          activeIcon: Icon(Icons.calendar_month_rounded),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    ),
  );
}
