import 'dart:async';
import '../Model/ModelEnseignant.dart';

abstract class EnseignantRepository {
  Future<List<Enseignant>> fetchEnseignants();
  Future<void> deleteEnseignant(int enseignantId);
  Future<void> updateEnseignant(String nom, String prenom, String email, String telephone, int id);
}
