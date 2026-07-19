import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';
import '../../../zikir/domain/entities/zikir_category.dart';

class CategoryCard extends StatelessWidget {
  final ZikirCategory category;

  const CategoryCard({super.key, required this.category});

  Color _getColor() {
    try {
      final hex = category.colorHex.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return AppColors.primary;
    }
  }

  IconData _getIcon() {
    switch (category.icon) {
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'nightlight':
        return Icons.nightlight;
      case 'bedtime':
        return Icons.bedtime;
      case 'menu_book':
        return Icons.menu_book;
      case 'menu_open':
        return Icons.menu_open;
      case 'refresh':
        return Icons.refresh;
      case 'favorite':
        return Icons.favorite;
      case 'shield':
        return Icons.shield;
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final l10n = AppLocalizations.of(context);

    return Container(
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
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(_getIcon(), color: color, size: 30),
                ),
                const SizedBox(height: 12),
                Text(
                  category.nameAr,
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '${category.zikirCount} ${l10n?.translate('azkar') ?? 'أذكار'}',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}