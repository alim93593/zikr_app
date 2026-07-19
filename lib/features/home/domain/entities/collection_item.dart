import 'package:equatable/equatable.dart';

class CollectionItem extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String? imageUrl;
  final String? accentHex; // color as hex string, platform-agnostic

  const CollectionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.accentHex,
  });

  @override
  List<Object?> get props => [id, title, subtitle, imageUrl, accentHex];
}
