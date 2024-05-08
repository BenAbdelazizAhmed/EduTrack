import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:untitled65/Views/rapport.dart';

import 'Annonces.dart';
import 'Boite de receptionEnseignant.dart';
import 'BoiteDeReception/BoiteDeReceptionEnseignant.dart';
import 'Classes.dart';
import 'Dapartement.dart';
import 'DateExamen.dart';
import 'ListeEtudiant.dart';
import 'Matieres.dart';
import 'PFEBOOK.dart';
import 'Resultas.dart';

class TableRowData {
  List<TextEditingController> controllers = List.generate(7, (_) => TextEditingController());
}

class EmploiDuTemps extends StatefulWidget {
  const EmploiDuTemps({Key? key}) : super(key: key);

  @override
  State<EmploiDuTemps> createState() => _EmploiDuTempsState();
}
class _EmploiDuTempsState extends State<EmploiDuTemps> {
  late String _selectedOption;
  late String _selectedOptionn;
  late String _selectedOptionnn;
  late String _selectedOptionnnn;
  late String _selectedOptionnnnn;
  late String ensei;

  List<List<List<String>>> rows = [];

  late String ma;
  late String sa;
  Future<void> getMatiere() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/matieres'),
      headers: headers,
    );
    var data = jsonDecode(response.body)['matieres'];
    if (response.statusCode == 200) {
      print(data);
      for (var ma in data) {
        setState(() {
          Matieress.add(ma['nom']);
        });
      }
    } else {
      print(data);
    }
  }
  Future<void> getEns() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/enseignants'),
      headers: headers,
    );
    var data = jsonDecode(response.body)['enseignants'];
    if (response.statusCode == 200) {
      print(data);
      for (var ma in data) {
        setState(() {
          Ensei.add(ma['id'].toString()+ma['prenom']+ma['nom']);
        });
      }
      print(Ensei);
    } else {
      print(data);
    }
  }

  Future<void> getSalles() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/salles'),
      headers: headers,
    );
    var data = jsonDecode(response.body)['salles'];
    if (response.statusCode == 200) {
      print(data);
      for (var ma in data) {
        setState(() {
          Salless.add(ma['nom']);
        });
      }
    } else {
      print(data);
    }
  }

  List<String> classe = [
    'Ingénierie',
    'Mastére',
    'L3',
    'L2',
    'L1',
  ];

  List<String> typeclasse = [
    'Génie Logiciel',
    'Systéme Embarqué',
    'Maths',
    'Tic',
  ];

  List<String> TD = [
    'TD 1',
    'TD 2',
    'TD 3',
    'TD 4',
    'TD 5',
    'TD 6',
  ];

  List<String> Ensei = [
    'Enseignant',

  ];

  List<String> Matieres = [
    'Matieres',
  ];

  List<String> Salle = [
    'Salle',
  ];

  List<String> Matieress = [
    'Matieres',
  ];

  List<String> Salless = [
    'Salle',
  ];

  final _tableKey = GlobalKey();

  List<List<String>> tableContent = [];

  List<List<TextEditingController>> _controllers = [];

  List<TableRowData> tableData = [];

  bool isSelected = true;
  List<List<TextEditingController>> controllers = List.generate(6, (_) => List.filled(7, TextEditingController()));
  List<List<List<String>>> copiedData = [];

  @override
  void initState() {
    _selectedOption = classe[0];
    _selectedOptionn = typeclasse[0];
    _selectedOptionnn = TD[0];
    _selectedOptionnnn = Matieres[0];
    _selectedOptionnnnn = Ensei[0];
    ensei = Ensei[0];
    sa = Salle[0];
    sa = Salless[0];
    ma = Matieress[0];
    getEns();
    getMatiere();
    getSalles();
    List<List<TextEditingController>> controllers = List.generate(
      6,
          (rowIndex) => List.generate(7, (_) => TextEditingController()),
    );    for (int i = 0; i < 6; i++) {
      tableData.add(TableRowData()..controllers = List.generate(7, (index) => TextEditingController()));
    }
    super.initState();
  }

  bool _showTable = false;

  @override
  int columns = 6; // Nombre de colonnes de la matrice
  List<List<List<String>>> rowControllers = [];
  List<Map<String, String>> selectedValuesMap = [];
  List<List<List<String>>> selectedValues = [];
  Future<void> ConfirmerDateEmploi() async {
    if (rowControllers.isEmpty) {
      print('Veuillez sélectionner des valeurs');
      return;
    }

    List<List<List<String>>> savedData = [];
    for (var row in rowControllers) {
      List<List<String>> rowData = [];
      for (var cell in row) {
        if (cell.isNotEmpty && !cell.every((value) => value == Ensei[0])) {
          rowData.add(List.from(cell));
        }
      }
      savedData.add(rowData);
    }
    for (var i = 1; i < savedData.length; i++) {
      copiedData.add(List.from(savedData[i]));
    }
    copiedData.forEach((list) {
      if (list.length > 1) {
        list.removeAt(0);
      }
    });

    print(copiedData);


    print(copiedData);
  }
  Future<void> EnvoiBack() async {
    try {
      for (var list in copiedData) {
        List<String> enseignant = list[0];
        String nomEnseignant = enseignant[0][0];
        String nomMatiere = enseignant[1];
        String nomSalle = enseignant[2];
        print(nomEnseignant[0]);
        print(nomMatiere);
        print(nomSalle);
        int a = int.parse(nomEnseignant[0]);

        Map<String, dynamic> data = {
          'classe_id': 1,
          'jours': [
            'matiere_id=>$nomMatiere,enseignant_id=>$a,salle_id=>$nomSalle,day=>Lundi,start_time=>8:30:22,end_time=>10:20:00',
          ],
        };

        String jsonData = jsonEncode(data);

        final response = await http.post(
          Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_emploi'),
          headers: {
            'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonData,
        );

        if (response.statusCode == 200) {
          print('Données envoyées avec succès');
          print(response.body);
        } else {
          print(response.body);
        }
      }
    } catch (error) {
      print('Erreur lors de la requête HTTP: $error');
    }
  }

  TableRow _buildRow(List<String> cells, {bool isHeader = false, required int rowIndex}) {
    for (int i = 0; i < cells.length; i++) {
      if (rowControllers.length <= rowIndex) {
        rowControllers.add([]);
      }
      while (rowControllers[rowIndex].length <= i) {
        rowControllers[rowIndex].add([
          Ensei[0], // Valeur par défaut pour "enseignant"
          Matieress[0], // Valeur par défaut pour "matiere"
          Salless[0], // Valeur par défaut pour "salle"
        ]);
      }
    }

    return TableRow(
      children: cells.asMap().entries.map(
            (entry) {
          final index = entry.key;
          final cell = entry.value;
          final isEditable = index != 0;
          final controller = isEditable ? rowControllers[rowIndex][index] : null;

          return TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Container(
              width: isHeader ? 120 : 120,
              height: isHeader ? 50 : 120,
              color: isHeader ? Color(0xFF93ccdd) : index == 0 ? Color(0xFFdaedf3) : null,
              child: Center(
                child: isHeader
                    ? Text(
                  cell,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
                    : isEditable
                    ? Column(
                  children: [
                    SizedBox(
                      height: 33,
                      child: DropdownButton<String>(
                        value: rowControllers[rowIndex][index][0], // Pour le menu déroulant enseignant
                        items: Ensei.map(
                              (option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            rowControllers[rowIndex][index][0] = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 33,
                      child: DropdownButton<String>(
                        value: rowControllers[rowIndex][index][1], // Pour le menu déroulant matière
                        items: Matieress.map(
                              (option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            rowControllers[rowIndex][index][1] = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 33,
                      child: DropdownButton<String>(
                        value: rowControllers[rowIndex][index][2], // Pour le menu déroulant salle
                        items: Salless.map(
                              (option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            rowControllers[rowIndex][index][2] = value!;
                          });
                        },
                      ),
                    ),
                  ],
                )
                    : Text(
                  cell,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }


    int rowss = 5;
  List<TableRow> buildMatrix() {
    return List.generate(
      rowss,
          (rowIndex) => _buildRow(
        List.generate(columns, (index) => 'Cell ${rowIndex + 1}-${index + 1}'),
        rowIndex: rowIndex,
      ),
    );
  }





    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFff7f7fa),
      body:Container(
        child:Column(children: [
          Container(
            height: 50,
            padding:EdgeInsets.only(right:30),
            width: double.infinity,
            color: Colors.white,
            child:Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child:Image.asset('lib/adminstration/img/téléchargement (2).png'),
                ),
                Row(
                  children: [
                    Text('ISIMM',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF26519e)),),
                    Text('_eCAMPUS',style:TextStyle(fontSize: 20),),
                  ],
                ),
                SizedBox(width: 40,),
                Container(
                  width: 40,
                  height: 40,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                  ),
                  child:Center(
                    child:Icon(Icons.dashboard,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius:BorderRadius.circular(10)
                    )
                    ,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: "search..."
                    ),
                  ),
                )),
                Expanded(child:Container()),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.1),
                        ),

                      ),
                      Positioned(
                          top: 5,
                          left: 5,
                          right: 5,
                          bottom: 5
                          ,child:CircleAvatar(
                        backgroundImage:AssetImage('lib/adminstration/img/tunisie.png'),
                      ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned(
                          child:CircleAvatar(
                            backgroundColor:Colors.black.withOpacity(0.05),
                            child: Icon(Icons.notifications_none,color: Colors.black,),
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.03),
                        ),
                      ),
                      Positioned(
                          child:CircleAvatar(
                            backgroundColor:Colors.black.withOpacity(0.03),

                            child:Icon(Icons.email_outlined,color: Colors.black,),
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          radius:20,
                          child:Image.asset('lib/adminstration/img/Capture d’écran 2023-05-28 190421.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ISIMM',style:TextStyle(fontWeight: FontWeight.bold),),
                          Text('Adminstration',style:TextStyle(color: Colors.blue),)

                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                height: 551,
                width: 222,
                color:Colors.white,
                child:ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Text('Menu principal',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap:(){
                              Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>AnnonceAdmistration()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal:10,vertical:3),
                              child: Padding(
                                padding: const EdgeInsets.only(),
                                child: Row(
                                  children: [
                                    Icon(Icons.home,color: Colors.black54,size: 15,),
                                    SizedBox(width: 20,),
                                    Text('Acceuille',style:TextStyle(color:Colors.black54)),
                                    Expanded(child: Container()),
                                    SizedBox(width:10,),
                                    Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal:10,vertical:3),


                            child: Row(
                              children: [
                                Container(
                                    decoration: isSelected
                                        ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                        : null,
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/prof.png',color: Colors.black54,)),
                                SizedBox(width: 20,),
                                Text('enseignants',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25,
                                    decoration: isSelected
                                        ? BoxDecoration(

                                      borderRadius: BorderRadius.circular(10),
                                    )
                                        : null
                                    ,child: Image.asset('lib/adminstration/img/etudiant-diplome.png')),
                                SizedBox(width: 20,),
                                GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ListEtud()));
                                    }
                                    ,child: Text('Etudiants',style:TextStyle(color:Colors.black54,))),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('Extra',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/discuter.png')),
                                SizedBox(width: 10,),
                                GestureDetector(
                                    onTap:(){

                                      Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ChatAdminEnseignant(userId: '1', name: 'hghg',)));
                                    }
                                    ,child: Text('Boite De Recéption',style:TextStyle(color:Colors.black54,))),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/presse-papiers.png')),
                                SizedBox(width: 10,),
                                GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Resultats()));
                                    }
                                    ,child: Text('Résultats',style:TextStyle(color:Colors.black54,))),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/discuter.png')),
                                SizedBox(width: 10,),
                                GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>DateExamen()));
                                    }
                                    ,child: Text('Horaires Examens',style:TextStyle(color:Colors.black54,))),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap:(){
                              //     Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>EmploiDuTemps()));
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal:10,vertical:3),
                                decoration: BoxDecoration(
                                  color: Color(0xFF3d5ee1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              child: Row(
                                children: [
                                  Container(
                                      height: 25,
                                      width: 25
                                      ,child: Image.asset('lib/adminstration/img/emploi-du-temps.png',color: Colors.white,)),
                                  SizedBox(width: 10,),
                                  Text('Emploi Du temps',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                                  Expanded(child: Container()),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,)
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Text('Autre',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap:(){
                              Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>rapport()));
                            },
                            child: Container(
                                height: 25,
                                width: 25
                                ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          ),
                          SizedBox(width: 10,),
                          GestureDetector(
                              onTap:(){
                                Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>rapport()));
                              }
                              ,child: Text('Rapports PFE',style:TextStyle(color:Colors.black54,))),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>pfebook()));

                      }
                      ,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap:(){
                              Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>pfebook()));
                            },
                            child: Container(
                                height: 25,
                                width: 25
                                ,child: Image.asset('lib/adminstration/imagepfe/téléchargement (14).png')),
                          ),
                          SizedBox(width: 10,),
                          Text('PFE BOOK',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    ),
                    GestureDetector(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Soci()));
                      }
                      ,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/imagepfe/téléchargement (15).png')),
                          SizedBox(width: 10,),
                          Text('Société',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    ),
                    Text('Gestion',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Dep()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                height: 25,
                                width: 25
                                ,child: Image.asset('lib/adminstration/imagepfe/images (8).png')),
                            SizedBox(width: 10,),
                            Text('Departements',style:TextStyle(color:Colors.black54,)),
                            Expanded(child: Container()),
                            Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Classe()));
                      }
                      ,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                height: 25,
                                width: 25
                                ,child: Image.asset('lib/adminstration/imagepfe/images (8).png')),
                            SizedBox(width: 10,),
                            Text('Classes',style:TextStyle(color:Colors.black54,)),
                            Expanded(child: Container()),
                            Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Subj()));

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                height: 25,
                                width: 25
                                ,child: Image.asset('lib/adminstration/imagepfe/téléchargement (17).png')),
                            SizedBox(width: 10,),
                            Text('Matieres',style:TextStyle(color:Colors.black54,)),
                            Expanded(child: Container()),
                            Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            Container(
              margin: EdgeInsets.only(left: 25),
              height: 500, width: 1020,
              child:Container(
                height: 100,
                color: Colors.blue,
                child:   Container(
                  height: 530,
                  color: Color(0xFff7f7fa),
                  child:ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      Row(
                        children: [
                          Text('Emploi Du temps',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
                          ,Expanded(child: Container()),
                          Text('Home   /'),
                          Text('  Emploi Du temps',style:TextStyle(color: Colors.black38),)
                        ],
                      ),
                      SizedBox(height: 15,),

                      Container(
                          height: 1000,
                          width: 550,
                          color:Colors.white,
                          child: Column(

                            children: [
                              Row(
                                children: [
                                  Text(
                                    'classe',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF26519e),
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  DropdownButton<String>(
                                    value: _selectedOption,
                                    items: classe.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedOption = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    'Section',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF26519e),
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  DropdownButton<String>(
                                    value: _selectedOptionn,
                                    items: typeclasse.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedOptionn = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    'TD',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF26519e),
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  DropdownButton<String>(
                                    value: _selectedOptionnn,
                                    items: TD.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedOptionnn = value!;
                                      });
                                    },
                                  ),

                                ],
                              ),

                              SizedBox(height: 10,),
                              SizedBox(
                                height: 30,
                                width: 85,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF3d5ee1),
                                  ),
                                  onPressed: () {
                                    ConfirmerDateEmploi();
                                    List<List<String>> savedData = [];
                                    for (var row in rowControllers) {
                                      List<String> rowData = [];
                                      for (var cell in row) {
                                        rowData.add(cell.join(', '));
                                      }
                                      savedData.add(rowData);
                                    }
                                    EnvoiBack();
                                  },
                                  child: Text(
                                    'Envoyer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10,),
                              Container(
                                width: 1300,
                                child: Table(
                                  border: TableBorder.all(),
                                  key: _tableKey,
                                  children: [
                                    _buildRow(['Horaire', '8:30_10:00', '8:30_10:00', '12:00_13:30', '13:30_14:45', '14:45_16:15', '16:30_18:00'], isHeader: true, rowIndex: 0),
                                    _buildRow(['Lundi', '', '', '', '', '', ''], rowIndex: 1),
                                    _buildRow(['Mardi', '', '', '', '', '', ''], rowIndex: 2),
                                    _buildRow(['Mercredi', '', '', '', '', '', ''], rowIndex: 3),
                                    _buildRow(['Jeudi', '', '', '', '', '', ''], rowIndex: 4),
                                    _buildRow(['Vendredi', '', '', '', '', '', ''], rowIndex: 5),
                                    _buildRow(['Samedi', '', '', '', '', '', ''], rowIndex: 6),
                                  ],
                                ),
                              ),
                            ],)
                      )

                    ],
                  ),
                ),




              ),
            )
            ],
          )
        ],),
      ),
    );

  }

}
