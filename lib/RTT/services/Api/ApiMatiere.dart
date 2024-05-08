import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Model/ModelMatiere.dart';
import '../../repositories/MatiereRepository.dart';

class ApiMat implements MatiereRepository{
  Future<List<Matiere>> fetchMatieres() async {
    try {
      final response =
      await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/enseignants'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        print(response.statusCode);
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('An error occurred while fetching enseignants: $e');
      throw Exception('Failed to fetch enseignants: $e');
    }
  }

  Future<void> deleteMatiere(int ense) async {

    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_matiere/$ense'),
      headers: {
        'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Announcement deleted successfully');
      print(data);
    } else {
      print('An error occurred while deleting the announcement');
      print(response.body);
    }

  }

  Future<void> addMatiere(String nom) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_matiere'),
        headers: {
          'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'nom': nom,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Matiere added successfully');
        print(data);
      } else {
        print('An error occurred while adding the matiere');
        print(response.body);
      }
    } catch (e) {
      print('An error occurred while adding the matiere: $e');
      throw Exception('Failed to add matiere: $e');
    }
  }

  Future<void> updateMatiere(String nom, int matiereId) async {
    try {
      final response = await http.patch(
        Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/modifier_matiere/$matiereId?nom=$nom'),
        headers: {
          'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Matiere updated successfully');
        print(data);
      } else {
        print('An error occurred while updating the matiere');
        print(response.body);
      }
    } catch (e) {
      print('An error occurred while updating the matiere: $e');
      throw Exception('Failed to update matiere: $e');
    }
  }

}