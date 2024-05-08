import '../Model/ModelClasse.dart';
import '../Model/ModelAnnonce.dart';

abstract class DepartementRepository {
  Future<Map<String,dynamic>> fetchDepartements();
  Future<void> deleteDepa(int classeId);
  Future<void> AjouterDepa(String nomdep,chef);
  Future<void> UpdateDepa( nom,  typeId);
}