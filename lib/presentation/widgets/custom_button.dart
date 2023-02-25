import 'package:chatqu/app/configs/colors.dart';
import 'package:chatqu/app/configs/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function() onTap;

  const CustomButton({required this.child, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: AppColors.blackColor,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.defaultRadiusTextField),
        ),
      ),
      child: child,
    );
  }
}
