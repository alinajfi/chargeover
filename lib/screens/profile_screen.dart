import 'package:chargeover/screens/widgets/profile_screen_field.dart';
import 'package:chargeover/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _accoutScreenBody(context),
    );
  }

  Widget _accoutScreenBody(BuildContext context) {
    return Column(
      children: [
        _profileInfo(),
        40.h.spaceV,
        Expanded(child: _actions()),
        _logoutBtn(context),
        40.h.spaceV,
      ],
    );
  }

  Widget _profileInfo() {
    return Container(
      padding: EdgeInsets.only(top: 40.h, left: 15, right: 15),
      color: AppColors.buyTicketBtnClr,
      height: 150.h,
      width: ScreenUtil().screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'My Profile',
              style: TextStyles.poppins(FontWeight.w400, 20.sp,
                  color: AppColors.white),
            ),
          ),
          10.h.spaceV,
          _info(),
        ],
      ),
    );
  }

  Widget _info() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: _profilePhoto()),
        10.w.spaceH,
        Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ibitsam Ali',
                  style: TextStyles.poppins(FontWeight.w600, 14.sp,
                      color: AppColors.white),
                ),
                Text('+01 65841542265', style: _style()),
                Text(
                  'ibitsam@gmail.com',
                  style: _style(),
                ),
              ],
            )),
        35.w.spaceH,
        Flexible(flex: 1, child: _editProfileBtn()),
      ],
    );
  }

  Widget _profilePhoto() {
    return Container(
      height: 60.h,
      width: 60.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Image.asset('assets/images/pngs/user_avatar.png'),
    );
  }

  Widget _editProfileBtn() {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        height: 25.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.white.withOpacity(0.2),
        ),
        child: Text(
          'Edit Profile',
          style: _style(),
        ),
      ),
    );
  }

  TextStyle _style() {
    return TextStyles.poppins(FontWeight.w400, 12.sp,
        color: const Color(0xFFFFFFFF));
  }

  Widget _actions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: const [
          AccountScreenFeild(
            title: 'My Profile',
            icon: 'assets/images/pngs/icon_account.png',
          ),
        ],
      ),
    );
  }

  Widget _logoutBtn(BuildContext context) {
    return GestureDetector(
      // onTap: () => showDialog(
      //   context: context,
      //   builder: (context) => const LogOutDialog(),
      // ),
      child: Container(
        alignment: Alignment.center,
        width: 200.w,
        height: 40.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.buyTicketBtnClr, width: 1)),
        child: const Text(
          'Logout',
        ),
      ),
    );
  }
}
