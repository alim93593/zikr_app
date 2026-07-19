import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';

class ZikirDetailCard extends StatelessWidget {
  final String text;
  final String? transliteration;
  final String? translation;
  final int count;
  final String category;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onTap;

  const ZikirDetailCard({
    super.key,
    required this.text,
    this.transliteration,
    this.translation,
    required this.count,
    required this.category,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? AppColors.error : AppColors.muted,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  text,
                  style: GoogleFonts.amiri(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.right,
                ),
                if (transliteration != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    transliteration!,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
                if (translation != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    translation!,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.repeat, size: 16, color: AppColors.muted),
                    const SizedBox(width: 4),
                    Text(
                      '$count ${l10n?.translate('times') ?? 'مرة'}',
                      style: GoogleFonts.cairo(
                        fontSize: 13,
                        color: AppColors.muted,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.touch_app, size: 16, color: AppColors.secondary),
                          const SizedBox(width: 4),
                          Text(
                            l10n?.translate('tasbeeh') ?? 'تسبيح',
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}