import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../Model/ModelEnseignant.dart';
import '../repositories/EnseignantRepository.dart';
import '../services/Api/ApiEnseignant.dart';

class EnseignantViewModel extends ChangeNotifier {
  final EnseignantRepository _repository;
  EnseignantViewModel(this._repository);

  List<Enseignant> _etudiants = [];
  List<Enseignant> get etudiants => _etudiants;

  final StreamController<List<Enseignant>> _enseignantsController =
  StreamController<List<Enseignant>>.broadcast();
  Stream<List<Enseignant>> get enseignantsStream =>
      _enseignantsController.stream;

  void fetchEnseignants() async {
    try {
      List<Enseignant> enseignants = await _repository.fetchEnseignants();
      _etudiants = enseignants;
      _enseignantsController.add(enseignants);
    } catch (e) {
      _enseignantsController.addError(e);
    }
  }

  void deleteEnseignant(int enseignantId) async {
    try {
      await _repository.deleteEnseignant(enseignantId);
      fetchEnseignants();
    } catch (e) {
      print('An error occurred while deleting the enseignant');
      print(e.toString());
    }
  }

  void updateEnseignant(
      String nom, String prenom, String email, String telephone, int id) async {
    try {
      await _repository.updateEnseignant(nom, prenom, email, telephone, id);
      fetchEnseignants();
    } catch (e) {
      print('An error occurred while updating the enseignant');
      print(e.toString());
    }
  }

  void dispose() {
    _enseignantsController.close();
  }
}
