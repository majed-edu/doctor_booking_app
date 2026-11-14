import 'package:doctor_booking_app/core/helpers/constants.dart';
import 'package:doctor_booking_app/core/routing/app_router.dart';
import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/di/dependency_injction.dart';
import 'package:doctor_booking_app/features/appointments/logic/appointments_cubit.dart';
import 'package:doctor_booking_app/features/main_layout/logic/main_layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class DocApp extends StatelessWidget {
  const DocApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      //   splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MainLayoutCubit>(create: (_) => MainLayoutCubit()),
          BlocProvider<AppointmentsCubit>(
            create: (_) => AppointmentsCubit(getIt()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Doc App',
          navigatorKey: appNavigatorKey,
          theme: ThemeData(
            primaryColor: ColorsManager.mainBlue,
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: !hasCompletedOnboarding
              ? Routes.onBoardingScreen
              : isLoggedInUser
              ? Routes.homeScreen
              : Routes.loginScreen,
          onGenerateRoute: appRouter.generateRoute,
        ),
      ),
    );
  }
}
