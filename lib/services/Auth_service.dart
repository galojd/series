import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseurl = 'http://localhost:5169/api';
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
    };

    final url = Uri.parse('http://192.168.1.11:5169/api/Usuario/Crear');

    final resp = await http.post(
      url,
      body: json.encode(authdata),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      return null;
    } else if (decodedResp['errores'] is Map) {
      return decodedResp['errores']['mensaje'];
    } else {
      return decodedResp['errores'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authdata = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final Uri url = Uri.parse('http://192.168.1.11:5169/api/Usuario/login');

    final http.Response resp = await http.post(
      url,
      body: json.encode(authdata),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.body.isEmpty) {
      return 'Respuesta vacía del servidor';
    }

    final Map<String, dynamic> decodedresp = json.decode(resp.body);

    if (decodedresp.containsKey('token')) {
      return null;
    } else if (decodedresp['errores'] is Map) {
      return decodedresp['errores']['mensaje'];
    } else {
      return 'problema desconocido';
    }
  }
}
