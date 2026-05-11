import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tourguide_app/core/storage/app_storage.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';

/// CircleAvatar that loads a protected storage URL with the Bearer token.
/// Falls back to initials when no URL is provided or the image fails.
class AuthAvatar extends StatelessWidget {
  final String? photoUrl;
  final String initials;
  final double radius;

  const AuthAvatar({
    super.key,
    this.photoUrl,
    required this.initials,
    this.radius = 45,
  });

  @override
  Widget build(BuildContext context) {
    if (photoUrl == null || photoUrl!.isEmpty) {
      return _Initials(initials: initials, radius: radius);
    }

    return FutureBuilder<String?>(
      future: AppStorage.getToken(),
      builder: (_, snapshot) {
        final token = snapshot.data;
        if (token == null) return _Initials(initials: initials, radius: radius);

        return CachedNetworkImage(
          imageUrl: photoUrl!,
          httpHeaders: {'Authorization': 'Bearer $token'},
          imageBuilder: (_, img) => CircleAvatar(radius: radius, backgroundImage: img),
          placeholder: (_, _) => _Initials(initials: initials, radius: radius),
          errorWidget: (_, _, _) => _Initials(initials: initials, radius: radius),
        );
      },
    );
  }
}

class _Initials extends StatelessWidget {
  final String initials;
  final double radius;
  const _Initials({required this.initials, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary,
      child: Text(
        initials.isNotEmpty ? initials[0].toUpperCase() : '?',
        style: AppTextStyles.heading1.copyWith(color: Colors.white),
      ),
    );
  }
}
