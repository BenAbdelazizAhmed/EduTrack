import 'dart:html';

abstract class PfeBookRepository {
  Future<void> postRapport(String post, File image);
  Future<void> deletePfeBook(int annonceId);
  Future<void> updatePfeBook(String titre, String description, int idannonce);
}
