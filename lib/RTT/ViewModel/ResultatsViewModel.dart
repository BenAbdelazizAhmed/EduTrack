import 'package:flutter/foundation.dart';

import '../Model/ResultatsModel.dart';
import '../repositories/ResultatsRepository.dart';

class ResultatViewModel extends ChangeNotifier {
  ResultatRepository _repository;
  List<ResultatModel> _resultats = [];

  ResultatViewModel(this._repository);

  List<ResultatModel> get resultats => _resultats;

  Future<void> fetchResultats(classeId,matiereId) async {
    _resultats = await _repository.fetchResultats(classeId, matiereId);
    notifyListeners();
  }

  Future<void> confirmerResultats(int matiereId,
       int etudiantId,
       double noteTD,
       double noteTP,
       double noteDS,
       double noteExamen,
       double moyenne,
       double credit,) async {
    await _repository.confirmerResultats(matiereId: matiereId, etudiantId: etudiantId, noteTD: noteTD, noteTP: noteTP, noteDS: noteDS, noteExamen: noteExamen, moyenne: moyenne, credit: credit);
    notifyListeners();
  }
}
