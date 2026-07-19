import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/core/components/custom_app_bar.dart';
import '../../domain/entities/collection_item.dart';

class CollectionPage extends StatelessWidget {
  final CollectionItem item;
  const CollectionPage({super.key, required this.item});

  static const routeName = '/collection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        titleKey: item.title,
        titleColor: AppColors.textPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.title, style: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Text(item.subtitle, style: GoogleFonts.cairo(fontSize: 16, color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            if (item.imageUrl != null) Image.network(item.imageUrl!),
          ],
        ),
      ),
    );
  }
}
