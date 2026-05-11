import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/support/model/ticket_model.dart';
import 'package:tourguide_app/features/support/viewmodel/support_cubit.dart';

class TicketDetailPage extends StatelessWidget {
  final String ticketId;
  const TicketDetailPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SupportCubit>()..loadTicket(int.parse(ticketId)),
      child: _TicketDetailView(ticketId: int.parse(ticketId)),
    );
  }
}

class _TicketDetailView extends StatefulWidget {
  final int ticketId;
  const _TicketDetailView({required this.ticketId});

  @override
  State<_TicketDetailView> createState() => _TicketDetailViewState();
}

class _TicketDetailViewState extends State<_TicketDetailView> {
  final _replyCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _replyCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupportCubit, SupportState>(
      listener: (context, state) {
        if (state is TicketDetailLoaded) _scrollToBottom();
        if (state is SupportError) {
          context.showSnackBar(state.message, isError: true);
        }
      },
      builder: (context, state) {
        if (state is SupportLoading || state is SupportInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is SupportError) {
          return Scaffold(
            appBar: AppBar(),
            body: ErrorView(
              message: state.message,
              onRetry: () => context.read<SupportCubit>().loadTicket(widget.ticketId),
            ),
          );
        }
        if (state is TicketDetailLoaded) {
          return _TicketChat(
            ticket: state.ticket,
            replyCtrl: _replyCtrl,
            scrollCtrl: _scrollCtrl,
            onSend: () {
              final msg = _replyCtrl.text.trim();
              if (msg.isNotEmpty) {
                _replyCtrl.clear();
                context.read<SupportCubit>().replyToTicket(widget.ticketId, msg);
              }
            },
          );
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class _TicketChat extends StatelessWidget {
  final TicketModel ticket;
  final TextEditingController replyCtrl;
  final ScrollController scrollCtrl;
  final VoidCallback onSend;

  const _TicketChat({required this.ticket, required this.replyCtrl, required this.scrollCtrl, required this.onSend});

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

  @override
  Widget build(BuildContext context) {
    final isClosed = ticket.status.toLowerCase() == 'closed';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('#${ticket.id} — ${ticket.subject}', overflow: TextOverflow.ellipsis),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              ticket.status.toUpperCase(),
              style: AppTextStyles.caption.copyWith(
                color: _statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ticket.replies.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline_rounded, size: 48, color: AppColors.textHint),
                        const SizedBox(height: 12),
                        Text('No replies yet.', style: AppTextStyles.body),
                        const SizedBox(height: 4),
                        Text('Our team will respond shortly.', style: AppTextStyles.caption),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: scrollCtrl,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    itemCount: ticket.replies.length,
                    itemBuilder: (_, i) => _MessageBubble(reply: ticket.replies[i]),
                  ),
          ),
          if (!isClosed)
            Container(
              padding: EdgeInsets.only(
                left: 16,
                right: 8,
                top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: replyCtrl,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Type a reply...',
                        filled: true,
                        fillColor: AppColors.surfaceVariant,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      style: AppTextStyles.body,
                    ),
                  ),
                  const SizedBox(width: 8),
                  BlocBuilder<SupportCubit, SupportState>(
                    builder: (context, state) => IconButton(
                      onPressed: state is SupportLoading ? null : onSend,
                      icon: state is SupportLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send_rounded),
                      color: AppColors.primary,
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.surfaceVariant,
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 6),
                  Text('This ticket is closed.', style: AppTextStyles.caption),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final TicketReplyModel reply;
  const _MessageBubble({required this.reply});

  @override
  Widget build(BuildContext context) {
    final isSupport = reply.isFromSupport;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isSupport ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isSupport) ...[
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.support_agent, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 8),
          ],
          if (!isSupport && reply.isFailed) ...[
            const Icon(Icons.error_outline, size: 18, color: AppColors.error),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSupport ? AppColors.surface : AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isSupport ? 4 : 16),
                  bottomRight: Radius.circular(isSupport ? 16 : 4),
                ),
                border: isSupport ? Border.all(color: AppColors.divider) : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reply.message,
                    style: AppTextStyles.body.copyWith(
                      color: isSupport ? AppColors.textPrimary : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reply.createdAt.toReadableWithTime(),
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      color: isSupport ? AppColors.textHint : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isSupport) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
