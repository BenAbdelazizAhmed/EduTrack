import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Model/ModelEtudiant.dart';
import '../../repositories/Etudiantrepository.dart';

class EtudiantApi implements EtudiantRepository{
  static const String baseUrl = 'http://192.168.1.13/ISIMM_eCampus/public/api';
  static const String authToken = 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C';

  Future<List<Etudiant>> fetchEtudiants() async {
    final response = await http.get(Uri.parse('$baseUrl/etudiants'), headers: {
      'Authorization': authToken,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final etudiants = List<Etudiant>.from(
        data['etudiants'].map((etudiant) => Etudiant.fromJson(etudiant)),
      );
      return etudiants;
    } else {
      throw Exception('Failed to fetch etudiants');
    }
  }

  Future<void> deleteEtudiant(int etudiantId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/supprimer_etudiant/$etudiantId'),
      headers: {
        'Authorization': authToken,
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Etudiant deleted successfully');
    } else {
      throw Exception('Failed to delete etudiant');
    }
  }

  Future<void> updateEtudiant( nom,prenom,email,telephone, int idannonce) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/modifier_etudiant/${idannonce}"'),
      headers: {
        'Authorization': authToken,
        'Accept': 'application/json',
      },
      body: {
        'name': nom,
        'prenom': prenom,
        'email': email,
        'telephone': telephone,
      },
    );

    if (response.statusCode == 200) {
      print('Etudiant updated successfully');
    } else {
      print(jsonDecode(response.body));
      throw Exception('Failed to update etudiant');
    }
  }
}