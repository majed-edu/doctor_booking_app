import 'package:doctor_booking_app/core/di/dependency_injction.dart';
import 'package:doctor_booking_app/features/appointments/ui/appointments_screen.dart';
import 'package:doctor_booking_app/features/doctors/logic/doctors_cubit.dart';
import 'package:doctor_booking_app/features/doctors/ui/doctors_screen.dart';
import 'package:doctor_booking_app/features/home/logic/home_cubit.dart';
import 'package:doctor_booking_app/features/home/ui/home_screen.dart';
import 'package:doctor_booking_app/features/main_layout/logic/main_layout_cubit.dart';
import 'package:doctor_booking_app/features/profile/logic/profile_cubit.dart';
import 'package:doctor_booking_app/features/profile/ui/profile_screen.dart';
import 'package:doctor_booking_app/features/main_layout/ui/widgets/main_layout_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(getIt())..getSpecializations(),
        ),
        BlocProvider<DoctorsCubit>(
          create: (_) => DoctorsCubit(getIt())..init(),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(getIt())..getUserProfile(),
        ),
      ],
      child: const _MainLayoutView(),
    );
  }
}

class _MainLayoutView extends StatelessWidget {
  const _MainLayoutView();

  static const List<Widget> _screens = [
    HomeScreen(),
    DoctorsScreen(),
    AppointmentsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final activeIndex = context.watch<MainLayoutCubit>().state;

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: activeIndex, children: _screens),
      bottomNavigationBar: MainLayoutNavigation(activeIndex: activeIndex),
    );
  }
}
