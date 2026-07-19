import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/components/custom_app_bar.dart';
import 'package:zikr_app/core/di/injection_container.dart' as di;
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/core/widgets/text_field.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ProfileCubit>()..loadProfile(),
      child: const _EditProfilePageContent(),
    );
  }
}

class _EditProfilePageContent extends StatefulWidget {
  const _EditProfilePageContent();

  @override
  State<_EditProfilePageContent> createState() => _EditProfilePageContentState();
}

class _EditProfilePageContentState extends State<_EditProfilePageContent> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool _isLoading = false;
  bool _controllersInitialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _initializeFromState(ProfileState state) {
    if (!_controllersInitialized && state.profile != null) {
      _nameController.text = state.profile!.displayName ?? '';
      _controllersInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'تعديل الملف الشخصي',
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state.status == ProfileStatus.loaded) {
              _initializeFromState(state);
            }
            if (state.status == ProfileStatus.loaded && state.message == 'updated') {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم تحديث البيانات بنجاح', style: GoogleFonts.cairo()),
                  backgroundColor: AppColors.success,
                ),
              );
            }
            if (state.status == ProfileStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message ?? 'حدث خطأ', style: GoogleFonts.cairo()),
                  backgroundColor: AppColors.error,
                ),
              );
              setState(() => _isLoading = false);
            }
          },
          builder: (context, state) {
            if (state.status == ProfileStatus.loading && !_controllersInitialized) {
              return const Center(child: CircularProgressIndicator());
            }
            _initializeFromState(state);
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildAvatar(state),
                    const SizedBox(height: 40),
                    _buildInfoCard(state),
                    const SizedBox(height: 24),
                    _buildEditSection(state),
                    const SizedBox(height: 32),
                    _buildSaveButton(context, state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAvatar(ProfileState state) {
    final name = _nameController.text.isNotEmpty ? _nameController.text : 'م';
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryVariant],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Text(
          name[0].toUpperCase(),
          style: GoogleFonts.amiri(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(ProfileState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.person_outline,
            label: 'الاسم',
            value: state.profile?.displayName ?? 'غير محدد',
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.email_outlined,
            label: 'البريد الإلكتروني',
            value: state.profile?.email ?? 'غير محدد',
            color: AppColors.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditSection(ProfileState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'تعديل الاسم',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _nameController,
            label: 'الاسم الجديد',
            hint: 'أدخل اسمك الجديد',
            prefixIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.person, color: AppColors.primary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, ProfileState state) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading || state.status == ProfileStatus.loading
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  HapticFeedback.mediumImpact();
                  setState(() => _isLoading = true);
                  context.read<ProfileCubit>().updateProfile(
                    _nameController.text.trim(),
                    null,
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
          elevation: 4,
          shadowColor: AppColors.primary.withValues(alpha: 0.4),
        ),
        child: _isLoading || state.status == ProfileStatus.loading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.save, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'حفظ التغييرات',
                    style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
      ),
    );
  }
}