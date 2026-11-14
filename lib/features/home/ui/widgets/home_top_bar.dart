import 'package:doctor_booking_app/core/helpers/constants.dart';
import 'package:doctor_booking_app/core/helpers/shared_pref_helper.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/profile/logic/profile_state.dart';
import 'package:doctor_booking_app/features/profile/logic/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeTopBar extends StatefulWidget {
  const HomeTopBar({super.key});

  @override
  State<HomeTopBar> createState() => _HomeTopBarState();
}

class _HomeTopBarState extends State<HomeTopBar> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    final name = await SharedPrefHelper.getString(SharedPrefKeys.userName);
    if (mounted && name.isNotEmpty) {
      setState(() {
        _userName = name.split(' ').first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          previous.user?.name != current.user?.name,
      builder: (context, state) {
        final profileName = state.user?.name?.trim() ?? '';
        final name = profileName.isNotEmpty ? profileName : _userName;
        final firstName = name.isNotEmpty ? name.split(' ').first : '';

        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstName.isNotEmpty ? 'Hey $firstName' : 'Hey User',
                  style: TextStyles.font18DarkBlueBold,
                ),
                Text(
                  'How are you feeling today?',
                  style: TextStyles.font12GrayRegular,
                ),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: 24,
              backgroundColor: ColorsManager.moreLighterGray,
              child: SvgPicture.asset('assets/svgs/notifications.svg'),
            ),
          ],
        );
      },
    );
  }
}
