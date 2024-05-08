import 'package:flutter/material.dart';

import '../Model/ModelEtudiant.dart';
import '../repositories/Etudiantrepository.dart';
class EtudiantViewModel extends ChangeNotifier {
  final EtudiantRepository _repository;

  EtudiantViewModel(this._repository);

  List<Etudiant> _etudiants = [];
  List<Etudiant> get etudiants => _etudiants;

  Future<void> fetchEtudiants() async {
    try {
      _etudiants = await _repository.fetchEtudiants();
      notifyListeners();
    } catch (error) {
      print('Error fetching etudiants: $error');
    }
  }

  Future<void> deleteEtudiant(int etudiantId) async {
    try {
      await _repository.deleteEtudiant(etudiantId);
      _etudiants.removeWhere((etudiant) => etudiant.id == etudiantId);
      notifyListeners();
    } catch (error) {
      print('Error deleting etudiant: $error');
    }
  }

  Future<void> updateEtudiant(String nom, String prenom, String email, String telephone, int id) async {
    try {
      await _repository.updateEtudiant(nom, prenom, email, telephone, id);
      final etudiantIndex = _etudiants.indexWhere((etudiant) => etudiant.id == id);
      if (etudiantIndex != -1) {
        _etudiants[etudiantIndex].nom = nom;
        _etudiants[etudiantIndex].prenom = prenom;
        _etudiants[etudiantIndex].email = email;
        _etudiants[etudiantIndex].telephone = telephone;
        notifyListeners();
      }
    } catch (error) {
      print('Error updating etudiant: $error');
    }
  }
}
