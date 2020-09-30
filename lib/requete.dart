import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class Connecter {
  String url;
  Stream<String> requestStream;
  var client = http.Client();
  Future<String> sessionId;


  Map<String, String> cleSession = {
    'sessionId' : null,
    'modulo' : null,
    'exposant' : null
  };

  Connecter({@required String url}) {
    this.url = url;
  }

  Future<String> get firstRequest {
    return requestStream.first;
  }


  Future<String> makeGetRequest() async {
    String response = await this.client.read(this.url + 'etudiants', headers: {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36'
    }).then((value)  {
      var indexOfSession = value.indexOf(new RegExp(',i'));
      var indexOfModulo = value.indexOf(new RegExp('MR:')) + 4;
      var indexOfExposant = value.indexOf(new RegExp('ER:'));

      this.cleSession['sessionId'] = value.substring(indexOfSession, indexOfSession + 7); //Session id is a 7-number digit
      this.cleSession['modulo'] = value.substring(indexOfModulo, indexOfModulo + 256); // Modulo is a 256 chars number(hexa)
      this.cleSession['exposant'] = value.substring(indexOfExposant, indexOfExposant + 256); // Exposant is a 256 chars number(binary)
      return value;
    });
    return response;
  }

  Future<String> makePostRequest (Map<String, String> parameters) async(){
    String response = await this.client.post(url).then((value) => null).catchError(onError);
    return 
  }

  void handlePostResponse(){
    
  }

  String makePostUrl(url, sessionId, numeroOrdre) => (url + 'appelfonction/2/' + sessionId + numeroOrdre);
}