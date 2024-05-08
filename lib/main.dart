import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled65/Views/Annonces.dart';
import 'package:untitled65/presence.dart';

import 'Api/aproposweb.dart';
import 'RTT/View/ClassesView.dart';
import 'RTT/View/PFEBOOKVIEW.dart';
import 'RTT/View/RaportPFEView.dart';
import 'RTT/View/ResultatsView.dart';
import 'RTT/View/SocieteView.dart';
import 'Views/BoiteDeReception/BoiteDeReceptionEnseignant.dart';
import 'Views/BoiteDeReception/BoiteReception/boiteetudiant.dart';
import 'Views/Classes.dart';
import 'Views/DateExamen.dart';
import 'Views/EmploiDuTemps.dart';
import 'Views/ListeEnseignant.dart';
import 'Views/ListeEtudiant.dart';
import 'Views/Matieres.dart';
import 'Views/Resultas.dart';
import 'Views/Societe.dart';
import 'Views/rapport.dart';
import 'RTT/View/DepartementView.dart';
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        home:AnnonceAdmistration(),
      );

  }
}

