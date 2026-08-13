import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/localization/language_switcher.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/app_text_field.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/support/viewmodel/support_cubit.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

class NewTicketPage extends StatelessWidget {
  const NewTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SupportCubit>(),
      child: const _NewTicketView(),
    );
  }
}

class _NewTicketView extends StatefulWidget {
  const _NewTicketView();

  @override
  State<_NewTicketView> createState() => _NewTicketViewState();
}

class _NewTicketViewState extends State<_NewTicketView> {
  final _formKey = GlobalKey<FormState>();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  String _category = 'TECHNICAL';
  String _priority = 'NORMAL';

  static const _categories = ['TECHNICAL', 'PAYMENT'];
  static const _priorities = ['NORMAL', 'HIGH', 'URGENT'];

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String categoryLabel(String value) => switch (value) {
      'TECHNICAL' => l10n.newTicketCategoryTechnical,
      'PAYMENT' => l10n.newTicketCategoryPayment,
      _ => value,
    };
    String priorityLabel(String value) => switch (value) {
      'NORMAL' => l10n.newTicketPriorityNormal,
      'HIGH' => l10n.newTicketPriorityHigh,
      'URGENT' => l10n.newTicketPriorityUrgent,
      _ => value,
    };

    return BlocListener<SupportCubit, SupportState>(
      listener: (context, state) {
        if (state is TicketCreated) {
          context.showSnackBar(l10n.newTicketSubmitted);
          context.pop(true);
        }
        if (state is SupportError) {
          context.showSnackBar(
            state.message ?? l10n.commonSomethingWentWrong,
            isError: true,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: LanguageAppBar(
          title: Text(l10n.newTicketTitle),
          backgroundColor: AppColors.surface,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.newTicketCategoryLabel,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  items: _categories
                      .map(
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Text(
                            categoryLabel(c),
                            style: AppTextStyles.body,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _category = v!),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.newTicketPriorityLabel,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _priority,
                  items: _priorities
                      .map(
                        (p) => DropdownMenuItem(
                          value: p,
                          child: Text(
                            priorityLabel(p),
                            style: AppTextStyles.body,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _priority = v!),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: l10n.newTicketSubjectLabel,
                  controller: _subjectCtrl,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? l10n.newTicketSubjectRequired
                      : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: l10n.newTicketMessageLabel,
                  controller: _messageCtrl,
                  maxLines: 5,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? l10n.newTicketMessageRequired
                      : null,
                ),
                const SizedBox(height: 24),
                BlocBuilder<SupportCubit, SupportState>(
                  builder: (context, state) => AppButton(
                    label: l10n.newTicketSubmitButton,
                    isLoading: state is SupportLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SupportCubit>().createTicket(
                          category: _category,
                          priority: _priority,
                          subject: _subjectCtrl.text.trim(),
                          message: _messageCtrl.text.trim(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
