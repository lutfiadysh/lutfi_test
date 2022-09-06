import 'package:flutter/material.dart';

void showFailedSnackbar(
  BuildContext context, {
  required String title,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    content: Row(
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
        ),
      ],
    ),
    backgroundColor: Colors.redAccent,
    behavior: SnackBarBehavior.floating,
  ));
}
