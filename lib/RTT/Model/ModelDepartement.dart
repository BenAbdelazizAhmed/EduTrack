class Departement {
  int id;
  String nom;
  String createdAt;
  String updatedAt;
  int enseignantsCount;
  List<ChefDepartement> chefDepartement;

  Departement({
    required this.id,
    required this.nom,
    required this.createdAt,
    required  this.updatedAt,
    required this.enseignantsCount,
    required this.chefDepartement,
  });

  factory Departement.fromJson(Map<String, dynamic> json) {
    return Departement(
      id: json['id'],
      nom: json['nom'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      enseignantsCount: json['enseignants_count'],
      chefDepartement: List<ChefDepartement>.from(
        json['chef_departement'].map((chef) => ChefDepartement.fromJson(chef)),
      ),
    );
  }
}

class ChefDepartement {
  int id;
  String nom;
  String prenom;
  Pivot pivot;

  ChefDepartement({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.pivot,
  });

  factory ChefDepartement.fromJson(Map<String, dynamic> json) {
    return ChefDepartement(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }
}

class Pivot {
  int departementId;
  int enseignantId;

  Pivot({
    required this.departementId,
    required this.enseignantId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      departementId: json['departement_id'],
      enseignantId: json['enseignant_id'],
    );
  }
}
