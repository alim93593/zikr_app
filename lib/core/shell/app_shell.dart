import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikr_app/core/di/injection_container.dart' as di;
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';
import 'package:zikr_app/features/zikir/presentation/cubit/zikir_cubit.dart';

import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/tasbeeh/presentation/pages/tasbeeh_page.dart';

final appShellKey = GlobalKey<_AppShellState>();

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;
  late final ZikirCubit _zikirCubit;

  void switchToTab(int index) {
    HapticFeedback.selectionClick();
    setState(() => _currentIndex = index);
  }

  @override
  void initState() {
    super.initState();
    _zikirCubit = di.sl<ZikirCubit>()
      ..loadCategories()
      ..loadFavoriteZikirs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ZikirCubit>.value(
      value: _zikirCubit,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeTab(onSwitchTab: switchToTab),
            FavoritesTab(onExploreAzkar: () => switchToTab(0)),
            const TasbeehTab(),
            const SettingsTab(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: Builder(
          builder: (navContext) => _buildBottomNav(navContext),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: l10n?.translate('home') ?? 'الرئيسية',
                isSelected: _currentIndex == 0,
                onTap: () => _onTabTapped(0),
              ),
              _NavItem(
                icon: Icons.favorite_rounded,
                label: l10n?.translate('favorites') ?? 'المفضلة',
                isSelected: _currentIndex == 1,
                onTap: () => _onTabTapped(1),
              ),
              _NavItem(
                icon: Icons.touch_app_rounded,
                label: l10n?.translate('tasbeeh') ?? 'التسبيح',
                isSelected: _currentIndex == 2,
                onTap: () => _onTabTapped(2),
              ),

              _NavItem(
                icon: Icons.settings_rounded,
                label: l10n?.translate('settings') ?? 'الإعدادات',
                isSelected: _currentIndex == 3,
                onTap: () => _onTabTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() => _currentIndex = index);
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.muted,
                size: 22,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final void Function(int) onSwitchTab;
  const HomeTab({super.key, required this.onSwitchTab});

  @override
  Widget build(BuildContext context) {
    return HomePage(onSwitchToFavorites: () => onSwitchTab(1));
  }
}

class TasbeehTab extends StatelessWidget {
  const TasbeehTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const TasbeehPage();
  }
}

class FavoritesTab extends StatelessWidget {
  final VoidCallback? onExploreAzkar;
  const FavoritesTab({super.key, this.onExploreAzkar});

  @override
  Widget build(BuildContext context) {
    return FavoritesPage(onExploreAzkar: onExploreAzkar);
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsPage();
  }
}
