import 'package:flutter/material.dart';

void showSnackBar({
  required String message,
  required BuildContext context,
  Color? color,
  IconData? icon,
}) {
  IconData resolvedIcon =
      icon ??
      ((color != null && color.value == Colors.red)
          ? Icons.cancel
          : (color != null && color.value == Colors.blue)
          ? Icons.info
          : Icons.check_circle);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(resolvedIcon, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              overflow: TextOverflow.visible,
              // style: GoogleFonts.poppins(color: AppColors.white),
            ),
          ),
        ],
      ),
      backgroundColor: color ?? Colors.green,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
