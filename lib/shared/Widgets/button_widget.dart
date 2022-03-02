import 'package:flutter/material.dart';

import '../themes/colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color primary;
  final String text;
  const ElevatedButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.primary,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: primary, shadowColor: AppColors.secondary, elevation: 5),
      onPressed: onPressed,
      child: Text(text,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
