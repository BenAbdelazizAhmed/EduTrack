import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:untitled65/RTT/repositories/SocieteRepository.dart';

class ApiSocie implements SocieteRepository{
  String imgselect=" ";
  late List<int> a;
  var b="";
  Future<Map<String, dynamic>> fetchSocietes() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };



    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/societes'),
      headers: headers,
    );
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      return jsonData;
    } else {
      print(jsonData);
      throw Exception('Failed to load data');
    }
  }

  Future<void> addSociete(String nomsoc,description,siteweb,adresse,telephone, image,) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_societe'));

    request.fields['nom'] = nomsoc;
    request.fields['a_propos'] = description;
    request.fields['site_web'] = siteweb;
    request.fields['adresse'] = adresse;
    request.fields['telephone'] = telephone;
    request.fields['email'] = "fdsfd@gmail.com";

    var headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json'

    };

    request.headers.addAll(headers);

    request.files.add(http.MultipartFile.fromBytes(
      'image',
      a,
      filename: imgselect,
    ));

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      fetchSocietes();

      print('Image sent successfully!');
    } else {
      print(response.body);
      print('Error sending the image: ${response.statusCode}');
    }
  }

  Future<void> deleteSociete(int societeId) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.21/ISIMM_eCampus/public/api/supprimer_societe/$societeId'),
      headers: {
        'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      fetchSocietes();
      print('Societe deleted successfully');
      print(data);
    } else {
      print('An error occurred while deleting the societe');
      print(response.body);
    }
  }

  Future<void> updateSociete(String description, int societeId) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.21/ISIMM_eCampus/public/api/update_annonce/$societeId'),
      body: {
        'description': description,
      },
      headers: {
        'Authorization': 'Bearer 8|vPWnz3i58JNfNRHMYL2w48bS5KFjkxgvgFFqYVbd',
        'Accept': 'application/json',
      },
    );

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('Societe updated successfully');
      print(data);
    } else {
      print('An error occurred while updating the societe');
      print(data);
    }
  }
}
