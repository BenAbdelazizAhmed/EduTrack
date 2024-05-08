import '../Model/ModelClasse.dart';
import '../Model/ModelAnnonce.dart';

abstract class ClasseRepository {
  Future<List<Classe>> fetchClasses();
  Future<void> deleteClasse(int classeId);
  Future<void> updateClasse(nom, chefId) ;
  Future<void> ajouterClasse(String nom,  typeId);
}