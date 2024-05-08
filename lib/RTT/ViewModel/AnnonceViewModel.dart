import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../Model/ModelAnnonce.dart';
import '../repositories/Annoncesrepository.dart';

class AnnonceViewModel extends ChangeNotifier {
  final AnnonceRepository repository;
  List<Annonce> annonces = [];

  AnnonceViewModel(this.repository);
  StreamController<List<Annonce>> _streamController = StreamController<List<Annonce>>();

  Stream<List<Annonce>> get stream => _streamController.stream;
  Future<void> fetchAnnonces() async {
    annonces = await repository.fetchAnnonces();
    _streamController.add(annonces);
    notifyListeners();
  }

  Future<void> addAnnonce(String description, String? image) async {
    await repository.postAnnonce(description, image);
    await fetchAnnonces();
  }

  Future<void> deleteAnnonce(int annonceId) async {
    await repository.deleteAnnouncement(annonceId);
    await fetchAnnonces();
  }

  Future<void> updateAnnonce(String description, int idannonce) async {
    await repository.updateAnnonce(description, idannonce);
    await fetchAnnonces();
  }

  Future<void> likeAnnonce(int idAnnonce) async {
    await repository.likeAnnonce(idAnnonce);
    await fetchAnnonces();
  }

  Future<void> dislikeAnnonce(int idAnnonce) async {
    await repository.dislikeAnnonce(idAnnonce);
    await fetchAnnonces();
  }
}