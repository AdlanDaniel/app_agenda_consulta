import 'package:app_agenda_consulta/core/ui/design/color.dart';
import 'package:app_agenda_consulta/core/ui/design/size.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(CustomColors.greenMedium),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: CustomSize.sizeL),
      ),
    );
  }
}
