import 'package:flutter/material.dart';

import '../../app/app.dart';

class CardRowItem extends StatelessWidget {
  final String? image;
  final String title;
  final String? subTitle;
  final Widget? rightCornerWidget;
  final bool isBackgroundWhite;
  final bool isSelected;

  const CardRowItem(
      {required this.image,
      required this.title,
      required this.subTitle,
      this.rightCornerWidget,
      this.isBackgroundWhite = false,
      this.isSelected = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: 84,
            width: double.infinity,
            margin: isSelected ? null : const EdgeInsets.only(left: 30),
            decoration: isBackgroundWhite
                ? BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  )
                : isSelected
                    ? BoxDecoration(
                        color: AppColors.greenColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1.5,
                          color: AppColors.backgroundOutlineColor,
                        ),
                      ),
          ),
          AnimatedPadding(
            padding: isSelected
                ? const EdgeInsets.only(left: 14)
                : const EdgeInsets.only(left: 0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: image == null
                        ? Image.asset(AssetsPath.icProfile)
                        : FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 100),
                            fadeOutDuration: const Duration(milliseconds: 100),
                            placeholder: AssetsPath.icProfile,
                            image: image!,
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subTitle ?? '',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [rightCornerWidget ?? const SizedBox()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
