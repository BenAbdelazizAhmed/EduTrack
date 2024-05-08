import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiEnseignant {


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



  Future<void> deleteEnseignant(int ense) async {

    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_enseignant/$ense'),
      headers: {
        'Authorization': 'Bearer 8|vPWnz3i58JNfNRHMYL2w48bS5KFjkxgvgFFqYVbd',
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


  UpdateEnseignant( nom,prenom,email,telephone, int idannonce) async {
    http.Response response = await http.post(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/modifier_enseignant/${idannonce}"),
        body: {
          'name': nom,
          'prenom':prenom,
          'email':email,
          'telephone':telephone
        },
        headers: {
          'Authorization': 'Bearer 8|vPWnz3i58JNfNRHMYL2w48bS5KFjkxgvgFFqYVbd',
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