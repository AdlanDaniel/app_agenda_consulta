import 'package:flutter/material.dart';

import 'package:app_agenda_consulta/core/ui/design/color.dart';
import 'package:app_agenda_consulta/core/ui/design/size.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readonly;
  final TextAlign textAlign;

  final Widget? suffixIcon;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    this.controller,
    this.validator,
    this.readonly = false,
    this.textAlign = TextAlign.start,
    this.suffixIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign,
      readOnly: readonly,
      cursorColor: CustomColors.greyHeavy,
      controller: controller,
      validator: validator,
      style: const TextStyle(
          color: CustomColors.greyHeavy, fontSize: CustomSize.sizeXL),
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.only(
              bottom: CustomSize.sizeS, top: CustomSize.sizeXXS),
          label: Text(labelText),
          labelStyle: const TextStyle(
              color: CustomColors.greyHeavy, fontSize: CustomSize.sizeXL),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: CustomColors.greyMedium,
            width: CustomSize.sizeXXS,
          )),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.greyMedium,
              width: CustomSize.sizeXXS,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.red,
              width: CustomSize.sizeXXS,
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.red,
              width: CustomSize.sizeXXS,
            ),
          )),
    );
  }
}
