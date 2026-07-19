import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/core/components/custom_app_bar.dart';
import 'package:zikr_app/l10n/app_localizations.dart';
import 'package:zikr_app/features/zikir/domain/entities/zikir.dart';
import 'package:zikr_app/features/zikir/presentation/cubit/zikir_cubit.dart';
import 'package:zikr_app/features/zikir/presentation/cubit/zikir_state.dart';
import '../widgets/favorite_card.dart';
import '../widgets/favorites_empty_state.dart';

class FavoritesPage extends StatelessWidget {
  final VoidCallback? onExploreAzkar;
  const FavoritesPage({super.key, this.onExploreAzkar});

  @override
  Widget build(BuildContext context) {
    return _FavoritesPageBody(onExploreAzkar: onExploreAzkar);
  }
}

class _FavoritesPageBody extends StatelessWidget {
  final VoidCallback? onExploreAzkar;
  const _FavoritesPageBody({this.onExploreAzkar});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        titleKey: 'favorites',
        showLeading: true,
        onLeadingTap: () {},
        leadingWidget: Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.favorite, color: AppColors.primary, size: 20),
        ),
      ),
      body: BlocBuilder<ZikirCubit, ZikirState>(
        builder: (context, state) {
          final isLoading = state.favoriteZikirs.isEmpty && state.status == ZikirStatus.loading;
          final favorites = isLoading ? _dummyFavorites : state.favoriteZikirs;
          final showEmpty = state.favoriteZikirs.isEmpty && !isLoading;

          if (showEmpty) {
            return FavoritesEmptyState(onExplore: onExploreAzkar);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, favorites.length, l10n),
              Expanded(
                child: _buildContent(context, favorites, isLoading, state),
              ),
            ],
          );
        },
      ),
    );
  }

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

  Widget _buildHeader(BuildContext context, int count, AppLocalizations? l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n?.translate('saveFavorites') ?? 'احفظ أذكارك المفضلة للوصول السريع',
              style: GoogleFonts.cairo(fontSize: 13, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_rounded, color: AppColors.error, size: 14),
                const SizedBox(width: 4),
                Text(
                  '$count',
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Zikir> favorites, bool isLoading, ZikirState state) {
    final l10n = AppLocalizations.of(context);
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Dismissible(
              key: Key(item.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(Icons.delete_outline_rounded, color: AppColors.error.withValues(alpha: 0.6), size: 24),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      AppColors.error.withValues(alpha: 0.9),
                      AppColors.error.withValues(alpha: 0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n?.translate('remove') ?? 'إزالة',
                      style: GoogleFonts.cairo(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 22),
                  ],
                ),
              ),
              onDismissed: (_) => context.read<ZikirCubit>().toggleFavorite(item),
              child: FavoriteCard(
                item: item,
                onRemove: () => context.read<ZikirCubit>().toggleFavorite(item),
              ),
            ),
          );
        },
      ),
    );
  }
}