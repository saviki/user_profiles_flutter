import 'dart:convert';

import 'package:list_demo/user.dart';
import 'package:http/http.dart' as http;

class RestAPI{

  String apiUrl = 'https://mocki.io/v1/530a20a7-d7c8-4f8d-a81a-1930052b90bd';

  Future<List<User>> getUsers() async{
    final response = await http.get(Uri.parse(apiUrl));

    // print(response.body);

    if(response.statusCode == 200){
      return getUsersList(response.body);
    }else{
      throw Exception('Unable to fetch tha data');
    }
  }

  List<User> getUsersList(String responseBody){
    final parsedBody = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsedBody.map<User>((json) => User.fromJson(json)).toList();
  }
}