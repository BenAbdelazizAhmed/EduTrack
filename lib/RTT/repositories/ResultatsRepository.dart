import '../Model/ResultatsModel.dart';
abstract class ResultatRepository {
  Future<List<ResultatModel>> fetchResultats(int classeId, int matiereId);
  Future<bool> confirmerResultats({
    required int matiereId,
    required int etudiantId,
    required double noteTD,
    required double noteTP,
    required double noteDS,
    required double noteExamen,
    required double moyenne,
    required double credit,
  });
}
