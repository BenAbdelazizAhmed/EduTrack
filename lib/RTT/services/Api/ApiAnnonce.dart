import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Model/ModelAnnonce.dart';
import '../../repositories/Annoncesrepository.dart';
import 'dart:io';

class ApiAnnonce implements AnnonceRepository {
  final String baseUrl = 'http://192.168.1.13/ISIMM_eCampus/public/api';
  final String token = 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C';

  @override
  Future<List<Annonce>> fetchAnnonces() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/annonces'),
      headers: {
        'Authorization': token,
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );


    if (response.statusCode == 200) {
      print("d");
      final List<dynamic> data = jsonDecode(response.body)['annonces'];
      print(data);
      return data.map((item) => Annonce.fromJson(item)).toList();
    } else {
      print(jsonDecode(response.body));
      throw Exception('Failed to fetch annonces');
    }
  }

  @override
  Future<void> postAnnonce(String post, String? image) async {
    print("d");
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/admin/ajouter_annonce'));

    request.fields['description'] = post;

    var headers = {
      'Authorization': token,
      'Accept': 'application/json',
    };

    request.headers.addAll(headers);

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Annonce postée avec succès');
    } else {
      print('Erreur lors de la publication de l\'annonce');
    }
  }

  @override
  Future<void> deleteAnnouncement(int annonceId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/supprimer_annonce/$annonceId'),
      headers: {
        'Authorization': token,
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print('Announcement deleted successfully');
      final data = jsonDecode(response.body);
      print(data);
    } else {
      print('An error occurred while deleting the announcement');
      print(response.body);
    }
  }

  @override
  Future<void> updateAnnonce(String description, int idannonce) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update_annonce/$idannonce'),
      body: {'description': description},
      headers: {
        'Authorization': token,
        'Accept': 'application/json',
      },
    );
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("Update avec succes");
      print(data);
    } else {
      print(data);
    }
  }

  @override
  Future<void> likeAnnonce(int idAnnonce) async {
    print('object');
    final response = await http.post(
      Uri.parse('$baseUrl/like/$idAnnonce'),
      headers: {
        'Authorization': token,
        'Accept': 'application/json',
      },
    );
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("Like avec succes");
      print(data);
    } else {
      print("Erreur lors du like");
      print(data);
    }
  }

@override
Future<void> dislikeAnnonce(int idAnnonce) async {
  final response = await http.post(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/deslike/${idAnnonce}'),
        headers: {
        'Authorization': token,
        'Accept': 'application/json',
        },
      );
      var data = jsonDecode(response.body);


  if (response.statusCode == 200) {
    print("Dislike avec succes");
    print(data);
  } else {
    print("Erreur lors du dislike");
    print(data);
  }
}
}