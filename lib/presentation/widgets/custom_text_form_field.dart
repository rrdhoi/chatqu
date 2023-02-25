import 'package:chatqu/app/configs/colors.dart';
import 'package:chatqu/app/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String errorText;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.errorText,
    this.obscureText = false,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _onError = false;
  late bool _onObscureText = widget.obscureText ? true : false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border.all(
          color: _onError ? AppColors.redColor : AppColors.backgroundColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppStyles.defaultRadiusTextField),
      ),
      child: TextFormField(
        obscureText: _onObscureText,
        controller: widget.controller,
        cursorColor: AppColors.greenColor,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppColors.greyTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: widget.obscureText
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _onObscureText = !_onObscureText;
                    });
                  },
                  child: Icon(
                    _onObscureText ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.greyColor,
                  ),
                )
              : null,
          border: InputBorder.none,
          errorMaxLines: 1,
          errorText: '',
          errorStyle: const TextStyle(color: Colors.transparent, height: 0),
        ),
        style: GoogleFonts.quicksand(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            setState(() {
              _onError = true;
            });
            return '';
          }
          setState(() {
            _onError = false;
          });
          return null;
        },
      ),
    );
  }
}
