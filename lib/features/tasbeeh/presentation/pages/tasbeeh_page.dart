import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/di/injection_container.dart' as di;
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/core/components/custom_app_bar.dart';
import 'package:zikr_app/l10n/app_localizations.dart';
import '../cubit/tasbeeh_cubit.dart';
import '../cubit/tasbeeh_state.dart';
import '../widgets/tasbeeh_counter_widget.dart';
import '../widgets/tasbeeh_target_selector.dart';

class TasbeehPage extends StatelessWidget {
  const TasbeehPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di.sl<TasbeehCubit>()..loadStats(),
      child: const _TasbeehPageContent(),
    );
  }
}

class _TasbeehPageContent extends StatelessWidget {
  const _TasbeehPageContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        titleKey: 'tasbeeh',
        showLeading: true,
        onLeadingTap: () {},
        leadingWidget: Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.mosque_rounded, color: AppColors.primary, size: 20),
        ),
        actions: [
          BlocBuilder<TasbeehCubit, TasbeehState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_fire_department, color: AppColors.textPrimary, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${state.streakDays}',
                      style: GoogleFonts.cairo(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      ' ${l10n?.translate('day') ?? 'day'}',
                      style: GoogleFonts.cairo(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<TasbeehCubit, TasbeehState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                const SizedBox(height: 20),
                _buildMotivationalText(context, state),
                const Spacer(),
                TasbeehCounterWidget(
                  count: state.count,
                  target: state.target,
                  progress: state.progress,
                  isCompleted: state.isCompleted,
                  onIncrement: () => context.read<TasbeehCubit>().increment(),
                ),
                const SizedBox(height: 40),
                _buildControls(context, state),
                const SizedBox(height: 32),
                TasbeehTargetSelector(
                  targets: const [33, 99, 100, 1000],
                  selectedTarget: state.target,
                  onTargetSelected: (target) => context.read<TasbeehCubit>().setTarget(target),
                ),
                const Spacer(),
                _buildTodayStats(context, state),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMotivationalText(BuildContext context, TasbeehState state) {
    final l10n = AppLocalizations.of(context);
    final textIndex = (state.totalCount ~/ 10) % 15 + 1;
    final textKey = 'tasbeehText$textIndex';

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Container(
        key: ValueKey(textKey),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.12),
              AppColors.primaryVariant.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.auto_awesome,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Flexible(
              child: Text(
                l10n?.translate(textKey) ?? _getDefaultText(textIndex),
                style: GoogleFonts.amiri(
                  fontSize: 20,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDefaultText(int index) {
    final texts = [
      'بارك الله فيك',
      'أحسنت، زيدك الله تقوى',
      'اللهم تقبل مني',
      'اكمل يا بطل',
      'جزاك الله خيرا',
      'سبحان الله وبحمده',
      'الله المستعان',
      'نعم الله عليك',
      'قريت توصل',
      'حفظك الله',
      'ما شاء الله',
      'الله أكبر',
      'لا إله إلا الله',
      'أستغفر الله',
      'الحمد لله',
    ];
    return texts[index - 1];
  }

  Widget _buildControls(BuildContext context, TasbeehState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ControlButton(
          icon: Icons.refresh_rounded,
          onTap: () => context.read<TasbeehCubit>().reset(),
          color: AppColors.error,
        ),
        const SizedBox(width: 24),
        GestureDetector(
          onTap: () => context.read<TasbeehCubit>().increment(),
          child: Container(
            width: 80,
            height: 80,
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
            child: const Icon(Icons.add, color: Colors.white, size: 36),
          ),
        ),
        const SizedBox(width: 24),
        _ControlButton(
          icon: Icons.check_circle_outline,
          onTap: () => _showCompletionDialog(context, state),
          color: AppColors.secondary,
        ),
      ],
    );
  }

  void _showCompletionDialog(BuildContext context, TasbeehState state) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.celebration, color: Colors.amber),
            const SizedBox(width: 8),
            Text(
              l10n?.translate('mashaAllah') ?? 'ما شاء الله',
              style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: Text(
          l10n?.translate('completedTasbeeh') ??
            'أكملت ${state.target} تسبيحة! جزاك الله خيراً',
          style: GoogleFonts.cairo(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n?.translate('continue') ?? 'استمر'),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayStats(BuildContext context, TasbeehState state) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.trending_up_rounded,
            label: l10n?.translate('todayProgress') ?? 'تقدم اليوم',
            value: '${state.count}',
            color: AppColors.primary,
          ),
          Container(width: 1, height: 36, color: AppColors.primary.withValues(alpha: 0.1)),
          _StatItem(
            icon: Icons.repeat_rounded,
            label: l10n?.translate('totalCount') ?? 'العدد الإجمالي',
            value: '${state.totalCount}',
            color: AppColors.secondary,
          ),
          Container(width: 1, height: 36, color: AppColors.primary.withValues(alpha: 0.1)),
          _StatItem(
            icon: Icons.local_fire_department_rounded,
            label: l10n?.translate('streak') ?? 'السلسلة',
            value: '${state.streakDays}',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _ControlButton({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
