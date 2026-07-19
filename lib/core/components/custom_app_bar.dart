import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleKey;
  final String? title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingTap;
  final List<Widget>? actions;
  final bool showLeading;
  final Color? backgroundColor;
  final Color? titleColor;
  final Widget? leadingWidget;

  const CustomAppBar({
    super.key,
    this.titleKey,
    this.title,
    this.leadingIcon,
    this.onLeadingTap,
    this.actions,
    this.showLeading = true,
    this.backgroundColor,
    this.titleColor,
    this.leadingWidget,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final displayTitle = titleKey != null ? l10n?.translate(titleKey!) : title;

    Widget? leading;

    if (showLeading) {
      if (leadingWidget != null) {
        leading = GestureDetector(
          onTap: onLeadingTap ?? () => Navigator.pop(context),
          child: leadingWidget,
        );
      } else {
        leading = Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: onLeadingTap ?? () => Navigator.pop(context),
            child: Icon(
              leadingIcon ?? Icons.arrow_forward,
              color: AppColors.primary,
              size: 20,
            ),
          ),
        );
      }
    }

    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor ?? AppColors.background,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: leading,
      title: Text(
        displayTitle ?? '',
        style: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: titleColor ?? AppColors.textPrimary,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }
}

class CustomLeadingIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double size;
  final VoidCallback? onTap;

  const CustomLeadingIcon({
    super.key,
    this.icon = Icons.arrow_forward,
    this.color,
    this.size = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
        child: Icon(icon, color: color ?? AppColors.primary, size: size),
      ),
    );
  }
}

class CustomActionIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double size;
  final VoidCallback onTap;

  const CustomActionIcon({
    super.key,
    required this.icon,
    this.color,
    this.size = 24,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        icon: Icon(icon, color: color ?? AppColors.muted, size: size),
        onPressed: onTap,
      ),
    );
  }
}
