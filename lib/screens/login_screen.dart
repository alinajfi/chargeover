import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chargeover/screens/home_screen.dart';
import 'package:chargeover/screens/signup_screen.dart';
import 'package:chargeover/screens/widgets/dialogues.dart';
import 'package:chargeover/screens/widgets/my_text_field.dart';
import 'package:chargeover/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../utils/text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool loggin = false;
  FocusNode focusNode = FocusNode();
  bool isObscuree = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
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
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            color: Colors.grey.withOpacity(0.2),
            width: Get.width,
            height: Get.height,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  20.0.spaceV,
                  _emailFeild(),
                  20.0.spaceV,
                  _passwordFeild(),
                  60.0.spaceV,
                  _loginButton(),
                  30.0.spaceV,
                  TextButton(
                      onPressed: () async {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyles.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          size: 14.sp,
                        ),
                      )),
                  TextButton(
                    onPressed: () async {
                      Get.to(const SignupScreen());
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyles.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: 'Sign Up',
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

  Widget _emailFeild() {
    return MyTextFeild(
      hint: 'Enter Email',
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) return 'Please Enter Email';
        return null;
      },
    );
  }

  Widget _passwordFeild() {
    return MyTextFeild(
      focusNode: focusNode,
      hint: 'Enter Password',
      obesecure: isObscuree,
      controller: passwordController,
      maxLines: 1,
      validator: (value) {
        if (value!.isEmpty) return 'Please Enter password';
        return null;
      },
      suffix: InkWell(
          onTap: () => setState(() {
                isObscuree = !isObscuree;
              }),
          child: isObscuree
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility_rounded)),
    );
  }

  Widget _loginButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        focusNode.unfocus();

        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

          Get.to(const HomeScreen());
        } catch (e) {
          if (e.toString().contains('String is empty')) {
            InfoDialogs.errorDialog('Fields are empty').show();
          } else {
            InfoDialogs.errorDialog(e.toString()).show();
          }
        }
      },
      icon: const Icon(
        Icons.person_2,
        color: AppColors.white,
      ),
      label: Text(
        'Log In',
        style: TextStyles.inter(
          color: Colors.white,
          size: 14.sp,
        ),
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
