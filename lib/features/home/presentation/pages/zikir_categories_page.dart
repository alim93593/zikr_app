import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/components/custom_app_bar.dart';
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';

import '../../../zikir/presentation/cubit/zikir_cubit.dart';
import '../../../zikir/presentation/cubit/zikir_state.dart';
import '../../../zikir/presentation/widgets/zikir_category_grid.dart';
import '../../../zikir/presentation/widgets/zikir_detail_page.dart';

class ZikirCategoriesPage extends StatelessWidget {
  const ZikirCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ZikirCategoriesContent();
  }
}

class _ZikirCategoriesContent extends StatelessWidget {
  const _ZikirCategoriesContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: l10n?.translate('categoriesTitle') ?? 'تصنيفات الأذكار',
        showLeading: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocBuilder<ZikirCubit, ZikirState>(
                builder: (context, state) {
                  if (state.status == ZikirStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == ZikirStatus.error) {
                    return _buildErrorState(context);
                  }
                  return ZikirCategoryGrid(
                    categories: state.categories.isEmpty
                        ? _getDummyCategories(l10n)
                        : state.categories,
                    onCategoryTap: (category) {
                      context.read<ZikirCubit>().loadZikirsByCategory(
                        category.id,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<ZikirCubit>(),
                            child: ZikirDetailPage(
                              categoryName: category.nameAr,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.translate('chooseCategory') ?? 'اختر التصنيف المناسب لأذكارك',
            style: GoogleFonts.cairo(
              fontSize: 18,
              color: AppColors.textPrimary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<ZikirCubit, ZikirState>(
            builder: (context, state) {
              final count = state.categories.isEmpty
                  ? 8
                  : state.categories.length;
              return Text(
                '$count ${l10n?.translate('categoriesAvailable') ?? 'تصنيفات متاحة'}',
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: AppColors.textPrimary.withValues(alpha: 0.8),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 48),
          const SizedBox(height: 16),
          Text(
            l10n?.translate('errorOccurred') ?? 'حدث خطأ',
            style: GoogleFonts.cairo(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<ZikirCubit>().loadCategories(),
            child: Text(
              l10n?.translate('retry') ?? 'إعادة المحاولة',
            ),
          ),
        ],
      ),
    );
  }

  List<dynamic> _getDummyCategories(AppLocalizations? l10n) {
    return [
      {
        'name': l10n?.translate('morningAzkar') ?? 'أذكار الصباح',
        'icon': Icons.wb_sunny,
        'color': Colors.orange,
        'count': 12,
        'id': 'morning',
      },
      {
        'name': l10n?.translate('eveningAzkar') ?? 'أذكار المساء',
        'icon': Icons.nightlight,
        'color': Colors.indigo,
        'count': 10,
        'id': 'evening',
      },
      {
        'name': l10n?.translate('sleepAzkar') ?? 'أذكار النوم',
        'icon': Icons.bedtime,
        'color': Colors.purple,
        'count': 8,
        'id': 'sleep',
      },
      {
        'name': l10n?.translate('propheticDua') ?? 'أدعية نبوية',
        'icon': Icons.menu_book,
        'color': Colors.teal,
        'count': 15,
        'id': 'prayers',
      },
      {
        'name': l10n?.translate('quranVerses') ?? 'آيات قرآنية',
        'icon': Icons.menu_open,
        'color': Colors.green,
        'count': 20,
        'id': 'quran',
      },
      {
        'name': l10n?.translate('istighfar') ?? 'الاستغفار',
        'icon': Icons.refresh,
        'color': Colors.blue,
        'count': 6,
        'id': 'forgiveness',
      },
      {
        'name': l10n?.translate('praiseThank') ?? 'الحمد والشكر',
        'icon': Icons.favorite,
        'color': Colors.amber,
        'count': 7,
        'id': 'gratitude',
      },
      {
        'name': l10n?.translate('protection') ?? 'الحفظ والحماية',
        'icon': Icons.shield,
        'color': Colors.red,
        'count': 9,
        'id': 'protection',
      },
    ];
  }
}
