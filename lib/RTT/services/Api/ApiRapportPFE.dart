import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../repositories/RapportPFERepository.dart';

class ApiRapport implements RapportRepository{

  Future<Map<String,dynamic>> fetchRapports()async{
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json' //ajout du header CORS dans la requête

    };
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/rapports'),
        headers: headers
    );
    var data = jsonDecode(response.body) as Map<String, dynamic> ;
    if(response.statusCode==200){
      print(data);
      return data ;
    }else{
      print(response.statusCode);
      print(data);

      return jsonDecode(response.body);
    }
  }

  Future<void> postRapport(String titre, String societe, String descrip, String image) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_rapport'));

    request.fields['titre'] = titre;
    request.fields['societe'] = societe;
    request.fields['description'] = descrip;

    var headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json',
    };

    request.headers.addAll(headers);

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Rapport posted successfully');
    } else {
      print('Failed to post rapport');
    }
  }

  Future<void> deleteRapport(int rapportId) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_rapport/${rapportId}'),
      headers: {
        'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Rapport deleted successfully');
    } else {
      print('Failed to delete rapport');
    }
  }

  Future<void> updateRapport(String titre, String description, int rapportId) async {
    final response = await http.patch(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/update_rapport/${rapportId}?titre=${titre}&description=${description}'),
      body: {
        'description': description,
      },
      headers: {
        'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
    'Accept': 'application/json',
    },
    );

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Rapport updated successfully');
      print(data);
    } else {
      print('Failed to update rapport');
      print(data);
    }
  }
}