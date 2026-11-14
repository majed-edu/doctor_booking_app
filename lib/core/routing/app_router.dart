import 'package:doctor_booking_app/core/di/dependency_injction.dart';
import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:doctor_booking_app/features/appointments/logic/appointments_cubit.dart';
import 'package:doctor_booking_app/features/appointments/ui/appointments_screen.dart';
import 'package:doctor_booking_app/features/booking/logic/booking_cubit.dart';
import 'package:doctor_booking_app/features/booking/ui/booking_screen.dart';
import 'package:doctor_booking_app/features/doctor_details/ui/doctor_details_screen.dart';
import 'package:doctor_booking_app/features/doctors/logic/doctors_cubit.dart';
import 'package:doctor_booking_app/features/doctors/ui/doctors_screen.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:doctor_booking_app/features/login/logic/cubit/login_cubit.dart';
import 'package:doctor_booking_app/features/login/ui/login_screen.dart';
import 'package:doctor_booking_app/features/main_layout/ui/main_layout_screen.dart';
import 'package:doctor_booking_app/features/onboarding/onboarding_screen.dart';
import 'package:doctor_booking_app/features/profile/logic/profile_cubit.dart';
import 'package:doctor_booking_app/features/profile/ui/profile_screen.dart';
import 'package:doctor_booking_app/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:doctor_booking_app/features/sign_up/ui/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const MainLayoutScreen(),
        );
      case Routes.doctorsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => DoctorsCubit(getIt())..init(),
            child: const DoctorsScreen(),
          ),
        );
      case Routes.doctorDetailsScreen:
        if (arguments is Doctors) {
          return MaterialPageRoute(
            builder: (_) => DoctorDetailsScreen(doctor: arguments),
          );
        }
        return null;
      case Routes.bookingScreen:
        if (arguments is Doctors) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => BookingCubit(getIt()),
              child: BookingScreen(doctor: arguments),
            ),
          );
        }
        return null;
      case Routes.appointmentsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AppointmentsCubit(getIt())..getAppointments(),
            child: const AppointmentsScreen(),
          ),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ProfileCubit(getIt())..getUserProfile(),
            child: const ProfileScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
