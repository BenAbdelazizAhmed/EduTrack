import '../Model/ModelMatiere.dart';

abstract class MatiereRepository {
  Future<List<Matiere>> fetchMatieres();
  Future<void> addMatiere(String nom);
  Future<void> deleteMatiere(int matiereId);
  Future<void> updateMatiere(String nom, int matiereId);
}
