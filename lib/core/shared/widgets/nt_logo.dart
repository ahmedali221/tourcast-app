import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';

const _kSvg = '''
<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <g transform="translate(0,100) scale(0.1,-0.1)">
    <path d="M450 847 l0 -97 -150 0 -150 0 0 -248 0 -247 100 -100 100 -100 0 248 0 247 150 0 150 0 0 -148 0 -148 98 -98 97 -98 3 243 2 244 -200 200 -200 200 0 -98z"/>
  </g>
</svg>
''';

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
        SvgPicture.string(
          _kSvg,
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(logoColor, BlendMode.srcIn),
        ),
        Text(
          'Nile Tech',
          style: TextStyle(
            color: logoColor,
            fontSize: size * 0.22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
