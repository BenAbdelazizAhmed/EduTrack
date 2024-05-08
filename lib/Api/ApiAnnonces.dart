import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiAnnonce {




  Future<void> postAnnonce(String post, image) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_annonce'));

    request.fields['description'] = post;
print("ddddddddddd");
    var headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json'

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

  Future<void> deleteAnnouncement(int annonceId) async {

    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_annonce/$annonceId'),
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


  UpdateAnnonce(String description, int idannonce) async {
    http.Response response = await http.post(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/update_annonce/${idannonce}"),
        body: {
          'description': description,
        },
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

  LikeAnnonce(idAnnonce) async {
    http.Response response = await http.post(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/like/$idAnnonce",
    ),
        headers: {
          'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
          'Accept': 'application/json'
        });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {

    } else {
      print("erruuur");
      print(response.statusCode);
      print(data);
    }
  }


  void DisLikeAnnonce(idAnnonce)async{
    http.Response response = await http.post(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/deslike/${idAnnonce}"),
        headers: {
          'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
          'Accept': 'application/json'
        });
    var data =jsonDecode( response.body);
    if(response.statusCode==200){
      print("ok");
      print(data);

    }else{
      print("erruuur");
      print(response.statusCode);
      print(data);

    }
  }

}