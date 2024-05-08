
abstract class SocieteRepository {
  Future<Map<String, dynamic>> fetchSocietes();
  Future<void> addSociete(String nomsoc,description,siteweb,adresse,telephone, image,) ;
  Future<void> deleteSociete(int societeId);
  Future<void> updateSociete(String description, int societeId);
}