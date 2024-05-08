import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled65/Views/ListeEnseignant.dart';

import 'package:uuid/uuid.dart';

import '../../../Api/ApiChat.dart';
import '../../Boite de receptionEnseignant.dart';
import '../../Classes.dart';
import '../../Dapartement.dart';
import '../../DateExamen.dart';
import '../../ListeEtudiant.dart';
import '../../Matieres.dart';
import '../../PFEBOOK.dart';
import '../../Resultas.dart';
import '../../rapport.dart';
import '../BoiteDeReceptionEnseignant.dart';
import '../MsgModel.dart';
import '../OwnMsg.dart';
import '../otherMsg.dart';

class ChatAdminEtudiant extends StatefulWidget {
  final String name;
  final String userId;
  const ChatAdminEtudiant({
    Key? key,
    required this.userId,
    required this.name,
  }) : super(key: key);

  @override
  State<ChatAdminEtudiant> createState() => _ChatAdminEtudiantState();
}

class _ChatAdminEtudiantState extends State<ChatAdminEtudiant> {
  TextEditingController _msgController = TextEditingController();
  var uuid =Uuid();
  bool isSelected=true;
late int ch;
  int selectedIndex = 14;
  IO.Socket? socket;
  List<MsgModel> listmsg = [];
  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  ApiChat com = ApiChat();

