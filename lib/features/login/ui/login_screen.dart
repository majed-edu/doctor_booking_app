import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/core/widgets/app_text_button.dart';
import 'package:doctor_booking_app/features/login/logic/cubit/login_cubit.dart';
import 'package:doctor_booking_app/features/login/ui/widgets/dont_have_account_text.dart';
import 'package:doctor_booking_app/features/login/ui/widgets/email_and_password.dart';
import 'package:doctor_booking_app/features/login/ui/widgets/login_bloc_listener.dart';
import 'package:doctor_booking_app/features/login/ui/widgets/terms_and_conditions_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back!', style: TextStyles.font32BlueBold),

                verticalSpace(8),
                Text(
                  'We\'re excited to see you again! Please login to your account to continue enjoying our services.',
                  style: TextStyles.font14GrayRegular,
                ),
                verticalSpace(36),

                Column(
                  children: [
                    const EmailAndPassword(),
                    verticalSpace(24),

                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        onTap: () {
                          // Handle forgot password action
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyles.font13BlueRegular,
                        ),
                      ),
                    ),
                    verticalSpace(40),

                    AppTextButton(
                      buttonText: 'Login',
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        // Handle login action
                        validateThenDoLogin(context);
                      },
                    ),

                    verticalSpace(16),
                    const TermsAndConditionsText(),
                    verticalSpace(60),
                    const DontHaveAccountText(),

                    const LoginBlocListener(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    if (loginCubit.fromKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginStates();
    }
  }
}
