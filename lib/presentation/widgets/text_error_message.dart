import 'package:chatqu/app/app.dart';
import 'package:flutter/material.dart';

class TextErrorMessage extends StatelessWidget {
  final String errorMessage;
  const TextErrorMessage({required this.errorMessage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage,
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(
            fontSize: 16,
            height: 1.5,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          )),
    );
  }
}
