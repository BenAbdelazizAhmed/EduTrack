import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiResultat {


  getResultat()async{
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
  void ConfimerResultats(int matiereid, int etudiantid, double td) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/confirmer_resultat'),
      headers: {
        'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'matiere_id': matiereid,
        'resultats': [
          {'etudiant_id': etudiantid, 'note_TD': td},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Résultat envoyé avec succès');
      print(data);
    } else {
      print('Une erreur s\'est produite lors de l\'envoi du résultat');
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