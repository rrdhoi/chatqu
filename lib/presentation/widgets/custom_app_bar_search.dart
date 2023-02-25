import 'package:chatqu/app/app.dart';
import 'package:flutter/material.dart';

class CustomAppBarSearch extends StatelessWidget with PreferredSizeWidget {
  final String? hintSearchText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const CustomAppBarSearch({
    Key? key,
    required this.hintSearchText,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 95,
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 12),
        iconSize: 22,
        splashRadius: 24,
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.blackColor,
        ),
      ),
      title: Container(
        margin: const EdgeInsets.only(right: 24, top: 16, bottom: 16),
        child: TextField(
          autofocus: true,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
          cursorColor: AppColors.greenColor,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: hintSearchText,
            hintStyle: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.greyTextColor,
            ),
            contentPadding: const EdgeInsets.only(right: 8, left: 16),
            filled: true,
            fillColor: AppColors.backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 24,
              minWidth: 24,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(95);
}
