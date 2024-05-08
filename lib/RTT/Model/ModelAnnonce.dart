class Annonce {
  final int id;
  final int proprietaireId;
  final int typeUser;
  final String? titre;
  final String description;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likesCount;
  final int dislikesCount;

  Annonce({
    required this.id,
    required this.proprietaireId,
    required this.typeUser,
    this.titre,
    required this.description,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.dislikesCount,
  });

  factory Annonce.fromJson(Map<String, dynamic> json) {
    return Annonce(
      id: json['id'],
      proprietaireId: json['proprietare_id'],
      typeUser: json['type_user'],
      titre: json['titre'],
      description: json['description'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      likesCount: json['likes_count'],
      dislikesCount: json['deslikes_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'proprietare_id': proprietaireId,
      'type_user': typeUser,
      'titre': titre,
      'description': description,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'likes_count': likesCount,
      'deslikes_count': dislikesCount,
    };
  }
}
