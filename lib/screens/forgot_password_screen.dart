import 'package:chargeover/screens/widgets/my_text_field.dart';
import 'package:chargeover/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _builBody(),
    );
  }

  Widget _builBody() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            color: Colors.red,
            child: Image.asset(
              r'assets/images/bgimage.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: Get.width,
            height: Get.height,
            color: Colors.grey.withOpacity(0.2),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  20.0.spaceV,
                  _emailFeild(),
                  20.0.spaceV,
                  _loginButton()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailFeild() {
    return MyTextFeild(
      hint: 'Enter Email',
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty) return 'Please Enter Email';
        return null;
      },
    );
  }

  Widget _loginButton() {
    return ElevatedButton.icon(
      onPressed: () async {},
      icon: const Icon(Icons.person_2),
      label: const Text('Reset Password'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        minimumSize: Size(220.w, 45.h),
      ),
    );
  }
}
