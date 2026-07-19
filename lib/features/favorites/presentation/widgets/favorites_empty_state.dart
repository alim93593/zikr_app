import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';

class FavoritesEmptyState extends StatelessWidget {
  final VoidCallback? onExplore;
  const FavoritesEmptyState({super.key, this.onExplore});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.error.withValues(alpha: 0.08),
                    AppColors.primary.withValues(alpha: 0.04),
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.08),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 52,
                color: AppColors.error.withValues(alpha: 0.45),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              l10n?.translate('noFavoritesYet') ?? 'لا توجد مفضلات',
              style: GoogleFonts.cairo(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n?.translate('emptyFavoritesAdd') ?? 'أضف أذكارك المفضلة من الشاشة الرئيسية\nللوصول إليها بسرعة',
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.7,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            GestureDetector(
              onTap: onExplore,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryVariant],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.explore_rounded, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      l10n?.translate('exploreAzkar') ?? 'استكشف الأذكار',
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}