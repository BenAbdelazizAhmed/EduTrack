import 'dart:async';
import '../Model/ModelEtudiant.dart';

abstract class EtudiantRepository {
  Future<List<Etudiant>> fetchEtudiants();
  Future<void> deleteEtudiant(int etudiantId);
  Future<void> updateEtudiant(String nom, String prenom, String email, String telephone, int id);
}
