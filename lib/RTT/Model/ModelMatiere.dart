class Matiere {
  final int id;
  final String nom;
  final String createdAt;
  final String updatedAt;
  final int enseignantsCount;
  final int classesCount;

  Matiere({
    required this.id,
    required this.nom,
    required this.createdAt,
    required this.updatedAt,
    required this.enseignantsCount,
    required this.classesCount,
  });

  factory Matiere.fromJson(Map<String, dynamic> json) {
    return Matiere(
      id: json['id'],
      nom: json['nom'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      enseignantsCount: json['enseignants_count'],
      classesCount: json['classes_count'],
    );
  }
}
