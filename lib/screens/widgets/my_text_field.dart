import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/text_styles.dart';

class MyTextFeild extends StatelessWidget {
  const MyTextFeild({
    Key? key,
    required this.hint,
    this.controller,
    this.suffix,
    this.validator,
    this.maxLines,
    this.obesecure = false,
    this.focusNode,
  }) : super(key: key);
  final String hint;
  final TextEditingController? controller;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool obesecure;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return TextFormField(
      focusNode: focusNode,
      validator: validator,
      cursorColor: AppColors.buyTicketBtnClr,
      controller: controller,
      obscureText: obesecure,
      maxLines: maxLines,
      style: TextStyles.inter(color: AppColors.white),
      decoration: InputDecoration(
          constraints: BoxConstraints(
              maxWidth: size.width,
              minWidth: size.width,
              maxHeight: 52.h,
              minHeight: 52.h),
          suffixIcon: suffix,
          hintText: hint,
          hintStyle: TextStyles.inter(color: AppColors.white),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: const BorderSide(
                  width: 5,
                  style: BorderStyle.solid,
                  color: Color(0xffBDC6D1))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: const BorderSide(
                  width: 5,
                  style: BorderStyle.solid,
                  color: AppColors.buyTicketBtnClr)),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
                width: 5, style: BorderStyle.solid, color: Color(0xffBDC6D1)),
          )),
    );
  }
}
