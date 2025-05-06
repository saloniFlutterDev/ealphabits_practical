import 'package:ealphabits_practical/utils/base_color_constants.dart';
import 'package:flutter/material.dart';

class BaseCommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final bool readOnly;
  final int maxLines;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final int? errorMessage;
  final int? errorMaxLines;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? initialValue;
  final Widget? suffixIcon;
  final bool obscureText;
  final String obscuringCharacter;

  const BaseCommonTextField({super.key,
    required this.controller,
    required this.hint,
    this.validator,
    this.readOnly = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    required this.textCapitalization,
    this.maxLength,
    this.errorMessage,
    this.errorMaxLines,
    this.onChanged,
    this.onFieldSubmitted, this.initialValue, this.suffixIcon,  this.obscureText=false,
    this.obscuringCharacter='*',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      focusNode: focusNode,
      maxLength: maxLength,
      initialValue: initialValue,
      maxLines: maxLines,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      decoration: InputDecoration(
      hintStyle: TextStyle(
        fontFamily: "OpenSans",
        // fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2,
        color: BaseColorConstants.black,
      ),
      labelStyle: TextStyle(
        fontFamily: "OpenSans",
        // fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2,
        color: BaseColorConstants.black,
      ),
      isDense: true,
      errorMaxLines:errorMaxLines ,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 14.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: BaseColorConstants.primary, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: BaseColorConstants.divider, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
        suffixIcon: suffixIcon,),
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
