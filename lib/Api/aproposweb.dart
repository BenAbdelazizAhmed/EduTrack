import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              Container(height: 32,color: Colors.white,),
              Positioned(
                top: 33,
                child: Container(
                  height: 240,
                  width: 400,
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  child: Image.asset(
                    'lib/Capture d’écran 2023-04-25 104045.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 220,
                child: Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset:Offset(1,1)
                        ),
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset:Offset(-1,-1)
                        )
                      ]

                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35,
                    backgroundImage: AssetImage('lib/ISIM_LOGO_ar.png'),
                  ),
                ),
              ),
              Positioned(
                top: 300,
                left: 15,
                right: 20,
                child: Container(
                  height: 470,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Text("ISIMM | Institut Supérieur d'Informatique et de Mathématiques de l’Université de Monastir", style:TextStyle(fontWeight:FontWeight.w500,fontSize: 20),),
                      SizedBox(height: 10,),
                      Container(
                        color: Colors.white,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('À propos :',style:TextStyle(
                                fontSize: 20,fontWeight: FontWeight.bold,color:  Color(0xFF3b4790)),),
                            SizedBox(height: 10,),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ExpandableText(
                                "L'Institut Supérieur d'Informatique et de Mathématiques de l’Université de Monastir [ISIMM] créé par le décret N° 1623 du 09 Juillet 2002, est un établissement d’enseignement supérieur scientifique, public, placé sous la tutelle du Ministère de l'Enseignement Supérieur de la Recherche Scientifique.Dans un premier temps ses formations ont été axées sur les métiers de l'Informatique et de ses applications, des Mathématiques et ses applications (Modélisation, Statistique). Au fil du temps il s’est vu autorisé à diversifier ses formations pour arriver à en dispenser toute une panoplie de formations allant de la licence aux Mastères de recherche et professionnel en passant par une formation d’ingénieurs en électronique. Avec bien sure la multiplication des spécialités offertes. En règle générale nos formations s’articulent autour de trois départements et d’une architecture LMD. Elles ont été enrichies ces dernières années par une formation spécifique du diplôme d’ingénieur en électronique.La qualité des formations qu'il propose ainsi que leur adéquation aux attentes du marché, s'appuient sur l'expérience de ses enseignants en matière de formation, expérience concrétisée par l’ouverture de l’établissement sur son environnement socioéconomique et industriel. Dans le cadre de l’harmonisation du système d’enseignement supérieur en Tunisie qui vise à faciliter les orientations progressives et à favoriser la mobilité nationale et internationale des étudiants.L’ISIMM propose des offres de formation dans le domaine des Sciences et Technologies dans les disciplines suivantes : Informatique, Mathématiques et Électronique.",
                                expandText: 'Read More',
                                collapseText: 'Read Less',
                                maxLines: 2,
                                linkColor: Colors.blue,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(height:15),
                            Row(
                              children: [
                                Text('Directeur :',style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF3b4790)),),
                                SizedBox(width: 80,),
                                Text('Pr. Halim Sghaier')
                              ],
                            ),
                            SizedBox(height:10),
                            Row(
                              children: [
                                Text('Secrétaire général :',style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF3b4790)),),
                                SizedBox(width: 21,),
                                Text('Imen ZROUR')
                              ],
                            ),
                            SizedBox(height:10),
                            Row(
                              children: [
                                Text('Téléphone  :',style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF3b4790)),),
                                SizedBox(width: 65,),
                                Text('73464288')
                              ],
                            ),
                            SizedBox(height:10),
                            Row(
                              children: [
                                Text('E-mail   :',style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF3b4790)),),
                                SizedBox(width: 90,),
                                Text('isimm@isimm.rnu.tn')
                              ],
                            ),
                            SizedBox(height:10),
                            Row(
                              children: [
                                Text('Site web :',style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF3b4790)),),
                                SizedBox(width: 82,),
                                Text('www.isimm.rnu.tn')
                              ],
                            ),
                            SizedBox(height:10),
                            Row(
                              children: [
                                Text('Adresse :',style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF3b4790)),),
                                SizedBox(width: 82,),
                                Text('Avenue de la Corniche,\nBP 223 Monastir la République\n')
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    color: Colors.red,
                                    height: 200,
                                    width: 355
                                    ,child: Image.asset('lib/Capture d’écran 2023-04-25 104410.png',fit: BoxFit.cover,))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

    );

  }
}
