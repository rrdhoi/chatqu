import 'package:chatqu/app/app.dart';
import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  final String title;
  final String hintSearchText;
  final Function() onSearchTap;
  const SearchHeader(
      {required this.title,
      required this.hintSearchText,
      required this.onSearchTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: GoogleFonts.quicksand(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),
            Image.asset(AssetsPath.icCategory, width: 24, height: 24),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: onSearchTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hintSearchText,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greyTextColor,
                  ),
                ),
                Image.asset(AssetsPath.icSearch, width: 24, height: 24),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
