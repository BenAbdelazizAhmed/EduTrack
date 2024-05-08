import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../repositories/SocieteRepository.dart';

class SocieteViewModel {
  final SocieteRepository repository;

  SocieteViewModel(this.repository);

  Future<Map<String, dynamic>> fetchSocietes() async {
    try {
      return await repository.fetchSocietes();
    } catch (e) {
      throw Exception('Failed to fetch societes: $e');
    }
  }

  Future<void> addSociete(
      String nomSoc, description, siteWeb, adresse, telephone, image) async {
    try {
      await repository.addSociete(
        nomSoc,
        description,
        siteWeb,
        adresse,
        telephone,
        image,

      );
    } catch (e) {
      throw Exception('Failed to add societe: $e');
    }
  }

  Future<void> deleteSociete(int societeId) async {
    try {
      await repository.deleteSociete(societeId);
    } catch (e) {
      throw Exception('Failed to delete societe: $e');
    }
  }

  Future<void> updateSociete(String description, int societeId) async {
    try {
      await repository.updateSociete(description, societeId);
    } catch (e) {
      throw Exception('Failed to update societe: $e');
    }
  }
}
