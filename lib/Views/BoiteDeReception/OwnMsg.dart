import 'package:flutter/material.dart';
class OwnMsgWidget extends StatelessWidget {
  final String msg;
  const OwnMsgWidget({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints:BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 130
        ),
        child: Container(
          decoration: BoxDecoration(
          ),
          child:Card(
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight:Radius.circular(60),topLeft:Radius.circular(60),bottomLeft: Radius.circular(60)),
            ),
            color: Color(0xFF012869),
            child:Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(msg,style:TextStyle(color: Colors.white,fontWeight: FontWeight.w400),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
