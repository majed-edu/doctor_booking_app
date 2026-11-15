import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/profile/logic/profile_cubit.dart';
import 'package:doctor_booking_app/features/profile/logic/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_actions.dart';
import 'profile_edit_sheet.dart';
import 'profile_error.dart';
import 'profile_header.dart';
import 'profile_info.dart';
import 'profile_loading.dart';
import 'profile_logout_dialog.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.loggedOut) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(Routes.loginScreen, (_) => false);
          }
          if (state.status == ProfileStatus.updateSuccess ||
              (state.status == ProfileStatus.error &&
                  state.errorMessage != null)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.status == ProfileStatus.updateSuccess
                      ? (state.successMessage ?? 'Profile updated')
                      : state.errorMessage!,
                ),
                backgroundColor: state.status == ProfileStatus.updateSuccess
                    ? ColorsManager.green
                    : ColorsManager.red,
              ),
            );
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('My Profile', style: TextStyles.font18DarkBlueBold),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
          ),
          body: SafeArea(
            child: state.isLoading && state.user == null
                ? const ProfileLoading()
                : state.user == null
                ? ProfileError(error: state.errorMessage)
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        ProfileHeader(
                          user: state.user!,
                          onEdit: () =>
                              showProfileEditSheet(context, state.user!),
                        ),
                        const SizedBox(height: 24),
                        ProfileInfo(user: state.user!),
                        const SizedBox(height: 20),
                        const ProfileActions(),
                        const SizedBox(height: 24),
                        ProfileLogoutButton(
                          onPressed: () => showLogoutDialog(context),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
          ),
        ),
      );
}
