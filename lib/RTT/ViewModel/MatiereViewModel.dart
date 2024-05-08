import 'package:flutter/cupertino.dart';

import '../Model/ModelMatiere.dart';
import '../repositories/MatiereRepository.dart';

class MatiereViewModel extends ChangeNotifier{
  final MatiereRepository matiereRepository;

  MatiereViewModel(this.matiereRepository);

  Future<List<Matiere>> fetchMatieres() async {
    try {
      List<Matiere> matieres = await matiereRepository.fetchMatieres();
      return matieres;
    } catch (error) {
      print('Error fetching matieres: $error');
      return [];
    }
  }

  Future<void> addMatiere(String nom) async {
    try {
      await matiereRepository.addMatiere(nom);
      print('Matiere added successfully');
    } catch (error) {
      print('Failed to add matiere: $error');
    }
  }

  Future<void> deleteMatiere(int matiereId) async {
    try {
      await matiereRepository.deleteMatiere(matiereId);
      print('Matiere deleted successfully');
    } catch (error) {
      print('Failed to delete matiere: $error');
    }
  }

  Future<void> updateMatiere(String nom, int matiereId) async {
    try {
      await matiereRepository.updateMatiere(nom, matiereId);
      print('Matiere updated successfully');
    } catch (error) {
      print('Failed to update matiere: $error');
    }
  }
}
