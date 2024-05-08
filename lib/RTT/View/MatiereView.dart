import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:untitled65/RTT/repositories/MatiereRepository.dart';

import '../../Api/ApiMatieres.dart';
import '../ViewModel/MatiereViewModel.dart';
class Subj extends StatefulWidget {
  const Subj({Key? key}) : super(key: key);

  @override
  State<Subj> createState() => _SubjState();
}

class _SubjState extends State<Subj> {
  Future<Map<String,dynamic>> getEnseignant()async{
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Accept': 'application/json' //ajout du header CORS dans la requête

    };
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/matieres'),
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
  final MatiereViewModel MVM;
  _SubjState() : MVM = MatiereViewModel(ApiMat() as MatiereRepository);
  StreamController<List<dynamic>> _streamController = StreamController.broadcast();

  late TextEditingController idd ;
  late TextEditingController nom;
  late TextEditingController prenom ;
  late TextEditingController classe ;
  late TextEditingController matiere ;
  late TextEditingController phone ;
  late TextEditingController mail ;
  late TextEditingController prenomm ;
  bool isSelected=true;

  @override
  void initState() {
    _streamController =  StreamController.broadcast();
    getEnseignant();
    super.initState();
  }

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
                                        Icon(Icons.home,color: Colors.black54,),
                                        SizedBox(width: 20,),
                                        Text('Acceuille',style:TextStyle(color:Colors.black54,)),
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

