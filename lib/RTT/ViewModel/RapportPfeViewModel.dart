import 'package:flutter/cupertino.dart';

import '../services/Api/ApiRapportPFE.dart';

class RapportViewModel extends ChangeNotifier{
  ApiRapport _apiRapport= ApiRapport();


  Future<void> fetchRapports() async {
    try {
      final response = await _apiRapport.fetchRapports();
      // Traitement des données de la réponse ici
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> postRapport(String titre, String societe, String descrip, String image) async {
    try {
      await _apiRapport.postRapport(titre, societe, descrip, image);
      print('Rapport posted successfully');
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> deleteRapport(int rapportId) async {
    try {
      await _apiRapport.deleteRapport(rapportId);
      print('Rapport deleted successfully');
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> updateRapport(String titre, String description, int rapportId) async {
    try {
      await _apiRapport.updateRapport(titre, description, rapportId);
      print('Rapport updated successfully');
    } catch (e) {
      print('Exception: $e');
    }
  }
}
