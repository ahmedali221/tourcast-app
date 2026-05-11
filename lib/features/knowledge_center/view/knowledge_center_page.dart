import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/knowledge_center/model/article_model.dart';
import 'package:tourguide_app/features/knowledge_center/viewmodel/knowledge_center_cubit.dart';

class KnowledgeCenterPage extends StatelessWidget {
  const KnowledgeCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<KnowledgeCenterCubit>()..loadArticles(),
      child: const _KnowledgeCenterView(),
    );
  }
}

class _KnowledgeCenterView extends StatefulWidget {
  const _KnowledgeCenterView();

  @override
  State<_KnowledgeCenterView> createState() => _KnowledgeCenterViewState();
}

class _KnowledgeCenterViewState extends State<_KnowledgeCenterView> {
  String? _selectedCategory;

  static const _categories = ['Getting Started', 'Payments', 'Apps & Tools', 'Account'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Knowledge Center')),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                _FilterChip(
                  label: 'All',
                  selected: _selectedCategory == null,
                  onTap: () {
                    setState(() => _selectedCategory = null);
                    context.read<KnowledgeCenterCubit>().loadArticles();
                  },
                ),
                ..._categories.map(
                  (c) => _FilterChip(
                    label: c,
                    selected: _selectedCategory == c,
                    onTap: () {
                      setState(() => _selectedCategory = c);
                      context.read<KnowledgeCenterCubit>().loadArticles(category: c);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<KnowledgeCenterCubit, KnowledgeCenterState>(
              builder: (context, state) {
                if (state is KnowledgeCenterLoading || state is KnowledgeCenterInitial) {
                  return _ShimmerView();
                }
                if (state is KnowledgeCenterError) {
                  return ErrorView(
                    message: state.message,
                    onRetry: () => context.read<KnowledgeCenterCubit>().loadArticles(category: _selectedCategory),
                  );
                }
                if (state is KnowledgeCenterLoaded) {
                  return _ArticleList(articles: state.articles);
                }
                return _ShimmerView();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.primary : AppColors.divider),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: selected ? Colors.white : AppColors.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _ArticleList extends StatelessWidget {
  final List<ArticleModel> articles;
  const _ArticleList({required this.articles});

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const EmptyState(
        icon: Icons.article_outlined,
        title: 'No articles yet',
        message: 'Check back later for new content.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
      itemCount: articles.length,
      itemBuilder: (_, i) => _ArticleCard(article: articles[i]),
    );
  }
}

class _ArticleCard extends StatefulWidget {
  final ArticleModel article;
  const _ArticleCard({required this.article});

  @override
  State<_ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<_ArticleCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.article_rounded, size: 18, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.article.title,
                          style: AppTextStyles.bodyMedium,
                          maxLines: _expanded ? null : 2,
                          overflow: _expanded ? null : TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (widget.article.category != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceVariant,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  widget.article.category!,
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 10,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            if (widget.article.category != null) const SizedBox(width: 6),
                            Text(
                              widget.article.publishedAt.toReadable(),
                              style: AppTextStyles.caption.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ],
              ),
            ),
            if (_expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: [
                    const Divider(color: AppColors.divider, height: 1),
                    const SizedBox(height: 12),
                    Text(widget.article.content, style: AppTextStyles.body),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
        child: Column(
          children: List.generate(
            5,
            (_) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 80,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ),
    );
  }
}