  Future<Map<String, dynamic>> getChatEnseignant() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/list_chats_etudiants'),
      headers: headers,
    );
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      setState(() {
        ch=jsonData['chats'][0]['id'];
      });

      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }


  List img=[
    'lib/Views/ImageEnsegin/téléchargement (5).jpg',

    'lib/Views/ImageEnsegin/téléchargement (4).jpg',
  ];
  Future<Map<String, dynamic>> getChatEtudiant() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };



    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/list_chats_etudiants'),
      headers: headers,
    );
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      return jsonData;

    } else {

      throw Exception('Failed to load data');
    }
  }


  Future<Map<String, dynamic>> getMsgEnseignant(int selectedindex)async{
    if(selectedIndex==14){
      setState(() {
        selectedIndex=14;
      });
    }

    Map<String, String> headers = {
      'Authorization': 'Bearer 205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/chat_messages_etudiant/${selectedIndex}'),
        headers: headers);
    var data = jsonDecode(response.body) as Map<String,dynamic>;

    if(response.statusCode==200){
      return data ;
    }else{
      return jsonDecode(response.body);
    }
  }

  var s=1;
  Future<Map<String, dynamic>> fetchChatData() async {
    final chatEnseignantFuture = getChatEnseignant();
    final chatEtudiantFuture = getChatEtudiant();
    final msgEtudientFuture = getMsgEnseignant(s);
    final chatEnseignant = await chatEnseignantFuture;
    final chatEtudiant = await chatEtudiantFuture;
    final msgEtudiant = await msgEtudientFuture;

    return {
      'chatEnseignant': chatEnseignant,
      'chatEtudiant': chatEtudiant,
      'getMsgEtudient':msgEtudiant,
    };
  }




  List<Map<String, dynamic>> combinedList = [];

  void connect() {
    // Connexion à l'instance Socket.io du serveur
    socket = IO.io('http://192.168.1.13:5000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    print("Connecté au serveur Socket.io");

    socket!.onConnect((_) {
      socket!.on("sendMsgServer", (msg) {

        print(msg['msg']);
        if (msg["userid"] != widget.userId) {
          setState(() {
            listmsg.add(MsgModel(
              type: msg["type"],
              msg: msg["msg"],
              sender: msg["senderName"],
            ));
          });
          if (msg["type"] == "otherMsg") {
          }
        }
      });
    });
  }

  void sendMsg(String msg, String sender,ids) {
    if (msg.trim().isEmpty) return; // Vérifiez que le message n'est pas vide

    MsgModel ownMsg = MsgModel(
      type: "ownMsg",
      msg: msg.trim(),
      sender: sender,
    );

    MsgModel otherMsg = MsgModel(
      type: "otherMsg",
      msg: msg.trim(),
      sender: sender,
    );

    // Ajouter le message à la liste pour l'expéditeur
    setState(() {
      listmsg.add(ownMsg);
    });

print(widget.userId);
    // Envoi du message au serveur via Socket.io
    socket?.emit('sendMsg', {
      "type": "otherMsg", // Correction du type de message à "otherMsg"
      "content": msg,
      "sender": sender,
      "userid": widget.userId ?? 1,
      "access_token": '205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C',
      "chat_id":ch,
    });

    // Efface le champ de saisie de message
    _msgController.clear();
  }

  @override
  void initState() {
    super.initState();
    getChatEnseignant();
    connect();
    setState(() {
      selectedIndex=14;
      ch=14;
      _streamController =  StreamController.broadcast();
    });
  }
  List ei=[
    'lib/Views/ImageEnsegin/téléchargement (9).jpg',
    'lib/Views/ImageEnsegin/téléchargement (4).jpg',
    'lib/Views/ImageEnsegin/téléchargement (6).jpg',
    'lib/Views/ImageEnsegin/images (6).jpg',
    'lib/Views/ImageEnsegin/téléchargement (10).jpg',
    'lib/Views/ImageEnsegin/téléchargement (7).jpg',
    'lib/Views/ImageEnsegin/téléchargement (5).jpg',
    'lib/Views/ImageEnsegin/téléchargement (8).jpg',
  ];

  var nom ="Ahmed ";
  var imgee="d";
  var idchat=9;
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
                                    ,child: Image.asset('lib/adminstration/img/discuter.png',color: Colors.white,)),
                                SizedBox(width: 10,),
                                GestureDetector(
                                    onTap:(){

                                      Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>ChatAdminEnseignant(userId: '1', name: 'hghg',)));
                                    }
                                    ,child: Text('Boite De Recéption',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,))),
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
                padding: EdgeInsets.only(top: 20,left: 20),
                width: 1010,
                height: 551,
                child:Column(
                  children: [
                    Row(
                      children: [
                        Text('Boite de Reception',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
                        ,Expanded(child: Container()),
                        Text('Home   /'),
                        Text('   Chat',style:TextStyle(color: Colors.black38),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Container(
                          height: 472,
                          width:260,
                          decoration:BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow:[
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    spreadRadius: 0,
                                    blurRadius:0.5,
                                    offset:Offset(1,1)
                                ),
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    spreadRadius: 0,
                                    blurRadius:0.5,
                                    offset:Offset(-1,-1)
                                )

                              ]
                          ),
                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  decoration:InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon:Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.search),
                                      )
                                      ,hintText: "Recherche ...",
                                      hintStyle:TextStyle(color: Colors.black.withOpacity(0.5))
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 4,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: StreamBuilder<Map<String, dynamic>>(
                                    stream: Stream.fromFuture(getChatEnseignant()),
                                    builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Text("${snapshot.error}");
                                      } else {
                                        List<dynamic> enseignants =snapshot.data!['chats'];

                                        return ListView.builder(
                                          itemCount:enseignants.length,
                                          itemBuilder: (context, id) {

                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedIndex = enseignants[id]['id'];
                                                      nom = enseignants[id]['nom'];
                                                      idchat=enseignants[id]['id'];
                                                    });
                                                  },
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: NetworkImage("http://192.168.1.13/ISIMM_eCampus/storage/app/public/${enseignants[id]['etudiant']['image']}"),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              enseignants[id]['nom'],
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              // enseignants[id]['lastmessage']['text'], // Handle null value for messages
                                                              enseignants[id]['lastmessage']['text'],
                                                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(child: Container()),
                                                        Text(
                                                          '3.15 PM',
                                                          style: TextStyle(
                                                            color: Colors.black.withOpacity(0.6),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 8,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 2,
                                                  color: Colors.black.withOpacity(0.1),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              )


                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 10, top: 8),
                          height: 472,
                          width: 720,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                spreadRadius: 0,
                                blurRadius: 0.5,
                                offset: Offset(1, 1),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                spreadRadius: 0,
                                blurRadius: 0.5,
                                offset: Offset(-1, -1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(

                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(nom,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'Connecté...',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                                ],
                              ),
                              Divider(),
                              /*Expanded(
                                child: Container(
                                  child: StreamBuilder<Map<String,dynamic>>(
                                    stream: Stream.fromFuture(getMsgEtudient()),
                                    builder:(context,AsyncSnapshot<Map<String,dynamic>> snapshot){
                                      return ListView.builder(
                                        itemCount: listmsg.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          if (listmsg[index].type == "ownMsg") {
                                            return OwnMsgWidget(msg: listmsg[index].msg);
                                          } else {
                                            return OtherMsgWidget(msg: listmsg[index].msg);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),*/
                              Expanded(
                                child: Container(
                                  child: StreamBuilder<Map<String, dynamic>>(
                                    stream: Stream.fromFuture(getMsgEnseignant(selectedIndex)),
                                    builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {


                                        List<dynamic> msg = snapshot.data!['messages'];

                                        int i = 0;
                                        return ListView.builder(
                                          itemCount: msg.length + listmsg.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            if (index < msg.length) {
                                              if (i <= msg.length) {
                                                if (msg[index]['sender_id'] == 6) {
                                                  i++;

                                                  return OwnMsgWidget(msg: msg[index]['text']);
                                                } else {
                                                  i++;

                                                  return OtherMsgWidget(msg: msg[index]['text'],img:msg[index]['etudiant']['image']);
                                                }
                                              }
                                            } else {
                                              int listMsgIndex = index - msg.length;
                                              if (listmsg[listMsgIndex].type == "ownMsg") {
                                                return OwnMsgWidget(msg: listmsg[listMsgIndex].msg);
                                              } else {
                                                return OtherMsgWidget(msg: listmsg[listMsgIndex].msg,img:msg[index]['enseignant']['image']);
                                              }
                                            }
                                            return SizedBox.shrink();
                                          },
                                        );

                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.add_circle, color: Color(0xFF3d5ee1)),
                                    Container(
                                      width: 400,
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: TextFormField(
                                        controller: _msgController,
                                        decoration: InputDecoration(
                                          hintText: "Ecrire un message...",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    SizedBox(
                                      width: 100,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3d5ee1)),
                                        ),
                                        onPressed: () {
                                          sendMsg(_msgController.text,'205|S3qPj3E0T4NQ5tJenKS2SVCUOAEYmbfKaIRytv7C','f' );
                                          print('ahla');
                                          _msgController.clear(); // Clear the text field after sending the message
                                        },
                                        child: Text(
                                          'Envoyer',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

            ],
          )
        ],),
      ),
    );

  }
}



