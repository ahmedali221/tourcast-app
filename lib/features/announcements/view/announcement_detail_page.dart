import 'package:flutter/material.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/announcements/model/announcement_model.dart';

class AnnouncementDetailPage extends StatelessWidget {
  final AnnouncementModel announcement;

  const AnnouncementDetailPage({super.key, required this.announcement});

  Color get _priorityColor {
    switch (announcement.priority.toUpperCase()) {
      case 'HIGH':
        return const Color(0xFFD4A017);
      case 'URGENT':
        return AppColors.error;
      case 'LOW':
        return AppColors.textSecondary;
      default:
        return AppColors.primary;
    }
  }

  Color get _priorityBg {
    switch (announcement.priority.toUpperCase()) {
      case 'HIGH':
        return const Color(0xFFFFF8E6);
      case 'URGENT':
        return AppColors.errorBg;
      case 'LOW':
        return AppColors.background;
      default:
        return AppColors.surfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Announcement', style: AppTextStyles.heading3),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Priority badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: _priorityBg,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _priorityColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                announcement.priority,
                style: AppTextStyles.caption.copyWith(
                  color: _priorityColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Title
            Text(announcement.title, style: AppTextStyles.heading2),
            const SizedBox(height: 12),

            // Date range
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(
                  '${announcement.startDate.toReadable()} – ${announcement.endDate.toReadable()}',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Optional image
            if (announcement.imageUrl != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  announcement.imageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, e, stack) => const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Divider
            const Divider(color: AppColors.divider, height: 1),
            const SizedBox(height: 20),

            // Content
            Text(
              announcement.content,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
