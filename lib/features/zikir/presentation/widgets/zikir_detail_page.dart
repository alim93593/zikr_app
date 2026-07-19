import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/components/custom_app_bar.dart';
import 'package:zikr_app/core/di/injection_container.dart' as di;
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';
import 'package:zikr_app/features/tasbeeh/presentation/cubit/tasbeeh_cubit.dart';
import 'package:zikr_app/features/tasbeeh/presentation/pages/tasbeeh_page.dart';

import '../cubit/zikir_cubit.dart';
import '../cubit/zikir_state.dart';
import 'zikir_detail_card.dart';

class ZikirDetailPage extends StatelessWidget {
  final String categoryName;

  const ZikirDetailPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: categoryName,
      ),
      body: SafeArea(
        child: BlocBuilder<ZikirCubit, ZikirState>(
          builder: (context, state) {
            if (state.status == ZikirStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ZikirStatus.error) {
              return _buildErrorState(context, state.message ?? '');
            }
            if (state.zikirs.isEmpty) {
              return _buildEmptyState(context);
            }
            return _buildZikirList(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildZikirList(BuildContext context, ZikirState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: state.zikirs.length,
      itemBuilder: (context, index) {
        final zikir = state.zikirs[index];
        return ZikirDetailCard(
          text: zikir.text,
          transliteration: zikir.transliteration,
          translation: zikir.translation,
          count: zikir.count,
          category: zikir.categoryName,
          isFavorite: zikir.isFavorite,
          onFavoriteToggle: () =>
              context.read<ZikirCubit>().toggleFavorite(zikir),
          onTap: () => _navigateToTasbeeh(context),
        );
      },
    );
  }

  void _navigateToTasbeeh(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => di.sl<TasbeehCubit>()..loadStats(),
          child: const TasbeehPage(),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book, size: 64, color: AppColors.muted),
          const SizedBox(height: 16),
          Text(
            l10n?.translate('noAzkarInCategory') ?? 'لا توجد أذكار في هذا التصنيف',
            style: GoogleFonts.cairo(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.error),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.cairo(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final state = context.read<ZikirCubit>().state;
              if (state.selectedCategoryId != null) {
                context.read<ZikirCubit>().loadZikirsByCategory(
                  state.selectedCategoryId!,
                );
              }
            },
            child: Text(
              l10n?.translate('tryAgain') ?? 'حاول مرة أخرى',
            ),
          ),
        ],
      ),
    );
  }
}
