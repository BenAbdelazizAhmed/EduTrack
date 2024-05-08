class ResultatModel {
  final int id;
  final int matiereId;
  final int studentId;
  final double noteTD;
  final double noteTP;
  final double noteDS;
  final double noteExamen;
  final double moyenne;
  final double credit;
  final DateTime createdAt;
  final DateTime updatedAt;
  final EtudiantModel etudiant;

  ResultatModel({
    required this.id,
    required this.matiereId,
    required this.studentId,
    required this.noteTD,
    required this.noteTP,
    required this.noteDS,
    required this.noteExamen,
    required this.moyenne,
    required this.credit,
    required this.createdAt,
    required this.updatedAt,
    required this.etudiant,
  });
}

class EtudiantModel {
  final int id;
  final String nom;
  final String prenom;
  final String image;

  EtudiantModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.image,
  });
}
