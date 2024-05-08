import 'package:flutter/foundation.dart';
import '../Model/ModelDepartement.dart';
import '../repositories/DepartementRepository.dart';

class DepartementViewModel with ChangeNotifier {
  final DepartementRepository _repository;

  List<Departement> _departements = [];
  List<Departement> get departements => _departements;

  DepartementViewModel(this._repository) {
    fetchDepartements();
  }

  Future<void> fetchDepartements() async {
    try {
      final result = await _repository.fetchDepartements();
      if (result != null) {
        notifyListeners();
      } else {
        _departements = [];
        notifyListeners();
      }
    } catch (e) {
      print('Exception occurred while fetching departments: $e');
    }
  }

  Future<void> deleteDepartement(int departementId) async {
    try {
      await _repository.deleteDepa(departementId);
      await fetchDepartements(); // Refresh the list of departments
      print('Department deleted successfully');
    } catch (e) {
      print('Exception occurred while deleting the department: $e');
    }
  }

  Future<void> ajouterDepartement(String nomdep, chef) async {
    try {
      await _repository.AjouterDepa(nomdep, chef);
      await fetchDepartements(); // Refresh the list of departments
      print('Department added successfully');
    } catch (e) {
      print('Exception occurred while adding the department: $e');
    }
  }

  Future<void> updateDepartement(int iddeparte, String nomde) async {
    try {
      await _repository.UpdateDepa(iddeparte,nomde);
      await fetchDepartements(); // Refresh the list of departments
      print('Department updated successfully');
    } catch (e) {
      print('Exception occurred while updating the department: $e');
    }
  }
}
