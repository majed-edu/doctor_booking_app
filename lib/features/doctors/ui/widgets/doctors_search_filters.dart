import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/doctors/logic/doctors_cubit.dart';
import 'package:doctor_booking_app/features/doctors/logic/doctors_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsSearchFilters extends StatelessWidget {
  const DoctorsSearchFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorsCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: ColorsManager.moreLighterGray,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorsManager.lighterGray),
            ),
            child: Row(
              children: [
                horizontalSpace(12),
                const Icon(Icons.search, color: ColorsManager.gray, size: 22),
                horizontalSpace(8),
                Expanded(
                  child: TextField(
                    controller: cubit.searchController,
                    onChanged: cubit.onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search doctor by name...',
                      hintStyle: TextStyles.font12GrayRegular,
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyles.font14DarkBlueMedium,
                  ),
                ),
                BlocBuilder<DoctorsCubit, DoctorsState>(
                  buildWhen: (previous, current) =>
                      previous.searchQuery != current.searchQuery,
                  builder: (context, state) => state.searchQuery.isEmpty
                      ? const SizedBox.shrink()
                      : IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: ColorsManager.gray,
                          ),
                          onPressed: () {
                            cubit.searchController.clear();
                            cubit.onSearchChanged('');
                          },
                        ),
                ),
              ],
            ),
          ),
          verticalSpace(12),
          BlocBuilder<DoctorsCubit, DoctorsState>(
            buildWhen: (previous, current) =>
                previous.specializations != current.specializations ||
                previous.selectedSpecializationId !=
                    current.selectedSpecializationId,
            builder: (context, state) {
              if (state.specializations.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: 36.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.specializations.length + 1,
                  separatorBuilder: (_, __) => horizontalSpace(8),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final isSelected = state.selectedSpecializationId == null;
                      return _FilterChip(
                        label: 'All Specs',
                        isSelected: isSelected,
                        onTap: () {
                          if (!isSelected) {
                            cubit.onSpecializationSelected(null);
                          }
                        },
                      );
                    }
                    final specialization = state.specializations[index - 1];
                    return _FilterChip(
                      label: specialization.name ?? 'Specialty',
                      isSelected:
                          state.selectedSpecializationId == specialization.id,
                      onTap: () =>
                          cubit.onSpecializationSelected(specialization.id),
                    );
                  },
                ),
              );
            },
          ),
          verticalSpace(10),
          BlocBuilder<DoctorsCubit, DoctorsState>(
            buildWhen: (previous, current) =>
                previous.governorates != current.governorates ||
                previous.cities != current.cities ||
                previous.selectedGovernorateId !=
                    current.selectedGovernorateId ||
                previous.selectedCityId != current.selectedCityId,
            builder: (context, state) => Row(
              children: [
                Expanded(
                  child: _LocationDropdown(
                    hint: 'Governorate',
                    value: state.selectedGovernorateId,
                    selected: state.selectedGovernorateId != null,
                    items: state.governorates
                        .map(
                          (item) => DropdownMenuItem<int?>(
                            value: item.id,
                            child: Text(
                              item.name ?? '',
                              style: TextStyles.font12DarkBlueRegular,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: cubit.onGovernorateSelected,
                  ),
                ),
                horizontalSpace(8),
                Expanded(
                  child: _LocationDropdown(
                    hint: 'City',
                    value: state.selectedCityId,
                    selected: state.selectedCityId != null,
                    items: state.availableCities
                        .map(
                          (item) => DropdownMenuItem<int?>(
                            value: item.id,
                            child: Text(
                              item.name ?? '',
                              style: TextStyles.font12DarkBlueRegular,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: cubit.onCitySelected,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? ColorsManager.mainBlue : ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected
              ? ColorsManager.mainBlue
              : ColorsManager.lighterGray,
        ),
      ),
      child: Text(
        label,
        style: isSelected
            ? TextStyles.font12DarkBlueRegular.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              )
            : TextStyles.font12DarkBlueRegular,
      ),
    ),
  );
}

class _LocationDropdown extends StatelessWidget {
  final String hint;
  final int? value;
  final bool selected;
  final List<DropdownMenuItem<int?>> items;
  final ValueChanged<int?> onChanged;

  const _LocationDropdown({
    required this.hint,
    required this.value,
    required this.selected,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
    height: 40.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: selected ? ColorsManager.mainBlue : ColorsManager.lighterGray,
      ),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<int?>(
        isExpanded: true,
        value: value,
        hint: Text(
          hint,
          style: TextStyles.font12GrayRegular,
          overflow: TextOverflow.ellipsis,
        ),
        icon: const Icon(Icons.keyboard_arrow_down, size: 18),
        items: [
          DropdownMenuItem<int?>(
            value: null,
            child: Text(
              hint == 'City' ? 'All Cities' : 'All Governorates',
              style: TextStyles.font12DarkBlueRegular,
            ),
          ),
          ...items,
        ],
        onChanged: onChanged,
      ),
    ),
  );
}
