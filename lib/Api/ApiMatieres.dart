import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiMat {


  getEnseignant()async{
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/enseignants'));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      print("ok");
      print(data);
    }else{
      print(response.statusCode);
      return jsonDecode(response.body);
    }
  }



  Future<void> deleteMatieres(int ense) async {

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
  Future<void>AjouterMatieres(String nom) async {

    final response = await http.post(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_matiere'),
      headers: {
        'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body:jsonEncode({
        'nom':nom,
      }) ,
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

  UpdateEnseignant(String nom ,int idmat) async {
    http.Response response = await http.patch(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/modifier_matiere/${idmat}?nom=${nom}"),
        headers: {
          'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
          'Accept': 'application/json'
        }
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Update avec succes");

      print(data);
    } else {
      print(data);
    }
  }



}