class Etudiant {
  int id;
  String nom;
  String prenom;
  String image;
  String email;
  String telephone;
  List<Classe> classe;

  Etudiant({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.image,
    required this.email,
    required this.telephone,
    required this.classe,
  });

  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      image: json['image'],
      email: json['email'],
      telephone: json['telephone'],
      classe: parseClasses(json['classe']),
    );
  }

  static List<Classe> parseClasses(List<dynamic> classesJson) {
    List<Classe> classes = [];
    for (var classeJson in classesJson) {
      classes.add(Classe.fromJson(classeJson));
    }
    return classes;
  }
}

class Classe {
  int id;
  String nom;
  Pivot pivot;

  Classe({
    required this.id,
    required this.nom,
    required this.pivot,
  });

  factory Classe.fromJson(Map<String, dynamic> json) {
    return Classe(
      id: json['id'],
      nom: json['nom'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }
}

class Pivot {
  int studentId;
  int classeId;

  Pivot({
    required this.studentId,
    required this.classeId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      studentId: json['student_id'],
      classeId: json['classe_id'],
    );
  }
}
