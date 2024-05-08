class Rapport {
  int id;
  String titre;
  String description;
  String annee;
  String fichier;
  String createdAt;
  String updatedAt;

  Rapport({
    required this.id,
    required this.titre,
    required this.description,
    required this.annee,
    required this.fichier,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Rapport.fromJson(Map<String, dynamic> json) {
    return Rapport(
      id: json['id'],
      titre: json['titre'],
      description: json['description'],
      annee: json['annee'],
      fichier: json['fichier'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
