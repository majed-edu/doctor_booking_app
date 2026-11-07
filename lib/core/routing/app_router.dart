import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:doctor_booking_app/features/login/ui/login_screen.dart';
import 'package:doctor_booking_app/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    // this arguments variable is used to pass data between screens, if needed in the future.
    final arguments = settings.arguments;


    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}
