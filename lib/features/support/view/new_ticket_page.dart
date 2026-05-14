import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/app_text_field.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/support/viewmodel/support_cubit.dart';

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
    return BlocListener<SupportCubit, SupportState>(
      listener: (context, state) {
        if (state is TicketCreated) {
          context.showSnackBar('Ticket submitted successfully!');
          context.pop(true);
        }
        if (state is SupportError) {
          context.showSnackBar(state.message, isError: true);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          title: const Text('New Ticket'),
          backgroundColor: AppColors.surface,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c, style: AppTextStyles.body)))
                      .toList(),
                  onChanged: (v) => setState(() => _category = v!),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Priority', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _priority,
                  items: _priorities
                      .map((p) => DropdownMenuItem(value: p, child: Text(p, style: AppTextStyles.body)))
                      .toList(),
                  onChanged: (v) => setState(() => _priority = v!),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Subject',
                  controller: _subjectCtrl,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Subject is required' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Message',
                  controller: _messageCtrl,
                  maxLines: 5,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Message is required' : null,
                ),
                const SizedBox(height: 24),
                BlocBuilder<SupportCubit, SupportState>(
                  builder: (context, state) => AppButton(
                    label: 'Submit Ticket',
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