                                         //   Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ChatAdminEnseignant(userId: '1', name: 'hghg',)));
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
                                          //  Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>DateExamen()));
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
                                    //Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>rapport()));
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
                                  //  Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>pfebook()));
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
                             // Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>Soci()));
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal:10,vertical:3),
                            decoration: BoxDecoration(
                              color: Color(0xFF3d5ee1),
                              borderRadius: BorderRadius.circular(10),
                            )
                            ,child: Row(
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
                              Text('Matieres',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                              Expanded(child: Container()),
                              Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,)
                            ],
                          ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 20,right: 30,left: 30),
                        width: 1020,
                        height: 530,
                        color: Color(0xFff7f7fa),
                        child:ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: [
                            Row(
                              children: [
                                Text('Liste de Matieres ',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
                                ,Expanded(child: Container()),
                                Text('Home   /'),
                                Text('  Matieres',style:TextStyle(color: Colors.black38),)
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 250,
                                  color: Colors.white,
                                  child:Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextFormField(
                                      decoration:InputDecoration(
                                          hintText: "Rechercher par identifiant",
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Container(
                                  height: 50,
                                  width:250,
                                  color: Colors.white,
                                  child:Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextFormField(
                                      decoration:InputDecoration(
                                          hintText: "Rechercher par nom",
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Container(
                                  height: 50,
                                  width: 250,
                                  color: Colors.white,
                                  child:Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextFormField(
                                      decoration:InputDecoration(
                                          hintText: "Rechercher par phone",
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Container(
                                  height: 50,
                                  width: 100,
                                  color: Colors.purple,
                                  child:Center(child: Text('Search',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                              height: 700,
                              width: 500,
                              color:Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: ElevatedButton(onPressed:(){
                                      ElevatedButton.styleFrom(
                                          backgroundColor:Colors.blue
                                      );
                                      showDialog(context:context,
                                          builder:(context){
                                            return AlertDialog(
                                              content:Container(
                                                height:200,
                                                width: 200,
                                                child:Column(
                                                  children: [
                                                    Text('Ajouter Matiere',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,                                color: Color(0xFF3d5ee1),
                                                    ),)
                                                    ,SizedBox(height: 30,),
                                                    Container(
                                                        width: 230,
                                                        height: 80
                                                        ,child:TextFormField(
                                                      controller: prenomm = TextEditingController(
                                                          text:"Nom Matiere"),
                                                      decoration: InputDecoration(
                                                        labelText: 'Nom Matiere' ,
                                                        labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                        border: OutlineInputBorder(),
                                                        helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                      ),
                                                    )
                                                    ),
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
                                                      setState(() {
                                                        MVM.addMatiere(prenomm.text);
                                                        getEnseignant();
                                                        Navigator.pop(context,null);
                                                      });
                                                    }, child:Text('Ajouter',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),


                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    }, child: Text('+',style:TextStyle(fontWeight: FontWeight.bold),)),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 5,),
                                      Expanded(
                                          flex:0
                                          ,child: Text('#',style:TextStyle(fontWeight: FontWeight.bold),)),
                                      SizedBox(width:40,),
                                      Container(
                                          width: 213,
                                          child: Text('Nom.Matiére',style:TextStyle(fontWeight: FontWeight.bold),)),
                                      Container(
                                          width: 180,
                                          child: Text('Nombre de classes',style:TextStyle(fontWeight: FontWeight.bold),)),
                                      Container(
                                          width: 250
                                          ,child: Text('Nombre de enseignants',style:TextStyle(fontWeight: FontWeight.bold),)),

                                      Expanded(
                                          flex: 1
                                          ,child: Text('Actions',style:TextStyle(fontWeight: FontWeight.bold),)),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Expanded(
                                    child: Container(
                                      constraints: BoxConstraints(minHeight: 50),
                                      child: StreamBuilder<Map<String,dynamic>>(
                                          stream: Stream.fromFuture(getEnseignant()),
                                          builder: (context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(child: CircularProgressIndicator());
                                            }
                                            var data = snapshot.data!;
                                            List<dynamic> matieres = snapshot.data!['matieres'];
                                            return ListView.builder(
                                              itemCount: matieres.length,
                                              itemBuilder: (context, id) {
                                                var col;
                                                (id % 2 != 0) ? col = Color(0xFFfafafa) : col = Color(0xFFffffff);
                                                return Container(
                                                  color: col,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 5,),
                                                        Expanded(
                                                          flex:0.9.toInt(),
                                                          child: Text(
                                                            matieres[id]['id'].toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(width:45,),
                                                        /*  CircleAvatar(
                                                          radius: 17,
                                                          backgroundImage: NetworkImage(
                                                              "http://192.168.1.13/ISIMM_eCampus/storage/app/public/${data!['enseignants'][id]['image']}"
                                                          ),
                                                        ),*/
                                                        SizedBox(width: 10),
                                                        Container(
                                                          width: 250,
                                                          child: Text(
                                                            matieres[id]['nom'],
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 200,
                                                          child: Text(
                                                            matieres[id]['enseignants_count'].toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        Container(
                                                            width: 170,
                                                            child:Text(matieres[id]['enseignants_count'].toString())),
                                                        Expanded(
                                                            flex: 1
                                                            ,child: Row(
                                                          children: [
                                                            IconButton(
                                                                onPressed: () {
                                                                  showDialog(context:context,
                                                                      builder:(context){
                                                                        return AlertDialog(
                                                                          content:Container(
                                                                            height:200,
                                                                            width: 500,
                                                                            child:Column(
                                                                              children: [
                                                                                Text('Modifier Matiere',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,                                color: Color(0xFF3d5ee1),
                                                                                ),)
                                                                                ,SizedBox(height: 30,),
                                                                                Row(
                                                                                  children: [
                                                                                    Container(
                                                                                        margin: EdgeInsets.symmetric(horizontal: 50),
                                                                                        width: 400,
                                                                                        height: 80
                                                                                        ,child:TextFormField(
                                                                                      controller: nom = TextEditingController(
                                                                                          text:matieres[id]['nom']),
                                                                                      decoration: InputDecoration(
                                                                                        labelText: 'Nom Matiére',
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
                                                                                        //    com.UpdateEnseignant(nom.text,matieres[id]['id']);
                                                                                        MVM.updateMatiere(nom.text, matieres[id]['id']);
                                                                                        Navigator.pop(context,null);
                                                                                        getEnseignant();
                                                                                      });
                                                                                    }, child:Text('Modifier',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),

                                                                                  ],
                                                                                )

                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                                icon: Container(
                                                                    height: 22,
                                                                    width: 22,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.green.withOpacity(0.17),
                                                                        borderRadius: BorderRadius.circular(3)
                                                                    ),child: Icon(Icons.edit,color: Colors.green.withOpacity(0.6),size: 18,))
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  showDialog(context:context, builder:(context){
                                                                    return AlertDialog(
                                                                      content:Container(
                                                                        width: 380,
                                                                        height: 130,
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text("Voulez-vous vraiment supprimer ce compte ?",style:TextStyle(fontWeight: FontWeight.w600,color: Color(0xFF3d5ee1),),),
                                                                            SizedBox(height: 15,),
                                                                            Text("Attention ! Tout le contenu de ce compte, les donneés du ce compte seront définitivement perdus.",style:TextStyle(color: Colors.grey),),
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
                                                                                    MVM.deleteMatiere(matieres[id]['id']);
                                                                                    print("aaa");
                                                                                    getEnseignant();
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
                                                                },
                                                                icon: Container(
                                                                    height: 22,
                                                                    width: 22,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.redAccent.withOpacity(0.17),
                                                                        borderRadius: BorderRadius.circular(3)
                                                                    ),child: Icon(Icons.delete_outline_outlined,color: Colors.redAccent.withOpacity(0.6),size: 18,))
                                                            ),
                                                          ],
                                                        ))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                            Center(child: Text('COPYRIGHT © ISIMM_eCAMPUS',style:TextStyle(fontSize: 16,color: Colors.grey),))
                          ],))])])));}}