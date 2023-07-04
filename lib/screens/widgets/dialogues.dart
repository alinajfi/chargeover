import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/text_styles.dart';

class InfoDialogs {
  static AwesomeDialog errorDialog(String message) {
    return AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.error,
      title: message,
      btnOk: ElevatedButton.icon(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.done),
        label: const Text('OK'),
      ),
    );
  }

  static AwesomeDialog succesDialog(String message, {void Function()? onTap}) {
    return AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.success,
      title: message,
      btnOk: ElevatedButton.icon(
        onPressed: onTap ?? () => Get.back(),
        icon: const Icon(Icons.done),
        label: const Text('OK'),
      ),
    );
  }

  static AwesomeDialog infooDialog(String message) {
    return AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.info,
      title: message,
      titleTextStyle: TextStyles.inter(color: AppColors.appBarColor),
      btnOk: ElevatedButton.icon(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.done),
        label: const Text('OK'),
      ),
    );
  }

  static AwesomeDialog onBoradDialog(String message, {void Function()? onTap}) {
    return AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.info,
      title: message,
      btnCancel: ElevatedButton.icon(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.cancel),
        label: const Text('No'),
      ),
      btnOk: ElevatedButton.icon(
        onPressed: onTap ?? () => Get.back(),
        icon: const Icon(Icons.done),
        label: const Text('Yes'),
      ),
    );
  }
}
