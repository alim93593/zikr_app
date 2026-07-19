import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/features/zikir/domain/entities/zikir.dart';
import 'package:zikr_app/l10n/app_localizations.dart';

class FavoriteCard extends StatelessWidget {
  final Zikir item;
  final VoidCallback? onRemove;

  const FavoriteCard({
    super.key,
    required this.item,
    this.onRemove,
  });

  IconData _getCategoryIcon() {
    final cat = item.categoryId.toLowerCase();
    switch (cat) {
      case 'morning':
        return Icons.wb_sunny_rounded;
      case 'evening':
        return Icons.nightlight_rounded;
      case 'sleep':
        return Icons.bedtime_rounded;
      case 'quran':
        return Icons.menu_book_rounded;
      case 'prayer':
      case 'dua':
        return Icons.mosque_rounded;
      case 'forgiveness':
      case 'istighfar':
        return Icons.refresh_rounded;
      case 'praise':
      case 'gratitude':
        return Icons.favorite_rounded;
      case 'protection':
        return Icons.shield_rounded;
      default:
        return Icons.auto_awesome_rounded;
    }
  }

  Color _getCategoryColor() {
    final cat = item.categoryId.toLowerCase();
    switch (cat) {
      case 'morning':
        return const Color(0xFFFF9800);
      case 'evening':
        return const Color(0xFF5C6BC0);
      case 'sleep':
        return const Color(0xFF9C27B0);
      case 'quran':
        return const Color(0xFF4CAF50);
      case 'prayer':
      case 'dua':
        return const Color(0xFF009688);
      case 'forgiveness':
      case 'istighfar':
        return const Color(0xFF2196F3);
      case 'praise':
      case 'gratitude':
        return const Color(0xFFF44336);
      case 'protection':
        return const Color(0xFFE91E63);
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = _getCategoryColor();
    final icon = _getCategoryIcon();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 5,
                    decoration: BoxDecoration(color: color),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  color.withValues(alpha: 0.16),
                                  color.withValues(alpha: 0.04),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Icon(icon, color: color, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.text,
                                  style: GoogleFonts.amiri(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                    height: 1.45,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: color.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        item.categoryName,
                                        style: GoogleFonts.cairo(
                                          fontSize: 10,
                                          color: color,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${item.count} ${l10n?.translate('times') ?? 'مرة'}',
                                      style: GoogleFonts.cairo(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: onRemove,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  Icons.close_rounded,
                                  color: AppColors.muted,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}