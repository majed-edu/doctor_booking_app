import 'package:doctor_booking_app/core/helpers/app_regex.dart';
import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/widgets/app_text_form_field.dart';
import 'package:doctor_booking_app/features/login/logic/cubit/login_cubit.dart';
import 'package:doctor_booking_app/features/login/ui/widgets/password_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;
  
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasSpecialCharacter = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<LoginCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      final password = passwordController.text;
      setState(() {
        hasUpperCase = AppRegex.hasUpperCase(password);
        hasLowerCase = AppRegex.hasLowerCase(password);
        hasSpecialCharacter = AppRegex.hasSpecialCharacter(password);
        hasNumber = AppRegex.hasNumber(password);
        hasMinLength = AppRegex.hasMinLength(password);
      });
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().fromKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty || !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
            },
            controller: context.read<LoginCubit>().emailController,
          ),
          verticalSpace(18),
          AppTextFormField(
            controller: context.read<LoginCubit>().passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
            hintText: 'Password',
            isObscureText: isObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              child: Icon(
                isObscureText
                 ? Icons.visibility 
                 : Icons.visibility_off,
                color: ColorsManager.mainBlue,
              ),
            ),
          ),
          verticalSpace(24),

          PasswordValidations(
            hasUpperCase: hasUpperCase,
            hasLowerCase: hasLowerCase,
            hasSpecialCharacter: hasSpecialCharacter,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
        ],
      ),
    );
  }


@override
  void dispose() {
    passwordController.removeListener(() {});
    super.dispose();
  }


  
}
