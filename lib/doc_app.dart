import 'package:doctor_booking_app/core/helpers/constants.dart';
import 'package:doctor_booking_app/core/routing/app_router.dart';
import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocApp extends StatelessWidget {
  const DocApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      //   splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doc App',
        theme: ThemeData(
          primaryColor: ColorsManager.mainBlue,
          scaffoldBackgroundColor: Colors.white,
        ),

        // debugShowCheckedModeBanner: false,
        // initialRoute: Routes.onBoardingScreen,
        // initialRoute: Routes.homeScreen,
          initialRoute: isLoggedInUser ? Routes.homeScreen : Routes.loginScreen,

        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
