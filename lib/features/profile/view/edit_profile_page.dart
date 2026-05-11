import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/auth_avatar.dart';
import 'package:tourguide_app/core/shared/widgets/app_text_field.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/core/utils/validators.dart';
import 'package:tourguide_app/features/profile/viewmodel/profile_cubit.dart';

// ─── Static data ────────────────────────────────────────────────────────────

const _countryList = <(String, String)>[
  ('Afghanistan', '🇦🇫'), ('Albania', '🇦🇱'), ('Algeria', '🇩🇿'),
  ('Argentina', '🇦🇷'), ('Armenia', '🇦🇲'), ('Australia', '🇦🇺'),
  ('Austria', '🇦🇹'), ('Azerbaijan', '🇦🇿'), ('Bahrain', '🇧🇭'),
  ('Bangladesh', '🇧🇩'), ('Belgium', '🇧🇪'), ('Bolivia', '🇧🇴'),
  ('Bosnia and Herzegovina', '🇧🇦'), ('Brazil', '🇧🇷'), ('Bulgaria', '🇧🇬'),
  ('Canada', '🇨🇦'), ('Chile', '🇨🇱'), ('China', '🇨🇳'),
  ('Colombia', '🇨🇴'), ('Croatia', '🇭🇷'), ('Czech Republic', '🇨🇿'),
  ('Denmark', '🇩🇰'), ('Ecuador', '🇪🇨'), ('Egypt', '🇪🇬'),
  ('Ethiopia', '🇪🇹'), ('Finland', '🇫🇮'), ('France', '🇫🇷'),
  ('Georgia', '🇬🇪'), ('Germany', '🇩🇪'), ('Ghana', '🇬🇭'),
  ('Greece', '🇬🇷'), ('Guatemala', '🇬🇹'), ('Hungary', '🇭🇺'),
  ('India', '🇮🇳'), ('Indonesia', '🇮🇩'), ('Iran', '🇮🇷'),
  ('Iraq', '🇮🇶'), ('Ireland', '🇮🇪'), ('Israel', '🇮🇱'),
  ('Italy', '🇮🇹'), ('Japan', '🇯🇵'), ('Jordan', '🇯🇴'),
  ('Kazakhstan', '🇰🇿'), ('Kenya', '🇰🇪'), ('Kuwait', '🇰🇼'),
  ('Lebanon', '🇱🇧'), ('Libya', '🇱🇾'), ('Malaysia', '🇲🇾'),
  ('Mexico', '🇲🇽'), ('Morocco', '🇲🇦'), ('Netherlands', '🇳🇱'),
  ('New Zealand', '🇳🇿'), ('Nigeria', '🇳🇬'), ('Norway', '🇳🇴'),
  ('Oman', '🇴🇲'), ('Pakistan', '🇵🇰'), ('Palestine', '🇵🇸'),
  ('Peru', '🇵🇪'), ('Philippines', '🇵🇭'), ('Poland', '🇵🇱'),
  ('Portugal', '🇵🇹'), ('Qatar', '🇶🇦'), ('Romania', '🇷🇴'),
  ('Russia', '🇷🇺'), ('Saudi Arabia', '🇸🇦'), ('Senegal', '🇸🇳'),
  ('Serbia', '🇷🇸'), ('Singapore', '🇸🇬'), ('Somalia', '🇸🇴'),
  ('South Africa', '🇿🇦'), ('South Korea', '🇰🇷'), ('Spain', '🇪🇸'),
  ('Sri Lanka', '🇱🇰'), ('Sudan', '🇸🇩'), ('Sweden', '🇸🇪'),
  ('Switzerland', '🇨🇭'), ('Syria', '🇸🇾'), ('Taiwan', '🇹🇼'),
  ('Tanzania', '🇹🇿'), ('Thailand', '🇹🇭'), ('Tunisia', '🇹🇳'),
  ('Turkey', '🇹🇷'), ('Uganda', '🇺🇬'), ('Ukraine', '🇺🇦'),
  ('United Arab Emirates', '🇦🇪'), ('United Kingdom', '🇬🇧'),
  ('United States', '🇺🇸'), ('Uzbekistan', '🇺🇿'), ('Venezuela', '🇻🇪'),
  ('Vietnam', '🇻🇳'), ('Yemen', '🇾🇪'), ('Zimbabwe', '🇿🇼'),
];

