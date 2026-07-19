import 'package:equatable/equatable.dart';

class ZikirCategory extends Equatable {
  final String id;
  final String name;
  final String nameAr;
  final String icon;
  final String colorHex;
  final int zikirCount;
  final String description;
  final String type;

  const ZikirCategory({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.icon,
    required this.colorHex,
    required this.zikirCount,
    this.description = '',
    this.type = '',
  });

  ZikirCategory copyWith({
    String? id,
    String? name,
    String? nameAr,
    String? icon,
    String? colorHex,
    int? zikirCount,
    String? description,
    String? type,
  }) {
    return ZikirCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      icon: icon ?? this.icon,
      colorHex: colorHex ?? this.colorHex,
      zikirCount: zikirCount ?? this.zikirCount,
      description: description ?? this.description,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [id, name, nameAr, icon, colorHex, zikirCount, description, type];
}