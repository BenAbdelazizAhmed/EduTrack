import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Model/ModelEnseignant.dart';
import '../../repositories/EnseignantRepository.dart';

class ApiEnseignant  implements EnseignantRepository{
  Future<List<Enseignant>> fetchEnseignants() async {
    http.Response response = await http.get(
        Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/enseignants'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List<Enseignant> enseignants = [];
      for (var enseignantData in data) {
        Enseignant enseignant = Enseignant.fromJson(enseignantData);
        enseignants.add(enseignant);
      }

      return enseignants;
    } else {
      throw Exception('Failed to fetch enseignants');
    }
  }

  Future<void> deleteEnseignant(int enseignantId) async {
    final response = await http.delete(
      Uri.parse(
          'http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_enseignant/$enseignantId'),
      headers: {
        'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete enseignant');
    }
  }

  Future<void> updateEnseignant(
      String nom, String prenom, String email, String telephone, int id) async {
    final response = await http.post(
        Uri.parse(
          'http://192.168.1.13/ISIMM_eCampus/public/api/modifier_enseignant/$id'),
          body: {
        'name': nom,
        'prenom': prenom,
        'email': email,
        'telephone': telephone
        },
          headers: {
            'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
            'Accept': 'application/json'
          },
        );
        if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body));
    }
  }


}