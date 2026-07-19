import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/theme/app_colors.dart';

class TasbeehCounterWidget extends StatelessWidget {
  final int count;
  final int target;
  final double progress;
  final bool isCompleted;
  final VoidCallback onIncrement;

  const TasbeehCounterWidget({
    super.key,
    required this.count,
    required this.target,
    required this.progress,
    required this.isCompleted,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onIncrement();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 220,
            height: 220,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return CircularProgressIndicator(
                  value: value,
                  strokeWidth: 12,
                  backgroundColor: AppColors.divider,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isCompleted ? AppColors.success : AppColors.primary,
                  ),
                );
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: count),
                duration: const Duration(milliseconds: 200),
                builder: (context, value, child) {
                  return Text(
                    '$value',
                    style: GoogleFonts.cairo(
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  );
                },
              ),
              Text(
                '/ $target',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              if (isCompleted) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: AppColors.success, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'تم',
                        style: GoogleFonts.cairo(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}