import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseurl = 'http://localhost:5169/api/Usuario/login';
  final _firebasetoken = '';

  Future<String?> createuser(String nombre, String apellido, String email,
      String password, String username) async {
    //se crea la peticion del post
    final Map<String, dynamic> authdata = {
      'Nombre': nombre,
      'Apellido': apellido,
      'Email': email,
      'Password': password,
      'UserName': username,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_baseurl, '/v1/accounts:signUp', {'key': _firebasetoken});

    //se dispara la peticion http, donde se recibe respuesta este bien o mal
    final resp = await http.post(url, body: json.encode(authdata));

    final Map<String, dynamic> decodedresp = json.decode(resp.body);

    print('si funciona');
  }
}
