import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiDep {


  getDepa() async {
    http.Response response = await http.get(
        Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/departements'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("ok");
      print(data);
    } else {
      print(response.statusCode);
      return jsonDecode(response.body);
    }
  }


  Future<void> deleteDepa(int ense) async {
    final response = await http.delete(
      Uri.parse(
          'http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_departement/${ense}'),
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

  Future<void> AjouterDepa(String nomdep,chef) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_departement'),
      headers: {
        'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'nom': nomdep,
        'chefDepartement':chef,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Dpartement deleted successfully');
      print(data);
    } else {
      print('An error occurred while deleting the announcement');
      print(response.body);
    }
  }

  UpdateDepa(iddeparte,nomde) async {
    http.Response response = await http.patch(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/modifier_departement/${iddeparte}?nom=${nomde}&chefDepartement=1"),

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
