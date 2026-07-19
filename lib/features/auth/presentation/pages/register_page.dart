import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/di/injection_container.dart' as di;
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/core/widgets/text_field.dart';
import 'package:zikr_app/l10n/app_localizations.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<AuthCubit>(),
      child: const _RegisterPageContent(),
    );
  }
}

class _RegisterPageContent extends StatefulWidget {
  const _RegisterPageContent();

  @override
  State<_RegisterPageContent> createState() => _RegisterPageContentState();
}

class _RegisterPageContentState extends State<_RegisterPageContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.error && state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!, style: GoogleFonts.cairo()), backgroundColor: AppColors.error),
              );
            }
            if (state.status == AuthStatus.authenticated) {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    _buildLogo(l10n),
                    const SizedBox(height: 40),
                    _buildWelcomeText(l10n),
                    const SizedBox(height: 32),
                    _buildNameField(l10n),
                    const SizedBox(height: 16),
                    _buildEmailField(l10n),
                    const SizedBox(height: 16),
                    _buildPasswordField(l10n),
                    const SizedBox(height: 16),
                    _buildConfirmPasswordField(l10n),
                    const SizedBox(height: 24),
                    _buildRegisterButton(context, state, l10n),
                    const SizedBox(height: 16),
                    _buildLoginLink(context, l10n),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLogo(AppLocalizations? l10n) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryVariant], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.auto_stories, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 16),
        Text(l10n?.translate('appName') ?? 'الذكر', style: GoogleFonts.amiri(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildWelcomeText(AppLocalizations? l10n) {
    return Column(
      children: [
        Text(l10n?.translate('createAccount') ?? 'إنشاء حساب', style: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Text(l10n?.translate('joinUs') ?? 'انضم إلينا اليوم', style: GoogleFonts.cairo(fontSize: 16, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildNameField(AppLocalizations? l10n) {
    return AppTextField(
      controller: _nameController,
      label: l10n?.translate('name') ?? 'الاسم',
      hint: 'محمد أحمد',
      prefixIcon: const Icon(Icons.person_outline, color: AppColors.muted),
    );
  }

  Widget _buildEmailField(AppLocalizations? l10n) {
    return AppTextField(
      controller: _emailController,
      label: l10n?.translate('email') ?? 'البريد الإلكتروني',
      hint: 'example@email.com',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email_outlined, color: AppColors.muted),
    );
  }

  Widget _buildPasswordField(AppLocalizations? l10n) {
    return AppTextField(
      controller: _passwordController,
      label: l10n?.translate('password') ?? 'كلمة المرور',
      hint: '••••••••',
      obscure: _obscurePassword,
      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.muted),
      suffixIcon: IconButton(
        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppColors.muted),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      ),
    );
  }

  Widget _buildConfirmPasswordField(AppLocalizations? l10n) {
    return AppTextField(
      controller: _confirmPasswordController,
      label: l10n?.translate('confirmPassword') ?? 'تأكيد كلمة المرور',
      hint: '••••••••',
      obscure: _obscureConfirmPassword,
      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.muted),
      suffixIcon: IconButton(
        icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, color: AppColors.muted),
        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context, AuthState state, AppLocalizations? l10n) {
    return ElevatedButton(
      onPressed: state.status == AuthStatus.loading
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                HapticFeedback.mediumImpact();
                context.read<AuthCubit>().signUp(
                      _emailController.text.trim(),
                      _passwordController.text,
                      _nameController.text.trim(),
                    );
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
      ),
      child: state.status == AuthStatus.loading
          ? const SizedBox(height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
          : Text(l10n?.translate('register') ?? 'إنشاء حساب', style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildLoginLink(BuildContext context, AppLocalizations? l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n?.translate('alreadyHaveAccount') ?? 'لديك حساب؟ ', style: GoogleFonts.cairo(color: AppColors.textSecondary)),
        TextButton(
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage())),
          child: Text(l10n?.translate('login') ?? 'تسجيل الدخول', style: GoogleFonts.cairo(color: AppColors.primary, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}