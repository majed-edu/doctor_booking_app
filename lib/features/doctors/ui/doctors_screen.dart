import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/doctors/logic/doctors_cubit.dart';
import 'package:doctor_booking_app/features/doctors/logic/doctors_state.dart';
import 'package:doctor_booking_app/features/doctors/ui/widgets/doctors_search_filters.dart';
import 'package:doctor_booking_app/features/doctors/ui/widgets/doctors_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('All Doctors', style: TextStyles.font18DarkBlueBold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          BlocBuilder<DoctorsCubit, DoctorsState>(
            builder: (context, state) => state.hasActiveFilters
                ? TextButton.icon(
                    onPressed: () =>
                        context.read<DoctorsCubit>().clearAllFilters(),
                    icon: const Icon(
                      Icons.refresh,
                      size: 18,
                      color: ColorsManager.mainBlue,
                    ),
                    label: Text('Reset', style: TextStyles.font12BlueRegular),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const DoctorsSearchFilters(),
            verticalSpace(8),
            Expanded(
              child: BlocBuilder<DoctorsCubit, DoctorsState>(
                builder: (context, state) {
                  switch (state.status) {
                    case DoctorsStatus.loading:
                    case DoctorsStatus.initial:
                      return const DoctorsLoading();
                    case DoctorsStatus.error:
                      return DoctorsErrorState(error: state.errorMessage);
                    case DoctorsStatus.success:
                      return state.doctors.isEmpty
                          ? const DoctorsEmptyState()
                          : DoctorsList(doctors: state.doctors);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
