import 'package:doctor_booking_app/core/di/dependency_injction.dart';
import 'package:doctor_booking_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'doc_app.dart';

void main() {
  
  setupGetIt();

  runApp( DocApp(
    appRouter: AppRouter(),
  ));
}
