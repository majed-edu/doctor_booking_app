import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpecialityListViewItem extends StatelessWidget {
  const SpecialityListViewItem({
    super.key,
    this.specializationsData,
    required this.itemIndex,
    required this.selectedIndex,
  });

  final SpecializationsData? specializationsData;
  final int itemIndex;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final isSelected = itemIndex == selectedIndex;
    final imageUrl = specializationsData?.image;

    return SizedBox(
      width: 84.w,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: itemIndex == 0 ? 0 : 12.w),
        child: Column(
          
          children: [
            SizedBox(height: 3.h,),
            AnimatedScale(
              scale: isSelected ? 1.08 : 1,
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                width: 64.w,
                height: 64.w,
                padding: EdgeInsets.all(isSelected ? 2.w : 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? ColorsManager.mainBlue
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? ColorsManager.mainBlue
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: isSelected
                      ? ColorsManager.lightBlue
                      : ColorsManager.lightBlue,
                  backgroundImage: imageUrl?.isNotEmpty == true
                      ? NetworkImage(imageUrl!)
                      : null,
                  child: imageUrl?.isNotEmpty == true
                      ? null
                      : SvgPicture.asset(
                          'assets/svgs/general_speciality.svg',
                          height: isSelected ? 42.h : 38.h,
                          width: isSelected ? 42.w : 38.w,
                          colorFilter: isSelected
                              ? const ColorFilter.mode(
                                  ColorsManager.mainBlue,
                                  BlendMode.srcIn,
                                )
                              : null,
                        ),
                ),
              ),
            ),
            verticalSpace(8),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: isSelected
                  ? TextStyles.font14DarkBlueBold
                  : TextStyles.font12DarkBlueRegular,
              child: Text(
                specializationsData?.name ?? 'Specialization',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
