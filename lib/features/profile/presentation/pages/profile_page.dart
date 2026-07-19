import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/components/custom_app_bar.dart';
import 'package:zikr_app/core/di/injection_container.dart' as di;
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';

import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ProfileCubit>()..loadProfile(),
      child: const ProfilePageContent(),
    );
  }
}

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        titleKey: 'profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.muted),
            onPressed: () => _showEditNameDialog(context, l10n),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ProfileStatus.error) {
              return Center(
                child: Text(state.message ?? 'Error', style: GoogleFonts.cairo()),
              );
            }
            return _buildProfileContent(context, state, l10n);
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileState state, AppLocalizations? l10n) {
    final profile = state.profile;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildProfileHeader(profile?.photoUrl, profile?.displayName ?? 'م', profile?.displayName ?? l10n?.translate('user') ?? 'User', profile?.email ?? ''),
          const SizedBox(height: 24),
          _buildMainStats(state, l10n),
          const SizedBox(height: 20),
          _buildDetailedStats(state, l10n),
          const SizedBox(height: 20),
          _buildAchievements(state, l10n),
          const SizedBox(height: 20),
          _buildEditProfileAction(context, l10n),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(String? photoUrl, String firstLetter, String name, String email) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryVariant],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: photoUrl != null
              ? ClipOval(child: Image.network(photoUrl, fit: BoxFit.cover))
              : Center(
                  child: Text(
                    firstLetter.isNotEmpty ? firstLetter[0] : 'م',
                    style: GoogleFonts.cairo(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: GoogleFonts.cairo(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: GoogleFonts.cairo(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMainStats(ProfileState state, AppLocalizations? l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryVariant],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text(
                l10n?.translate('yourStats') ?? 'Your Stats',
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _mainStatItem(
                icon: Icons.touch_app,
                value: '${state.profile?.totalTasbeehCount ?? 0}',
                label: l10n?.translate('totalTasbeeh') ?? 'Total Tasbeeh',
              ),
              Container(width: 1, height: 50, color: Colors.white24),
              _mainStatItem(
                icon: Icons.local_fire_department,
                value: '${state.profile?.currentStreak ?? 0}',
                label: l10n?.translate('currentStreak') ?? 'Current Streak',
              ),
              Container(width: 1, height: 50, color: Colors.white24),
              _mainStatItem(
                icon: Icons.favorite,
                value: '${state.profile?.favoritesCount ?? 0}',
                label: l10n?.translate('favorites') ?? 'Favorites',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mainStatItem({required IconData icon, required String value, required String label}) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
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
          style: GoogleFonts.cairo(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedStats(ProfileState state, AppLocalizations? l10n) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.insights, color: AppColors.primary, size: 18),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n?.translate('achievementDetails') ?? 'Achievement Details',
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.divider),
          _detailRow(Icons.emoji_events, l10n?.translate('longestStreak') ?? 'Longest Streak', '${state.profile?.longestStreak ?? 0} ${l10n?.translate('days') ?? 'days'}'),
          Divider(height: 1, color: AppColors.divider, indent: 56),
          _detailRow(Icons.calendar_today, l10n?.translate('joinedAt') ?? 'Joined At', _formatDate(state.profile?.joinedAt, l10n)),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date, AppLocalizations? l10n) {
    if (date == null) return l10n?.translate('notSpecified') ?? 'Not specified';
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.secondary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements(ProfileState state, AppLocalizations? l10n) {
    final streak = state.profile?.currentStreak ?? 0;
    final tasbeeh = state.profile?.totalTasbeehCount ?? 0;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.emoji_events, color: Colors.amber.shade700, size: 18),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n?.translate('achievements') ?? 'Achievements',
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.divider),
          _achievementRow(
            icon: Icons.local_fire_department,
            title: l10n?.translate('shining') ?? 'Shining',
            subtitle: streak >= 7 
                ? l10n?.translate('streak7Days') ?? 'Maintained 7-day streak' 
                : '${l10n?.translate('needDays') ?? 'Need'} ${7 - streak} ${l10n?.translate('daysToReach') ?? 'days to reach'}',
            isUnlocked: streak >= 7,
            color: Colors.orange,
            l10n: l10n,
          ),
          Divider(height: 1, color: AppColors.divider, indent: 56),
          _achievementRow(
            icon: Icons.stars,
            title: l10n?.translate('activeWorshiper') ?? 'Active Worshiper',
            subtitle: tasbeeh >= 100 
                ? l10n?.translate('completed100') ?? 'Completed 100 tasbeeh' 
                : '${l10n?.translate('need') ?? 'Need'} ${100 - tasbeeh} ${l10n?.translate('tasbeehToReach') ?? 'tasbeeh to reach'}',
            isUnlocked: tasbeeh >= 100,
            color: Colors.purple,
            l10n: l10n,
          ),
          Divider(height: 1, color: AppColors.divider, indent: 56),
          _achievementRow(
            icon: Icons.rocket_launch,
            title: l10n?.translate('beginner') ?? 'Beginner',
            subtitle: l10n?.translate('completeFirst') ?? 'Complete your first tasbeeh',
            isUnlocked: tasbeeh > 0,
            color: Colors.blue,
            l10n: l10n,
          ),
        ],
      ),
    );
  }

  Widget _achievementRow({required IconData icon, required String title, required String subtitle, required bool isUnlocked, required Color color, AppLocalizations? l10n}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isUnlocked ? color.withValues(alpha: 0.1) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isUnlocked ? color : Colors.grey.shade400,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isUnlocked ? AppColors.textPrimary : Colors.grey,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: isUnlocked ? AppColors.textSecondary : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          if (isUnlocked)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '✓',
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEditProfileAction(BuildContext context, AppLocalizations? l10n) {
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showEditNameDialog(context, l10n),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.edit_outlined, color: AppColors.primary, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    l10n?.translate('editProfile') ?? 'Edit Profile',
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(Icons.chevron_left, color: AppColors.muted, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditNameDialog(BuildContext context, AppLocalizations? l10n) {
    final controller = TextEditingController(
      text: context.read<ProfileCubit>().state.profile?.displayName ?? '',
    );
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          l10n?.translate('editName') ?? 'Edit Name',
          style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
        ),
        content: TextField(
          controller: controller,
          style: GoogleFonts.cairo(),
          decoration: InputDecoration(
            labelText: l10n?.translate('name') ?? 'Name',
            labelStyle: GoogleFonts.cairo(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n?.translate('cancel') ?? 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ProfileCubit>().updateProfile(controller.text, null);
              Navigator.pop(ctx);
            },
            child: Text(l10n?.translate('save') ?? 'Save'),
          ),
        ],
      ),
    );
  }
}
