import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/text_styles.dart';

class HomeTextfield extends StatelessWidget {
  const HomeTextfield(
      {Key? key,
      required this.hint,
      this.controller,
      this.suffix,
      this.validator,
      this.maxLines,
      this.obesecure = false,
      this.focusNode,
      this.onChanged})
      : super(key: key);
  final String hint;
  final TextEditingController? controller;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool obesecure;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;

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
      onChanged: onChanged,
      style: TextStyles.inter(color: AppColors.white),
      decoration: InputDecoration(
          constraints: BoxConstraints(
              maxWidth: size.width,
              minWidth: size.width,
              maxHeight: 52.h,
              minHeight: 52.h),
          suffixIcon: suffix,
          hintText: hint,
          hintStyle: TextStyles.inter(color: AppColors.black),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Color(0xffBDC6D1))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: AppColors.buyTicketBtnClr)),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: const BorderSide(
                width: 2, style: BorderStyle.solid, color: Color(0xffBDC6D1)),
          )),
    );
  }
}
