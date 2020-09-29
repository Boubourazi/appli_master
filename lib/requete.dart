import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class Connecter {
  String url;
  Stream<String> requestStream;
  var client = http.Client();
  Future<String> sessionId;

  Connecter({@required String url}) {
    this.url = url;
  }

  Future<String> get firstRequest {
    return requestStream.first;
  }

  Future<String> makeGetRequest() async {
    String response = await this.client.read(this.url, headers: {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36'
    }).then((value) => value);
    return response;
  }

  Future<String> makePostRequest(url, sessionId, numeroOrdre) async(){

  }

  Map<String, dynamic> _jsonify(String json) {}

  int _parseSessionId(String body) {}
  String _constructUrl(urlBase, sessionId, numeroOrdre) {}
}
