import 'dart:io';

import 'package:flutter/material.dart';

import '../../Api/ApiPFEBOOK.dart';

class PfeBookViewModel extends ChangeNotifier {
  final ApiPfeBook _apiPfeBook;

  PfeBookViewModel(this._apiPfeBook);

  Future<void> postRapport(String post, File image) async {
    try {
      await _apiPfeBook.postRapport(post, image);
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la publication de l\'annonce: $e');
    }
  }

  Future<void> deletePfeBook(int annonceId) async {
    try {
      await _apiPfeBook.deletepfebook(annonceId);
      notifyListeners();
    } catch (e) {
      print('Une erreur s\'est produite lors de la suppression de l\'annonce: $e');
    }
  }

  Future<void> updatePfeBook(String titre, String description, int idannonce) async {
    try {
      await _apiPfeBook.UpdatePfeBook(titre, description, idannonce);
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la mise à jour du PfeBook: $e');
    }
  }
}
