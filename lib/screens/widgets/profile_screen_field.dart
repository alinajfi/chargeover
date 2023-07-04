import 'package:chargeover/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class AccountScreenFeild extends StatelessWidget {
  const AccountScreenFeild({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 4),
                )
              ]),
          height: 40.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  icon,
                  color: Colors.black,
                  height: 18.h,
                  fit: BoxFit.fill,
                ),
              ),
              10.w.spaceH,
              Expanded(
                  child: Text(title,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: Colors.grey)))
            ],
          )),
    );
  }
}
