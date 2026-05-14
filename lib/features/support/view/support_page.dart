import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/logout_button.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/support/model/ticket_model.dart';
import 'package:tourguide_app/features/support/viewmodel/support_cubit.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SupportCubit>()..loadTickets(),
      child: const _SupportView(),
    );
  }
}

class _SupportView extends StatefulWidget {
  const _SupportView();

  @override
  State<_SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<_SupportView> {
  String? _statusFilter;
  Timer? _pollTimer;

  static const _filters = [
    (label: 'All', value: null),
    (label: 'Open', value: 'OPEN'),
    (label: 'Pending', value: 'PENDING'),
    (label: 'Closed', value: 'CLOSED'),
  ];

  void _syncTimer(List<TicketModel> tickets) {
    final hasOpen = tickets.any((t) => t.status.toUpperCase() == 'OPEN');
    if (hasOpen && _pollTimer == null) {
      _pollTimer = Timer.periodic(const Duration(minutes: 2), (_) {
        if (mounted) context.read<SupportCubit>().loadTickets();
      });
    } else if (!hasOpen && _pollTimer != null) {
      _pollTimer!.cancel();
      _pollTimer = null;
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  List<TicketModel> _applyFilter(List<TicketModel> tickets) {
    if (_statusFilter == null) return tickets;
    return tickets.where((t) => t.status.toUpperCase() == _statusFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Support Tickets'), actions: [const LogoutButton()]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await context.push<bool>(AppRoutes.newTicket);
          if (created == true && context.mounted) {
            context.read<SupportCubit>().loadTickets();
          }
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _filters.length,
              itemBuilder: (_, i) {
                final filter = _filters[i];
                final selected = _statusFilter == filter.value;
                return GestureDetector(
                  onTap: () => setState(() => _statusFilter = filter.value),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: selected ? AppColors.primary : AppColors.divider),
                    ),
                    child: Text(
                      filter.label,
                      style: AppTextStyles.caption.copyWith(
                        color: selected ? Colors.white : AppColors.textSecondary,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SupportCubit, SupportState>(
              builder: (context, state) {
                if (state is SupportLoading || state is SupportInitial) {
                  return _ShimmerView();
                }
                if (state is SupportError) {
                  return ErrorView(
                    message: state.message,
                    onRetry: () => context.read<SupportCubit>().loadTickets(),
                  );
                }
                if (state is TicketsLoaded) {
                  _syncTimer(state.tickets);
                  return _TicketsList(tickets: _applyFilter(state.tickets));
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

class _TicketsList extends StatelessWidget {
  final List<TicketModel> tickets;
  const _TicketsList({required this.tickets});

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return const EmptyState(
        icon: Icons.support_agent_rounded,
        title: 'No tickets yet',
        message: 'Tap + to open a new support ticket.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
      itemCount: tickets.length,
      itemBuilder: (context, i) => _TicketCard(ticket: tickets[i]),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final TicketModel ticket;
  const _TicketCard({required this.ticket});

  Color get _statusColor {
    switch (ticket.status.toLowerCase()) {
      case 'open':
        return AppColors.primary;
      case 'pending':
        return const Color(0xFFD4A017);
      case 'closed':
        return AppColors.textSecondary;
      default:
        return AppColors.textSecondary;
    }
  }

  Color get _statusBg {
    switch (ticket.status.toLowerCase()) {
      case 'open':
        return AppColors.surfaceVariant;
      case 'pending':
        return const Color(0xFFFFF8E6);
      case 'closed':
        return AppColors.background;
      default:
        return AppColors.background;
    }
  }

  Color get _priorityColor {
    switch (ticket.priority.toUpperCase()) {
      case 'URGENT':
        return AppColors.error;
      case 'HIGH':
        return const Color(0xFFD4A017);
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = ticket.hasUnread;

    return GestureDetector(
      onTap: () async {
        await context.push('/support/${ticket.id}');
        if (context.mounted) context.read<SupportCubit>().loadTickets();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasUnread ? AppColors.primary.withValues(alpha: 0.35) : AppColors.divider,
            width: hasUnread ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject + Status badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    ticket.subject,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusBg,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _statusColor.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    ticket.status.toUpperCase(),
                    style: AppTextStyles.caption.copyWith(
                      color: _statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Last unread message preview + unread badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    ticket.lastMessage ?? '',
                    style: AppTextStyles.caption.copyWith(
                      color: hasUnread ? AppColors.textPrimary : AppColors.textSecondary,
                      fontWeight: hasUnread ? FontWeight.w500 : FontWeight.w400,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (hasUnread) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            // Category + Priority chips + Date
            Row(
              children: [
                _Chip(label: ticket.category, color: AppColors.primary),
                const SizedBox(width: 6),
                _Chip(label: ticket.priority, color: _priorityColor),
                const Spacer(),
                Text(ticket.createdAt.toReadable(), style: AppTextStyles.caption.copyWith(fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 10,
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
              height: 90,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ),
    );
  }
}
