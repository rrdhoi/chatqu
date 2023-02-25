import 'package:chatqu/app/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideBarNavigation extends StatelessWidget {
  const SideBarNavigation({
    Key? key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
  }) : super(key: key);

  final List<SideBarItem> items;
  final int currentIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final item in items)
          navigatorTitle(item, items.indexOf(item) == currentIndex)
      ],
    );
  }

  Widget navigatorTitle(SideBarItem item, bool isSelected) {
    return GestureDetector(
      onTap: () => onTap?.call(items.indexOf(item)),
      child: Row(
        children: [
          (isSelected)
              ? Container(
                  width: 5,
                  height: 30,
                  margin: const EdgeInsets.only(right: 10),
                  color: AppColors.greenColor,
                )
              : Container(
                  width: 5,
                  height: 30,
                  margin: const EdgeInsets.only(right: 10),
                ),
          const SizedBox(
            width: 10,
            height: 55,
          ),
          Text(
            item.title,
            style: GoogleFonts.quicksand(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class SideBarItem {
  final Widget? activeIcon;
  final String title;
  final Color? selectedColor;
  final Color? unselectedColor;

  SideBarItem({
    required this.title,
    this.activeIcon,
    this.selectedColor,
    this.unselectedColor,
  });
}
