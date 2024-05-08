class Enseignant {
  int id;
  String nom;
  String prenom;
  String email;
  String telephone;
  // Autres propriétés nécessaires

  Enseignant({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    // Initialiser les autres propriétés
  });

  factory Enseignant.fromJson(Map<String, dynamic> json) {
    return Enseignant(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      telephone: json['telephone'],
      // Convertir les autres propriétés du JSON en propriétés du modèle
    );
  }
}