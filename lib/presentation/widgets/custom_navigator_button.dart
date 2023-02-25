import 'package:chatqu/app/app.dart';
import 'package:flutter/material.dart';

class CustomNavigatorButton extends StatelessWidget {
  final Function() onTap;
  final Widget icon;

  const CustomNavigatorButton({
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.backgroundOutlineColor,
            width: 1.5,
          ),
        ),
        child: icon,
      ),
    );
  }
}
