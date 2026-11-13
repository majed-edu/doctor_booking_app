import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';

import 'doctors_list_view_item.dart';

class DoctorsListView extends StatelessWidget {
  const DoctorsListView({super.key, required this.doctorsList});

  final List<Doctors?>? doctorsList;

  @override
  Widget build(BuildContext context) {
    final doctors = doctorsList ?? const <Doctors?>[];

    if (doctors.isEmpty) {
      return const Expanded(
        child: Center(child: Text('No doctors found for this specialization')),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: doctors.length,
        itemBuilder: (context, index) =>
            DoctorsListViewItem(doctorsModel: doctors[index]),
      ),
    );
  }
}
