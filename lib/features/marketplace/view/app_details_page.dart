import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/features/verification/viewmodel/verification_cubit.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/marketplace/model/app_model.dart';
import 'package:tourguide_app/features/marketplace/repository/i_marketplace_repository.dart';
import 'package:tourguide_app/features/marketplace/viewmodel/marketplace_cubit.dart';
import 'package:video_player/video_player.dart';

class AppDetailsPage extends StatelessWidget {
  final String appId;
  final AppModel? app;

  const AppDetailsPage({super.key, required this.appId, this.app});

  @override
  Widget build(BuildContext context) {
    if (app != null) return _AppDetailsView(app: app!);

    return BlocProvider(
      create: (_) => locator<MarketplaceCubit>()..loadAppDetails(int.parse(appId)),
      child: BlocBuilder<MarketplaceCubit, MarketplaceState>(
        builder: (context, state) {
          if (state is MarketplaceLoading || state is MarketplaceInitial) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is MarketplaceDetailLoaded) {
            return _AppDetailsView(app: state.app);
          }
          if (state is MarketplaceError) {
            return Scaffold(
              appBar: AppBar(),
              body: ErrorView(
                message: state.message,
                onRetry: () => context.read<MarketplaceCubit>().loadAppDetails(int.parse(appId)),
              ),
            );
          }
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

class _AppDetailsView extends StatelessWidget {
  final AppModel app;
  const _AppDetailsView({required this.app});

  static const _cardColors = [
    Color(0xFF1A6B4A),
    Color(0xFF3B82F6),
    Color(0xFFD4A017),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
    Color(0xFF0EA5E9),
  ];

  @override
  Widget build(BuildContext context) {
    final bg = _cardColors[app.id % _cardColors.length];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Hero header ──
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: bg,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    right: -40, top: -40,
                    child: Container(
                      width: 180, height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30, bottom: -50,
                    child: Container(
                      width: 140, height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Icon + name
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 80, 24, 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _AppIcon(iconUrl: app.iconUrl, bg: bg, size: 72, fallbackLabel: app.name),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(app.name,
                                  style: AppTextStyles.heading2
                                      .copyWith(color: Colors.white)),
                              if (app.description.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(app.description,
                                    style: AppTextStyles.caption.copyWith(
                                        color: Colors.white.withValues(alpha: 0.85)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Body content ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Category badge (only if present)
                if (app.category != null)
                  Wrap(
                    children: [
                      _Badge(
                        icon: Icons.category_outlined,
                        label: app.category!,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),

                // About section
                if (app.fullDescription != null && app.fullDescription!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text('About', style: AppTextStyles.label),
                  const SizedBox(height: 8),
                  Text(app.fullDescription!, style: AppTextStyles.body),
                ],

                // Video preview
                if (app.videoUrl != null) ...[
                  const SizedBox(height: 24),
                  _VideoSection(url: app.videoUrl!),
                ],

                // Promo code section
                if (app.havePromoCode) ...[
                  const SizedBox(height: 28),
                  _PromoCodeSection(app: app),
                ],

                // Plans
                if (app.plans.isNotEmpty && app.plans.any((p) => p.price > 0)) ...[
                  const SizedBox(height: 28),
                  Text('Available Plans', style: AppTextStyles.label),
                  const SizedBox(height: 12),
                  ...app.plans.map((plan) => _PlanCard(plan: plan)),
                ],
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _DownloadBar(app: app),
    );
  }

}

// ── Download bar ─────────────────────────────────────────────────────────────

class _DownloadBar extends StatelessWidget {
  final AppModel app;
  const _DownloadBar({required this.app});

  Future<void> _launch(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        context.showSnackBar('Could not open store link');
      }
    } catch (_) {
      if (context.mounted) context.showSnackBar('Could not open store link');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasAndroid = app.androidUrl != null;
    final hasIos = app.iosUrl != null;
    if (!hasAndroid && !hasIos) return const SizedBox.shrink();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Row(
        children: [
          if (hasAndroid) ...[
            Expanded(
              child: _StoreButton(
                icon: Icons.android,
                label: 'Google Play',
                onTap: () => _launch(context, app.androidUrl!),
              ),
            ),
            if (hasIos) const SizedBox(width: 12),
          ],
          if (hasIos)
            Expanded(
              child: _StoreButton(
                icon: Icons.apple,
                label: 'App Store',
                onTap: () => _launch(context, app.iosUrl!),
              ),
            ),
        ],
      ),
    );
  }
}

class _StoreButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _StoreButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── App icon with network image + shimmer placeholder + letter fallback ───────

class _AppIcon extends StatelessWidget {
  final String? iconUrl;
  final Color bg;
  final double size;
  final String fallbackLabel;

  const _AppIcon({
    required this.iconUrl,
    required this.bg,
    required this.size,
    required this.fallbackLabel,
  });

  @override
  Widget build(BuildContext context) {
    final radius = size * 0.25;
    final letterWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(
        fallbackLabel.isNotEmpty ? fallbackLabel[0].toUpperCase() : '?',
        style: AppTextStyles.heading1.copyWith(color: Colors.white, fontSize: size * 0.44),
      ),
    );

    if (iconUrl == null) return letterWidget;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: iconUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (_, _) => Shimmer.fromColors(
          baseColor: AppColors.shimmerBase,
          highlightColor: AppColors.shimmerHighlight,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        errorWidget: (_, _, _) => letterWidget,
      ),
    );
  }
}

// ── Inline video player ───────────────────────────────────────────────────────

class _VideoSection extends StatefulWidget {
  final String url;
  const _VideoSection({required this.url});

  @override
  State<_VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<_VideoSection> {
  late VideoPlayerController _ctrl;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ctrl = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        if (mounted) setState(() => _initialized = true);
      });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preview', style: AppTextStyles.label),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _initialized
              ? AspectRatio(
                  aspectRatio: _ctrl.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_ctrl),
                      GestureDetector(
                        onTap: () {
                          if (_ctrl.value.isPlaying) {
                            _ctrl.pause().then((_) { if (mounted) setState(() {}); });
                          } else {
                            _ctrl.play().then((_) { if (mounted) setState(() {}); });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            _ctrl.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: AppColors.surfaceVariant,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
        ),
      ],
    );
  }
}

// ── Small reusable badge ──────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _Badge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.bodyMedium.copyWith(color: color)),
        ],
      ),
    );
  }
}

