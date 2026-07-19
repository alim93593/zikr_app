import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_app/core/theme/app_colors.dart';
import 'package:zikr_app/l10n/app_localizations.dart';

class ColorOption extends StatelessWidget {
  final int color;
  final int selected;
  final Function(int) onSelect;

  const ColorOption({
    super.key,
    required this.color,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = color == selected;
    final col = Color(color);
    return GestureDetector(
      onTap: () => onSelect(color),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: col,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: col.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 1)]
              : [BoxShadow(color: col.withValues(alpha: 0.3), blurRadius: 4)],
        ),
        child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 20) : null,
      ),
    );
  }
}

class ManageZikirPage extends StatefulWidget {
  const ManageZikirPage({super.key});

  @override
  State<ManageZikirPage> createState() => _ManageZikirPageState();
}

class _ManageZikirPageState extends State<ManageZikirPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _firestore = FirebaseFirestore.instance;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _userId = FirebaseAuth.instance.currentUser?.uid;
  }

  String get _userCollectionPath => 'users/$_userId/categories';

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.cairo(fontSize: 14, color: AppColors.textPrimary),
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.cairo(fontSize: 13, color: AppColors.muted),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final nameController = TextEditingController();
    final nameEnController = TextEditingController();
    final descController = TextEditingController();
    String selectedIcon = 'category';
    int selectedColor = 0xFF2196F3;
    String selectedType = '';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.create_new_folder_outlined, color: AppColors.primary, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'إضافة تصنيف جديد',
                      style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Divider(color: AppColors.divider.withValues(alpha: 0.6), thickness: 1),
                const SizedBox(height: 8),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        _buildSectionLabel('الاسم بالعربية'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: nameController, hintText: 'مثال: أذكار الصباح'),
                        const SizedBox(height: 14),
                        _buildSectionLabel('الاسم بالإنجليزية'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: nameEnController, hintText: 'Example: Morning Azkar'),
                        const SizedBox(height: 14),
                        _buildSectionLabel('الوصف'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: descController, hintText: 'وصف التصنيف', maxLines: 2),
                        const SizedBox(height: 18),
                        _buildSectionLabel('اختر الأيقونة'),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _iconOption(Icons.wb_sunny, 'wb_sunny', selectedIcon, (v) => setState(() => selectedIcon = v)),
                            _iconOption(Icons.nightlight, 'nightlight', selectedIcon, (v) => setState(() => selectedIcon = v)),
                            _iconOption(Icons.bedtime, 'bedtime', selectedIcon, (v) => setState(() => selectedIcon = v)),
                            _iconOption(Icons.menu_book, 'menu_book', selectedIcon, (v) => setState(() => selectedIcon = v)),
                            _iconOption(Icons.store, 'store', selectedIcon, (v) => setState(() => selectedIcon = v)),
                            _iconOption(Icons.mosque, 'mosque', selectedIcon, (v) => setState(() => selectedIcon = v)),
                            _iconOption(Icons.touch_app, 'touch_app', selectedIcon, (v) => setState(() => selectedIcon = v)),
                          ],
                        ),
                        const SizedBox(height: 18),
                        _buildSectionLabel('نوع التصنيف'),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _TypeChip('بدون', '', selectedType, (v) => setState(() => selectedType = v)),
                            _TypeChip('صباح', 'morning', selectedType, (v) => setState(() => selectedType = v)),
                            _TypeChip('مساء', 'evening', selectedType, (v) => setState(() => selectedType = v)),
                            _TypeChip('نوم', 'sleep', selectedType, (v) => setState(() => selectedType = v)),
                          ],
                        ),
                        const SizedBox(height: 18),
                        _buildSectionLabel('اختر اللون'),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            ColorOption(color: 0xFFFF9800, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF3F51B5, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF673AB7, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF4CAF50, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF795548, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF607D8B, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Divider(color: AppColors.divider.withValues(alpha: 0.6), thickness: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('إلغاء', style: GoogleFonts.cairo(color: AppColors.muted, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 46,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          onPressed: () async {
                            if (nameController.text.isEmpty) return;
                            await _firestore.collection(_userCollectionPath).add({
                              'name': nameController.text,
                              'nameEn': nameEnController.text,
                              'description': descController.text,
                              'icon': selectedIcon,
                              'color': selectedColor,
                              'type': selectedType,
                              'order': DateTime.now().millisecondsSinceEpoch,
                              'createdAt': FieldValue.serverTimestamp(),
                            });
                            if (ctx.mounted) Navigator.pop(ctx);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.add, color: Colors.white, size: 18),
                              const SizedBox(width: 6),
                              Text('إضافة', style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconOption(
    IconData icon,
    String value,
    String selected,
    Function(String) onSelect,
  ) {
    final isSelected = value == selected;
    return GestureDetector(
      onTap: () => onSelect(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.12) : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: AppColors.primary, width: 2) : Border.all(color: Colors.transparent),
        ),
        child: Icon(icon, color: isSelected ? AppColors.primary : AppColors.muted, size: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.06),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n?.translate('manageZikir') ?? 'إدارة الأذكار',
          style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.muted,
              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(5),
              labelStyle: GoogleFonts.cairo(fontWeight: FontWeight.w700, fontSize: 14),
              unselectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.w600, fontSize: 14),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.folder_outlined, size: 18),
                        const SizedBox(width: 8),
                        Text(l10n?.translate('categories') ?? 'التصنيفات'),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.menu_book_outlined, size: 18),
                        const SizedBox(width: 8),
                        Text(l10n?.translate('azkar') ?? 'الأذكار'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _CategoriesTab(
            firestore: _firestore,
            onAddPressed: () => _showAddCategoryDialog(context),
            userCollectionPath: _userCollectionPath,
          ),
          _ZikrsTab(
            firestore: _firestore,
            userCollectionPath: _userCollectionPath,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          if (_tabController.index == 0) {
            _showAddCategoryDialog(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n?.translate('selectCategoryFromTab') ?? 'اختر تصنيفاً من تب الأذكار ثم اضغط +', style: GoogleFonts.cairo()),
                backgroundColor: AppColors.secondary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final String value;
  final String selected;
  final Function(String) onSelect;

  const _TypeChip(this.label, this.value, this.selected, this.onSelect);

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == value;
    return GestureDetector(
      onTap: () => onSelect(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider, width: 1.5),
        ),
        child: Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 13,
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _CategoriesTab extends StatelessWidget {
  final FirebaseFirestore firestore;
  final VoidCallback onAddPressed;
  final String userCollectionPath;

  const _CategoriesTab({
    required this.firestore,
    required this.onAddPressed,
    required this.userCollectionPath,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(userCollectionPath).orderBy('order').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.folder_open_rounded, size: 48, color: AppColors.primary),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n?.translate('noCategories') ?? 'لا توجد تصنيفات',
                    style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n?.translate('addCategoryFirst') ?? 'أضف تصنيفاً جديداً للبدء في تنظيم الأذكار',
                    style: GoogleFonts.cairo(fontSize: 14, color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: onAddPressed,
                      icon: const Icon(Icons.add, color: Colors.white, size: 20),
                      label: Text(l10n?.translate('addCategory') ?? 'إضافة تصنيف', style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w700)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final categories = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final data = category.data() as Map<String, dynamic>;
            return _CategoryCard(
              id: category.id,
              name: data['name'] ?? '',
              nameEn: data['nameEn'] ?? '',
              description: data['description'] ?? '',
              icon: data['icon'] ?? 'category',
              color: data['color'] ?? 0xFF2196F3,
              type: data['type'] ?? '',
              firestore: firestore,
              userCollectionPath: userCollectionPath,
            );
          },
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String id;
  final String name;
  final String nameEn;
  final String description;
  final String icon;
  final int color;
  final String type;
  final FirebaseFirestore firestore;
  final String userCollectionPath;

  const _CategoryCard({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.description,
    required this.icon,
    required this.color,
    required this.type,
    required this.firestore,
    required this.userCollectionPath,
  });

  IconData _getIcon() {
    switch (icon) {
      case 'wb_sunny': return Icons.wb_sunny;
      case 'nightlight': return Icons.nightlight;
      case 'bedtime': return Icons.bedtime;
      case 'menu_book': return Icons.menu_book;
      case 'store': return Icons.store;
      case 'mosque': return Icons.mosque;
      case 'touch_app': return Icons.touch_app;
      default: return Icons.category;
    }
  }

  String _typeLabel() {
    switch (type) {
      case 'morning': return 'صباح';
      case 'evening': return 'مساء';
      case 'sleep': return 'نوم';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final col = Color(color);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border(left: BorderSide(color: col, width: 5)),
        boxShadow: [
          BoxShadow(
            color: col.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: col.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(_getIcon(), color: col, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: GoogleFonts.cairo(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.textPrimary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (_typeLabel().isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: col.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _typeLabel(),
                                style: GoogleFonts.cairo(fontSize: 10, fontWeight: FontWeight.w700, color: col),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: GoogleFonts.cairo(fontSize: 12, color: AppColors.textSecondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.divider.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.more_horiz, size: 18, color: AppColors.textSecondary),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 4,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      height: 42,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.edit_outlined, size: 18, color: AppColors.primary),
                          ),
                          const SizedBox(width: 12),
                          Text('تعديل', style: GoogleFonts.cairo(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      onTap: () => _showEditDialog(context),
                    ),
                    PopupMenuItem(
                      height: 42,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                          ),
                          const SizedBox(width: 12),
                          Text('حذف', style: GoogleFonts.cairo(fontWeight: FontWeight.w600, color: AppColors.error)),
                        ],
                      ),
                      onTap: () => _showDeleteDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final nameController = TextEditingController(text: name);
    final nameEnController = TextEditingController(text: nameEn);
    final descController = TextEditingController(text: description);
    String selectedType = type;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'تعديل التصنيف',
                      style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Divider(color: AppColors.divider.withValues(alpha: 0.6), thickness: 1),
                const SizedBox(height: 12),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('الاسم بالعربية'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: nameController, hintText: 'مثال: أذكار الصباح'),
                        const SizedBox(height: 14),
                        _buildSectionLabel('الاسم بالإنجليزية'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: nameEnController, hintText: 'Example: Morning Azkar'),
                        const SizedBox(height: 14),
                        _buildSectionLabel('الوصف'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: descController, hintText: 'وصف التصنيف', maxLines: 2),
                        const SizedBox(height: 14),
                        _buildSectionLabel('نوع التصنيف'),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _TypeChip('بدون', '', selectedType, (v) => setState(() => selectedType = v)),
                            _TypeChip('صباح', 'morning', selectedType, (v) => setState(() => selectedType = v)),
                            _TypeChip('مساء', 'evening', selectedType, (v) => setState(() => selectedType = v)),
                            _TypeChip('نوم', 'sleep', selectedType, (v) => setState(() => selectedType = v)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Divider(color: AppColors.divider.withValues(alpha: 0.6), thickness: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('إلغاء', style: GoogleFonts.cairo(color: AppColors.muted, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 46,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          onPressed: () async {
                            await firestore.collection(userCollectionPath).doc(id).update({
                              'name': nameController.text,
                              'nameEn': nameEnController.text,
                              'description': descController.text,
                              'type': selectedType,
                            });
                            if (ctx.mounted) Navigator.pop(ctx);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.save_rounded, color: Colors.white, size: 18),
                              const SizedBox(width: 6),
                              Text('حفظ', style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.cairo(fontSize: 14, color: AppColors.textPrimary),
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.cairo(fontSize: 13, color: AppColors.muted),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.delete_forever_rounded, color: AppColors.error, size: 32),
              ),
              const SizedBox(height: 20),
              Text(
                'حذف التصنيف',
                style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'هل أنت متأكد من حذف "$name"؟',
                style: GoogleFonts.cairo(fontSize: 14, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.error.withValues(alpha: 0.15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber_rounded, size: 16, color: AppColors.error),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'سيتم حذف جميع الأذكار بداخله',
                        style: GoogleFonts.cairo(fontSize: 12, color: AppColors.error, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          side: BorderSide(color: AppColors.divider),
                        ),
                        child: Text('إلغاء', style: GoogleFonts.cairo(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          await firestore.collection(userCollectionPath).doc(id).delete();
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: Text('حذف', style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ZikrsTab extends StatelessWidget {
  final FirebaseFirestore firestore;
  final String userCollectionPath;

  const _ZikrsTab({required this.firestore, required this.userCollectionPath});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(userCollectionPath).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.menu_book_rounded, size: 48, color: AppColors.secondary),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n?.translate('noCategories') ?? 'لا توجد تصنيفات',
                    style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n?.translate('selectCategoryFromTab') ?? 'أضف تصنيفات من تب التصنيفات أولاً',
                    style: GoogleFonts.cairo(fontSize: 14, color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        final categories = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final data = category.data() as Map<String, dynamic>;
            return _CategoryZikrsSection(
              categoryId: category.id,
              categoryName: data['name'] ?? '',
              categoryColor: data['color'] ?? 0xFF2196F3,
              firestore: firestore,
              userCollectionPath: userCollectionPath,
            );
          },
        );
      },
    );
  }
}

class _CategoryZikrsSection extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final int categoryColor;
  final FirebaseFirestore firestore;
  final String userCollectionPath;

  const _CategoryZikrsSection({
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
    required this.firestore,
    required this.userCollectionPath,
  });

  @override
  Widget build(BuildContext context) {
    final col = Color(categoryColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: col.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: col.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: col, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      categoryName,
                      style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w800, color: col),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _showAddZikirDialog(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [col, col.withValues(alpha: 0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: col.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          'إضافة ذكر',
                          style: GoogleFonts.cairo(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection(userCollectionPath)
              .doc(categoryId)
              .collection('zikrs')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.menu_book_outlined, size: 32, color: AppColors.muted.withValues(alpha: 0.5)),
                      const SizedBox(height: 8),
                      Text(
                        'لا توجد أذكار',
                        style: GoogleFonts.cairo(fontSize: 13, color: AppColors.muted, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final zikir = snapshot.data!.docs[index];
                final data = zikir.data() as Map<String, dynamic>;
                return _ZikirCard(
                  id: zikir.id,
                  categoryId: categoryId,
                  text: data['text'] ?? '',
                  count: data['count'] ?? 0,
                  source: data['source'] ?? '',
                  color: data['color'] ?? categoryColor,
                  firestore: firestore,
                  userCollectionPath: userCollectionPath,
                );
              },
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.cairo(fontSize: 14, color: AppColors.textPrimary),
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.cairo(fontSize: 13, color: AppColors.muted),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  void _showAddZikirDialog(BuildContext context) {
    final textController = TextEditingController();
    final countController = TextEditingController(text: '1');
    final sourceController = TextEditingController();
    int selectedColor = categoryColor;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(categoryColor).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(Icons.auto_awesome, color: Color(categoryColor), size: 22),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'إضافة ذكر جديد',
                      style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Divider(color: AppColors.divider.withValues(alpha: 0.6), thickness: 1),
                const SizedBox(height: 12),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('نص الذكر'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: textController, hintText: 'أدخل نص الذكر', maxLines: 3),
                        const SizedBox(height: 14),
                        _buildSectionLabel('عدد مرات الذكر'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: countController, hintText: 'مثال: 33', keyboardType: TextInputType.number),
                        const SizedBox(height: 14),
                        _buildSectionLabel('المصدر'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: sourceController, hintText: 'مثال: صحيح البخاري'),
                        const SizedBox(height: 18),
                        _buildSectionLabel('اختر لون العرض'),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            ColorOption(color: 0xFFFF9800, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF3F51B5, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF673AB7, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF4CAF50, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFFE91E63, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF795548, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF2196F3, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Divider(color: AppColors.divider.withValues(alpha: 0.6), thickness: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('إلغاء', style: GoogleFonts.cairo(color: AppColors.muted, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 46,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          onPressed: () async {
                            if (textController.text.isEmpty) return;
                            await firestore
                                .collection(userCollectionPath)
                                .doc(categoryId)
                                .collection('zikrs')
                                .add({
                              'text': textController.text,
                              'count': int.tryParse(countController.text) ?? 1,
                              'source': sourceController.text,
                              'color': selectedColor,
                              'createdAt': FieldValue.serverTimestamp(),
                            });
                            if (ctx.mounted) Navigator.pop(ctx);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.add, color: Colors.white, size: 18),
                              const SizedBox(width: 6),
                              Text('إضافة', style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ],
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

class _ZikirCard extends StatelessWidget {
  final String id;
  final String categoryId;
  final String text;
  final int count;
  final String source;
  final int color;
  final FirebaseFirestore firestore;
  final String userCollectionPath;

  const _ZikirCard({
    required this.id,
    required this.categoryId,
    required this.text,
    required this.count,
    required this.source,
    required this.color,
    required this.firestore,
    required this.userCollectionPath,
  });

  @override
  Widget build(BuildContext context) {
    final col = Color(color);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: col, width: 5)),
        boxShadow: [
          BoxShadow(
            color: col.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: col.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '$count',
                      style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w800, color: col),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.4),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (source.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.auto_stories, size: 12, color: AppColors.muted),
                            const SizedBox(width: 4),
                            Text(
                              source,
                              style: GoogleFonts.cairo(fontSize: 11, color: AppColors.muted, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.divider.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.more_horiz, size: 18, color: AppColors.textSecondary),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 4,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      height: 42,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.edit_outlined, size: 18, color: AppColors.primary),
                          ),
                          const SizedBox(width: 12),
                          Text('تعديل', style: GoogleFonts.cairo(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      onTap: () => _showEditDialog(context),
                    ),
                    PopupMenuItem(
                      height: 42,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                          ),
                          const SizedBox(width: 12),
                          Text('حذف', style: GoogleFonts.cairo(fontWeight: FontWeight.w600, color: AppColors.error)),
                        ],
                      ),
                      onTap: () => _showDeleteDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final textController = TextEditingController(text: text);
    final countController = TextEditingController(text: count.toString());
    final sourceController = TextEditingController(text: source);
    int selectedColor = color;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'تعديل الذكر',
                      style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Divider(color: AppColors.divider.withValues(alpha: 0.6), thickness: 1),
                const SizedBox(height: 12),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('نص الذكر'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: textController, hintText: 'أدخل نص الذكر', maxLines: 3),
                        const SizedBox(height: 14),
                        _buildSectionLabel('عدد مرات الذكر'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: countController, hintText: 'مثال: 33', keyboardType: TextInputType.number),
                        const SizedBox(height: 14),
                        _buildSectionLabel('المصدر'),
                        const SizedBox(height: 8),
                        _buildInputField(controller: sourceController, hintText: 'مثال: صحيح البخاري'),
                        const SizedBox(height: 18),
                        _buildSectionLabel('اختر لون العرض'),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            ColorOption(color: 0xFFFF9800, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF3F51B5, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF673AB7, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF4CAF50, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFFE91E63, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF795548, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                            ColorOption(color: 0xFF2196F3, selected: selectedColor, onSelect: (v) => setState(() => selectedColor = v)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Divider(color: AppColors.divider.withValues(alpha: 0.6), thickness: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('إلغاء', style: GoogleFonts.cairo(color: AppColors.muted, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 46,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          onPressed: () async {
                            await firestore
                                .collection(userCollectionPath)
                                .doc(categoryId)
                                .collection('zikrs')
                                .doc(id)
                                .update({
                              'text': textController.text,
                              'count': int.tryParse(countController.text) ?? 1,
                              'source': sourceController.text,
                              'color': selectedColor,
                            });
                            if (ctx.mounted) Navigator.pop(ctx);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.save_rounded, color: Colors.white, size: 18),
                              const SizedBox(width: 6),
                              Text('حفظ', style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.cairo(fontSize: 14, color: AppColors.textPrimary),
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.cairo(fontSize: 13, color: AppColors.muted),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.delete_forever_rounded, color: AppColors.error, size: 32),
              ),
              const SizedBox(height: 20),
              Text(
                'حذف الذكر',
                style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'هل أنت متأكد من حذف هذا الذكر؟',
                style: GoogleFonts.cairo(fontSize: 14, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          side: BorderSide(color: AppColors.divider),
                        ),
                        child: Text('إلغاء', style: GoogleFonts.cairo(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          await firestore
                              .collection(userCollectionPath)
                              .doc(categoryId)
                              .collection('zikrs')
                              .doc(id)
                              .delete();
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: Text('حذف', style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
