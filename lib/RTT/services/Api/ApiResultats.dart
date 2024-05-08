import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Model/ResultatsModel.dart';
import '../../repositories/ResultatsRepository.dart';

class ApiResultats implements ResultatRepository {
  final String baseUrl = 'http://192.168.1.13/ISIMM_eCampus/public/api';
  final String token = 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C';

  Future<List<dynamic>> getMatiere() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/matieres'),
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['matieres'];
        return data;
      } else {
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération des matières: $e');
      return [];
    }
  }

  Future<bool> confirmerResultats({
    required int matiereId,
    required int etudiantId,
    required double noteTD,
    required double noteTP,
    required double noteDS,
    required double noteExamen,
    required double moyenne,
    required double credit,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/confirmer_resultat'),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'matiere_id': matiereId,
          'resultats': [
            {
              'etudiant_id': etudiantId,
              'note_TD': noteTD,
              'note_TP': noteTP,
              'note_DS': noteDS,
              'note_Examen': noteExamen,
              'moyenne': moyenne,
              'credit': credit,
            }
          ],
        }),
      );
      if (response.statusCode == 200) {
        print('Résultat envoyé avec succès');
        return true;
      } else {
        print('Erreur lors de l\'envoi du résultat');
        return false;
      }
    } catch (e) {
      print('Erreur lors de l\'envoi du résultat: $e');
      return false;
    }
  }

  Future<List<ResultatModel>> fetchResultats(int classeId, int matiereId) async {

      final response = await http.get(
        Uri.parse('$baseUrl/list_resultats?matiere_id=$matiereId&classe_id=$classeId'),
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
        },
      );
      final data = jsonDecode(response.body) ;

      if (response.statusCode == 200) {
        return data;
      } else {
        return data;
      }
    }

}
