import '../../domain/entities/collection_item.dart';

class CollectionModel extends CollectionItem {
  const CollectionModel({
    required super.id,
    required super.title,
    required super.subtitle,
    super.imageUrl,
    super.accentHex,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['imageUrl'] as String?,
      accentHex: json['accentHex'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'imageUrl': imageUrl,
    'accentHex': accentHex,
  };
}
