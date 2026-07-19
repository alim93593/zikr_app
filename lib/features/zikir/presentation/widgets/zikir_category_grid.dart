import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';
import '../../domain/entities/zikir_category.dart';

class ZikirCategoryGrid extends StatelessWidget {
  final List<dynamic> categories;
  final Function(dynamic) onCategoryTap;

  const ZikirCategoryGrid({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryGridItem(
          category: category,
          onTap: () => onCategoryTap(category),
        );
      },
    );
  }
}

class _CategoryGridItem extends StatelessWidget {
  final dynamic category;
  final VoidCallback onTap;

  const _CategoryGridItem({
    required this.category,
    required this.onTap,
  });

  IconData _getIcon() {
    final iconName = category is ZikirCategory ? category.icon : category['icon'];
    switch (iconName) {
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

  Color _getColor() {
    if (category is ZikirCategory) {
      try {
        final hex = (category as ZikirCategory).colorHex.replaceFirst('#', '');
        return Color(int.parse('FF$hex', radix: 16));
      } catch (_) {
        return AppColors.primary;
      }
    }
    return category['color'] as Color? ?? AppColors.primary;
  }

  String _getName() {
    if (category is ZikirCategory) {
      return (category as ZikirCategory).nameAr;
    }
    return category['name'] as String;
  }

  int _getCount() {
    if (category is ZikirCategory) {
      return (category as ZikirCategory).zikirCount;
    }
    return category['count'] as int? ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

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
          onTap: onTap,
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
                  _getName(),
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${_getCount()} ${AppLocalizations.of(context)?.translate('azkar') ?? 'أذكار'}',
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