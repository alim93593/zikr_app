import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/components/custom_app_bar.dart';
import 'package:zikr_app/core/di/injection_container.dart' as di;
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:zikr_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:zikr_app/features/profile/presentation/cubit/profile_state.dart';
import 'package:zikr_app/features/tasbeeh/presentation/cubit/tasbeeh_cubit.dart';
import 'package:zikr_app/features/tasbeeh/presentation/cubit/tasbeeh_state.dart';
import 'package:zikr_app/l10n/app_localizations.dart';

import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di.sl<ProfileCubit>()..loadProfile()),
        BlocProvider.value(value: di.sl<TasbeehCubit>()),
      ],
      child: const _SettingsPageContent(),
    );
  }
}

class _SettingsPageContent extends StatelessWidget {
  const _SettingsPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        titleKey: 'settings',
        showLeading: true,
        onLeadingTap: () {},
        leadingWidget: Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.settings, color: AppColors.primary, size: 20),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state.status == SettingsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildStatsCard(context)),
                SliverToBoxAdapter(child: _buildAccountSection(context)),
                SliverToBoxAdapter(child: _buildSettingsList(context, state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<TasbeehCubit, TasbeehState>(
      builder: (context, tasbeehState) {
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryVariant],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                label: l10n?.translate('todayProgress') ?? 'تقدم اليوم',
                value: '${tasbeehState.count}',
              ),
              Container(width: 1, height: 40, color: Colors.white24),
              _StatItem(
                label: l10n?.translate('totalCount') ?? 'العدد الإجمالي',
                value: '${tasbeehState.totalCount}',
              ),
              Container(width: 1, height: 40, color: Colors.white24),
              _StatItem(
                label: l10n?.translate('streakDays') ?? 'الأيام المتتالية',
                value: '${tasbeehState.streakDays}',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        final profile = profileState.profile;
        return BlocBuilder<TasbeehCubit, TasbeehState>(
          builder: (context, tasbeehState) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primaryVariant,
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            profile?.displayName.isNotEmpty == true
                                ? profile!.displayName[0]
                                : 'م',
                            style: GoogleFonts.cairo(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile?.displayName ?? 'مستخدم',
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.lock_outline,
                                  size: 12,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    profile?.email ?? '',
                                    style: GoogleFonts.cairo(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _AccountInfoRow(
                    label:
                        l10n?.translate('totalTasbeeh') ?? 'إجمالي التسبيحات',
                    value: '${tasbeehState.totalCount}',
                  ),
                  _AccountInfoRow(
                    label:
                        l10n?.translate('currentStreak') ?? 'السلسلة الحالية',
                    value: '${tasbeehState.streakDays}',
                  ),
                  _AccountInfoRow(
                    label: l10n?.translate('favorites') ?? 'المفضلة',
                    value: '${profile?.favoritesCount ?? 0}',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSettingsList(BuildContext context, SettingsState state) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title: l10n?.translate('general') ?? 'عام'),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.person_outline,
                title: l10n?.translate('account') ?? 'الحساب',
                subtitle: state.settings.language == 'ar'
                    ? 'العربية'
                    : 'English',
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
              _SettingsTile(
                icon: Icons.language,
                title: l10n?.translate('language') ?? 'اللغة',
                trailing: _buildLanguageSelector(context, state),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionTitle(title: l10n?.translate('reminders') ?? 'التذكيرات'),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.notifications_outlined,
                title: l10n?.translate('notifications') ?? 'إشعارات الأذكار',
                subtitle: 'تذكير بأذكار الصباح والمساء',
                trailing: _NotificationSwitch(
                  isEnabled: state.settings.notificationsEnabled,
                  onChanged: (value) {
                    HapticFeedback.lightImpact();
                    context.read<SettingsCubit>().toggleNotifications(value);
                  },
                ),
              ),
              _SettingsTile(
                icon: Icons.schedule_outlined,
                title: l10n?.translate('notificationTime') ?? 'وقت التذكير',
                subtitle:
                    '${state.settings.morningReminderTime} - ${state.settings.eveningReminderTime}',
                onTap: () => _showTimePickerDialog(context, state),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionTitle(title: l10n?.translate('app') ?? 'التطبيق'),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.admin_panel_settings,
                title: l10n?.translate('manageZikir') ?? 'إدارة الأذكار',
                subtitle: 'إضافة وتعديل الأذكار والتصنيفات',
                onTap: () => Navigator.pushNamed(context, '/manage-zikir'),
              ),
              Divider(height: 1, color: AppColors.divider, indent: 56),
              _SettingsTile(
                icon: Icons.info_outline,
                title: l10n?.translate('aboutApp') ?? 'عن التطبيق',
                subtitle: 'الإصدار 1.0.0',
                onTap: () => _showAboutDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.logout,
                title: l10n?.translate('logout') ?? 'تسجيل الخروج',
                iconColor: AppColors.error,
                titleColor: AppColors.error,
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context, SettingsState state) {
    final l10n = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _showLanguageDialog(context, state);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.settings.language == 'ar'
                  ? (l10n?.translate('arabic') ?? 'العربية')
                  : (l10n?.translate('english') ?? 'English'),
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, SettingsState state) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          l10n?.translate('chooseLanguage') ?? 'اختر اللغة',
          style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LanguageOption(
              title: l10n?.translate('arabic') ?? 'العربية',
              isSelected: state.settings.language == 'ar',
              onTap: () {
                context.read<SettingsCubit>().setLanguage('ar');
                Navigator.pop(ctx);
              },
            ),
            const SizedBox(height: 8),
            _LanguageOption(
              title: l10n?.translate('english') ?? 'English',
              isSelected: state.settings.language == 'en',
              onTap: () {
                context.read<SettingsCubit>().setLanguage('en');
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryVariant],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.auto_stories,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n?.translate('appName') ?? 'الذكر',
              style: GoogleFonts.amiri(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n?.translate('version') ?? 'الإصدار'}: 1.0.0',
              style: GoogleFonts.cairo(),
            ),
            const SizedBox(height: 8),
            Text(
              l10n?.translate('aboutApp') ?? 'تطبيق الأذكار والتسبيح',
              style: GoogleFonts.cairo(),
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.translate('praiseGod') ?? 'الحمد لله الذي بلغنا هذا اليوم',
              style: GoogleFonts.amiri(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              l10n?.translate('close') ?? 'إغلاق',
              style: GoogleFonts.cairo(),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          l10n?.translate('logout') ?? 'تسجيل الخروج',
          style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
        ),
        content: Text(
          l10n?.translate('logoutConfirm') ?? 'هل أنت متأكد من تسجيل الخروج؟',
          style: GoogleFonts.cairo(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              l10n?.translate('cancel') ?? 'إلغاء',
              style: GoogleFonts.cairo(),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final authCubit = di.sl<AuthCubit>();
              await authCubit.logout();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(
              l10n?.translate('logout') ?? 'تسجيل الخروج',
              style: GoogleFonts.cairo(),
            ),
          ),
        ],
      ),
    );
  }

  void _showTimePickerDialog(BuildContext context, SettingsState state) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, updatedState) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n?.translate('reminderTimes') ?? 'أوقات التذكير',
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                _TimePickerRow(
                  icon: Icons.wb_sunny_rounded,
                  iconColor: const Color(0xFFFF9800),
                  label: l10n?.translate('morningAzkar') ?? 'أذكار الصباح',
                  time: updatedState.settings.morningReminderTime,
                  onTap: () async {
                    final time = await _pickTime(context, updatedState.settings.morningReminderTime);
                    if (time != null && ctx.mounted) {
                      context.read<SettingsCubit>().updateMorningReminderTime(time);
                    }
                  },
                ),
                const SizedBox(height: 16),
                _TimePickerRow(
                  icon: Icons.nightlight_rounded,
                  iconColor: const Color(0xFF5C6BC0),
                  label: l10n?.translate('eveningAzkar') ?? 'أذكار المساء',
                  time: updatedState.settings.eveningReminderTime,
                  onTap: () async {
                    final time = await _pickTime(context, updatedState.settings.eveningReminderTime);
                    if (time != null && ctx.mounted) {
                      context.read<SettingsCubit>().updateEveningReminderTime(time);
                    }
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<String?> _pickTime(BuildContext context, String currentTime) async {
    final parts = currentTime.split(':');
    final initialHour = int.tryParse(parts[0]) ?? 6;
    final initialMinute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initialHour, minute: initialMinute),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null) return null;
    return '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationSwitch extends StatelessWidget {
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  const _NotificationSwitch({required this.isEnabled, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isEnabled),
      child: Container(
        width: 50,
        height: 30,
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.primary : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: isEnabled ? 24 : 4,
              top: 3,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          final index = entry.key;
          final child = entry.value;
          return Column(
            children: [
              child,
              if (index < children.length - 1)
                Divider(height: 1, color: AppColors.divider, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.primary).withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.cairo(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: titleColor ?? AppColors.textPrimary,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              trailing ??
                  (onTap != null
                      ? Icon(Icons.chevron_left, color: AppColors.muted)
                      : const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _AccountInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimePickerRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String time;
  final VoidCallback onTap;

  const _TimePickerRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time_rounded, color: AppColors.primary, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    time,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
