import '../Model/ModelAnnonce.dart';

abstract class AnnonceRepository {
  Future<List<Annonce>> fetchAnnonces();
  Future<void> postAnnonce(String post, String? image);
  Future<void> deleteAnnouncement(int annonceId);
  Future<void> updateAnnonce(String description, int idannonce);
  Future<void> likeAnnonce(int idAnnonce);
  Future<void> dislikeAnnonce(int idAnnonce);
}
