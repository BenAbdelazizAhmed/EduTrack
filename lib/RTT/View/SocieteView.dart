
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

import '../ViewModel/SocieteViewModel.dart';
import '../services/Api/ApiSociete.dart';

class Socim extends StatefulWidget {


  const Socim({Key? key,

  }) : super(key: key);

  @override
  State<Socim> createState() => _SocimState();
}

class _SocimState extends State<Socim> {
  final SocieteViewModel DVM;
  _SocimState() : DVM = SocieteViewModel(ApiSocie());
  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  TextEditingController textannonce =TextEditingController();
  Future<Map<String, dynamic>> getSocietes() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };



    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/societes'),
      headers: headers,
    );
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      return jsonData;
    } else {
      print(jsonData);
      throw Exception('Failed to load data');
    }
  }
  late TextEditingController idd ;
  late TextEditingController nom;
  late TextEditingController prenom ;
  late TextEditingController classe ;
  late TextEditingController matiere ;
  late TextEditingController mail ;
  late TextEditingController nomsoc;
  late TextEditingController AdresseSoc;
  late TextEditingController webSoc;
  late TextEditingController telephone ;
  late TextEditingController apropos ;
  late TextEditingController nomsoc1;
  late TextEditingController AdresseSoc1;
  late TextEditingController webSoc1;
  late TextEditingController telephone1 ;
  late TextEditingController apropos1 ;

  void pickFile(String titre, String description, String mail) async {
    final input = html.FileUploadInputElement();
    input.accept = 'application/pdf'; // Accept only PDF files
    input.click();

    await input.onChange.first;

    final file = input.files!.first;

    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);

    await reader.onLoadEnd.first;

    final fileBytes = List<int>.from(reader.result as List<num>);

    // Send the file to the backend using http




  }

  String imgselect=" ";
  late List<int> a;
  var b="";
  void pickImage() async {
    final input = html.FileUploadInputElement();
    input.accept = 'image/*'; // Accept all image file types
    input.click();

    await input.onChange.first;

    final file = input.files!.first;

    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);

    await reader.onLoadEnd.first;

    final fileBytes = List<int>.from(reader.result as List<int>);
    setState(() {
      imgselect=file.name;
      a=fileBytes;
      print(imgselect);
    });

  }
  Future<void> postSociete(String nomsoc,description,siteweb,adresse,telephone, image) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_societe'));

    request.fields['nom'] = nomsoc;
    request.fields['a_propos'] = description;
    request.fields['site_web'] = siteweb;
    request.fields['adresse'] = adresse;
    request.fields['telephone'] = telephone;
    request.fields['email'] = "fdsfd@gmail.com";

    var headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json'

    };

    request.headers.addAll(headers);

    request.files.add(http.MultipartFile.fromBytes(
      'image',
      a,
      filename: imgselect,
    ));

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('Image sent successfully!');
    } else {
      print(response.body);
      print('Error sending the image: ${response.statusCode}');
    }
  }
  Future<void> deleteSociet(int annonceId) async {

    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_societe/${annonceId}'),
      headers: {
        'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Announcement deleted successfully');
      print(data);
    } else {
      print('An error occurred while deleting the announcement');
      print(response.body);
    }

  }
  UpdateAnnonce(String email,telephone,adresse,siteweb, int idannonce) async {
    http.Response response = await http.patch(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/update_societe/${idannonce}?email=${email}&telephone=${telephone}&adresse=${adresse}&site_web=${siteweb}"),

        headers: {
          'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
          'Accept': 'application/json'
        }
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Update avec succes");

      print(data);
    } else {
      print(data);
    }
  }

  @override
  void initState() {
    super.initState();
    getSocietes();
    setState(() {
      _streamController =  StreamController.broadcast();
      getSocietes();
    });
  }

  bool isSelected = false;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
  var uuid =Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFff7f7fa),
      //Color(0xFff7f7fa)
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
                          child:Image.asset('lib/ISIM_LOGO_ar.png')),
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
                              color: Color(0xFF3d5ee1),
                              borderRadius: BorderRadius.circular(10),
                            )
                            ,
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: Row(
                                children: [
                                  Icon(Icons.home,color: Colors.black54,),
                                  SizedBox(width: 20,),
                                  Text('Acceuille',style:TextStyle(color:Colors.black54,fontWeight: FontWeight.bold)),
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
                                      color: Color(0xFF3d5ee1),
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                        : null,
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/prof.png')),
                                SizedBox(width: 20,),
                                GestureDetector(
                                    onTap:(){
                                  //    Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ListEnse()));
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
                                      color: Color(0xFF3d5ee1),
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                        : null
                                    ,child: Image.asset('lib/adminstration/img/etudiant-diplome.png')),
                                SizedBox(width: 20,),
                                GestureDetector(
                                    onTap:(){
                                    // Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ListEtud()));
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

                                  //    Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ChatAdminEnseignant(userId: '1', name: 'hghg',)));
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
                                      //Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Resultats()));
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
                                      //Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>DateExamen()));
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
                             /// Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>rapport()));
                            },
                            child: Container(
                                height: 25,
                                width: 25
                                ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          ),
                          SizedBox(width: 10,),
                          GestureDetector(
                              onTap:(){
                               // Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>rapport()));
                              }
                              ,child: Text('Rapports PFE',style:TextStyle(color:Colors.black54,))),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                       // Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>pfebook()));

                      }
                      ,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap:(){
                             // Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>pfebook()));
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
                        Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Socim()));
                      }
                      ,child: Container(
                      padding: EdgeInsets.symmetric(horizontal:10,vertical:3),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      )
                      ,
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
                      //  Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Dep()));
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
                       // Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Classe()));
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
                       // Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Subj()));

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

              Expanded(
                child: Container(
                  height:551 ,
                  color: Colors.grey.withOpacity(0.01),
                  child:Stack(
                    children: [
                      Container(
                        height: 170,
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      Positioned(
                        top: 10
                        ,child:Container(height: 50,
                        width: 1000,
                        padding: EdgeInsets.only(right: 30,left: 30),
                        child:Row(
                          children: [
                            Text('My Courses for',style:TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                            Text('  "All Courses"',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)
                            ,Expanded(child:Container()),
                            Container(
                              width: 180,
                              height: 30,
                              color: Colors.white,
                              child:Row(
                                children: [
                                  Image.asset('lib/adminstration/imagepfe/images (2).jpg'),
                                  TextButton(
                                      onPressed:() {
                                        showDialog(context: (context), builder: (context) {
                                          return AlertDialog(
                                            content:Container(
                                              height:380,
                                              width: 500,
                                              child:Column(
                                                children: [
                                                  Text('Ajouter Société ',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,                                color: Color(0xFF3d5ee1),
                                                  ),)
                                                  ,SizedBox(height: 30,),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width: 230,
                                                          height: 80
                                                          ,child:TextFormField(
                                                        controller: nomsoc = TextEditingController(
                                                        ),
                                                        decoration: InputDecoration(
                                                          labelText: 'Titre Societe',
                                                          labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                          border: OutlineInputBorder(),
                                                          helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                        ),
                                                      )
                                                      ),
                                                      SizedBox(width: 15,),
                                                      Container(
                                                          width: 230,
                                                          height: 80
                                                          ,child:TextFormField(
                                                        controller:  AdresseSoc = TextEditingController(
                                                        ),
                                                        decoration: InputDecoration(
                                                          labelText: 'Adresse Sociéte',
                                                          labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                          border: OutlineInputBorder(),
                                                          helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                        ),
                                                      )
                                                      ),

                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width: 230,
                                                          height: 80
                                                          ,child:TextFormField(
                                                        controller: webSoc = TextEditingController(
                                                        ),
                                                        decoration: InputDecoration(
                                                          labelText: 'Site Web',
                                                          labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                          border: OutlineInputBorder(),
                                                          helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                        ),
                                                      )
                                                      ),
                                                      SizedBox(width: 15,),
                                                      Container(
                                                          width: 230,
                                                          height: 80
                                                          ,child:TextFormField(
                                                        controller:  telephone = TextEditingController(
                                                        ),
                                                        decoration: InputDecoration(
                                                          labelText: 'Telephone',
                                                          labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                          border: OutlineInputBorder(),
                                                          helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                        ),
                                                      )
                                                      ),

                                                    ],
                                                  ),
                                                  Row(
                                                    children: [

                                                      Container(
                                                          width: 500,
                                                          height: 80
                                                          ,child:TextFormField(
                                                        controller: apropos = TextEditingController(
                                                        ),
                                                        maxLines: 4,
                                                        decoration: InputDecoration(
                                                          labelText: 'A propos',
                                                          labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                          border: OutlineInputBorder(),
                                                          helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                        ),
                                                      )
                                                      ),

                                                    ],
                                                  ),
                                                  SizedBox(height: 15,),
                                                  TextButton(onPressed:(){
                                                    pickImage();
                                                  }, child:Text('Pick file')),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                          width: 180,
                                                          height: 38
                                                          ,child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:Colors.red,
                                                              shape:RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10)
                                                              )
                                                          )
                                                          ,onPressed:(){
                                                        Navigator.pop(context,null);
                                                      }, child:Text('Cancel',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),
                                                      SizedBox(width: 10,),
                                                      SizedBox(
                                                          width: 180,
                                                          height: 38
                                                          ,child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:Color(0xFF3d5ee1),
                                                              shape:RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10)
                                                              )
                                                          )
                                                          ,onPressed:(){
                                                        setState(() {
                                                          postSociete(nomsoc.text, apropos.text, AdresseSoc.text, AdresseSoc.text, telephone.text, imgselect);
                                                          // com.UpdateEnseignant(nom.text,prenom.text,mail.text,phone.text,data['enseignants'][id]['id']);
                                                          Navigator.pop(context,null);
                                                          getSocietes();
                                                        });
                                                      }, child:Text('Ajouter',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),

                                                    ],
                                                  )

                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                      child: Text('  :Ajouter Societe',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black),))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      ),
                      Positioned(
                          top: 50,
                          left: 40
                          ,child:Container(
                        height: 521,
                        width: 950,
                        child: StreamBuilder<Map<String,dynamic>>(
                            stream: Stream.fromFuture(getSocietes()),
                            builder: (context, snapshot) {
                              List<dynamic> soc = snapshot.data!['sociétés'];
                              return GridView.builder(
                                  itemCount: soc.length,
                                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,),
                                  itemBuilder:(context,id){
                                    return SizedBox(
                                      height: 70,
                                      child: Container(
                                        margin: EdgeInsets.all(15),
                                        padding: EdgeInsets.all(5),
                                        width: 120,
                                        height: 80,
                                        decoration:BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  spreadRadius: 0,
                                                  blurRadius: 1,
                                                  offset:Offset(4,4)
                                              ),
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  spreadRadius: 0,
                                                  blurRadius: 1,
                                                  offset:Offset(-4,-4)
                                              )
                                            ]
                                        ),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 120,
                                              color: Colors.red,
                                              width: double.infinity,
                                              child: Image.network(
                                                "http://192.168.1.13/ISIMM_eCampus/storage/app/public/${soc[id]['image']}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),

                                            Text(soc[id]['nom'],style:TextStyle(fontWeight: FontWeight.bold),)
                                            , SizedBox(height: 5,),
                                            Text(soc[id]['adresse'],style:TextStyle(color: Colors.black.withOpacity(0.5)),)
                                            , SizedBox(height: 5,),
                                            Text(soc[id]['email'],style:TextStyle(color: Colors.black.withOpacity(0.5)),)
                                            , SizedBox(height: 5,),
                                            Text(soc[id]['site_web'],style:TextStyle(color: Colors.black.withOpacity(0.5)),)
                                            , SizedBox(height: 5,),
                                            Text('Contact',style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                            Divider(thickness: 1,),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0,left: 8,bottom: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.phone,color: Colors.blue,),
                                                      SizedBox(width: 5,),
                                                      Text("+216 "+soc[id]['telephone'],style:TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),),

                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      PopupMenuButton(
                                                        child: Icon(Icons.more_vert),
                                                        itemBuilder: (BuildContext context) =>
                                                        [
                                                          PopupMenuItem(
                                                              value: 'modifier', child: Text('Modifier')),
                                                          PopupMenuItem(
                                                              value: 'supprimer', child: Text('Supprimer')),
                                                        ],
                                                        onSelected: (value) {
                                                          if (value == 'supprimer') {
                                                            setState(() {
                                                              deleteSociet(soc[id]['id']);
                                                              getSocietes();
                                                            });
                                                          } else if (value == 'modifier') {
                                                            final tita = TextEditingController(
                                                            );
                                                            showDialog(context: (context), builder: (context) {
                                                              return AlertDialog(
                                                                content:Container(
                                                                  height:270,
                                                                  width: 500,
                                                                  child:Column(
                                                                    children: [
                                                                      Text('Modifier Société ',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,                                color: Color(0xFF3d5ee1),
                                                                      ),)
                                                                      ,SizedBox(height: 30,),
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                              width: 230,
                                                                              height: 80
                                                                              ,child:TextFormField(
                                                                            controller: nomsoc1 = TextEditingController(
                                                                            ),
                                                                            decoration: InputDecoration(
                                                                              labelText: 'Email Societe',
                                                                              labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                                              border: OutlineInputBorder(),
                                                                              helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                                            ),
                                                                          )
                                                                          ),
                                                                          SizedBox(width: 15,),
                                                                          Container(
                                                                              width: 230,
                                                                              height: 80
                                                                              ,child:TextFormField(
                                                                            controller:  AdresseSoc1 = TextEditingController(
                                                                            ),
                                                                            decoration: InputDecoration(
                                                                              labelText: 'Adresse Sociéte',
                                                                              labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                                              border: OutlineInputBorder(),
                                                                              helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                                            ),
                                                                          )
                                                                          ),

                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                              width: 230,
                                                                              height: 80
                                                                              ,child:TextFormField(
                                                                            controller: webSoc1 = TextEditingController(
                                                                            ),
                                                                            decoration: InputDecoration(
                                                                              labelText: 'Site Web',
                                                                              labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                                              border: OutlineInputBorder(),
                                                                              helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                                            ),
                                                                          )
                                                                          ),
                                                                          SizedBox(width: 15,),
                                                                          Container(
                                                                              width: 230,
                                                                              height: 80
                                                                              ,child:TextFormField(
                                                                            controller:  telephone1 = TextEditingController(
                                                                            ),
                                                                            decoration: InputDecoration(
                                                                              labelText: 'Telephone',
                                                                              labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                                              border: OutlineInputBorder(),
                                                                              helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                                            ),
                                                                          )
                                                                          ),

                                                                        ],
                                                                      ),

                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                              width: 180,
                                                                              height: 38
                                                                              ,child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                  backgroundColor:Colors.red,
                                                                                  shape:RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10)
                                                                                  )
                                                                              )
                                                                              ,onPressed:(){
                                                                            Navigator.pop(context,null);
                                                                          }, child:Text('Cancel',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),
                                                                          SizedBox(width: 10,),
                                                                          SizedBox(
                                                                              width: 180,
                                                                              height: 38
                                                                              ,child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                  backgroundColor:Color(0xFF3d5ee1),
                                                                                  shape:RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10)
                                                                                  )
                                                                              )
                                                                              ,onPressed:(){
                                                                            setState(() {
                                                                              UpdateAnnonce(nomsoc1.text, telephone1.text, AdresseSoc1.text,webSoc1.text, soc[id]['id']);
                                                                              getSocietes();
                                                                              // com.UpdateEnseignant(nom.text,prenom.text,mail.text,phone.text,data['enseignants'][id]['id']);
                                                                              Navigator.pop(context,null);

                                                                            });
                                                                          }, child:Text('Modifier',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),

                                                                        ],
                                                                      )

                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });

                                                          }
                                                        },
                                                      ),
                                                      GestureDetector(
                                                          onTap:(){
                                                            showDialog(context: (context), builder: (context) {
                                                              return AlertDialog(
                                                                content:Container(
                                                                  height:340,
                                                                  width: 500,
                                                                  child:Column(
                                                                    children: [
                                                                      Text(soc[id]['nom'],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24,
                                                                      ),),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(right: 50.0,left: 50,top: 20),
                                                                        child: Container(
                                                                          height: 100,
                                                                          width: double.infinity,
                                                                          child: Image.network(
                                                                            "http://192.168.1.13/ISIMM_eCampus/storage/app/public/${soc[id]['image']}",
                                                                            fit: BoxFit.contain,
                                                                          ),
                                                                        ),   ),
                                                                      SizedBox(height: 8,),
                                                                      Row(
                                                                        children: [
                                                                          Icon(Icons.account_balance_outlined),
                                                                          SizedBox(width: 5,),
                                                                          Text('A propos',style:TextStyle(fontWeight: FontWeight.bold),),
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: 10,),
                                                                      Text(soc[id]['a_propos']),
                                                                      SizedBox(height: 15,),

                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                              width: 180,
                                                                              height: 38
                                                                              ,child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                  backgroundColor:Colors.red,
                                                                                  shape:RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10)
                                                                                  )
                                                                              )
                                                                              ,onPressed:(){
                                                                            Navigator.pop(context,null);
                                                                          }, child:Text('Cancel',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),

                                                                        ],
                                                                      )

                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });

                                                          }
                                                          ,child: Text('More',style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                                                    ],
                                                  ),


                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          )
        ],),
      ),
    );

  }}