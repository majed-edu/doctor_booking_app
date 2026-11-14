import 'package:doctor_booking_app/core/di/dependency_injction.dart';
import 'package:doctor_booking_app/core/helpers/constants.dart';
import 'package:doctor_booking_app/core/helpers/shared_pref_helper.dart';
import 'package:doctor_booking_app/core/networking/dio_factory.dart';
import 'package:doctor_booking_app/core/routing/app_router.dart';
import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_booking_app/doc_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // To fix texts being hidden bug in flutter_screenutil in release mode.
  await ScreenUtil.ensureScreenSize();
  await checkIfLoggedInUser();
  await setupGetIt();
  DioFactory.setUnauthorizedHandler(
    () => appNavigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.loginScreen,
      (route) => false,
    ),
  );

  runApp(DocApp(appRouter: AppRouter()));
}

Future<void> checkIfLoggedInUser() async {
  final userToken = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );
  if (userToken.trim().isNotEmpty) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
