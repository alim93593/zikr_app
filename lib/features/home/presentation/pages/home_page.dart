import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zikr_app/core/di/injection_container.dart' as di;
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';

import '../../../tasbeeh/presentation/cubit/tasbeeh_cubit.dart';
import '../../../tasbeeh/presentation/cubit/tasbeeh_state.dart';
import '../../../zikir/domain/entities/zikir.dart';
import '../../../zikir/domain/entities/zikir_category.dart';
import '../../../zikir/presentation/cubit/zikir_cubit.dart';
import '../../../zikir/presentation/cubit/zikir_state.dart';
import '../../../zikir/presentation/widgets/zikir_detail_page.dart';
import 'zikir_categories_page.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onSwitchToFavorites;
  const HomePage({super.key, this.onSwitchToFavorites});

  @override
  Widget build(BuildContext context) {
    return _HomePageContent(onSwitchToFavorites: onSwitchToFavorites);
  }
}

class _HomePageContent extends StatelessWidget {
  final VoidCallback? onSwitchToFavorites;
  const _HomePageContent({this.onSwitchToFavorites});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.black12,
            elevation: 0,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryVariant],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_stories_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n?.translate('appName') ?? 'الذكر',
                  style: GoogleFonts.amiri(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(left: 8, right: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    _HeaderButton(
                      icon: Icons.history_rounded,
                      label: l10n?.translate('history') ?? 'السجل',
                      color: AppColors.secondary,
                      onTap: () => _navigateToHistory(context),
                    ),
                    Container(height: 20, width: 1, color: AppColors.divider),
                    _HeaderButton(
                      icon: Icons.add_circle_outline_rounded,
                      label: l10n?.translate('add') ?? 'إضافة',
                      color: AppColors.primary,
                      onTap: () async {
                        await Navigator.pushNamed(context, '/manage-zikir');
                        if (context.mounted) {
                          context.read<ZikirCubit>().loadCategories();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          ..._buildBodySlivers(context),
        ],
      ),
    );
  }

  List<Widget> _buildBodySlivers(BuildContext context) {
    return [
      SliverToBoxAdapter(child: _buildDailyReminder(context)),
      SliverToBoxAdapter(child: _buildStatsRow(context)),
      SliverToBoxAdapter(child: _buildQuickTasbeeh(context)),
      SliverToBoxAdapter(child: _buildCategoriesSection(context)),
      _buildCategoriesList(context),
      SliverToBoxAdapter(child: _buildFavoritesSection(context)),
      SliverToBoxAdapter(child: _buildQuranQuote(context)),
      const SliverToBoxAdapter(child: SizedBox(height: 110)),
    ];
  }

  Widget _buildSectionTitle({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 9),
              Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          if (actionLabel != null && onAction != null)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onAction,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      Text(
                        actionLabel,
                        style: GoogleFonts.cairo(
                          color: AppColors.primary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDailyReminder(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hour = DateTime.now().hour;
    final isMorning = hour < 12;

    String greeting;
    IconData iconData;
    if (hour < 12) {
      greeting = l10n?.translate('morningGreeting') ?? 'صباح النور';
      iconData = Icons.wb_sunny_rounded;
    } else if (hour < 17) {
      greeting = l10n?.translate('eveningGreeting') ?? 'مساء النور';
      iconData = Icons.wb_twilight_rounded;
    } else {
      greeting = l10n?.translate('nightGreeting') ?? 'مساء الخير';
      iconData = Icons.nightlight_rounded;
    }

    final cardColor = isMorning ? const Color(0xFF4A9B7E) : const Color(0xFF3A7A5E);
    final cardColorLight = isMorning ? const Color(0xFF5BB896) : const Color(0xFF4A9B7E);

    return GestureDetector(
      onTap: () =>
          _navigateToZikrCategory(context, isMorning ? 'morning' : 'evening'),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cardColorLight, cardColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: cardColor.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(iconData, size: 13, color: Colors.white),
                  const SizedBox(width: 5),
                  Text(
                    greeting,
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isMorning
                  ? (l10n?.translate('morningAzkar') ?? 'أذكار الصباح')
                  : (l10n?.translate('eveningAzkar') ?? 'أذكار المساء'),
              style: GoogleFonts.cairo(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              '${l10n?.translate('donotForgetAzkar') ?? 'ولا تنسَ الأذكار'} 🤲',
              style: GoogleFonts.cairo(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n?.translate('startNow') ?? 'ابدأ الآن',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryVariant,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 15,
                    color: AppColors.primaryVariant,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToZikrCategory(BuildContext context, String type) {
    final zikirCubit = context.read<ZikirCubit>();
    final l10n = AppLocalizations.of(context);
    final isMorning = type == 'morning';
    final categoryName = isMorning
        ? (l10n?.translate('morningAzkar') ?? 'أذكار الصباح')
        : (l10n?.translate('eveningAzkar') ?? 'أذكار المساء');
    zikirCubit.loadZikirsByCategoryType(type);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: zikirCubit,
          child: ZikirDetailPage(categoryName: categoryName),
        ),
      ),
    );
  }

  void _navigateToFavorites(BuildContext context) {
    onSwitchToFavorites?.call();
  }

  void _navigateToHistory(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tasbeehCubit = di.sl<TasbeehCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => BlocProvider.value(
        value: tasbeehCubit,
        child: BlocBuilder<TasbeehCubit, TasbeehState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryVariant],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.history_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n?.translate('history') ?? 'السجل',
                    style: GoogleFonts.cairo(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildHistoryStat(
                    icon: Icons.touch_app_rounded,
                    label:
                        l10n?.translate('totalTasbeeh') ?? 'إجمالي التسبيحات',
                    value: '${state.totalCount}',
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 10),
                  _buildHistoryStat(
                    icon: Icons.local_fire_department_rounded,
                    label:
                        l10n?.translate('currentStreak') ?? 'السلسلة الحالية',
                    value:
                        '${state.streakDays} ${l10n?.translate('day') ?? 'يوم'}',
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 10),
                  _buildHistoryStat(
                    icon: Icons.calendar_today_rounded,
                    label: l10n?.translate('todayProgress') ?? 'تقدم اليوم',
                    value: '${state.count}',
                    color: Colors.green,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHistoryStat({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tasbeehCubit = di.sl<TasbeehCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: BlocProvider.value(
        value: tasbeehCubit,
        child: BlocBuilder<TasbeehCubit, TasbeehState>(
          builder: (context, state) {
            return Skeletonizer(
              enabled: state.isLoading,
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.touch_app_rounded,
                      label: l10n?.translate('today') ?? 'اليوم',
                      value: '${state.count}',
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.local_fire_department_rounded,
                      label: l10n?.translate('streak') ?? 'السلسلة',
                      value: '${state.streakDays}',
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.stars_rounded,
                      label: l10n?.translate('total') ?? 'الإجمالي',
                      value: '${state.totalCount}',
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuickTasbeeh(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tasbeehCubit = di.sl<TasbeehCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: BlocProvider.value(
        value: tasbeehCubit,
        child: BlocBuilder<TasbeehCubit, TasbeehState>(
          builder: (context, state) {
            return Skeletonizer(
              enabled: state.isLoading,
              child: _QuickTasbeehCard(
                count: state.count,
                target: state.target,
                isLoading: state.isLoading,
                onIncrement: () => tasbeehCubit.increment(),
                l10n: l10n,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _buildSectionTitle(
      icon: Icons.grid_view_rounded,
      iconColor: AppColors.primary,
      iconBg: AppColors.primary.withValues(alpha: 0.1),
      title: l10n?.translate('categories') ?? 'تصنيفات الأذكار',
      actionLabel: l10n?.translate('viewAll') ?? 'عرض الكل',
      onAction: () => _navigateToCategories(context),
    );
  }

  void _navigateToCategories(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ZikirCubit>(),
          child: const ZikirCategoriesPage(),
        ),
      ),
    );
  }

  Widget _buildCategoriesList(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ZikirCubit, ZikirState>(
      builder: (context, state) {
        final isLoading = state.status == ZikirStatus.loading;
        final categories = isLoading ? _dummyCategories : state.categories;
        if (state.categories.isEmpty && !isLoading) {
          return SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.folder_open_rounded,
                      size: 36,
                      color: AppColors.primary.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n?.translate('noCategories') ?? 'لا توجد تصنيفات',
                    style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n?.translate('addCategoryFirst') ?? 'أضف تصنيفاً أولاً',
                    style: GoogleFonts.cairo(fontSize: 12, color: AppColors.muted),
                  ),
                ],
              ),
            ),
          );
        }
        return SliverToBoxAdapter(
          child: Skeletonizer(
            enabled: isLoading,
            child: SizedBox(
              height: 118,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _CategoryChip(category: category, onTap: () => _navigateToCategory(context, category));
                },
              ),
            ),
          ),
        );
      },
    );
  }

  static const _dummyCategories = <ZikirCategory>[
    ZikirCategory(id: '1', name: 'Morning', nameAr: 'أذكار الصباح', icon: 'wb_sunny', colorHex: '#FF9800', zikirCount: 20),
    ZikirCategory(id: '2', name: 'Evening', nameAr: 'أذكار المساء', icon: 'nightlight', colorHex: '#5C6BC0', zikirCount: 15),
    ZikirCategory(id: '3', name: 'Sleep', nameAr: 'أذكار النوم', icon: 'bedtime', colorHex: '#9C27B0', zikirCount: 10),
    ZikirCategory(id: '4', name: 'Quran', nameAr: 'آيات قرآنية', icon: 'menu_book', colorHex: '#4CAF50', zikirCount: 25),
    ZikirCategory(id: '5', name: 'Praise', nameAr: 'الحمد والشكر', icon: 'favorite', colorHex: '#F44336', zikirCount: 8),
  ];

  static final _dummyFavorites = List.filled(
    3,
    const Zikir(
      id: 'd',
      text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      count: 100,
      categoryName: 'أذكار الصباح',
      categoryId: 'morning',
      isFavorite: true,
    ),
  );

  void _navigateToCategory(BuildContext context, ZikirCategory category) {
    context.read<ZikirCubit>().loadZikirsByCategory(category.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ZikirCubit>(),
          child: ZikirDetailPage(categoryName: category.nameAr),
        ),
      ),
    );
  }

Widget _buildFavoritesSection(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ZikirCubit, ZikirState>(
      builder: (context, state) {
        final isLoading = state.favoriteZikirs.isEmpty && state.status == ZikirStatus.loading;
        final favorites = isLoading ? _dummyFavorites : state.favoriteZikirs;
        final showEmpty = state.favoriteZikirs.isEmpty && !isLoading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(
              icon: Icons.favorite_rounded,
              iconColor: AppColors.error,
              iconBg: AppColors.error.withValues(alpha: 0.1),
              title: l10n?.translate('favorites') ?? 'المفضلة',
              actionLabel: !showEmpty
                  ? (l10n?.translate('viewAll') ?? 'عرض الكل')
                  : null,
              onAction: !showEmpty
                  ? () => _navigateToFavorites(context)
                  : null,
            ),
            if (showEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          Icons.favorite_border_rounded,
                          color: AppColors.error.withValues(alpha: 0.4),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n?.translate('favoriteAzkarEmpty') ??
                                  'لم تضف أذكاراً للمفضلة بعد',
                              style: GoogleFonts.cairo(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n?.translate('addFromCategories') ??
                                  'أضف من التصنيفات',
                              style: GoogleFonts.cairo(
                                fontSize: 12,
                                color: AppColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Skeletonizer(
                enabled: isLoading,
                child: SizedBox(
                  height: 108,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: favorites.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final zikir = favorites[index];
                      return _FavoriteCard(
                        title: zikir.text,
                        subtitle:
                            '${zikir.count} ${l10n?.translate('times') ?? 'مرة'}',
                        source: zikir.categoryName,
                      );
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildQuranQuote(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dayOfYear = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    final verseIndex = dayOfYear % 5;
    final verses = [
      (
        l10n?.translate('quranVerse1') ?? 'وَأَقِمِ الصَّلَاةَ لِذِكْرِي',
        l10n?.translate('quranSource1') ?? 'سورة طه - آية 14',
      ),
      (
        l10n?.translate('quranVerse2') ?? 'فَاذْكُرُونِي أَذْكُرْكُمْ',
        l10n?.translate('quranSource2') ?? 'سورة البقرة - آية 152',
      ),
      (
        l10n?.translate('quranVerse3') ?? 'وَاذْكُرْ رَبَّكَ فِي نَفْسِكَ',
        l10n?.translate('quranSource3') ?? 'سورة الأعراف - آية 205',
      ),
      (
        l10n?.translate('quranVerse4') ??
            'الَّذِينَ يَذْكُرُونَ اللَّهَ قِيَامًا وَقُعُودًا',
        l10n?.translate('quranSource4') ?? 'سورة آل عمران - آية 191',
      ),
      (
        l10n?.translate('quranVerse5') ??
            'يَا أَيُّهَا الَّذِينَ آمَنُوا اذْكُرُوا اللَّهَ ذِكْرًا كَثِيرًا',
        l10n?.translate('quranSource5') ?? 'سورة الأحزاب - آية 41',
      ),
    ];
    final (verse, source) = verses[verseIndex];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 22, 20, 0),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, AppColors.primary.withValues(alpha: 0.04)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.1),
                  AppColors.primary.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.auto_stories_rounded,
                  color: AppColors.primary,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                  l10n?.translate('quranQuote') ?? 'قال الله تعالى',
                  style: GoogleFonts.cairo(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            verse,
            style: GoogleFonts.amiri(
              fontSize: 20,
              color: AppColors.textPrimary,
              height: 1.7,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              source,
              style: GoogleFonts.cairo(
                fontSize: 11,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _HeaderButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 4),
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.15),
                  color.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 10,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? source;
  const _FavoriteCard({
    required this.title,
    required this.subtitle,
    this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: AppColors.error,
                  size: 13,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (source != null) ...[
            const SizedBox(height: 3),
            Text(
              source!,
              style: const TextStyle(fontSize: 9, color: AppColors.muted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final ZikirCategory category;
  final VoidCallback onTap;
  const _CategoryChip({required this.category, required this.onTap});

  IconData _getIcon() {
    switch (category.icon) {
      case 'wb_sunny':
        return Icons.wb_sunny_rounded;
      case 'nightlight':
        return Icons.nightlight_rounded;
      case 'bedtime':
        return Icons.bedtime_rounded;
      case 'menu_book':
        return Icons.menu_book_rounded;
      case 'store':
        return Icons.store_rounded;
      case 'touch_app':
        return Icons.touch_app_rounded;
      case 'mosque':
        return Icons.mosque_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  Color _getColor() {
    try {
      final hex = category.colorHex.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = _getColor();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 88,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: color.withValues(alpha: 0.06), width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.16),
                    color.withValues(alpha: 0.04),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_getIcon(), color: color, size: 20),
            ),
            const SizedBox(height: 6),
            Text(
              category.nameAr,
              style: GoogleFonts.cairo(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              '${category.zikirCount} ${l10n?.translate('azkar') ?? 'أذكار'}',
              style: GoogleFonts.cairo(
                fontSize: 8,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickTasbeehCard extends StatefulWidget {
  final int count;
  final int target;
  final bool isLoading;
  final VoidCallback onIncrement;
  final AppLocalizations? l10n;

  const _QuickTasbeehCard({
    required this.count,
    required this.target,
    required this.isLoading,
    required this.onIncrement,
    this.l10n,
  });

  @override
  State<_QuickTasbeehCard> createState() => _QuickTasbeehCardState();
}

class _QuickTasbeehCardState extends State<_QuickTasbeehCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onIncrement();
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.target > 0
        ? (widget.count / widget.target).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.primary,
                        size: 13,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.l10n?.translate('quickTasbeeh') ?? 'تسبيحة سريعة',
                        style: GoogleFonts.cairo(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.count}',
                      style: GoogleFonts.cairo(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '/ ${widget.target}',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress >= 1.0 ? AppColors.secondary : AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.l10n?.translate('todaysTasbeeh') ?? 'من تسبيحتك اليوم',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              ScaleTransition(
                scale: _scaleAnim,
                child: GestureDetector(
                  onTap: _onTap,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryVariant],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.l10n?.translate('tap') ?? 'اضغط',
                style: GoogleFonts.cairo(
                  fontSize: 9,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
