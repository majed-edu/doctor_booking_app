import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:doctor_booking_app/features/home/logic/home_cubit.dart';
import 'package:doctor_booking_app/features/home/logic/home_state.dart';
import 'package:doctor_booking_app/features/home/ui/widgets/doctors_list/doctros_bloc_builder.dart';
import 'package:doctor_booking_app/features/home/ui/widgets/doctors_list/doctors_shimmer_loading.dart';
import 'package:doctor_booking_app/features/home/ui/widgets/specializations_list/speciality_list_view.dart';
import 'package:doctor_booking_app/features/home/ui/widgets/specializations_list/speciality_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecializationsBlocBuilder extends StatelessWidget {
  const SpecializationsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is SpecializationsLoading ||
          current is SpecializationsSuccess ||
          current is SpecializationsError,
      builder: (context, state) {
        return state.maybeWhen(
          specializationsLoading: () => _loading(),
          specializationsSuccess: (specializationDataList) =>
              _success(specializationDataList ?? const []),
          specializationsError: (_) => _error(),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _loading() {
    return const Expanded(
      child: Column(
        children: [
          SpecialityShimmerLoading(),
          SizedBox(height: 8),
          DoctorsShimmerLoading(),
        ],
      ),
    );
  }

  Widget _success(List<SpecializationsData?> specializationDataList) {
    return Expanded(
      child: Column(
        children: [
          SpecialityListView(specializationDataList: specializationDataList),
          verticalSpace(8),
          DoctorsBlocBuilder(
            initialDoctors: specializationDataList.isEmpty
                ? const []
                : specializationDataList.first?.doctorsList,
          ),
        ],
      ),
    );
  }

  Widget _error() {
    return const Expanded(
      child: Center(child: Text('Unable to load specializations')),
    );
  }
}