// ── Promo code section ────────────────────────────────────────────────────────

class _PromoCodeSection extends StatefulWidget {
  final AppModel app;
  const _PromoCodeSection({required this.app});

  @override
  State<_PromoCodeSection> createState() => _PromoCodeSectionState();
}

class _PromoCodeSectionState extends State<_PromoCodeSection> {
  List<PromoCodeModel> _codes = [];
  bool _loadingCodes = true;
  bool _generating = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCodes();
  }

  Future<void> _loadCodes() async {
    setState(() { _loadingCodes = true; _error = null; });
    try {
      final repo = locator<IMarketplaceRepository>();
      final codes = await repo.getPromoCodes(appId: widget.app.id);
      if (mounted) setState(() => _codes = codes);
    } catch (_) {
      if (mounted) setState(() => _error = 'Failed to load promo codes.');
    } finally {
      if (mounted) setState(() => _loadingCodes = false);
    }
  }

  Future<void> _generate() async {
    final result = await showModalBottomSheet<({String? name})>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PromoCodeFormSheet(),
    );
    if (result == null || !mounted) return;

    setState(() { _generating = true; _error = null; });
    try {
      final repo = locator<IMarketplaceRepository>();
      final name = result.name;
      final newCode = await repo.generatePromoCode(
        appId: widget.app.id,
        code: (name != null && name.isNotEmpty) ? name : null,
      );
      if (mounted) setState(() => _codes = [newCode, ..._codes]);
    } catch (e) {
      if (mounted) setState(() => _error = 'Failed to generate promo code. Please try again.');
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  void _openRedemptions(PromoCodeModel code) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RedemptionsSheet(code: code),
    );
  }

  void _copy(String code) {
    Clipboard.setData(ClipboardData(text: code));
    context.showSnackBar('Copied!');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.local_offer, color: AppColors.badgePending, size: 18),
            const SizedBox(width: 8),
            Text('My Promo Codes',
                style: AppTextStyles.label.copyWith(color: AppColors.badgePending)),
            const Spacer(),
            if (!_loadingCodes)
              BlocBuilder<VerificationCubit, VerificationState>(
                builder: (context, verState) {
                  final canGenerate = verState is VerificationLoaded &&
                      verState.verification != null &&
                      verState.verification!.status.toUpperCase() == 'VERIFIED';
                  return GestureDetector(
                    onTap: _generating
                        ? null
                        : canGenerate
                            ? _generate
                            : () => context.showSnackBar(
                                  'Promo codes are available once your account is verified.',
                                  isError: true,
                                ),
                    child: Opacity(
                      opacity: canGenerate ? 1.0 : 0.5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _generating
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : Text('+ Generate',
                                style: AppTextStyles.caption.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: 12),

        if (_error != null) ...[
          Text(_error!,
              style: AppTextStyles.caption.copyWith(color: AppColors.error)),
          const SizedBox(height: 8),
        ],

        if (_loadingCodes)
          const Center(child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CircularProgressIndicator(),
          ))
        else if (_codes.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                Icon(Icons.local_offer_outlined,
                    size: 36, color: AppColors.textSecondary.withValues(alpha: 0.4)),
                const SizedBox(height: 8),
                Text('No promo codes yet',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text('Tap "+ Generate" to create your first code.',
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: List.generate(_codes.length, (i) {
                final c = _codes[i];
                return GestureDetector(
                  onTap: () => _openRedemptions(c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: i < _codes.length - 1
                          ? const Border(bottom: BorderSide(color: AppColors.divider))
                          : null,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.code,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                      letterSpacing: 2,
                                      color: AppColors.badgePending,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(height: 2),
                              Text(
                                '${c.discountLabel}  ·  ${c.usedCount} use${c.usedCount == 1 ? '' : 's'}',
                                style: AppTextStyles.caption
                                    .copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy_rounded,
                              size: 18, color: AppColors.textSecondary),
                          onPressed: () => _copy(c.code),
                          tooltip: 'Copy',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right,
                            size: 18, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}

// ── Redemptions sheet ─────────────────────────────────────────────────────────

class _RedemptionsSheet extends StatefulWidget {
  final PromoCodeModel code;
  const _RedemptionsSheet({required this.code});

  @override
  State<_RedemptionsSheet> createState() => _RedemptionsSheetState();
}

class _RedemptionsSheetState extends State<_RedemptionsSheet> {
  List<RedemptionModel> _redemptions = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final repo = locator<IMarketplaceRepository>();
      final data = await repo.getRedemptions(codeId: widget.code.id);
      if (mounted) setState(() => _redemptions = data);
    } catch (_) {
      if (mounted) setState(() => _error = 'Failed to load redemptions.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: AppColors.border, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.code.code,
                          style: AppTextStyles.heading3.copyWith(
                              color: AppColors.badgePending, letterSpacing: 2)),
                      Text(
                        '${widget.code.discountLabel}  ·  ${widget.code.usedCount} redemption${widget.code.usedCount == 1 ? '' : 's'}',
                        style: AppTextStyles.caption
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.divider),
          if (_loading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: CircularProgressIndicator(),
            )
          else if (_error != null)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(_error!,
                  style: AppTextStyles.caption.copyWith(color: AppColors.error)),
            )
          else if (_redemptions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(Icons.people_outline,
                      size: 36,
                      color: AppColors.textSecondary.withValues(alpha: 0.4)),
                  const SizedBox(height: 8),
                  Text('No redemptions yet',
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textSecondary)),
                ],
              ),
            )
          else
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                shrinkWrap: true,
                itemCount: _redemptions.length,
                separatorBuilder: (_, _) =>
                    const Divider(height: 1, color: AppColors.divider),
                itemBuilder: (_, i) {
                  final r = _redemptions[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 38, height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person_outline,
                              size: 18, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(r.userName, style: AppTextStyles.bodyMedium),
                              if (r.project != null)
                                Text(r.project!,
                                    style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              r.commissionBase.toStringAsFixed(2),
                              style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(r.redeemedAt.toReadable(),
                                style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Promo code form sheet ─────────────────────────────────────────────────────

class _PromoCodeFormSheet extends StatefulWidget {
  const _PromoCodeFormSheet();

  @override
  State<_PromoCodeFormSheet> createState() => _PromoCodeFormSheetState();
}

class _PromoCodeFormSheetState extends State<_PromoCodeFormSheet> {
  final _nameCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
          24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Create Promo Code', style: AppTextStyles.heading3),
          const SizedBox(height: 4),
          Text(
            'Enter a custom name for your promo code, or leave it empty to auto-generate one.',
            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          Text('Promo Code Name (optional)',
              style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          TextFormField(
            controller: _nameCtrl,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              hintText: 'e.g. AHMED20 — leave empty to auto-generate',
            ),
          ),
          const SizedBox(height: 24),
          AppButton(
            label: 'Generate',
            onPressed: () => Navigator.pop(context, (name: _nameCtrl.text.trim())),
          ),
        ],
      ),
    );
  }
}

// ── Plan card ─────────────────────────────────────────────────────────────────

class _PlanCard extends StatelessWidget {
  final PlanModel plan;
  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plan.name, style: AppTextStyles.bodyMedium),
                if (plan.planType.isNotEmpty)
                  Text(
                    plan.planType,
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                  ),
              ],
            ),
          ),
          Text(
            plan.price == 0 ? 'Free' : '\$${plan.price.toStringAsFixed(0)}',
            style: AppTextStyles.bodyMedium.copyWith(
              color: plan.price == 0 ? AppColors.success : AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
