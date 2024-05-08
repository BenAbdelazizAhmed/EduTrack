import 'dart:async';
import 'package:flutter/cupertino.dart';

import '../Model/ModelClasse.dart';
import '../repositories/ClasseRepository.dart';


class ClasseViewModel extends ChangeNotifier {
  final ClasseRepository _repository;
  List<Classe> _classes = [];
  StreamController<List<Classe>> _classesStreamController = StreamController<List<Classe>>();

  ClasseViewModel(this._repository);

  Stream<List<Classe>> get classeStream => _classesStreamController.stream;

  List<Classe> get classes => _classes;

  Future<void> fetchClasses() async {
    _classes = await _repository.fetchClasses();
    _classesStreamController.add(_classes);
    notifyListeners();
  }

  Future<void> deleteClasse(int classeId) async {
    await _repository.deleteClasse(classeId);
    await fetchClasses();
  }

  Future<void> updateClasse(String nom,  chefId) async {
    await _repository.updateClasse(nom, chefId) ;
    await fetchClasses();
  }

  Future<void> ajouterClasse(String nom, String typeId) async {
    await _repository.ajouterClasse(nom, typeId);
    await fetchClasses();
  }

  @override
  void dispose() {
    _classesStreamController.close();
    super.dispose();
  }
}
