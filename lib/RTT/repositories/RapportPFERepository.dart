import '../Model/ModelRapportPFE.dart';

abstract class RapportRepository {
  Future<Map<String,dynamic>> fetchRapports();
  Future<void> deleteRapport(int rapportId);
  Future<void> updateRapport(String titre, String description, int rapportId);
}
