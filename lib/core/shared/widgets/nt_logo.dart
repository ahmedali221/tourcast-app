import 'package:flutter/material.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';

class NtLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const NtLogo({super.key, this.size = 64, this.color});

  @override
  Widget build(BuildContext context) {
    final logoColor = color ?? AppColors.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(size * 0.22),
          child: Image.asset(
            'assets/images/app_icon.png',
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          'Nile Tech',
          style: TextStyle(
            color: logoColor,
            fontSize: size * 0.22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
