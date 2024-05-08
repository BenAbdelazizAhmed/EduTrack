import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled65/Views/rapport.dart';
import 'package:uuid/uuid.dart';
import '../Api/ApiAnnonces.dart';
import 'BoiteDeReception/BoiteDeReceptionEnseignant.dart';
import 'Classes.dart';
import 'DateExamen.dart';
import 'ListeEnseignant.dart';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';

import 'ListeEtudiant.dart';
import 'Matieres.dart';
import 'PFEBOOK.dart';
import 'Resultas.dart';
class Soci extends StatefulWidget {


  const Soci({Key? key,

  }) : super(key: key);

  @override
  State<Soci> createState() => _SociState();
}

class _SociState extends State<Soci> {

  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  ApiAnnonce com = ApiAnnonce();
  TextEditingController textannonce =TextEditingController();
  Future<Map<String, dynamic>> getAnnonce() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };



    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/annonces'),
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
  Future<void> postAnnonce(String post, image) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.1.13/ISIMM_eCampus/public/api/admin/ajouter_annonce'));

    request.fields['description'] = post;

    var headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json'

    };

    request.headers.addAll(headers);

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image));
    }

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    var decodedJson = jsonDecode(responseString);
    if (response.statusCode == 200) {
      print('Annonce postée avec succès');
      print(decodedJson);
    } else {
      print(decodedJson);
      print('Erreur lors de la publication de l\'annonce');
    }
  }


  String imgselect=" ";
  void pickImage(String desc,) async {
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
      print(imgselect);
    });
    // Send the image to the backend using http
    final url = "http://192.168.1.13/ISIMM_eCampus/public/api/admin/ajouter_annonce"; // Replace with the endpoint URL of your backend

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C';
    request.headers['Accept'] = 'application/json';
    request.fields['description'] = desc;

    request.files.add(http.MultipartFile.fromBytes(
      'image',
      fileBytes,
      filename: file.name,
    ));

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('Image sent successfully!');
    } else {
      print(response.body);
      print('Error sending the image: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getAnnonce();
    setState(() {
      _streamController =  StreamController.broadcast();
      getAnnonce();
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
                              borderRadius: BorderRadius.circular(10),
                            )
                            ,
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: Row(
                                children: [
                                  Icon(Icons.home,color: Colors.white,),
                                  SizedBox(width: 20,),
                                  Text('Acceuille',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                                  Expanded(child: Container()),
                                  SizedBox(width:10,),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,)
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
                    Padding(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Subj()));

                            },
                            child: Container(
                                height: 25,
                                width: 25
                                ,child: Image.asset('lib/adminstration/imagepfe/téléchargement (17).png')),
                          ),
                          SizedBox(width: 10,),
                          Text('Matieres',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
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
                          top: 70,
                          left: 50
                          ,child:Container(
                        height: 521,
                        width: 950,
                        child: GridView.builder(
                            itemCount: 20,
                            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,),
                            itemBuilder:(context,id){
                              return SizedBox(
                                height: 70,
                                child: Container(
                                  margin: EdgeInsets.all(15),
                                  padding: EdgeInsets.all(8),
                                  width: 120,
                                  height: 70,
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
                                          height: 50,
                                          child: Image.asset('lib/adminstration/img/images (3).png',height: 40,fit: BoxFit.contain,)),
                                      SizedBox(height: 10,),
                                      Text('vermeg tunisie :',style:TextStyle(fontWeight: FontWeight.bold),)
                                      , SizedBox(height: 5,),
                                      Text('Tunisia – Tunis Rue du Lac Biwa',style:TextStyle(color: Colors.black.withOpacity(0.5)),)
                                      , SizedBox(height: 5,),
                                      Text('+216 21050601',style:TextStyle(color: Colors.black.withOpacity(0.5)),)
                                      , SizedBox(height: 5,),
                                      Text('Contact',style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                      Divider(thickness: 1,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('www.vermeg.com',style:TextStyle(fontWeight: FontWeight.bold),),
                                          GestureDetector(
                                              onTap:(){
                                                showDialog(context: (context), builder: (context) {
                                                  return AlertDialog(
                                                    content:Container(
                                                      height:270,
                                                      width: 500,
                                                      child:Column(
                                                        children: [
                                                          Text('Poxym Tunisie',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24,
                                                          ),),
                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 50.0,left: 50),
                                                            child: Image.asset('lib/adminstration/img/images (3).png'),
                                                          ),
                                                          SizedBox(height: 8,),
                                                          Row(
                                                            children: [
                                                              Icon(Icons.account_balance_outlined),
                                                              SizedBox(width: 5,),
                                                              Text('A propos',style:TextStyle(fontWeight: FontWeight.bold),),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Text("VERMEG est unansformation actuelle ete la finance, mais aussi pour accompagner ces acteurs dans la refonte de leur système d’information ; à travers la réduction de leurs coûts, la maitrise de leur Time-To-Market et la modernisation de leurs systèmes d’information."),
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
                                              ,child: Text('More',style:TextStyle(color: Colors.blue),))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
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

  }
}