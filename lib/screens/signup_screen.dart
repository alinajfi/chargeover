import 'dart:developer';

import 'package:chargeover/screens/home_screen.dart';
import 'package:chargeover/screens/login_screen.dart';
import 'package:chargeover/screens/widgets/my_text_field.dart';
import 'package:chargeover/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

import '../controllers/signup_controller.dart';
import '../models/user_model.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
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
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            color: Colors.grey.withOpacity(0.2),
            width: Get.width,
            height: Get.height,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  150.0.spaceV,
                  _image(),
                  20.0.spaceV,
                  _nameFeild(),
                  20.0.spaceV,
                  _emailFeild(),
                  20.0.spaceV,
                  _passwordFeild(),
                  60.0.spaceV,
                  _signUpButton(),
                  30.0.spaceV,
                  TextButton(
                    onPressed: () {
                      Get.to(const LoginScreen());
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Already have an account?',
                          style: TextStyles.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: 'Sign In',
                          style: TextStyles.inter(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600)),
                    ])),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          width: 90.h,
          height: 90.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: const ClipRRect(),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('Take a photo'),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('Choose from gallery'),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _nameFeild() {
    return MyTextFeild(
      controller: controller.nameController,
      hint: 'Enter Your Name',
      validator: (value) {
        if (value!.isEmpty) return 'Please Your Name';
        return null;
      },
    );
  }

  Widget _emailFeild() {
    return MyTextFeild(
      hint: 'Enter Your  Email',
      controller: controller.emailController,
      validator: (value) {
        if (value!.isEmpty) return 'Please Enter Email';
        return null;
      },
    );
  }

  Widget _passwordFeild() {
    return MyTextFeild(
      hint: 'Enter Your Password',
      controller: controller.passwordController,
      maxLines: 1,
      validator: (value) {
        if (value!.isEmpty) return 'Please Enter password';
        return null;
      },
    );
  }

  Widget _signUpButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        try {
          if (controller.formKey.currentState!.validate()) {
            if (!controller.emailController.text.contains('uw.edu') ||
                !controller.emailController.text.contains('washington.edu')) {
              if (controller.imageFile == null) {
                await controller.createUser(
                    controller.emailController.text.trim(),
                    controller.passwordController.text.trim());

                User? user = controller.user!.user;

                controller.saveUserToFirestore(UserModel(
                    email: controller.emailController.text,
                    imageUrl: "",
                    username: controller.nameController.text,
                    userId: user!.uid));
                Get.to(const HomeScreen());
              } else {
                controller.isUploadingImage(true);

                await controller.createUser(
                    controller.emailController.text.trim(),
                    controller.passwordController.text.trim());
                String imageUrl =
                    await controller.uploadUserImage(controller.imageFile!);

                User? user = controller.user!.user;

                controller.saveUserToFirestore(UserModel(
                    email: controller.emailController.text,
                    imageUrl: imageUrl,
                    username: controller.nameController.text,
                    userId: user!.uid));

                controller.isUploadingImage(false);
                Get.to(const HomeScreen());
              }
            } else {
              warningDialog('Enter email').show();
            }
          } else {
            log('Enter Data Corrrectly');
          }
        } on FirebaseAuthException catch (e) {
          controller.isUploadingImage(false);
          warningDialog(e.toString()).show();
          //  print('------------ $e');
        }
      },
      icon: const Icon(
        Icons.person_2,
        color: AppColors.white,
      ),
      label: Text(
        'Sign UP',
        style: TextStyles.inter(
            color: AppColors.white, size: 14.sp, fontWeight: FontWeight.w500),
      ),
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

  AwesomeDialog warningDialog(String message) {
    return AwesomeDialog(
      context: Get.context!,
      title: message,
      dialogType: DialogType.info,
      btnOk: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.appBarColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          minimumSize: Size(220.w, 45.h),
        ),
        child: const Text('OK'),
      ),
    );
  }
}
