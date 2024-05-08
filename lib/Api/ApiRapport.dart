import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:path/path.dart' as path;
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
class ApiRapport {




  Future<void> postRapport(String titre,Societe,descrip,image) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://localhost/ISIMM_eCampus/public/api/ajouter_pfeBook'));

    request.fields['titre'] = titre;
    request.fields['societe'] = Societe;
    request.fields['description'] = descrip;

    var headers = {
      'Authorization': 'Bearer 8|vPWnz3i58JNfNRHMYL2w48bS5KFjkxgvgFFqYVbd',
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

  Future<void> deleteRapport(int annonceId) async {

    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_rapport/${annonceId}'),
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

  Future<void> __openPdf(String filePath) async {
    try {
      await OpenFile.open(filePath);
    } catch (e) {
      print('Failed to open PDF: $e');
    }
  }

  Future<File?> __downloadFile(String filename) async {
    final String fileUrl =
        'http://192.168.1.13/ISIMM_eCampus/public/api/download_cours?filename=gvRlHwEkmU8RzjP7jttr';

    var httpClient = http.Client();

    var request = http.Request('GET', Uri.parse(fileUrl));
    request.headers['Authorization'] = 'Bearer 28|sf0P9jkN6WnwYmaxj9XSvhVDIh7KsTjxo1MCAvcl';
    request.headers['Accept'] = 'application/pdf';

    var response = await httpClient.send(request);

    var httpResponse = await http.Response.fromStream(response);

    var bytes = httpResponse.bodyBytes;
    var contentType = httpResponse.headers['content-type'];
    if (contentType != 'application/pdf') {
      print('Erreur: Le fichier téléchargé n\'est pas un fichier PDF.');
      return null;
    }

    Directory? downloadsDir;
    try {
      downloadsDir = await getExternalStorageDirectory();
    } catch (e) {
      // Handle error if unable to access external storage directory
      print('Failed to get external storage directory: $e');
      return null;
    }

    String downloadsPath = downloadsDir!.path;
    String filePath = '$downloadsPath/$filename.pdf';
    File file = File(filePath);
    await file.writeAsBytes(bytes);

    await _openPdf(file.path);

    httpClient.close();

    return file;
  }
  Future<void> _openPdf(String filePath) async {
    try {
      // Ouvrir le fichier dans le navigateur
      await js.context.callMethod('open', [filePath]);
    } catch (e) {
      print('Failed to open PDF: $e');
    }
  }

  Future<void> downloadFile(String filename) async {
    final String fileUrl =
        'http://192.168.1.13/ISIMM_eCampus/public/api/download_cours?filename=gvRlHwEkmU8RzjP7jttr';

    var httpClient = http.Client();

    var request = http.Request('GET', Uri.parse(fileUrl));
    request.headers['Authorization'] = 'Bearer 28|sf0P9jkN6WnwYmaxj9XSvhVDIh7KsTjxo1MCAvcl';
    request.headers['Accept'] = 'application/pdf';

    var response = await httpClient.send(request);

    var httpResponse = await http.Response.fromStream(response);

    var bytes = httpResponse.bodyBytes;
    var contentType = httpResponse.headers['content-type'];
    if (contentType != 'application/pdf') {
      print('Erreur: Le fichier téléchargé n\'est pas un fichier PDF.');
      return;
    }

    Uint8List uint8List = Uint8List.fromList(bytes);
    var blob = html.Blob([uint8List], 'application/pdf');
    var url = html.Url.createObjectUrlFromBlob(blob);
    var anchor = html.AnchorElement()
      ..href = url
      ..style.display = 'none'
      ..download = filename + '.pdf';
    html.document.body!.children.add(anchor);
    anchor.click();
    anchor.remove();
    html.Url.revokeObjectUrl(url);

    httpClient.close();
  }

  UpdateRapport(String titre,String description,  idannonce) async {
    http.Response response = await http.patch(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/update_rapport/${idannonce}?titre=${titre}&description=${description}"),
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



}