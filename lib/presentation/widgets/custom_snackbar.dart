import 'package:chatqu/app/app.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      BuildContext context, String text) {
    SnackBar snackBar = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(left: 24, bottom: 16, right: 24),
      content: Text(text,
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColor,
          )),
      backgroundColor: AppColors.blackColor,
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
