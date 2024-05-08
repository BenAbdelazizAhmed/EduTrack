import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled65/Views/Classes.dart';
import 'package:untitled65/Views/PFEBOOK.dart';
import 'package:untitled65/Views/rapport.dart';

import '../Api/ApiResultat.dart';
import 'Views/Boite de receptionEnseignant.dart';
import 'Views/BoiteDeReception/BoiteDeReceptionEnseignant.dart';
import 'Views/Dapartement.dart';
import 'Views/DateExamen.dart';
import 'Views/ListeEnseignant.dart';
import 'Views/ListeEtudiant.dart';
import 'Views/Matieres.dart';
import 'Views/Resultas.dart';


class presence extends StatefulWidget {
  const presence({Key? key}) : super(key: key);
  @override
  State<presence> createState() => _presence();
}

class _presence extends State<presence> {
  late String _selectedOption;
  late String _selectedOptionn;
  late String _selectedOptionnn;
  late String _selectedOptionnnn;
  late String _selectedOptionnnnn;
  late String Ma;
  String a ="1";
  String mo="1";
  List<String> classe = [
    'Ingénierie',
    'Mastére',
    'L3',
    'L2',
    'L1',
  ];

  List<String> semestre = [
    'semestre 1',
    'semestre 2',

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


  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  List<Map<String, dynamic>> modifiedResultats = [];

 List eid=[
    'lib/Views/Imageetudiant/téléchargement (11).jpg',
    'lib/Views/Imageetudiant/images (8).jpg',
    'lib/Views/Imageetudiant/images (9).jpg',
    'lib/Views/Imageetudiant/images (7).jpg',

    'lib/Views/Imageetudiant/téléchargement (12).jpg',
    'lib/Views/Imageetudiant/téléchargement (13).jpg',
    'lib/Views/Imageetudiant/istockphoto-1278978168-612x612.jpg',

    'lib/Views/Imageetudiant/téléchargement (14).jpg',
    'lib/Views/Imageetudiant/téléchargement (15).jpg',

  ];
  List Matiere=[
    'Matieres',
  ];
  Future<void> getMatiere() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/matieres'),
      headers: headers,
    );
    print("ok");
    var data = jsonDecode(response.body)['matieres'];
    if (response.statusCode == 200) {
      print(data);
      for (var ma in data) {
        print(ma);
        setState(() {
          Matiere.add(ma['id'].toString()+':'+ma['nom']);
        });
      }
    } else {
      print(data);
    }
  }


  Future<Map<String,dynamic>> getpresence() async {
    print("x");
    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/presence?matiere_id=${a}&classe_id=1'),
      headers: {
        'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },

    );

    final data = jsonDecode(response.body) as Map<String,dynamic>;
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('Résultat envoyé avec succès');
      print(data);
      return data;
    } else {
      print(response.statusCode);
      print(data);
      return data;
    }
  }
  ApiResultat com = ApiResultat();
  bool isSelected=true;
  int ba=1;
  @override
  void initState() {
    getpresence();
    getMatiere();
    _selectedOption = classe[0];
    _selectedOptionn = typeclasse[0];
    _selectedOptionnn = TD[0];
    _selectedOptionnnn = Matiere[0];
    Ma="physique";
    _selectedOptionnnnn = semestre[0];
    _streamController =  StreamController.broadcast();
    super.initState();
  }
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
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
                width: 252,
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal:10,vertical:3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            )
                            ,
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: Row(
                                children: [
                                  Icon(Icons.home,color: Colors.black54,),
                                  SizedBox(width: 20,),
                                  Text('Acceuille',style:TextStyle(color:Colors.black54)),
                                  Expanded(child: Container()),
                                  SizedBox(width:10,),
                                  Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                    ,child: Image.asset('lib/adminstration/img/prof.png')),
                                SizedBox(width: 20,),
                                GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ListEnse()));
                                    }
                                    ,child: Text('enseignants',style:TextStyle(color:Colors.black54,))),
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal:10,vertical:3),
                            decoration: BoxDecoration(
                              color: Color(0xFF3d5ee1),
                              borderRadius: BorderRadius.circular(10),
                            )
                            ,
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/presse-papiers.png',color: Colors.white,)),
                                SizedBox(width: 10,),
                                GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Resultats()));
                                    }
                                    ,child: Text('Résultats',style:TextStyle(color:Colors.white,))),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,)
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                      height: 25,
                                      width: 25
                                      ,child: Image.asset('lib/adminstration/img/emploi-du-temps.png')),
                                  SizedBox(width: 10,),
                                  Text('Emploi Du temps',style:TextStyle(color:Colors.black54,)),
                                  Expanded(child: Container()),
                                  Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
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
                  padding: EdgeInsets.only(top: 20, right: 30, left: 30),
                  width: 1020,
                  height: 530,
                  color: Color(0xFff7f7fa),
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [

                        Row(
                          children: [
                            Text('Résultats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                            Expanded(child: Container()),
                            Text('Home   /'),
                            Text('  Résultats', style: TextStyle(color: Colors.black38)),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 250,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Rechercher par identifiant",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 50,
                              width: 250,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Rechercher par nom",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 50,
                              width: 250,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Rechercher par Adresse mail",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 50,
                              width: 100,
                              color: Colors.purple,
                              child: Center(
                                child: Text(
                                  'Search',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          height: 700,
                          width: 500,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                                        mo=_selectedOptionnn.substring(2,3);
                                        print("matiere"+mo);

                                      });
                                    },
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    'Matiéres',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF26519e),
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 33,
                                    child: DropdownButton<String>(
                                      value: _selectedOptionnnn, // Pour le menu déroulant matière
                                      items: Matiere.map(
                                            (option) {
                                          return DropdownMenuItem<String>(
                                            value: option,
                                            child: Text(option),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedOptionnnn = value!;
                                          a=_selectedOptionnnn.substring(0,1);
                                          print("2023");
                                          print(a);
                                        });
                                      },
                                    ),
                                  ),

                                  SizedBox(width: 15),
                                  Text(
                                    'Semestre',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF26519e),
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  DropdownButton<String>(
                                    value: _selectedOptionnnnn,
                                    items: semestre.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedOptionnnnn = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0,bottom: 25),
                                child: Row(
                                  children: [
                                    SizedBox(width: 5),
                                    Text(
                                      'Name',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 155),
                                    Text(
                                      'Nombre des séances',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 55),
                                    Text(
                                      'Présences',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      'Absence',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 45),
                                    Text(
                                      'Status',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),

                                  ],
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 40),
                                  child: FutureBuilder<Map<String, dynamic>>(
                                    future: getpresence(),

                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(
                                          child:CircularProgressIndicator(),
                                        );
                                      }
                                      if (snapshot.data!['message']=='la matiere ne possède aucune presence') {
                                        return Center(child: Text('la matiere ne possède aucune presence'));
                                      }
                                      var data = snapshot.data!;
                                      List<dynamic> resultats = data['etudiants'];
                                      List<dynamic> abscence = data['abscence'];
                                      return ListView.builder(
                                        itemCount: 8,
                                        itemBuilder: (context, id) {
                                          var col;
                                          (id % 2 != 0) ? col = Color(0xFFfafafa) : col = Color(0xFFffffff);
                                          int j= snapshot.data!['seances']-abscence[id];
                                          print(j);
                                          print(resultats[id]['student']['nom']);
                                          print(  snapshot.data!['seances'].toString());
                                          print(  abscence[id].toString());
                                          return Container(
                                            color: col,
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 17,
                                                    backgroundImage:AssetImage(eid[id]),
                                                    // backgroundImage: NetworkImage(
                                                    //   "https://192.168.1.13/ISIMM_eCampus/storage/app/public/${resultats[id]['etudiant']['image']}",
                                                    // ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 120,
                                                    child: Text(
                                                      resultats[id]['student']['nom'] +
                                                          " " +
                                                          resultats[id]['student']['prenom'],
                                                    ),
                                                  ),
                                                  SizedBox(width: 110),
                                                  Text(
                                                   snapshot.data!['seances'].toString(),
                                                  ),
                                                  SizedBox(width: 140),
                                                  Container(
                                                    width: 110,
                                                    child: Text(
                                                      j.toString(),
                                                    ),

                                                  ),
                                              Container(
                                                width: 85,
                                                child: Text(
                                                  abscence[id].toString(),
                                                ),

                                              ),
                                                  abscence[id]>=3 ?Text(
                                               'Eliminé',style:TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                                              ):Text('Admissible',style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold))],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ])),

            ],
          )
        ],),
      ),
    );

  }
}
