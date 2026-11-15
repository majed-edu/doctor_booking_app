import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:doctor_booking_app/features/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'speciality_list_view_item.dart';

class SpecialityListView extends StatefulWidget {
  const SpecialityListView({super.key, required this.specializationDataList});

  final List<SpecializationsData?> specializationDataList;

  @override
  State<SpecialityListView> createState() => _SpecialityListViewState();
}

class _SpecialityListViewState extends State<SpecialityListView> {
  int _selectedSpecializationIndex = 0;

  @override
  void didUpdateWidget(covariant SpecialityListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_selectedSpecializationIndex >= widget.specializationDataList.length) {
      _selectedSpecializationIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.specializationDataList.length,
        itemBuilder: (context, index) {
          final specialization = widget.specializationDataList[index];
          return GestureDetector(
            onTap: () {
              setState(() => _selectedSpecializationIndex = index);
              context.read<HomeCubit>().getDoctorsList(
                specializationId: specialization?.id,
              );
            },
            child: SpecialityListViewItem(
              specializationsData: specialization,
              itemIndex: index,
              selectedIndex: _selectedSpecializationIndex,
            ),
          );
        },
      ),
    );
  }
}
