import 'package:chatqu/app/app.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final VoidCallback onBackButtonPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onBackButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      shadowColor: AppColors.backgroundColor,
      elevation: 1,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 12),
        splashRadius: 24,
        onPressed: onBackButtonPressed,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.blackColor,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.quicksand(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
