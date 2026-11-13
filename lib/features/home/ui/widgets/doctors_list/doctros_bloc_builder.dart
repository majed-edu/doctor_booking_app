import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:doctor_booking_app/features/home/logic/home_cubit.dart';
import 'package:doctor_booking_app/features/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doctors_list_view.dart';

class DoctorsBlocBuilder extends StatelessWidget {
  const DoctorsBlocBuilder({super.key, required this.initialDoctors});

  final List<Doctors?>? initialDoctors;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is DoctorsSuccess || current is DoctorsError,
      builder: (context, state) {
        return state.maybeWhen(
          doctorsSuccess: (doctorsList) =>
              DoctorsListView(doctorsList: doctorsList),
          doctorsError: (_) => const DoctorsListView(doctorsList: []),
          orElse: () => DoctorsListView(doctorsList: initialDoctors),
        );
      },
    );
  }
}
