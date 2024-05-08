class Societe {
  final int id;
  final String nom;
  final String image;
  final String aPropos;
  final String adresse;
  final String email;
  final String telephone;
  final String siteWeb;
  final String createdAt;
  final String updatedAt;

  Societe({
    required this.id,
    required this.nom,
    required this.image,
    required this.aPropos,
    required this.adresse,
    required this.email,
    required this.telephone,
    required this.siteWeb,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Societe.fromJson(Map<String, dynamic> json) {
    return Societe(
      id: json['id'],
      nom: json['nom'],
      image: json['image'],
      aPropos: json['a_propos'],
      adresse: json['adresse'],
      email: json['email'],
      telephone: json['telephone'],
      siteWeb: json['site_web'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
