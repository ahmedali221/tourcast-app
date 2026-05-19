import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
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
      body: CustomScrollView(
        slivers: [
          _HeroSliver(announcement: announcement),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Priority badge + date row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                      const SizedBox(width: 10),
                      const Icon(Icons.calendar_today_outlined,
                          size: 13, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${announcement.startDate.toReadable()} – ${announcement.endDate.toReadable()}',
                          style: AppTextStyles.caption
                              .copyWith(color: AppColors.textSecondary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Title
                  Text(announcement.title, style: AppTextStyles.heading2),
                  const SizedBox(height: 20),

                  // Video player (only when videoUrl is present)
                  if (announcement.videoUrl != null) ...[
                    _VideoSection(url: announcement.videoUrl!),
                    const SizedBox(height: 20),
                  ],

                  // Divider
                  const Divider(color: AppColors.divider, height: 1),
                  const SizedBox(height: 20),

                  // Article body
                  Text(
                    announcement.content,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero sliver with image or fallback banner ──────────────────────────────

class _HeroSliver extends StatelessWidget {
  final AnnouncementModel announcement;

  const _HeroSliver({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: announcement.imageUrl != null ? 260 : 160,
      pinned: true,
      backgroundColor: AppColors.surface,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: _BackButton(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: announcement.imageUrl != null
            ? _NetworkHero(url: announcement.imageUrl!)
            : _FallbackHero(),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/home');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_back_ios_new_rounded,
            size: 18, color: Colors.white),
      ),
    );
  }
}

class _NetworkHero extends StatelessWidget {
  final String url;

  const _NetworkHero({required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, e) => _FallbackHero(),
    );
  }
}

class _FallbackHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceVariant,
      alignment: Alignment.center,
      child: const Icon(Icons.campaign_outlined,
          size: 52, color: AppColors.primary),
    );
  }
}

// ── Video player section ───────────────────────────────────────────────────

class _VideoSection extends StatefulWidget {
  final String url;

  const _VideoSection({required this.url});

  @override
  State<_VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<_VideoSection> {
  late final VideoPlayerController _controller;
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        if (mounted) setState(() => _initialized = true);
      }).catchError((_) {
        if (mounted) setState(() => _error = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: _initialized ? _controller.value.aspectRatio : 16 / 9,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _initialized
                ? VideoPlayer(_controller)
                : Container(color: AppColors.surfaceVariant),
            if (!_initialized && !_error)
              const CircularProgressIndicator(
                  color: AppColors.primary, strokeWidth: 2.5),
            if (_initialized)
              GestureDetector(
                onTap: () => setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                }),
                child: AnimatedOpacity(
                  opacity: _controller.value.isPlaying ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(14),
                    child: const Icon(Icons.play_arrow_rounded,
                        color: Colors.white, size: 32),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
