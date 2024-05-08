import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiChat {


  getChat()async{
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/enseignants'));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      print("ok");
      print(data);
    }else{
      print(response.statusCode);
      return jsonDecode(response.body);
    }
  }







}