const _languageList = [
  'Arabic', 'Bengali', 'Chinese (Cantonese)', 'Chinese (Mandarin)',
  'Czech', 'Danish', 'Dutch', 'English', 'Finnish', 'French',
  'German', 'Greek', 'Hebrew', 'Hindi', 'Hungarian', 'Indonesian',
  'Italian', 'Japanese', 'Korean', 'Malay', 'Norwegian', 'Persian',
  'Polish', 'Portuguese', 'Romanian', 'Russian', 'Spanish', 'Swahili',
  'Swedish', 'Tamil', 'Thai', 'Turkish', 'Ukrainian', 'Urdu', 'Vietnamese',
];

const _specializationList = [
  'Adventure Tourism', 'Archaeological Tours', 'Budget Tours',
  'City Tours', 'Corporate Tours', 'Cruise Excursions', 'Cultural Tours',
  'Desert Safari', 'Eco-Tourism', 'Family Tourism', 'Food & Cuisine Tours',
  'Historical Tours', 'Luxury Tours', 'Museum Guided Tours',
  'Nature & Wildlife', 'Nightlife Tours', 'Photography Tours',
  'Religious Tourism', 'River Cruises', 'Solo Travel Support',
];

// ─── Page ───────────────────────────────────────────────────────────────────

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ProfileCubit>()..loadProfile(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();
  final _experienceCtrl = TextEditingController();

  String? _selectedCountry;
  List<String> _languages = [];
  List<String> _specializations = [];
  File? _photo;
  String? _serverPhotoUrl;
  bool _initialized = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cityCtrl.dispose();
    _bioCtrl.dispose();
    _experienceCtrl.dispose();
    super.dispose();
  }

  void _initFromState(ProfileLoaded state) {
    if (_initialized) return;
    _initialized = true;
    final p = state.profile;
    _nameCtrl.text = p.fullName;
    _cityCtrl.text = p.city ?? '';
    _bioCtrl.text = p.bio ?? '';
    _experienceCtrl.text = p.yearsOfExperience?.toString() ?? '';
    _selectedCountry = p.country;
    _serverPhotoUrl = p.photoUrl;
    _languages = List.from(p.languages);
    _specializations = List.from(p.specializations);
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) setState(() => _photo = File(picked.path));
  }

  Future<void> _openCountryPicker() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CountryPickerSheet(selected: _selectedCountry),
    );
    if (result != null) setState(() => _selectedCountry = result);
  }

  Future<void> _openMultiSelect(
    String title,
    List<String> options,
    List<String> current,
    void Function(List<String>) onSave,
  ) async {
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _MultiSelectSheet(title: title, options: options, initial: current),
    );
    if (result != null) setState(() => onSave(result));
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<ProfileCubit>();
    if (_photo != null) cubit.uploadPhoto(_photo!);
    cubit.updateProfile({
      'full_name': _nameCtrl.text.trim(),
      'country': _selectedCountry ?? '',
      'city': _cityCtrl.text.trim(),
      'bio': _bioCtrl.text.trim(),
      'years_of_experience': int.tryParse(_experienceCtrl.text.trim()),
      'languages': _languages,
      'specializations': _specializations,
    });
  }

  String? _countryFlag(String name) {
    try {
      return _countryList.firstWhere((c) => c.$1 == name).$2;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          if (_initialized) {
            context.showSnackBar('Profile updated successfully!');
          }
          _initFromState(state);
        }
        if (state is ProfileError) context.showSnackBar(state.message, isError: true);
      },
      builder: (context, state) {
        final isLoading = state is ProfileLoading;
        return Scaffold(
          backgroundColor: AppColors.surface,
          appBar: AppBar(
            title: const Text('Edit Profile'),
            backgroundColor: AppColors.surface,
            actions: [
              TextButton(
                onPressed: isLoading ? null : _save,
                child: Text(
                  'Save',
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Center(
                    child: Stack(
                      children: [
                        _photo != null
                            ? CircleAvatar(
                                radius: 45,
                                backgroundImage: FileImage(_photo!),
                              )
                            : AuthAvatar(
                                photoUrl: _serverPhotoUrl,
                                initials: _nameCtrl.text,
                                radius: 45,
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickPhoto,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.surface, width: 2),
                              ),
                              child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: GestureDetector(
                      onTap: _pickPhoto,
                      child: Text(
                        'Change Photo',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  AppTextField(
                    label: 'Full Name',
                    controller: _nameCtrl,
                    validator: (v) => Validators.required(v, fieldName: 'Full name'),
                  ),
                  const SizedBox(height: 16),

                  // Country picker
                  Text(
                    'Country',
                    style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: _openCountryPicker,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          if (_selectedCountry != null) ...[
                            Text(
                              _countryFlag(_selectedCountry!) ?? '',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 10),
                            Text(_selectedCountry!, style: AppTextStyles.body),
                          ] else
                            Text(
                              'Select country',
                              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                            ),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  AppTextField(label: 'City', controller: _cityCtrl),
                  const SizedBox(height: 16),
                  AppTextField(label: 'Bio', controller: _bioCtrl, maxLines: 4),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Years of Experience',
                    controller: _experienceCtrl,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),

                  // Languages
                  _ChipField(
                    label: 'Languages',
                    chips: _languages,
                    onTap: () => _openMultiSelect(
                      'Languages',
                      _languageList,
                      _languages,
                      (v) => _languages = v,
                    ),
                    onRemove: (t) => setState(() => _languages.remove(t)),
                  ),
                  const SizedBox(height: 16),

                  // Specializations
                  _ChipField(
                    label: 'Specializations',
                    chips: _specializations,
                    onTap: () => _openMultiSelect(
                      'Specializations',
                      _specializationList,
                      _specializations,
                      (v) => _specializations = v,
                    ),
                    onRemove: (t) => setState(() => _specializations.remove(t)),
                  ),
                  const SizedBox(height: 24),

                  AppButton(label: 'Save Changes', isLoading: isLoading, onPressed: _save),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Country picker bottom sheet ─────────────────────────────────────────────

class _CountryPickerSheet extends StatefulWidget {
  final String? selected;
  const _CountryPickerSheet({this.selected});

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final _searchCtrl = TextEditingController();
  List<(String, String)> _filtered = _countryList;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearch(String q) {
    setState(() {
      _filtered = q.isEmpty
          ? _countryList
          : _countryList.where((c) => c.$1.toLowerCase().contains(q.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Select Country', style: AppTextStyles.heading3),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchCtrl,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: 'Search country...',
                  hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: _filtered.length,
                itemBuilder: (_, i) {
                  final (name, flag) = _filtered[i];
                  final isSelected = widget.selected == name;
                  return ListTile(
                    leading: Text(flag, style: const TextStyle(fontSize: 24)),
                    title: Text(name, style: AppTextStyles.body),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: AppColors.primary)
                        : null,
                    onTap: () => Navigator.pop(context, name),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Multi-select bottom sheet ───────────────────────────────────────────────

class _MultiSelectSheet extends StatefulWidget {
  final String title;
  final List<String> options;
  final List<String> initial;

  const _MultiSelectSheet({
    required this.title,
    required this.options,
    required this.initial,
  });

  @override
  State<_MultiSelectSheet> createState() => _MultiSelectSheetState();
}

class _MultiSelectSheetState extends State<_MultiSelectSheet> {
  late Set<String> _selected;
  final _searchCtrl = TextEditingController();
  List<String> _filtered = [];

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.initial);
    _filtered = widget.options;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearch(String q) {
    setState(() {
      _filtered = q.isEmpty
          ? widget.options
          : widget.options.where((o) => o.toLowerCase().contains(q.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Select ${widget.title}', style: AppTextStyles.heading3),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, _selected.toList()),
                    child: Text(
                      'Done (${_selected.length})',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchCtrl,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: _filtered.length,
                itemBuilder: (_, i) {
                  final option = _filtered[i];
                  final isSelected = _selected.contains(option);
                  return CheckboxListTile(
                    value: isSelected,
                    title: Text(option, style: AppTextStyles.body),
                    activeColor: AppColors.primary,
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (_) {
                      setState(() {
                        if (isSelected) {
                          _selected.remove(option);
                        } else {
                          _selected.add(option);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, MediaQuery.of(context).padding.bottom + 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _selected.toList()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Apply (${_selected.length} selected)',
                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Chip field ──────────────────────────────────────────────────────────────

class _ChipField extends StatelessWidget {
  final String label;
  final List<String> chips;
  final VoidCallback onTap;
  final void Function(String) onRemove;

  const _ChipField({
    required this.label,
    required this.chips,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            ...chips.map(
              (t) => Container(
                padding: const EdgeInsets.only(left: 10, right: 4, top: 4, bottom: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(t, style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => onRemove(t),
                      child: const Icon(Icons.close, size: 14, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('+ Add', style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
