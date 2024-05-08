class Classe {
  int id;
  int typeId;
  String nom;
  String createdAt;
  String updatedAt;
  int etudiantsCount;
  ClasseType type;

  Classe({
    required this.id,
    required this.typeId,
    required this.nom,
    required this.createdAt,
    required this.updatedAt,
    required this.etudiantsCount,
    required this.type,
  });

  factory Classe.fromJson(Map<String, dynamic> json) {
    return Classe(
      id: json['id'],
      typeId: json['type_id'],
      nom: json['nom'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      etudiantsCount: json['etudiants_count'],
      type: ClasseType.fromJson(json['type']),
    );
  }
}

class ClasseType {
  int id;
  String type;

  ClasseType({
    required this.id,
    required this.type,
  });

  factory ClasseType.fromJson(Map<String, dynamic> json) {
    return ClasseType(
      id: json['id'],
      type: json['type'],
    );
  }
}
