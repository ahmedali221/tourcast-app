import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/app_text_field.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/core/utils/validators.dart';
import 'package:tourguide_app/features/verification/viewmodel/verification_cubit.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<VerificationCubit>()..loadStatus(),
      child: const _VerificationView(),
    );
  }
}

class _VerificationView extends StatelessWidget {
  const _VerificationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(title: const Text('Identity Verification'), backgroundColor: AppColors.surface),
      body: BlocConsumer<VerificationCubit, VerificationState>(
        listener: (context, state) {
          if (state is VerificationSubmitted) {
            context.go(AppRoutes.verificationSuccess);
          }
          if (state is VerificationError) {
            context.showSnackBar(state.message, isError: true);
          }
        },
        builder: (context, state) {
          if (state is VerificationLoading || state is VerificationInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is VerificationError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<VerificationCubit>().loadStatus(),
            );
          }
          if (state is VerificationLoaded) {
            final v = state.verification;
            return _BodyView(status: v?.status);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _BodyView extends StatefulWidget {
  final String? status;
  const _BodyView({this.status});

  @override
  State<_BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<_BodyView> {
  final _formKey = GlobalKey<FormState>();
  final _passportCtrl = TextEditingController();
  final _nationalIdCtrl = TextEditingController();
  final _licenseCtrl = TextEditingController();

  File? _nationalIdFile;
  File? _licenseFile;

  @override
  void dispose() {
    _passportCtrl.dispose();
    _nationalIdCtrl.dispose();
    _licenseCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickNationalId() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) setState(() => _nationalIdFile = File(picked.path));
  }

  Future<void> _pickLicense() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) setState(() => _licenseFile = File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusBanner(status: widget.status),
            if (widget.status == 'VERIFIED') ...[
              const SizedBox(height: 16),
              _VerifiedCard(),
            ] else ...[
              const SizedBox(height: 20),
              Text('Document Details', style: AppTextStyles.label),
              const SizedBox(height: 12),
              AppTextField(
                label: 'Passport Number',
                controller: _passportCtrl,
                validator: (v) => Validators.required(v, fieldName: 'Passport number'),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'National ID Number',
                controller: _nationalIdCtrl,
                validator: (v) => Validators.required(v, fieldName: 'National ID'),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Guide License Number',
                controller: _licenseCtrl,
                validator: (v) => Validators.required(v, fieldName: 'License number'),
              ),
              const SizedBox(height: 28),
              Text('Upload Documents', style: AppTextStyles.label),
              const SizedBox(height: 4),
              Text(
                'Please upload clear, legible copies of your documents.',
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: 16),
              _DocumentUploadCard(
                title: 'National ID Photo',
                subtitle: 'Front side of your national ID card',
                acceptedFormats: 'JPEG or PNG • Max 2 MB',
                icon: Icons.badge_outlined,
                fileName: _nationalIdFile?.uri.pathSegments.last,
                onTap: _pickNationalId,
                onRemove: () => setState(() => _nationalIdFile = null),
              ),
              const SizedBox(height: 12),
              _DocumentUploadCard(
                title: 'Guide License',
                subtitle: 'Official tour guide license document',
                acceptedFormats: 'JPEG or PNG • Max 5 MB',
                icon: Icons.workspace_premium_outlined,
                fileName: _licenseFile?.uri.pathSegments.last,
                onTap: _pickLicense,
                onRemove: () => setState(() => _licenseFile = null),
              ),
              const SizedBox(height: 28),
              AppButton(
                label: 'Submit for Verification',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<VerificationCubit>().submitVerification(
                          passportNumber: _passportCtrl.text.trim(),
                          nationalId: _nationalIdCtrl.text.trim(),
                          guideLicenseNumber: _licenseCtrl.text.trim(),
                          nationalIdFile: _nationalIdFile,
                          licenseFile: _licenseFile,
                        );
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}

class _DocumentUploadCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String acceptedFormats;
  final IconData icon;
  final String? fileName;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _DocumentUploadCard({
    required this.title,
    required this.subtitle,
    required this.acceptedFormats,
    required this.icon,
    required this.fileName,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasFile ? AppColors.success : AppColors.border,
          width: hasFile ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: hasFile
                        ? AppColors.success.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    hasFile ? Icons.check_circle_outline : icon,
                    size: 22,
                    color: hasFile ? AppColors.success : AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.bodyMedium),
                      const SizedBox(height: 2),
                      Text(subtitle, style: AppTextStyles.caption),
                    ],
                  ),
                ),
                if (hasFile)
                  GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.errorBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.error),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Upload zone / selected file
          GestureDetector(
            onTap: hasFile ? null : onTap,
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: hasFile
                    ? AppColors.success.withValues(alpha: 0.06)
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: hasFile ? AppColors.success.withValues(alpha: 0.3) : AppColors.divider,
                  style: hasFile ? BorderStyle.solid : BorderStyle.solid,
                ),
              ),
              child: hasFile
                  ? Row(
                      children: [
                        const Icon(Icons.insert_drive_file_outlined, size: 20, color: AppColors.success),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            fileName!,
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.success),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          'Uploaded',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cloud_upload_outlined, size: 20, color: AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tap to upload',
                              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                            ),
                            Text(
                              acceptedFormats,
                              style: AppTextStyles.caption.copyWith(fontSize: 11),
                            ),
                          ],
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

class _StatusBanner extends StatelessWidget {
  final String? status;
  const _StatusBanner({this.status});

  @override
  Widget build(BuildContext context) {
    if (status == null) return const SizedBox();
    if (status == 'VERIFIED') return const SizedBox();

    final (bg, border, icon, text) = status == 'REJECTED'
        ? (
            AppColors.errorBg,
            AppColors.error,
            Icons.cancel_outlined,
            'Your documents were rejected. Please resubmit.',
          )
        : (
            AppColors.surfaceVariant,
            AppColors.primary,
            Icons.schedule_outlined,
            'Your documents are under review. We\'ll notify you.',
          );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        border: Border(left: BorderSide(color: border, width: 4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: border),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary))),
        ],
      ),
    );
  }
}

class _VerifiedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.successTint,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_outlined, size: 40, color: AppColors.success),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Identity Verified', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.success)),
                const SizedBox(height: 4),
                Text('Your identity has been successfully verified.', style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
