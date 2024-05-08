import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:untitled65/Api/ApiPFEBOOK.dart';
import 'package:untitled65/Views/Societe.dart';
import 'package:untitled65/Views/rapport.dart';
import 'dart:html' as html;

import '../ViewModel/PFEBOOKViewModel.dart';
class pfebookm extends StatefulWidget {
  const pfebookm({Key? key}) : super(key: key);

  @override
  State<pfebookm> createState() => _pfebookmState();
}

class _pfebookmState extends State<pfebookm> {
  Future<Map<String,dynamic>> getDepa()async{
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json' //ajout du header CORS dans la requête

    };
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/pfeBooks'),
        headers: headers
    );
    var data = jsonDecode(response.body) as Map<String, dynamic> ;
    if(response.statusCode==200){
      print(data);
      return data ;
    }else{
      print(response.statusCode);
      print(data);

      return jsonDecode(response.body);
    }
  }
  final PfeBookViewModel PVM;
  _pfebookmState() : PVM = PfeBookViewModel(ApiPfeBook());

  StreamController<List<dynamic>> _streamController = StreamController.broadcast();


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
    final url = "http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_pfeBook"; // Replace with the endpoint URL of your backend

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C';
    request.headers['Accept'] = 'application/json';
    request.headers['Access-Control-Allow-Origin'] = '*';
    request.fields['titre'] = titre;
    request.fields['societe'] = mail;
    request.fields['description'] = description;

    request.files.add(http.MultipartFile.fromBytes(
      'rapport',
      fileBytes,
      filename: file.name,
    ));

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('File sent successfully!');
    } else {
      print(jsonDecode(response.body));
      print('Error sending the file: ${response.statusCode}');
    }
  }

  late TextEditingController idd ;
  late TextEditingController nom;
  late TextEditingController prenom ;
  late TextEditingController classe ;
  late TextEditingController matiere ;
  late TextEditingController mail ;



  @override
  void initState() {
    _streamController =  StreamController.broadcast();
    setState(() {
      getDepa();
    });
    getDepa();
    super.initState();
  }
  List<Color> list =[
    Colors.yellow,
    Colors.green,
    Colors.pink,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.yellow,
    Colors.green,
    Colors.pink,
    Colors.blue,
    Colors.red,
    Colors.purple
  ];
  bool showModificationDialog = false;

  bool isSelected =true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color(0xFff7f7fa),
        body:Container(
            child:Column(children: [
              Container(
                height: 50,
                padding:EdgeInsets.symmetric(horizontal: 0),
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
                          padding: const EdgeInsets.only(top: 10.0,right: 10),
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
                                          //  Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ListEnse()));
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
                                         //   Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ListEtud()));
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

                                       //     Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ChatAdminEnseignant(userId: '1', name: 'hghg',)));
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
                                         //   Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Resultats()));
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
                                         //   Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>DateExamen()));
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
                                  Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>pfebookm()));

                            }
                            ,child:    Container(
                            padding: EdgeInsets.symmetric(horizontal:10,vertical:3),
                            decoration: BoxDecoration(
                              color: Color(0xFF3d5ee1),
                              borderRadius: BorderRadius.circular(10),
                            )
                            ,

                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>pfebookm()));
                                  },
                                  child: Container(
                                      height: 25,
                                      width: 25
                                      ,child: Image.asset('lib/adminstration/imagepfe/téléchargement (14).png',)),
                                ),
                                SizedBox(width: 10,),
                                Text('PFE BOOK',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,)
                              ],
                            ),
                          ),
                          ),
                          GestureDetector(
                            onTap:(){
                              Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Socier()));
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
                             // Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Dep()));
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
                            //  Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Classe()));
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

                            //  Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Subj()));

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
                      height: 550,

                      width: 1022,
                      color: Colors.blue.withOpacity(0.03),
                      child:Column(
                        children: [
                          Container(height: 50,
                            width: 1000,
                            padding: EdgeInsets.only(right: 30,left: 30),
                            child:Row(
                              children: [
                                Text('Espace PFE',style:TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                                Text('  "PFE BOOK"',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)
                                ,Expanded(child:Container()),
                                Container(
                                  width: 150,
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
                                                  height:280,
                                                  width: 500,
                                                  child:Column(
                                                    children: [
                                                      Text('Ajouter PFE BOOK',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,                                color: Color(0xFF3d5ee1),
                                                      ),)
                                                      ,SizedBox(height: 30,),
                                                      Row(
                                                        children: [
                                                          Container(
                                                              width: 230,
                                                              height: 80
                                                              ,child:TextFormField(
                                                            controller: nom = TextEditingController(
                                                            ),
                                                            decoration: InputDecoration(
                                                              labelText: 'Titre',
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
                                                            controller:  prenom = TextEditingController(
                                                            ),
                                                            decoration: InputDecoration(
                                                              labelText: 'Description',
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
                                                            controller: mail = TextEditingController(
                                                            ),
                                                            decoration: InputDecoration(
                                                              labelText: 'Societe',
                                                              labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                              border: OutlineInputBorder(),
                                                              helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                                              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                            ),
                                                          )
                                                          ),
                                                          SizedBox(width: 15,),
                                                          TextButton(onPressed:(){
                                                            pickFile(nom.text, prenom.text,mail.text);
                                                          }, child:Text('Pick file')),

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
                                                              // com.UpdateEnseignant(nom.text,prenom.text,mail.text,phone.text,data['enseignants'][id]['id']);
                                                              Navigator.pop(context,null);
                                                              getDepa();
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
                                          child: Text('  :Pick File',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black),))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 500,
                            child: StreamBuilder<Map<String,dynamic>>(
                                stream:Stream.fromFuture(getDepa()),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  } else {
                                    List<dynamic> rapport = snapshot.data!['rapports'];
                                    return GridView.builder(
                                        itemCount: rapport.length,
                                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                        ), itemBuilder:(context,id){
                                      return Container(
                                        padding: EdgeInsets.all(12),
                                        height: 210,
                                        margin: EdgeInsets.only(left: 20,top: 20),
                                        color: Colors.white,
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Image.asset('lib/adminstration/imagepfe/téléchargement (7).png',height: 40,),
                                                Expanded(child: Container()),
                                                Container(
                                                  width: 60,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Color(0xFFe8f9f9),
                                                  ),
                                                  child:Center(
                                                    child:Text('Done',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                                                  ),
                                                ),
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
                                                        showDialog(context:context, builder:(context){
                                                          return AlertDialog(
                                                            content:Container(
                                                              width: 380,
                                                              height: 130,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text("Voulez-vous vraiment supprimer ce PFE BOOK ?",style:TextStyle(fontWeight: FontWeight.w600,color: Color(0xFF3d5ee1),),),
                                                                  SizedBox(height: 15,),
                                                                  Text("Attention ! Tout le contenu et les donneés du ce fichier seront définitivement perdus.",style:TextStyle(color: Colors.grey),),
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
                                                                          PVM.deletePfeBook(rapport[id]['id']);
                                                                          getDepa();
                                                                          Navigator.pop(context,null);
                                                                        });
                                                                      }, child:Text('Supprimer',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });

                                                      });
                                                    } else if (value == 'modifier') {
                                                      setState(() {
                                                        showModificationDialog = true;
                                                      });
                                                      final tita = TextEditingController(
                                                          text: "f");
                                                      showDialog(context:context,
                                                        builder:(context){
                                                          return AlertDialog(
                                                            content:Container(
                                                              height:270,
                                                              width: 500,
                                                              child:Column(
                                                                children: [
                                                                  Text('Modifier',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,                                color: Color(0xFF3d5ee1),
                                                                  ),)
                                                                  ,SizedBox(height: 30,),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          width: 230,
                                                                          height: 80
                                                                          ,child:TextFormField(
                                                                        controller: nom = TextEditingController(
                                                                            text: rapport[id]['titre']),
                                                                        decoration: InputDecoration(
                                                                          labelText: 'Titre',
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
                                                                        controller:  prenom = TextEditingController(
                                                                            text: rapport[id]['description']),
                                                                        decoration: InputDecoration(
                                                                          labelText: 'Description',
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
                                                                        controller: mail = TextEditingController(
                                                                            text:rapport[id]['id'].toString()),
                                                                        decoration: InputDecoration(
                                                                          labelText: 'ID',
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
                                                                        controller: mail = TextEditingController(
                                                                            text: rapport[id]['annee']),
                                                                        decoration: InputDecoration(
                                                                          labelText: "annee",
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
                                                                          backgroundColor: Color(0xFF3d5ee1),
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                          ),
                                                                        ),
                                                                        onPressed: () {
                                                                          setState(() {
                                                                            print(rapport[id]['id']);
                                                                            PVM.updatePfeBook(nom.text, prenom.text, rapport[id]['id']);
                                                                            Navigator.pop(context, null);
                                                                            getDepa();
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                          'Modifier',
                                                                          style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            color: Colors.white,
                                                                          ),
                                                                        ),
                                                                      )
                                                                      ),

                                                                    ],
                                                                  )

                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },

                                                      );    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 9,),
                                            Text(rapport[id]['titre'],style:TextStyle(fontWeight: FontWeight.bold),),
                                            SizedBox(height: 2,),
                                            SizedBox(
                                              width: 25,
                                              child: Divider(
                                                thickness: 1,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Expanded(child: Text(rapport[id]['description'],style:TextStyle(color: Colors.black.withOpacity(0.8)),)),
                                            Divider(thickness: 5,color: list[id],),
                                            SizedBox(height: 2,),
                                            Row(
                                              children: [
                                                Image.asset('lib/adminstration/img/calendrier.png',height: 15,),
                                                SizedBox(width: 5,),
                                                Text(rapport[id]['created_at'].substring(0, 10) ,style:TextStyle(fontSize: 12),),
                                                Expanded(child: Container()),
                                                TextButton(
                                                  onPressed: () {},
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Text(
                                                        'Download',
                                                        style: TextStyle(),
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        left: 0,
                                                        right: 0,
                                                        child: Container(
                                                          height: 1,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });}
                                }
                            ),
                          ),
                        ],
                      ),
                    )
                  ])

            ]

            )


        ));}}
